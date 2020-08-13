Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890E6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 00:10:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52DA5205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 00:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="kvZk5qni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DA5205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k60pQ-0007Fw-HJ
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 20:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k60on-0006lB-AB; Wed, 12 Aug 2020 20:10:05 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39903 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k60oj-0006Zc-PW; Wed, 12 Aug 2020 20:10:05 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BRn4s0knwz9sTM; Thu, 13 Aug 2020 10:09:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597277389;
 bh=KpWeZjc4SxL8xfOPVPcf6z/CatX54IwfQQPXxVk+P+4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kvZk5qniS8sD0jt0Gls29bNbvAazF22PAgfD/MEwn1wGN85isBoO4PqaC5SPsCXyX
 yq5EFCxMlyzU+tVL9kpP0YCzB/0yFLhPZRaoAUwx2JAzaZNN2GbzSn8MIgl7HbOH/p
 5yNihOsMq4Goc6WoMT/fvN9rO1LZ1RAq+/eGteD8=
Date: Thu, 13 Aug 2020 10:03:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2] target/ppc: Integrate icount to purr, vtb, and tbu40
Message-ID: <20200813000321.GA17532@yekko.fritz.box>
References: <20200811153235.4527-1-gromero@linux.ibm.com>
 <5944440c-73ac-8c21-9f02-fee91a3a2dfd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <5944440c-73ac-8c21-9f02-fee91a3a2dfd@linaro.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 20:09:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-ppc@nongnu.org,
 clg@kaod.org, Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2020 at 02:33:33PM -0700, Richard Henderson wrote:
> On 8/11/20 8:32 AM, Gustavo Romero wrote:
> > Currently if option '-icount auto' is passed to the QEMU TCG to enable
> > counting instructions the VM crashes with the following error report wh=
en
> > Linux runs on it:
> >=20
> > qemu-system-ppc64: Bad icount read
> >=20
> > This happens because read/write access to the SPRs PURR, VTB, and TBU40
> > is not integrated to the icount framework.
> >=20
> > This commit fixes that issue by making the read/write access of these
> > SPRs aware of icount framework, adding the proper gen_io_start() calls
> > before calling the helpers to load/store these SPRs in TCG and ensuring
> > that the associated TBs end immediately after, accordingly to what's in
> > docs/devel/tcg-icount.rst.
> >=20
> > Signed-off-by: Gustavo Romero <gromero@linux.ibm.com>
> > ---
> >  target/ppc/translate_init.inc.c | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Applied to ppc-for-5.2, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl80g0cACgkQbDjKyiDZ
s5LmQg/+PfVvvwHr7AvWkGs3XRBHLfuQtuA/SbsoARKOAVoM6Rpdjdhv0U1i3QZW
WWOGxvhvRjQwj1T68kSRMK7G1HuP/sdaSteG6FmfanwFGXyqChVe1AlKgicz2iCr
F+ckgCxB6OopMpsW1zd6sM7etq1qgSvgbE+ZUgJExKHUzGFR7RsRnymn4Uf3MZVM
T1QF9X80DGhL+06TY+TkBCpnli8VjkLaTADUpbZ+ldYMJ03LyZykFL7QHQNIvF34
RKUATQo2isQvIShcXDp7i0kAKAZoV6MxyQGML6snVOeaOiIcM14JQJgpZ7rWJQPH
G+WrIl+Ibq2wBYUAaf/s/zT06hBfdmkQjsLolnpzLu4169y0dEHNIZ/hewkd4ZgE
7FCs9asstyuVc40KdlOMZ3roor949np1LqzpBrVGA6C98Jq4t7GTEyoewdG8gWXd
GSZVPC7bQIUGMCBZvQIZbEn/fjM6ExntDIbwpQv23kStcuLfBpMonNNnEJ0g8T/T
LNGJ1ntZXgl2li0P0Pk0Lz26XL9S0+Os17HcJD4j2orXcSVqrhBCNtZC7fsw7gzp
CCuqC+G8Qpj1KXU92ecAi9VsRoEXF110LfyC1qphGLdEx0O5f20GVFUyJPbPdGCT
1Ft7BhOnXdDRbM4OJIqysI88VlZWrGZXIevcExp6A1lAZcDQjyc=
=THmT
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--

