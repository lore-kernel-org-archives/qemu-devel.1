Received: from eggs.gnu.org ([2001:4830:134:3::10]:58500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAGzX-0008Dg-ES
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAGzT-0006i2-E7
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:28:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dAGzT-0006ho-4X
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:28:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E4F3280F96
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 14:28:49 +0000 (UTC)
References: <20170511163228.6666-1-quintela@redhat.com>
	<20170511163228.6666-3-quintela@redhat.com>
	<20170512034033.GN28293@pxdev.xzpeter.org>
	<877f1mgx9h.fsf@secure.mitica>
	<5bab598f-30eb-fcf6-9d06-8f683b466414@redhat.com>
	<87lgpyfo28.fsf@secure.mitica>
From: Eric Blake <eblake@redhat.com>
Message-ID: <22efcebe-e6fb-d053-7216-10ccd63f7287@redhat.com>
Date: Mon, 15 May 2017 09:28:40 -0500
MIME-Version: 1.0
In-Reply-To: <87lgpyfo28.fsf@secure.mitica>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DEDogn8eKT4ushRQ37WX6lV9IvP7lsj0k"
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: Remove use of old
 MigrationParams
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: Peter Xu <peterx@redhat.com>, lvivier@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DEDogn8eKT4ushRQ37WX6lV9IvP7lsj0k
From: Eric Blake <eblake@redhat.com>
To: quintela@redhat.com
Cc: Peter Xu <peterx@redhat.com>, lvivier@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, Markus Armbruster <armbru@redhat.com>
Message-ID: <22efcebe-e6fb-d053-7216-10ccd63f7287@redhat.com>
Subject: Re: [PATCH 2/3] migration: Remove use of old MigrationParams
References: <20170511163228.6666-1-quintela@redhat.com>
 <20170511163228.6666-3-quintela@redhat.com>
 <20170512034033.GN28293@pxdev.xzpeter.org> <877f1mgx9h.fsf@secure.mitica>
 <5bab598f-30eb-fcf6-9d06-8f683b466414@redhat.com>
 <87lgpyfo28.fsf@secure.mitica>
In-Reply-To: <87lgpyfo28.fsf@secure.mitica>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[adding Markus]

On 05/15/2017 04:48 AM, Juan Quintela wrote:
> Eric Blake <eblake@redhat.com> wrote:
>> On 05/12/2017 05:55 AM, Juan Quintela wrote:
>>>>> @@ -1239,6 +1240,7 @@ void qmp_migrate(const char *uri, bool has_bl=
k, bool blk,
>>>>>      }
>>>>> =20
>>>>>      if (has_inc && inc) {
>>>>> +        migrate_set_block_enabled(s, true);
>>>>>          migrate_set_block_shared(s, true);
>>>>
>>>> [2]
>>>>
>>>> IIUC for [1] & [2] we are solving the same problem that "shared"
>>>> depends on "enabled" bit. Would it be good to unitfy this dependency=

>>>> somewhere? E.g., by changing migrate_set_block_shared() into:
>>>>
>>>> void migrate_set_block_shared(MigrationState *s, bool value)
>>>> {
>>>>     s->enabled_capabilities[MIGRATION_CAPABILITY_BLOCK_SHARED] =3D v=
alue;
>>>>     if (value) {
>>>>         migrate_set_block_enabled(s, true);
>>>>     }
>>>> }
>>>
>>> ok with this.
>>
>> Or, as I commented on 1/3, maybe having a single property that is a
>> tri-state enum value, instead of 2 separate boolean properties, might =
be
>> nicer (but certainly a bit more complex to code up).
>=20
> If you teach me how to do the qapi/qmp part, I will do the other bits.
> I don't really care if we do it one way or the other.

Adding Markus in, as I value his opinion on matters of UI design.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DEDogn8eKT4ushRQ37WX6lV9IvP7lsj0k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZGbsYAAoJEKeha0olJ0NqdC4H/ikUkk49nc4DhcLg/saPKs17
v54As7JD5hE/149s9M+tdm+jlVSSKDDQzC4W4qvTFTCtPHWnPFCtA12O7sZggjOt
sQboUgVmu2AiCnihBzMC73vKV5bUN9iDekyXhKgVYB2/u11sDfddRNndsO7SgzN0
HE1DVG6EdKgQ/akkdsmTR7pmGhCNeJzt1RroXaWoG4xEHcurNLxL25rY0OfnZlKz
I7OdTd02Nq0qQHlPnBzis+zP1hjj8U8GqUwPgXqgh7zwD+Bzvfk+SMNpwXHnVuTY
nhi6BtTHfbR502ZnYZyH6byA72wNpQ5n8dlvIZN+WNF39TXCxg5Ia54L1uWmK0I=
=gn0F
-----END PGP SIGNATURE-----

--DEDogn8eKT4ushRQ37WX6lV9IvP7lsj0k--
