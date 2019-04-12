Received: from eggs.gnu.org ([209.51.188.92]:36348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hEqs2-0004ZJ-Pc
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hEqs1-0004kf-Nb
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:45:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hEqs1-0004kG-Dt
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:45:09 -0400
References: <20190411175931.29235-1-brijesh.singh@amd.com>
	<61c415de-ac47-9818-2b06-b9e46445833f@redhat.com>
	<7d449ae2-6762-97c2-4930-358f34f3ef4b@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <869394fb-7b3d-cc01-7329-e931a260e73c@redhat.com>
Date: Fri, 12 Apr 2019 09:45:02 +0200
MIME-Version: 1.0
In-Reply-To: <7d449ae2-6762-97c2-4930-358f34f3ef4b@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/i386: sev: add 'sev-max-guests'
 field to 'query-sev-capabilities'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Singh, Brijesh" <brijesh.singh@amd.com>, Laszlo Ersek <lersek@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Erik Skultety <eskultet@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 11/04/19 21:02, Singh, Brijesh wrote:
>=20
>=20
> On 4/11/19 1:10 PM, Laszlo Ersek wrote:
>> On 04/11/19 19:59, Singh, Brijesh wrote:
>>> There are limited numbers of the SEV guests that can be run concurren=
tly.
>>> A management applications may need to know this limit so that it can =
place
>>> SEV VMs on hosts which have suitable resources available.
>>>
>>> Currently, this limit is not exposed to the application. Add a new
>>> 'sev-max-guest' field in the query-sev-capabilities to provide this
>>> information.
>>>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Markus Armbruster <armbru@redhat.com>
>>> Cc: Eric Blake <eblake@redhat.com>
>>> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>> Cc: Laszlo Ersek <lersek@redhat.com>
>>> Cc: Erik Skultety <eskultet@redhat.com>
>>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>>> ---
>>>   qapi/target.json  | 6 ++++--
>>>   target/i386/sev.c | 6 ++++--
>>>   2 files changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/qapi/target.json b/qapi/target.json
>>> index 1d4d54b600..b45121d30b 100644
>>> --- a/qapi/target.json
>>> +++ b/qapi/target.json
>>> @@ -183,7 +183,8 @@
>>>     'data': { 'pdh': 'str',
>>>               'cert-chain': 'str',
>>>               'cbitpos': 'int',
>>> -            'reduced-phys-bits': 'int'},
>>> +            'reduced-phys-bits': 'int',
>>> +            'sev-max-guests': 'int'},
>>
>> Would it be useful to make this new field optional? E.g. if it was
>> missing, libvirtd could assume "no limit".
>>
>=20
> I am not sure if we need to make this field optional - mainly because
> in SEV context hardware will always have some limits (at least in
> foreseeable future). The architecture provides us a CPUID to query
> this capabilities so I am assuming that future CPUs will populate
> some values in it.

Since this field is not specific to guest configuration, I don't think
it belongs in query-sev-capabilities; QEMU does not care about >1 guest.

Paolo
