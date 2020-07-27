Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A326C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 06:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58CFD2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 06:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jKgijQq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58CFD2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzwij-0002QT-LW
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 02:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jzwht-0001Pe-JC; Mon, 27 Jul 2020 02:33:54 -0400
Received: from ozlabs.org ([203.11.71.1]:59701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jzwhr-0004mO-2G; Mon, 27 Jul 2020 02:33:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BFVPj48cMz9sRW; Mon, 27 Jul 2020 16:33:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595831625;
 bh=SHz1xsciwn+faV4kcwI0Mz8B61s/ECoa82BkmB+xCI4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jKgijQq8XPz/MhjHGJzy4eAdxYAm9jevjavrEzCqBX7b8Pr471RdeTtl7zAsrq5Zf
 UFEjzWOo1nGE7xlca+Z/zukrpZ6ZN9bprIM4vvsfJT3320gVvP4H5iaHPmHgnjaWBF
 ZNmPLn6W11gP7Pp0iWqDi6m/quwJr0Vu4jT6MU1U=
Date: Mon, 27 Jul 2020 16:32:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 3/6] target/ppc: add vmulh{su}w instructions
Message-ID: <20200727063255.GF84173@umbus.fritz.box>
References: <20200724045845.89976-1-ljp@linux.ibm.com>
 <20200724045845.89976-4-ljp@linux.ibm.com>
 <7fb84b5a-b32f-4c2a-7359-2aaabf34814d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
Content-Disposition: inline
In-Reply-To: <7fb84b5a-b32f-4c2a-7359-2aaabf34814d@linaro.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 02:33:47
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
Cc: qemu-ppc@nongnu.org, Lijun Pan <ljp@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2020 at 10:57:51AM -0700, Richard Henderson wrote:
> On 7/23/20 9:58 PM, Lijun Pan wrote:
> > vmulhsw: Vector Multiply High Signed Word
> > vmulhuw: Vector Multiply High Unsigned Word
> >=20
> > Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
> > ---
> > v4/v5: no change
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > v3: inline the helper_vmulh{su}w multiply directly instead of using mac=
ro
> > v2: fix coding style
> >     use Power ISA 3.1 flag
>=20
> The Reviewed-by tag goes above the "---" marker so that it is included wh=
en the
> patch is applied.

Right, but I've fixed it up on this occasion.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8edRUACgkQbDjKyiDZ
s5LRzA/+IykxkcakPaXmiCEbizkkpSg7Sm/pkvtsYfmBaSXwb5dfGVcK3Yy5jGvs
kAIwoJUoMpvYf29l59LvF06/fr10+havpaZJa/sOQU4YXqR5KgDLsy19MlZcwYSB
mNp+EuMz5on3aqGgkUnqOTFsjLTWcUsDDoAiIPmV3qaiMWpzvCJfWkgw9immSjnF
GkSn8tned02CQXsWbZBC0iL/5QP3tjipBQE8V22K9fgvmKEFbsq4eiKaBtAButH8
nNSLhiJZhoDDm1QMHLR+4WuexIxrUXxMdB9RpoKO79bDD76R3Fp8rZ7lPRxTwpNb
CwfHACZaTBmXp3ttsnUurrzKjLxyHZnKT9VGoiQH9tGYPzIWYVQMB228X8veFufI
u6U1sHBl1HjAVFbdEvdt0yzYR9ZHmM98B7XKNFqAKmUqpDb/zIpx8Tm3PzLpEEbJ
4qmHfY6hWYUjj4e4j/9hyoT9ltOVO3ohE62924WSKGhxEHKM+eeGW0XlsR1C+A6i
nYy9sD7HVtZTdJjN/eXmyGvkQTsAxp5oUnqZaHZZlRDVRtTgvP69uqinfF2Y+mcY
9GauZPg6KP0ANMr8fPtqlGlrJje/eLqnBdqJ86SJo6aCv6vbQwUVV6J2dN3igudz
9lG9eGR/p3WGOMpGZPYfSZYVamsSGA/1+SEG3ZYeHxwR1L9zSpI=
=161J
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--

