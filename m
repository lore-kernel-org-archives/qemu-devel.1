Received: from eggs.gnu.org ([2001:4830:134:3::10]:36124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ehcX2-0006zh-U6
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:41:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ehcWy-0000vu-10
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:41:36 -0500
Received: from mail-bn3nam01on0064.outbound.protection.outlook.com
	([104.47.33.64]:44896
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1ehcWx-0000vB-MC
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:41:31 -0500
References: <20180129174132.108925-1-brijesh.singh@amd.com>
	<20180129174132.108925-14-brijesh.singh@amd.com>
	<20180201175802.GK2457@work-vm>
	<7c3c7a89-04ef-016e-c9a5-4f4d4be1c449@amd.com>
	<20180201200442.GQ2457@work-vm> <20180202130817.GE15403@redhat.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <3e6cf550-9bd8-daa7-e54a-d390354ffcb0@amd.com>
Date: Fri, 2 Feb 2018 07:46:44 -0600
MIME-Version: 1.0
In-Reply-To: <20180202130817.GE15403@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v6 13/23] hmp: display memory encryption
 support in 'info kvm'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: brijesh.singh@amd.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>



On 2/2/18 7:08 AM, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Feb 01, 2018 at 08:04:43PM +0000, Dr. David Alan Gilbert wrote:
>> * Brijesh Singh (brijesh.singh@amd.com) wrote:
>>>
>>> On 2/1/18 11:58 AM, Dr. David Alan Gilbert wrote:
>>>> * Brijesh Singh (brijesh.singh@amd.com) wrote:
>>>>> update 'info kvm' to display the memory encryption support.
>>>>>
>>>>> (qemu) info kvm
>>>>> kvm support: enabled
>>>>> memory encryption: disabled
>>>> As Markus said, this should be split qmp/hmp; but something else to
>>>> think about is whether this is a boolean or needs to be an enum;  do
>>>> you have one version of encryption or are we going to need to flag up
>>>> versions or the features of the encryption?
>>> In future I could see us providing encrypted state status when we
>>> implement SEV-ES support, something like
>>>
>>> (qemu) info kvm
>>> kvm support: enabled
>>> memory encryption: enabled
>>> cpu register state: encrypted
>>>
>>> but so far I do not see need to provide the version string. If user
>>> wants to know the SEV version then it can open /dev/sev device to get
>>> platform status and more.
>> Yes, I was worried a bit more about how general that was going to be
>> or whether we're collecting a lot of architecture specific fields here.
>> So I wondered, if it was an enum, whether that would be come:
>>
>> memory encryption: none
>>
>> memory encryption: SEV
>>
>> memory encryption: SEV-ES
>>
>> (I'm not too sure whether that's better or not, just a suggestion)
> I wonder if it is is even appropriate to have under 'info kvm', since
> 'info kvm' is architecture independant and SEV is specific to AMD x86_64
> only. It might suggest an 'info sev' command is better ?

The reason I kept under 'info kvm' is because now KVM has a ioctl for
memory encryption operation, I like your suggestion for=C2=A0 introducing
'info sev' -- the command can be used to provide additional SEV specific
details (e.g SEV FW state, SEV FW version, SEV active policy etc).

>
> Regards,
> Daniel
