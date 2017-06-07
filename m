Received: from eggs.gnu.org ([2001:4830:134:3::10]:56829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIdiT-0004lh-KH
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:21:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIdiP-0000kA-D3
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:21:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dIdiP-0000ju-6C
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:21:49 -0400
References: <20170607152825.12081-1-pbonzini@redhat.com>
	<20170607152825.12081-2-pbonzini@redhat.com>
	<CAFEAcA8CppP6YEPkGxVEyLnO=Kk1qirpGk2sh0bXedscxct8Jg@mail.gmail.com>
	<8229C6EB-56EA-475E-99D4-6D9B36B5D0A7@nutanix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7a06506e-20ba-66b8-8c69-c500efe86301@redhat.com>
Date: Wed, 7 Jun 2017 18:21:45 +0200
MIME-Version: 1.0
In-Reply-To: <8229C6EB-56EA-475E-99D4-6D9B36B5D0A7@nutanix.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 18/33] vhost-user-scsi: Introduce
 vhost-user-scsi host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>



On 07/06/2017 17:39, Felipe Franciosi wrote:
> 
>> On 7 Jun 2017, at 16:37, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On 7 June 2017 at 16:28, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> From: Felipe Franciosi <felipe@nutanix.com>
>>>
>>> This commit introduces a vhost-user device for SCSI. This is based
>>> on the existing vhost-scsi implementation, but done over vhost-user
>>> instead. It also uses a chardev to connect to the backend. Unlike
>>> vhost-scsi (today), VMs using vhost-user-scsi can be live migrated.
>>>
>>> To use it, start Qemu with a command line equivalent to:
>>>
>>> qemu-system-x86_64 \
>>>       -chardev socket,id=vus0,path=/tmp/vus.sock \
>>>       -device vhost-user-scsi-pci,chardev=vus0,bus=pci.0,addr=...
>>>
>>> A separate commit presents a sample application linked with libiscsi to
>>> provide a backend for vhost-user-scsi.
>>>
>>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>>> Message-Id: <1488479153-21203-4-git-send-email-felipe@nutanix.com>
>>> [Disable migration for now, since it does not support bdrv_drain. - Paolo]
>>
>> I was expecting this to mean a VMStateDescription with a
>> ".unmigratable = 1" field, but it doesn't seem to have one.
>> Does it disable migration some other way?
>
> Hi Peter,
> 
> vhost-user-scsi supports migration.

How, since there is no synchronization point between the vhost-user
server on the source and the destination?

Can you please send a version of your patch that uses .unmigratable?

I'll send a v6 that momentarily drops vhost-scsi, but I intend to
include it again in the next pull request.

Thanks,

Paolo
