Received: from eggs.gnu.org ([2001:4830:134:3::10]:58104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d5xy6-0006Rt-8O
	for qemu-devel@nongnu.org; Wed, 03 May 2017 13:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d5xy3-0002yu-4c
	for qemu-devel@nongnu.org; Wed, 03 May 2017 13:21:38 -0400
Received: from 10.mo5.mail-out.ovh.net ([46.105.52.148]:37037)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d5xy2-0002yS-TZ
	for qemu-devel@nongnu.org; Wed, 03 May 2017 13:21:35 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 53341EAAE1
	for <qemu-devel@nongnu.org>; Wed,  3 May 2017 19:21:33 +0200 (CEST)
Date: Wed, 3 May 2017 19:21:26 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170503192126.0d4964a9@bahia>
In-Reply-To: <c3224a61-cc45-c419-6aff-a3cc43ffed80@redhat.com>
References: <1493735386-39622-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1493735386-39622-4-git-send-email-pradeep.jagadeesh@huawei.com>
	<c3224a61-cc45-c419-6aff-a3cc43ffed80@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/LX4vFhGEJuP7dN/utgfZ_Kq";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3 3/4] qmp: refactor duplicate code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

--Sig_/LX4vFhGEJuP7dN/utgfZ_Kq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 2 May 2017 17:15:02 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 05/02/2017 09:29 AM, Pradeep Jagadeesh wrote:
> > This patchset factor out the duplicate qmp throttle interface code
> > that was present in both block and fsdev device files. =20
>=20
> Instead of adding the duplicate code in patch 2 then cleaning it out
> here, you should refactor this patch to be first (fix existing code in
> blockdev.c to make use of the new interfaces), then add the new fsdev
> code that uses this code right away.
>=20

Yeah I second that.

Pradeep,

When you worked on the command line version for 2.9, I didn't really know
what we would be able to share between fsdev and blockdev... I had hence
asked to code it separately and then factor out. The situation is different
here: the core throttling code is in place for both fsdev and blockdev. We
really want to share as much code as possible. So you probably should move
this patch and maybe the next one in front and then have fsdev to use the
new code as Eric is suggesting.

Cheers,

--
Greg

> >=20
> > Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> > ---
> >  blockdev.c                      | 53 +++------------------------------=
----
> >  fsdev/qemu-fsdev-throttle.c     | 51 +--------------------------------=
---
> >  fsdev/qemu-fsdev.c              |  1 -
> >  hmp.c                           | 34 ++++++++++++------------
> >  include/qemu/throttle-options.h |  5 ++++
> >  util/Makefile.objs              |  1 +
> >  util/throttle-options.c         | 58 +++++++++++++++++++++++++++++++++=
++++++++
> >  7 files changed, 85 insertions(+), 118 deletions(-)
> >  create mode 100644 util/throttle-options.c
> >  =20
>=20


--Sig_/LX4vFhGEJuP7dN/utgfZ_Kq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkKEZYACgkQAvw66wEB28J4EQCgidIRiExhaoKVae4O9pcTMgRT
S+gAn3WFIjV+1DVmKJHCagChGnMD9809
=jRME
-----END PGP SIGNATURE-----

--Sig_/LX4vFhGEJuP7dN/utgfZ_Kq--
