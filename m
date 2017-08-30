Received: from eggs.gnu.org ([2001:4830:134:3::10]:50150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dn2w9-0000Eu-CZ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dn2w4-0002O6-Br
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:21:41 -0400
Received: from 15.mo6.mail-out.ovh.net ([188.165.39.161]:49824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dn2w4-0002NT-5l
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:21:36 -0400
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id A9E9E108862
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 15:21:33 +0200 (CEST)
Date: Wed, 30 Aug 2017 15:21:27 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170830152127.295ea15e@bahia>
In-Reply-To: <61cd0715-27e4-7e50-1e85-9da3b4a48bb1@posteo.de>
References: <1915302638.2814146.1504030043465.ref@mail.yahoo.com>
	<1915302638.2814146.1504030043465@mail.yahoo.com>
	<14033890-2a35-666c-2fa7-5a8727090801@tuxfamily.org>
	<1075529669.195794.1504079702032@mail.yahoo.com>
	<bc7bacd9-fec7-c193-6de0-99d1f7fd0f6f@tuxfamily.org>
	<2061420835.208824.1504085337258@mail.yahoo.com>
	<20170830121109.7fab5559@bahia>
	<61cd0715-27e4-7e50-1e85-9da3b4a48bb1@posteo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/RPJ9kyOAA3mRkwEdtWUqe1C";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-discuss] Accessing a shared folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <th.huth@posteo.de>
Cc: Mahmood <nt_mahmood@yahoo.com>, Thomas Huth <huth@tuxfamily.org>, "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>

--Sig_/RPJ9kyOAA3mRkwEdtWUqe1C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Aug 2017 12:17:22 +0200
Thomas Huth <th.huth@posteo.de> wrote:

> On 30.08.2017 12:11, Greg Kurz wrote:
> [...]
> > Hi,
> >=20
> > Both -virtfs and -fsdev/-device syntaxes work for me with the current Q=
EMU
> > master branch :) Where's your qemu-system-x86_64 binary coming from ? =
=20
>=20
> There is at least one problem with -virtfs if you forget to specify
> the "security_model=3Dxxx" option:
>=20
> $ x86_64-softmmu/qemu-system-x86_64 -virtfs local,id=3Dshared,path=3D/tmp=
,mount_tag=3Dtag
> qemu-system-x86_64: util/qemu-option.c:547: opt_set: Assertion `opt->str'=
 failed.
> Aborted (core dumped)
>=20

Yeah, we should print out that security_model is missing instead of dumping
core... :-\

> According to the qemu-doc, the securit_model is optional, so it
> should be possible to run qemu without it, too, shouldn't it?
>=20

Hmm... the documentation is a bit misleading. We indeed have:

-virtfs fsdriver[,path=3Dpath],mount_tag=3Dmount_tag[,security_model=3Dsecu=
rity_model]
        [,writeout=3Dwriteout][,readonly][,socket=3Dsocket|sock_fd=3Dsock_f=
d]

but the description of security_model says:=20

Security model is mandatory only for local fsdriver. Other fsdrivers (like
handle, proxy) don't take security model as a parameter.

The same goes for the proxy fsdriver which needs socket or sock_fd, and doe=
sn't use
path.

Should we have a -virtfs line for each fsdriver ?

>  Thomas


--Sig_/RPJ9kyOAA3mRkwEdtWUqe1C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWaa71wAKCRAC/DrrAQHb
wrEvAJ0ZE16md+seF7QhctZO1w4VrsY2AgCfZ0xOAHRaTSD+5/aGaw5cQFsOiqY=
=wr1g
-----END PGP SIGNATURE-----

--Sig_/RPJ9kyOAA3mRkwEdtWUqe1C--
