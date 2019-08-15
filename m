Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9068C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 12:16:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA2A206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 12:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA2A206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sk2.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyEfy-0008CQ-I5
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 08:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steve@sk2.org>) id 1hyEcg-0005Ou-Qo
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 08:12:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <steve@sk2.org>) id 1hyEcf-0004Vu-JU
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 08:12:54 -0400
Received: from 5.mo7.mail-out.ovh.net ([178.32.120.239]:37555)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <steve@sk2.org>) id 1hyEcf-0004Rj-DV
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 08:12:53 -0400
Received: from player715.ha.ovh.net (unknown [10.109.159.132])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 87CDC12E30D
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 14:12:43 +0200 (CEST)
Received: from sk2.org (gw.sk2.org [88.186.243.14])
 (Authenticated sender: steve@sk2.org)
 by player715.ha.ovh.net (Postfix) with ESMTPSA id D2F9F8B217CF;
 Thu, 15 Aug 2019 12:12:36 +0000 (UTC)
Date: Thu, 15 Aug 2019 14:12:44 +0200
From: Stephen Kitt <steve@sk2.org>
To: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20190815141244.25a93a3a@heffalump.sk2.org>
In-Reply-To: <20190815105704.GA3018@lap1>
References: <20190811194247.9861-1-steve@sk2.org> <20190815105704.GA3018@lap1>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_//NcwAh8bRXZ0zut8ALq4QSY"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 5492984171748478376
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudefuddggeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.120.239
Subject: Re: [Qemu-devel] [PATCH] Fix hw/rdma/vmw/pvrdma_cmd.c build
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_//NcwAh8bRXZ0zut8ALq4QSY
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Aug 2019 13:57:05 +0300, Yuval Shaia <yuval.shaia@oracle.com>
wrote:

> On Sun, Aug 11, 2019 at 09:42:47PM +0200, Stephen Kitt wrote:
> > This was broken by the cherry-pick in 41dd30f. Fix by handling errors
> > as in the rest of the function: "goto out" instead of "return rc".
> >=20
> > Signed-off-by: Stephen Kitt <steve@sk2.org>
> > ---
> >  hw/rdma/vmw/pvrdma_cmd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
> > index bb9a9f1cd1..a3a86d7c8e 100644
> > --- a/hw/rdma/vmw/pvrdma_cmd.c
> > +++ b/hw/rdma/vmw/pvrdma_cmd.c
> > @@ -514,7 +514,7 @@ static int create_qp(PVRDMADev *dev, union
> > pvrdma_cmd_req *req, cmd->recv_cq_handle, rings, &resp->qpn);
> >      if (resp->hdr.err) {
> >          destroy_qp_rings(rings);
> > -        return rc;
> > +        goto out; =20
>=20
> This label was removed, can you please check master branch?

Sorry, it wasn=E2=80=99t clear from my message =E2=80=94 my patch is agains=
t the stable-3.1
branch.

Regards,

Stephen

--Sig_//NcwAh8bRXZ0zut8ALq4QSY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl1VTDwACgkQgNMC9Yht
g5xT6hAAnwZOx2Asj4wSXNHjc80ZoHPBmrIw0t0HKMjZrzC0tet54MXa8GE8/0wl
m0wJr5MrAlnCDkmb7h/X3+DoJncJgNetwgRBgrKpu5adhrhFRI831Z3TnldFhAUX
xG39zl1cu7wsrn30xwvOT0iLB1kXcBzXhlmYGCQouTajYFNpjQj8ZhYn258Bn4eV
XQNWfssks679rTMrOhbPNj97oXB5lnvWxBiVzhdmVUbbGTzG4UkT7/PU7611t9kX
CTmHRy0GN5bF1F5z5TFNp9jGqfD7hljgc+eqUWNPHUlYkJpVJbA/4FKHilpKHz5Y
Lkr/rSW6z/7CmOsmdkVSCiBnPeSNlC5N6kbzmDjED4jw+hlYaxsVeb/RmoGcU1nk
CL9pvaZDQ4e8oBWoalOZsgw2L6HRZ2lR07Jp/C3o1+FnKP8LcUS/KxCL/GFDjMwD
VHgBLrJrmc1PfgaOSz1H/cLFaAz6JpHSpz1mVSz7hmH8N/UQVi4BYBU7QUisG/U6
VuA/r4GoL/WR/oPEy9ghiXOnficGSDOQ4TeT5Gx+SFf1SqvlzcZLwyA7QOYMJ9cu
1sJXVnLp9nlu+NpDB2Z7m6sCmWCl2h5eLRKj6Vq7Z09n5StKrCErykHvzQgEVKVJ
euCKG6yjPTmUDhNXJcNk+FlsKNJtSjsg7yC+VTkFYYxvlO9AVME=
=aAm9
-----END PGP SIGNATURE-----

--Sig_//NcwAh8bRXZ0zut8ALq4QSY--

