Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4C5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 11:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFFCF20838
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 11:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="kS0tXKSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFCF20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6B8m-0002cL-6m
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 07:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6B7a-0000fL-Rq; Thu, 13 Aug 2020 07:10:10 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:52861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6B7Y-0002om-S5; Thu, 13 Aug 2020 07:10:10 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BS3kc1lF1z9sTY; Thu, 13 Aug 2020 21:10:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597317000;
 bh=UYzL5wYR5QCWT463jScFfMjBJZWAUwSoER2Ibw++y2A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kS0tXKSb6ZNH0PtbRsV/jhXDFtSj7p3umNgGRSAuRPqlVff4uSno7+Iw4XfEAf5Qi
 GVjw1gvmo7jWnYVrkc4rkXNqfhDUxS4KI6LXEVmaDvtsr7K9CTVz9j7kMxRxYi3WYa
 C+uNAUildFXMw7nl6hZEQkcPJaCMtTxlA3Ktvb2k=
Date: Thu, 13 Aug 2020 21:07:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 13/14] ppc/xive: Simplify error handling in
 xive_tctx_realize()
Message-ID: <20200813110738.GD6255@yekko.fritz.box>
References: <159707843034.1489912.1082061742626355958.stgit@bahia.lan>
 <159707852234.1489912.16410314514265848075.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sgneBHv3152wZ8jf"
Content-Disposition: inline
In-Reply-To: <159707852234.1489912.16410314514265848075.stgit@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2020 at 06:55:22PM +0200, Greg Kurz wrote:
> Now that kvmppc_xive_cpu_connect() returns a negative errno on failure,
> use that and get rid of the local_err boilerplate.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.2

> ---
>  hw/intc/xive.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 17ca5a1916b4..489e6256ef70 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -662,7 +662,6 @@ static void xive_tctx_realize(DeviceState *dev, Error=
 **errp)
>      XiveTCTX *tctx =3D XIVE_TCTX(dev);
>      PowerPCCPU *cpu;
>      CPUPPCState *env;
> -    Error *local_err =3D NULL;
> =20
>      assert(tctx->cs);
>      assert(tctx->xptr);
> @@ -683,9 +682,7 @@ static void xive_tctx_realize(DeviceState *dev, Error=
 **errp)
> =20
>      /* Connect the presenter to the VCPU (required for CPU hotplug) */
>      if (xive_in_kernel(tctx->xptr)) {
> -        kvmppc_xive_cpu_connect(tctx, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> +        if (kvmppc_xive_cpu_connect(tctx, errp) < 0) {
>              return;
>          }
>      }
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl81HvkACgkQbDjKyiDZ
s5J+kQ//cTqe2EZYjt+iaDrjYHMc0Didv4CvIhsrP1tQVPkkjtjRDmKEMqJaSvQJ
liiR3B1KM8BG0iImIdc6uxn5CC9yEgFOJ/tSASYabo10x6GxLhEOko2TJqZm34SZ
S/CEROXf8Ny3nr+sE6quyZK5Tgterf+ZAeNoMQ/MkKpqRUWtZkIhNo1H11IuetlG
Rd6zmvGr9lW+RxTInzuwkzy4vfAUj22TaO25qMYYHEw5aicHlVh3sGrLB0spEvwM
3uqlz0a0raPFwhsPLPbZS9n3TgGvkFysgtoaHUcQTYGfaBtB7q9urvuHYo2TbA1Q
KAlzvKnPg/W0PYQ19h3di91sYKkxTRXcOPCnZhfCuN8s7WEWQKUM9g6PzJOncxfu
gn/ORKRgWcXnksbNZCJgPgHS0sNq3P2VTv7xbB5wWj6olDJfXgcamPzZPwgr2lVR
S2S/2yL8CXyTPCAPpV51smtlP99O6DDrUiHGO7qJjL9oWREJVcu6t6k/0ExZ2k9Z
dE8PRTZ8gbH5RqTAmDPiO62GmgISVIrdoa9rGNRCYsPslBvFWXDUq1UvB+7r4AL2
SeOMYmNijvPT3NKto00i4p95M7aT/sLmFIjtdA+upM6CKhKpX8DAXraGwdrPZuzZ
R1JgR5VJPRvD636DmRG5u9pBRBfF8XhPKBq3WB7enwJCg7uJpfg=
=gSkE
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--

