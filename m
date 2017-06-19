Received: from eggs.gnu.org ([2001:4830:134:3::10]:50480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dN28p-0003M7-7n
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 15:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dN28m-0006zI-3s
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 15:15:15 -0400
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:59446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dN28l-0006yd-SW
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 15:15:12 -0400
Received: from player716.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 2927A4708C
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 21:15:10 +0200 (CEST)
Date: Mon, 19 Jun 2017 21:15:05 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170619211505.105d5beb@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170619142848.14258-1-tobleminer@gmail.com>
References: <20170619142848.14258-1-tobleminer@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/gjV=z7Ptgsbl1.qfPTogj6a";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v4 0/1] 9pfs: local: Add support for custom
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

--Sig_/gjV=z7Ptgsbl1.qfPTogj6a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Jun 2017 16:28:47 +0200
Tobias Schramm <tobleminer@gmail.com> wrote:

> Hi,
>=20
> i've noticed that there is no way to control the permissions of newly cre=
ated files and
> folders on the host when using 9p in mapped security mode. This can be a =
big problem when
> configuring permissions for access to such data for groups and via ACLs o=
n the host.
> Thus I added the options fmode and dmode to the fsdev and virtfs options =
that set the actual
> permissions of newly created files and folders on the host.
>=20
> This version of the patch fixes the back to front "mask" naming in the pr=
evious patches. I
> always meant "mode" when actually writing "mask".
>=20

Indeed, this hasn't the umask semantics.

> Also specifying fmode and dmode only has an effect in mapped security mod=
es. Specifying it
> in any other mode now throws an error.
>=20
> Additionally I've switched fmode and dmode to QEMU_OPT_NUMBER because it =
handels octal input
> just fine.
>=20
> Also previous versions leaked a string with g_strdup if an error during p=
arsing of fmode/dmode
> occurred.
>=20
> Thanks to Greg Kurz for pointing out most of the above issues to me.
>=20
> Tobias Schramm
>=20
> Tobias Schramm (1):
>   Add support for custom fmode/dmode in 9ps mapped security modes
>=20
>  fsdev/file-op-9p.h      |  4 ++++
>  fsdev/qemu-fsdev-opts.c | 12 ++++++++++++
>  hw/9pfs/9p-local.c      | 34 +++++++++++++++++++++++++---------
>  hw/9pfs/9p.c            |  3 +++
>  qemu-options.hx         | 20 ++++++++++++++++----
>  5 files changed, 60 insertions(+), 13 deletions(-)
>=20


--Sig_/gjV=z7Ptgsbl1.qfPTogj6a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllIIrkACgkQAvw66wEB28KpEgCgpC7veuxvPsF/Naq81+GjgsCH
3RwAoIL/srG1NUVCpuBNI+Vah2vcNBxV
=z7LC
-----END PGP SIGNATURE-----

--Sig_/gjV=z7Ptgsbl1.qfPTogj6a--
