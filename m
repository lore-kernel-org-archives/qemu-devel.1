Received: from eggs.gnu.org ([2001:4830:134:3::10]:55571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eumLZ-00066j-Iv
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 16:48:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eumLY-0003Tv-P4
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 16:48:09 -0500
References: <20180224154033.29559-1-mreitz@redhat.com>
	<20180224154033.29559-4-mreitz@redhat.com>
	<abd5ed7a-d5ee-028c-1cd5-208161f88beb@redhat.com>
	<fb3756be-e002-8b47-921f-80a5ce332721@redhat.com>
	<01bf42f6-971d-1a28-eeb4-61063ae62bd7@redhat.com>
	<8b6cb74b-6335-3ee2-0dc3-ff5604704608@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <19bb0fb0-6e9c-97aa-f4fb-c619ffabde87@redhat.com>
Date: Sat, 10 Mar 2018 15:48:00 -0600
MIME-Version: 1.0
In-Reply-To: <8b6cb74b-6335-3ee2-0dc3-ff5604704608@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/7] qapi: Replace qobject_to_X(o) by
 qobject_to(o, X)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 02/28/2018 12:08 PM, Max Reitz wrote:

>>>>> +=C2=A0=C2=A0=C2=A0 options =3D qobject_to(options_obj, QDict);
>>>>
>>>> Bikeshedding - would it read any easier as:
>>>>
>>>> options =3D qobject_to(QDict, options_obj);
>>>>

>> So at this point, I'm 70:30 in favor of doing the rename to have
>> qobject_to(type, obj) for consistency with majority of other macros th=
at
>> take a type name (type names are already unusual as arguments to macro=
s,
>> whether or not the macro is named with ALL_CAPS).=C2=A0 (Sorry, I know=
 that
>> means more busy work for you, if you agree with my reasoning)
>=20
> I agree, because it means I have a decision. :-)

Are you planning on posting a v4, or shall I go ahead and make the swap=20
as part of staging this on my QAPI tree?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
