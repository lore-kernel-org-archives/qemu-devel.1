Received: from eggs.gnu.org ([2001:4830:134:3::10]:49735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNKQo-0003zt-5n
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNKQj-0002jn-9G
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:47:02 -0400
Received: from 8.mo68.mail-out.ovh.net ([46.105.74.219]:49964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dNKQj-0002jP-26
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:46:57 -0400
Received: from player789.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 01BA05E668
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 16:46:52 +0200 (CEST)
Date: Tue, 20 Jun 2017 16:46:48 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170620164648.0b793a32@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20170619233718.24959-1-tobleminer@gmail.com>
References: <20170619233718.24959-1-tobleminer@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/jiZ39tpp2KTkcGs9ND0fjmr";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v5 0/1] 9pfs: local: Add support for custom
 fmode/dmode in 9ps mapped security modes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tobias Schramm <tobleminer@gmail.com>
Cc: qemu-devel@nongnu.org, aneesh.kumar@linux.vnet.ibm.com, el13635@mail.ntua.gr

--Sig_/jiZ39tpp2KTkcGs9ND0fjmr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jun 2017 01:37:17 +0200
Tobias Schramm <tobleminer@gmail.com> wrote:

> Hi Greg,
>=20
> thank you for your hints on improving this patch. I've implemented them a=
ll
> in this version.
>=20
> In the last version of the patch I moved the path check down because I mo=
ved
> the g_strdup and tried to keep all operations performed on path as close
> together as possible to increase readability. But I clearly didn't think =
of
> madatory vs optional aguments.
>=20
> I introduced extra variables for fmode and dmode for clear separation of
> fetching and processing of arguments. But I guess that trade off is just
> personal preference.
>=20
> I do agree that unifying the mapped mode checks is a good idea. Consideri=
ng
> that it is used in quite a few places might it be a good idea to write a =
macro
> for that check?
>=20

Yeah, I was thinking about some static inline helpers.

> Also I have added a much more descriptive commit message.
>=20
> Again, thank you for the great help (and patience :)).
>=20
> Regards,
>=20
> Tobias Schramm
>=20
> Tobias Schramm (1):
>   9pfs: local: Add support for custom fmode/dmode in 9ps mapped security
>     modes
>=20
>  fsdev/file-op-9p.h      |  4 ++++
>  fsdev/qemu-fsdev-opts.c | 12 ++++++++++++
>  hw/9pfs/9p-local.c      | 25 +++++++++++++++++++++----
>  hw/9pfs/9p.c            |  3 +++
>  qemu-options.hx         | 20 ++++++++++++++++----
>  5 files changed, 56 insertions(+), 8 deletions(-)
>=20


--Sig_/jiZ39tpp2KTkcGs9ND0fjmr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllJNVgACgkQAvw66wEB28KmjwCcC2vPMbKQAOdC6PThW2h9UCPX
Dp8Ani7xPPTPv/8lq3EjHctsIcOFVKK/
=nzLJ
-----END PGP SIGNATURE-----

--Sig_/jiZ39tpp2KTkcGs9ND0fjmr--
