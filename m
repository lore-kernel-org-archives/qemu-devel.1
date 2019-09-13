Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2854DC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 10:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0C1020830
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 10:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C1020830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8ij2-0006NU-3f
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 06:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i8ihh-0005JT-Ad
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:21:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i8ihc-0003id-IC
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:21:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53402)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i8ihR-0003eR-Bw; Fri, 13 Sep 2019 06:21:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CB68130860BD;
 Fri, 13 Sep 2019 10:21:07 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 940F15D9C3;
 Fri, 13 Sep 2019 10:21:06 +0000 (UTC)
Date: Fri, 13 Sep 2019 12:21:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190913102105.GD8312@dhcp-200-226.str.redhat.com>
References: <20190910154110.6905-1-pl@kamp.de>
 <20190910154110.6905-2-pl@kamp.de>
 <ede55319-ca74-ab1c-6b3e-8558d9e6bdd8@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <ede55319-ca74-ab1c-6b3e-8558d9e6bdd8@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 13 Sep 2019 10:21:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH V2 1/2] block/nfs: tear down aio before
 nfs_close
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ronniesahlberg@gmail.com, Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 13.09.2019 um 11:51 hat Max Reitz geschrieben:
> On 10.09.19 17:41, Peter Lieven wrote:
> > nfs_close is a sync call from libnfs and has its own event
> > handler polling on the nfs FD. Avoid that both QEMU and libnfs
> > are intefering here.
> >=20
> > CC: qemu-stable@nongnu.org
> > Signed-off-by: Peter Lieven <pl@kamp.de>
> > ---
> >  block/nfs.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> I=E2=80=99ve just seen that Kevin has already included the second patch (=
in its
> v1) in his pull request.

Oops, sorry about this. Peter hasn't pulled yet, so I'll update the tag
for the pull request. Let's see which version gets merged in the end.

Kevin

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJde22RAAoJEH8JsnLIjy/WZIkQAMV1trhGBNCDnmFG/iGC1N2m
TbrnFn6OGQ9YBNa//mZMRB8ofRAvz5zt0Z5+BTcJsfJWdz6xQRvn29YM5J9J+PkL
s31G1kbDeoFVEjUOIYfGqXtaFFOhNd8zsEIfy3dbWXyDDbtD52nl1Tpz3m4Yr6b0
UyUVWXQ9MIGkWcFsxf4tatYweHDaCDk9msj6JBpXCFIdjmkiTz4wcWc/ZjgI4t3v
d365xfZoND7KoTMEbUeIVEc5RexFkaPMMlQInsrGgC5w7kuXz+w5PxR7Z5jlNl5z
KdZa4od1t/sP4CbVLlub6efteG0QPUgVDTTsnKtQoku6hK+4McPIGNy8Cds/M1Rb
gShgUL3w12G2gRosX2jO2bx5WupTAcYHYyvg3dRscVmVHYCpXJGnkzv1jq5pBn1E
GyyQd3k/yPjNfyt59w5NVrbFcBjyy6qYQ91HW1OyS3ud72zlQUOO6Q9G8X39HSGB
Sz6UjYXo3vBkTNAAHgL0WEIRrkF6ySgDMKVvc0EN2sYhU0t43cYcAuoY6a3NTaNh
9vU728Dz4FRBtRSM2Q6XgDNNEYxLkh94RyZT4HR1EoDuZWrYzemag2aF8NeXRD1l
Tcs0QZ2N4yRNO6h5/3HqZorO1pKyyt3qzQxjAvalW8DXcevcnak7FNKK1/6qP7KP
DOawSq/fcajEXl05O4fV
=WM3B
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--

