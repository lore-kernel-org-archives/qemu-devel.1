Received: from eggs.gnu.org ([2001:4830:134:3::10]:53701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7kjf-0002FE-I7
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7kje-0008A1-NF
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:38:07 -0400
References: <20170507000552.20847-1-eblake@redhat.com>
	<20170507000552.20847-2-eblake@redhat.com>
	<35324a73-aae8-e677-f411-00dfaf6d4f38@redhat.com>
	<f72fca48-7e77-4268-9463-a2c51e999687@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e1338ab4-02f9-9644-ee94-f92fb4b8d617@redhat.com>
Date: Mon, 8 May 2017 17:37:57 +0200
MIME-Version: 1.0
In-Reply-To: <f72fca48-7e77-4268-9463-a2c51e999687@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LsgsV0aLD5h2SN199eigloVPDd3pXUaP2"
Subject: Re: [Qemu-devel] [PATCH v13 01/12] qcow2: Nicer variable names in
 qcow2_update_snapshot_refcount()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LsgsV0aLD5h2SN199eigloVPDd3pXUaP2
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <e1338ab4-02f9-9644-ee94-f92fb4b8d617@redhat.com>
Subject: Re: [PATCH v13 01/12] qcow2: Nicer variable names in
 qcow2_update_snapshot_refcount()
References: <20170507000552.20847-1-eblake@redhat.com>
 <20170507000552.20847-2-eblake@redhat.com>
 <35324a73-aae8-e677-f411-00dfaf6d4f38@redhat.com>
 <f72fca48-7e77-4268-9463-a2c51e999687@redhat.com>
In-Reply-To: <f72fca48-7e77-4268-9463-a2c51e999687@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.05.2017 17:36, Eric Blake wrote:
> On 05/08/2017 10:27 AM, Max Reitz wrote:
>> On 07.05.2017 02:05, Eric Blake wrote:
>>> In order to keep checkpatch happy when the next patch changes
>>> indentation, we first have to shorten some long lines.  The easiest
>>> approach is to use a new variable in place of
>>> 'offset & L2E_OFFSET_MASK', except that 'offset' is the best name
>>> for that variable.  Change '[old_]offset' to '[old_]entry' to
>>> make room.
>>>
>>> While touching things, also fix checkpatch warnings about unusual
>>> 'for' statements.
>>>
>>> Suggested by Max Reitz <mreitz@redhat.com>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>>
>=20
>>> @@ -1117,20 +1118,22 @@ int qcow2_update_snapshot_refcount(BlockDrive=
rState *bs,
>>>                  goto fail;
>>>              }
>>>
>>> -            for(j =3D 0; j < s->l2_size; j++) {
>>> +            for (j =3D 0; j < s->l2_size; j++) {
>>>                  uint64_t cluster_index;
>>> +                uint64_t offset;
>>
>> Actually, introducing entry and old_entry in this scope would have
>> sufficed, too, because they aren't used anywhere else. But nobody
>> actually cares (O:-)), so:
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>>>
>>> -                offset =3D be64_to_cpu(l2_table[j]);
>>> -                old_offset =3D offset;
>>> -                offset &=3D ~QCOW_OFLAG_COPIED;
>>> +                entry =3D be64_to_cpu(l2_table[j]);
>>> +                old_entry =3D entry;
>=20
> Other things I thought about, but didn't care enough to actually do:
> it's possible to reduce a line of code by either:
>=20
> old_entry =3D entry =3D be64_to_cpu(l2_table[j]);
> entry &=3D ~QCOW_OFLAG_COPIED;
>=20
> or by:
>=20
> old_entry =3D be64_to_cpu(l2_table[j]);
> entry =3D old_entry & ~QCOW_OFLAG_COPIED;
>=20
> for one less line of source.  You're welcome to make either such tweak
> if you care, but I'm not going to respin for just that ;)

No, I actually like the code as it is. :-)

Max


--LsgsV0aLD5h2SN199eigloVPDd3pXUaP2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkQkNYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AuscIAIFZAD+EwuxvNCs7xyM19uGoXbeZRnJG
fYOHVyJUaSTkMCbyDJ2cSiefehDw0Yi2WEWE7O87UVSJT/P9LabX6ZkNxmEvylXh
f/pF8px8x6lLaFti+u0GvFjGDv7h3A03Lt6Yko3C6rNMXTQdWQGcjR1CQZB+zAP+
2UrTTOjYuRccYZU16XWwtAGY1/pjI1vrHAVqQoohr7xI/XtkalMCDTnEsfeWJap2
0Aa1J2Xlcfg6+wBoi2RaD6MwbCho++XrLSej94rkEZoyZrhCigxZjxwm6QfwUSTp
ilaGP/vC1+pTpACsPhG+b+JNMeU+8tx81/Z/hE5u+RYp6f+XddCnXmU=
=R+Vv
-----END PGP SIGNATURE-----

--LsgsV0aLD5h2SN199eigloVPDd3pXUaP2--
