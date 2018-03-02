Received: from eggs.gnu.org ([2001:4830:134:3::10]:35102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erlOo-0005tB-Je
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:11:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erlOj-0001sv-U3
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:11:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39308 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erlOj-0001sI-QI
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:10:57 -0500
References: <20180301130939.15875-1-aik@ozlabs.ru>
	<20180301130939.15875-2-aik@ozlabs.ru>
	<3986fcf2-844d-bc49-d297-960f788c3941@redhat.com>
	<f8511c97-74c2-94e1-85ce-e03cd2bf2e21@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <50cf7369-8b44-99a3-87cb-271f755c3870@redhat.com>
Date: Fri, 2 Mar 2018 08:10:38 -0600
MIME-Version: 1.0
In-Reply-To: <f8511c97-74c2-94e1-85ce-e03cd2bf2e21@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, Andrea Bolognani <abologna@redhat.com>

On 03/02/2018 07:42 AM, Paolo Bonzini wrote:
> On 02/03/2018 14:37, Eric Blake wrote:
>>>
>>> index 0262b9f..87327e5 100644
>>> --- a/qapi-schema.json
>>> +++ b/qapi-schema.json
>>> @@ -1266,10 +1266,12 @@
>>>  =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3) A link type in=
 the form 'link<subtype>' where subtype is
>>> a qdev
>>>  =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 device type name.=C2=A0 Link properties form the device model
>>> graph.
>>>  =C2=A0 #
>>> +# @description: if specified, the description of the property.
>>
>> Missing a '(since 2.12)' tag.
>=20
> Some of the users had it (in other types that are now unified) before
> 2.12.  I'm not sure whether it is more accurate to have the annotation
> or not, especially considering that it is optional.  Protocol-wise it i=
s
> never an issue to add optional fields, since you cannot distinguish an
> implementation that lacks the field from one that never fills it.

True; you could write it as '(since 2.2)', as that is the earliest=20
version that provided the optional field between the structs that you=20
are merging.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
