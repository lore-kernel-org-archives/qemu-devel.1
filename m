Received: from eggs.gnu.org ([2001:4830:134:3::10]:37433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1elJ99-0007Gr-On
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:48:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1elJ96-0003Wz-82
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:48:11 -0500
Received: from mail-sn1nam02on0047.outbound.protection.outlook.com
	([104.47.36.47]:7402
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1elJ96-0003Vq-0L
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:48:08 -0500
References: <20180212153715.87555-1-brijesh.singh@amd.com>
	<20180212153715.87555-14-brijesh.singh@amd.com>
	<e4672dbf-4d1f-3950-aba8-9a52903f35cb@redhat.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <4dca2760-df74-ca42-ca8d-3462c200a715@amd.com>
Date: Mon, 12 Feb 2018 12:47:57 -0600
MIME-Version: 1.0
In-Reply-To: <e4672dbf-4d1f-3950-aba8-9a52903f35cb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v8 13/28] qmp: add query-sev command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: brijesh.singh@amd.com, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>



On 2/12/18 11:27 AM, Eric Blake wrote:
> On 02/12/2018 09:37 AM, Brijesh Singh wrote:
>> The QMP query command can used to retrieve the SEV information when
>> memory encryption is enabled on AMD platform.
>>
>> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>
>> +# @SevInfo:
>> +#
>> +# Information about Secure Encrypted Virtualization (SEV) support
>> +#
>> +# @enabled: true if SEV is active
>> +#
>> +# @api-major: SEV API major version
>> +#
>> +# @api-minor: SEV API minor version
>> +#
>> +# @build-id: SEV FW build id
>> +#
>> +# @policy: SEV policy value
>> +#
>> +# @state: SEV guest state
>
> Is there a finite list of guest states?
>

Yes, the list is finite.

include/sysemu/sev.h defines the enum

typedef enum {
=C2=A0=C2=A0=C2=A0 SEV_STATE_UNINIT =3D 0,
=C2=A0=C2=A0=C2=A0 SEV_STATE_LUPDATE,
=C2=A0=C2=A0=C2=A0 SEV_STATE_SECRET,
=C2=A0=C2=A0=C2=A0 SEV_STATE_RUNNING,
=C2=A0=C2=A0=C2=A0 SEV_STATE_SUPDATE,
=C2=A0=C2=A0=C2=A0 SEV_STATE_RUPDATE,
=C2=A0=C2=A0=C2=A0 SEV_STATE_MAX
}


>> +#
>> +# Since: 2.12
>> +##
>> +{ 'struct': 'SevInfo',
>> +=C2=A0=C2=A0=C2=A0 'data': { 'enabled': 'bool',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 'api-major': 'uint8',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 'api-minor' : 'uint8',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 'build-id' : 'uint8',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 'policy' : 'uint32',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 'state' : 'str'
>
> If so, this should be an enum type listing those possible states,
> rather than an open-coded 'str' that can hold anything.
>

If the preference is to return enum, then I can convert the state to
return enum instead of string.
