Received: from eggs.gnu.org ([2001:4830:134:3::10]:59702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ejUD5-0006aV-At
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:12:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ejUCz-0007yF-Jt
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:12:43 -0500
Received: from mail-sn1nam02on0074.outbound.protection.outlook.com
	([104.47.36.74]:52480
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1ejUCz-0007xn-3c
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:12:37 -0500
References: <20180207160638.98872-1-brijesh.singh@amd.com>
	<20180207160638.98872-26-brijesh.singh@amd.com>
	<14588677-a845-be1e-449f-901ade4a8fe6@redhat.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <dce6f9a2-e3e6-b75c-cc34-2fdfc30321f6@amd.com>
Date: Wed, 7 Feb 2018 12:12:25 -0600
MIME-Version: 1.0
In-Reply-To: <14588677-a845-be1e-449f-901ade4a8fe6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 26/26] qmp: add query-sev-launch-measure
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: brijesh.singh@amd.com, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>



On 02/07/2018 10:29 AM, Eric Blake wrote:
...

>> +#
>> +# Since: 2.12
>> +#
>> +# Notes: If measurement is not available then a null measurement is=20
>> returned.
>=20
> Null measurement, as in empty string?=C2=A0 Would it be better to have=20
> query-sev-launch-measure return an error instead of an=20
> SevLaunchMeasureInfo with a null measurement in that case?
>=20

Yes, an empty string when measurement is not available. I can certainly=20
change it to return an error when measurement is not available.


>> +##
>> +{ 'struct': 'SevLaunchMeasureInfo', 'data': {'data': 'str'} }
>> +
>> +##
>> +# @query-sev-launch-measure:
>> +#
>> +# Query the SEV guest launch information.
>> +#
>> +# Returns: The @SevLaunchMeasureInfo for the guest
>> +#
>> +# Since: 2.12
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "query-sev-launch-measure" }
>> +# <- { "return": { "data": "4l8LXeNlSPUDlXPJG5966/8%YZ" } }
>> +#
>=20
>=20
