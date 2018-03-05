Received: from eggs.gnu.org ([2001:4830:134:3::10]:51205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1esu1I-00023g-8e
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:35:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1esu1E-00080S-PN
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:35:28 -0500
Received: from mail-sn1nam01on0074.outbound.protection.outlook.com
	([104.47.32.74]:54080
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1esu1E-000804-Em
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:35:24 -0500
References: <20180228211028.83970-1-brijesh.singh@amd.com>
	<20180228211028.83970-27-brijesh.singh@amd.com>
	<e11092fd-d332-8708-4dd2-38147dde83e9@redhat.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <0cd852ce-33cf-379d-9c71-bad6fc19a8a2@amd.com>
Date: Mon, 5 Mar 2018 11:35:10 -0600
MIME-Version: 1.0
In-Reply-To: <e11092fd-d332-8708-4dd2-38147dde83e9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 26/28] qmp: add query-sev-capabilities
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
Cc: brijesh.singh@amd.com, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>



On 03/01/2018 02:13 PM, Eric Blake wrote:
> On 02/28/2018 03:10 PM, Brijesh Singh wrote:
>> The command can be used by libvirt to query the SEV capabilities.
>>
>> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>> =C2=A0 monitor.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +++++++
>> =C2=A0 qapi-schema.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 42 +++++++++++++=
+++++++++++++++++++++++++++++
>> =C2=A0 target/i386/monitor.c |=C2=A0 5 +++++
>> =C2=A0 3 files changed, 54 insertions(+)
>=20
> And another rebase victim.
>=20
>=20

I will wait for couple of days for more feedback then rebase the series.


>> +##
>> +# @query-sev-capabilities:
>> +#
>> +# This command is used to get the SEV capabilities and supported on AMD
>=20
> grammar suggestion: s/capabilities and/capabilities, and is/
>=20
>> +# X86 platform only.
>=20
> s/platform/platforms/
>=20

Will fix it.

>> +#
>> +# Returns: a list of SevCapability objects.
>=20
> This says it returns a list of objects...
>=20

Earlier I thought we may need list but we really need one element. I=20
will fix it.


>> +#
>> +# Since: 2.12
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "query-sev-capabilities" }
>=20
> ...but this says it returns a single object.
>=20
>> +# <- { "return": { "pdh": "8CCDD8DDD", "cert-chain": "888CCCDDDEE",
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "cbitpos": 47, "reduced-phys-bits": 5}}
>> +#
>> +##
>> +{ 'command': 'query-sev-capabilities', 'returns': 'SevCapability' }
>> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
>> index 577d50eebaaa..1b55dd0fff88 100644
>> --- a/target/i386/monitor.c
>> +++ b/target/i386/monitor.c
>> @@ -737,3 +737,8 @@ SevLaunchMeasureInfo=20
>> *qmp_query_sev_launch_measure(Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return info;
>> =C2=A0 }
>> +
>> +SevCapability *qmp_query_sev_capabilities(Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return NULL;
>=20
> Should call error_setg() before returning NULL.
>=20

Later in the patches this function gets filled with capability call and=20
we set the error before returning NULL.
