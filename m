Received: from eggs.gnu.org ([2001:4830:134:3::10]:36887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1co7PS-0006IZ-AT
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1co7PR-0003Yj-JA
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:48:06 -0400
References: <20170314023050.32756-1-famz@redhat.com>
	<02221132-c55f-e7af-67f2-5f7da67f30a0@redhat.com>
	<20170315030604.GB3088@lemon.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4e3b593d-1827-3535-66b9-fa474a8c53f1@redhat.com>
Date: Wed, 15 Mar 2017 06:47:57 -0500
MIME-Version: 1.0
In-Reply-To: <20170315030604.GB3088@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pTMhoAFE6g7JEHMgmA68mOcN8rMRv5hcX"
Subject: Re: [Qemu-devel] [PATCH] block: Always call bdrv_child_check_perm
 first
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pTMhoAFE6g7JEHMgmA68mOcN8rMRv5hcX
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <4e3b593d-1827-3535-66b9-fa474a8c53f1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Always call bdrv_child_check_perm
 first
References: <20170314023050.32756-1-famz@redhat.com>
 <02221132-c55f-e7af-67f2-5f7da67f30a0@redhat.com>
 <20170315030604.GB3088@lemon.lan>
In-Reply-To: <20170315030604.GB3088@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/14/2017 10:06 PM, Fam Zheng wrote:

>>> +static int bdrv_child_check_perm(BdrvChild *c, uint64_t perm, uint64=
_t shared,
>>> +                                 GSList *ignore_children, Error **er=
rp);
>>> +static void bdrv_child_abort_perm_update(BdrvChild *c);
>>> +static void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_=
t shared);
>>> +
>>
>> Now that you have static prototypes, is it worth rearranging the file
>> (in a followup) to sort the function implementations into topological
>> order so that a prototype is not necessary?  [In general, I try to cod=
e
>> so that static prototypes are only necessary if I am implementing
>> mutually-referencing recursive code. But it's not a strict requirement=
]
>=20
> Yes, thanks for pointing out, but it does have a recursion here:
>=20
> bdrv_check_update_perm
>     -> bdrv_check_perm
>         -> bdrv_child_check_perm
>             -> bdrv_check_update_perm
>=20

So you're right, topological sorting is not possible.  Carry on, nothing
to see here :)

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--pTMhoAFE6g7JEHMgmA68mOcN8rMRv5hcX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYySntAAoJEKeha0olJ0Nqn/wH/1UewBL74qt6gm739RBdsw2N
xjTpl/SaF3jSgsvxnKDqnbmFV9ukF8GOLlyj8V3EAT+aDRILUQEBoO+vI18IcCS7
V0BKmEsZZsKSAmMb1ACLDYIiLl5mlrVaNPZRfHAi7yZHaNL7WnjyK7cL6S9LeBPH
s2wtsDf46NLwT/cwQAOfW8B+R4hhYyKeksneUxLHhzca6J1aoOtZMMmhniQNsRNs
DhF+lJ7ZdHBEudsZz8Hr5VJQlIenyrFg3sPRdApjIybzPkf7w/Li9LUQJK9l9TG0
1w8UOIySeE2ujBiNHifkKMFkcWrtIng2LZgUnh2A2tm5kpfyn+NJj73WmdFUAEM=
=bPgN
-----END PGP SIGNATURE-----

--pTMhoAFE6g7JEHMgmA68mOcN8rMRv5hcX--
