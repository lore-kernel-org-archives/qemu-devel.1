Received: from eggs.gnu.org ([2001:4830:134:3::10]:36097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chN4M-0006xO-Ed
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 16:06:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chN4L-0005Ly-Fh
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 16:06:26 -0500
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
	<1487710908-26356-3-git-send-email-armbru@redhat.com>
	<5f90e39c-e4ea-8638-d057-25eff232ad3d@redhat.com>
	<878toxmeol.fsf@dusky.pond.sub.org> <877f4g2f6m.fsf@dusky.pond.sub.org>
	<c00ea08f-f596-6e3e-4084-7f183c92a04d@redhat.com>
	<87h93j2ytj.fsf@dusky.pond.sub.org>
	<86ea8b80-f2ae-088f-ae2d-cf529d2db02b@redhat.com>
	<87r32nxrzm.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <420c2df1-5bb9-29dc-ed0f-707e8985b4f3@redhat.com>
Date: Fri, 24 Feb 2017 15:06:15 -0600
MIME-Version: 1.0
In-Reply-To: <87r32nxrzm.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CS8XvjfGdm5qutEFfBUspvp1bOLEAuOba"
Subject: Re: [Qemu-devel] [PATCH RFC v3 2/5] keyval: New keyval_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CS8XvjfGdm5qutEFfBUspvp1bOLEAuOba
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <420c2df1-5bb9-29dc-ed0f-707e8985b4f3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 2/5] keyval: New keyval_parse()
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
 <1487710908-26356-3-git-send-email-armbru@redhat.com>
 <5f90e39c-e4ea-8638-d057-25eff232ad3d@redhat.com>
 <878toxmeol.fsf@dusky.pond.sub.org> <877f4g2f6m.fsf@dusky.pond.sub.org>
 <c00ea08f-f596-6e3e-4084-7f183c92a04d@redhat.com>
 <87h93j2ytj.fsf@dusky.pond.sub.org>
 <86ea8b80-f2ae-088f-ae2d-cf529d2db02b@redhat.com>
 <87r32nxrzm.fsf@dusky.pond.sub.org>
In-Reply-To: <87r32nxrzm.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/24/2017 02:18 PM, Markus Armbruster wrote:
>> I have a preference for option 1 in the long run, but as it seems to b=
e
>> upwards compatible from option 2 for -blockdev in 2.9, I'm leaning
>> towards option 2 for this release.
>=20
> Let me rename the options:
>=20
> * "no sugar -blockdev": both "FOO" and "noFOO" are rejected.
>=20
> * "positive sugar blockdev": "FOO" is desugared to "FOO=3Don", "noFOO" =
to
>   "noFOO=3Don".
>=20
> Which one do you prefer for 2.9?

My current leanings:

For 2.9: keyval_parse() should have no sugar.  Both "FOO" and "noFOO"
are rejected; an '=3D' must be present except for an implicit key -
although if -blockdev is the only client of keyval_parse(), then it's a
tossup whether we want to use it with an implicit key.

Also for 2.9: turn on the deprecation warning for QemuOpts negative
sugar, but leave positive sugar unchanged (it seems like positive sugar
is probably more in use than negative sugar, other than chardev nowait).

That way, we still have the option of enabling positive sugar blockdev
in a later version, if we decide its useful (and after dealing with any
QemuOpts fallout), but are not locked into having to use it.


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--CS8XvjfGdm5qutEFfBUspvp1bOLEAuOba
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsKBHAAoJEKeha0olJ0Nq9m0H/j6FayGDFpTWIQJrls3J/wb+
WURE3O34BaLSnP1jH+yFBdMsN8gKV7pilRSqxx9WrYWWKA8kG76ISeu8g/w2yV9f
G4DhbUPCS/HJIeMsyheIhNLB+sMW5Q9d1lckyqbmRiz2qyFvWOy2toOzeGz2XBFs
bTipgu94pE8tbiM5wUb+OPgW8V/S4tm+m+IWs7/W6ULGknStVjXTtprxdft4XnH7
A1Jt2+siOz8f5XPpQMntmlzqNdvFZim70kKVojCKk/TjTmT1Bn1ITLTtsgq3skjK
K5y7CquIjFIKDWFTm4qkSlEpcNQ5WemzqlDRpr2TzgxfPQpqquLIqN5JrhJXLhc=
=t5fm
-----END PGP SIGNATURE-----

--CS8XvjfGdm5qutEFfBUspvp1bOLEAuOba--
