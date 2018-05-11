Received: from eggs.gnu.org ([2001:4830:134:3::10]:57939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fHCrg-0001Ro-Lf
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fHCrf-0007RD-Sj
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:34:00 -0400
References: <20180509165530.29561-1-mreitz@redhat.com>
	<20180509165530.29561-9-mreitz@redhat.com>
	<ba5e8366-e549-5611-b161-1710fc2f95b5@redhat.com>
	<2418987f-17d1-7025-5e83-e46d87cdc322@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7d213a92-ba5d-5a5b-d2c8-deaf01e53ffd@redhat.com>
Date: Fri, 11 May 2018 13:33:54 -0500
MIME-Version: 1.0
In-Reply-To: <2418987f-17d1-7025-5e83-e46d87cdc322@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/13] tests: Add
 qdict_stringify_for_keyval() test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 05/11/2018 01:13 PM, Max Reitz wrote:

>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 "h": 0xffffffffff=
ffffff,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 "i": true,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 "j": 0
>>
>> Is it worth testing fun things like '-0.0'?
>=20
> Sure, why not.  Maybe even infinity, although I'm not quite sure the
> input visitor can handle it...

JSON can't handle Inf or NaN, even if the input visitor can.  So=20
probably best to not worry about those.

>>> +=C2=A0=C2=A0=C2=A0 g_assert(!strcmp(qdict_get_str(dict, "a"), "null"=
));
>>> +=C2=A0=C2=A0=C2=A0 g_assert(!strcmp(qdict_get_str(dict, "b"), "42"))=
;
>>> +=C2=A0=C2=A0=C2=A0 g_assert(!strcmp(qdict_get_str(dict, "c"), "-23")=
);
>>> +=C2=A0=C2=A0=C2=A0 g_assert(!strcmp(qdict_get_str(dict, "d"), "off")=
);
>>> +=C2=A0=C2=A0=C2=A0 g_assert(qobject_type(qdict_get(dict, "e")) =3D=3D=
 QTYPE_QNULL);
>>
>> Is it worth shortening this line to:
>> g_assert(qobject_to(QNull, qdict_get(dict, "e")));
>=20
> I think explicitly checking the type is a bit more expressive.

Okay (qobject_to() checks the type under the hood, and returns non-NULL=20
only when it was the right type - but I see your point about that being=20
a bit more magic)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
