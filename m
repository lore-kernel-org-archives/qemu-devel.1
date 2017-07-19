Received: from eggs.gnu.org ([2001:4830:134:3::10]:40279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dXlAJ-0004xN-S2
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dXlAI-0004tq-Hq
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:21:07 -0400
Date: Wed, 19 Jul 2017 12:21:02 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170719092102.dg6g3qxg6zbmijq4@postretch>
References: <1500453887-20819-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zefdc3guo33fcadu"
Content-Disposition: inline
In-Reply-To: <1500453887-20819-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10] block: Skip implicit
 nodes in query-block/blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com, nsoffer@redhat.com


--zefdc3guo33fcadu
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2017 at 10:44:47AM +0200, Kevin Wolf wrote:
>Commits 0db832f and 6cdbceb introduced the automatic insertion of filter
>nodes above the top layer of mirror and commit block jobs. The
>assumption made there was that since libvirt doesn't do node-level
>management of the block layer yet, it shouldn't be affected by added
>nodes.
>
>This is true as far as commands issued by libvirt are concerned. It only
>uses BlockBackend names to address nodes, so any operations it performs
>still operate on the root of the tree as intended.
>
>However, the assumption breaks down when you consider query commands,
>which return data for the wrong node now. These commands also return
>information on some child nodes (bs->file and/or bs->backing), which
>libvirt does make use of, and which refer to the wrong nodes, too.
>
>One of the consequences is that oVirt gets wrong information about the
>image size and stops the VM in response as long as a mirror or commit
>job is running:
>
>https://bugzilla.redhat.com/show_bug.cgi?id=3D1470634
>
>This patch fixes the problem by hiding the implict nodes created
s/implict/implicit

Also, it seems like qemu-stable wasn't successfully CC'd (the patch is=20
not in the list archives either).

Reviewed-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

--zefdc3guo33fcadu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllvJH4ACgkQc2J8L2kN
9xBsGhAAhINHFSXJGFU6YnyR/XTiSC+oakGL1BeVaCaF1puC7f6zyrJmq5zQxpmY
14C0pgQFf6/xRbLY5LH1dFZnu7Rh6bpQwkOaHgK3hraGegPcPF+5Q2c6U3235xrd
AKZGfevbunkmW8zo8p5qNyeA0/NiWb2vmiAN/8qDyLLOVL+r2V3JQbUKXx4NPT1V
vEPiW1jk5iCliUASerh8TbmkdfNpq2Wta5VtTF0lUhIabYRlrNEMZV+0A3InG1VQ
sxbnj2148ZRzzYqaiQegcx0Fz6fNO6f3BTgM6DWFJy9ngrUoo4LFEAfNQJIALwdO
L1UiPnQc18QkcROVQ9KLSgRzux0Lcxr7GFPoAKhE8aQaG7XviPc6oXf1RJ8EaTz5
v8CA/51lExsmTrRG1HE6W24WJ/MEPfD75+OuTpvW6WC04W91iHZ/LghDLD578TdI
QNNB0qA1FQA8kYGWoNiKLP7F7WVrpxvEqUbR25iFWXyQf2EuzDT72yU6Ndla1ufA
AYBODO43XFdO8IAXWG6dZRpWsjiRhXs+mVC+Yei9dWKDGDkTzRSKEHekNi6N5UgW
LqLucz83v0JxoP0XJJRApYExZ+jRKrg/AfsixmMV+rBF9etQTZ+dDI8X/Z/cr73K
VTmZw1MTZsnfjNv+apyWVvBUhwmt5iI8q/ZUvFYZ9FiGSGoARv0=
=dXTD
-----END PGP SIGNATURE-----

--zefdc3guo33fcadu--
