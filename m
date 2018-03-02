Received: from eggs.gnu.org ([2001:4830:134:3::10]:55619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1erkxC-0002AB-8N
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:42:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1erkx9-0007RI-5i
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:42:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38590 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1erkx9-0007RC-1W
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:42:27 -0500
References: <20180301130939.15875-1-aik@ozlabs.ru>
	<20180301130939.15875-2-aik@ozlabs.ru>
	<3986fcf2-844d-bc49-d297-960f788c3941@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f8511c97-74c2-94e1-85ce-e03cd2bf2e21@redhat.com>
Date: Fri, 2 Mar 2018 14:42:24 +0100
MIME-Version: 1.0
In-Reply-To: <3986fcf2-844d-bc49-d297-960f788c3941@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH qemu v3 1/2] qmp: Merge ObjectPropertyInfo
 and DevicePropertyInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, Andrea Bolognani <abologna@redhat.com>

On 02/03/2018 14:37, Eric Blake wrote:
>>
>> index 0262b9f..87327e5 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -1266,10 +1266,12 @@
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3) A link type in t=
he form 'link<subtype>' where subtype is
>> a qdev
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=
evice type name.=C2=A0 Link properties form the device model
>> graph.
>> =C2=A0 #
>> +# @description: if specified, the description of the property.
>=20
> Missing a '(since 2.12)' tag.

Some of the users had it (in other types that are now unified) before
2.12.  I'm not sure whether it is more accurate to have the annotation
or not, especially considering that it is optional.  Protocol-wise it is
never an issue to add optional fields, since you cannot distinguish an
implementation that lacks the field from one that never fills it.

Paolo
