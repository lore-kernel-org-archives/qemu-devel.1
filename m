Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50208C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BC2B206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PkG95pcw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC2B206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIFdb-0000eY-Lj
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 13:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iI7rR-0001r4-Nf
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iI7rQ-0000jf-Kt
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:02:21 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52453 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iI7rQ-0000j7-9A; Wed, 09 Oct 2019 05:02:20 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46p7Wr3Svnz9sP7; Wed,  9 Oct 2019 20:02:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570611736;
 bh=w9U73fyFQTNRy938ES9lJPp54ztiGLkLXXWNEPCMDXQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PkG95pcw9TAknX3hl4q2eCBoKdI31LJS54GOp6aj4vM/yXKFi9CFiy4lDFMru3d/O
 oailfSLjWz2qzxIiBXQ4KbRNeyCf3eBFjyLycMFgV3I6B6EuPZRRem5RuUvMNNiFyA
 og6V2DB8E1ttgIshcCCMA1qi9X9EOrDNFH/kxerQ=
Date: Wed, 9 Oct 2019 20:02:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org, clg@kaod.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v4 00/19] spapr: IRQ subsystem cleanup
Message-ID: <20191009090200.GF5035@umbus.fritz.box>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lIrNkN/7tmsD/ALM"
Content-Disposition: inline
In-Reply-To: <20191009060818.29719-1-david@gibson.dropbear.id.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 groug@kaod.org, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2019 at 05:07:59PM +1100, David Gibson wrote:
> This is a substantial rework to clean up the handling of IRQs in
> spapr.  It includes some cleanups to both the XICS and XIVE interrupt
> controller backends, as well as more to the common spapr irq handling
> infrastructure.
>=20
> The last two patches of this series, dealing with VFIO devices, are
> RFC only - there some problems that I'm discussing with Alex
> Williamson.

Oops, I screwed up my base branch selection for git-publish - patches
1..3 aren't supposed to be in this series (although 1..2 fit well
enough thematically).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lIrNkN/7tmsD/ALM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2doggACgkQbDjKyiDZ
s5KaKA//Yz4p9y0oY2ehz0//qCK2E1cek+kEQY8KM0iCH9BuNGslkgA3VAGjV4Zg
hCuBqTTFdhttVDPeSU+iofppwpUUXMQMqlSStSpEzG5H+JfJ1HhlAX083jtslOJf
326q9i2w4C7jHgOMDOTgg/LZsGsi2qy8p9vJi0cUIhfz3QXlfy2c9MWyeHEEtI+8
GOMg6vmnZJq84HTe8Subgnm38xPZZGaU+QXV78bKPuTd7cqq7MYtRBg/y8hw5ofU
3qPipMp4FJ0ZAz34pekwse7zgEokhXGdtRPBzU1drr/LrzWCwrTUynDABbz4n+3T
wDEVZZ9vEnb8l5kJz0Zrf3BBtEqvIt+LZiQtc7I2Tt4kHPEpB1EoI3U3XqJ00hyU
1ZXGIxyLgbQJdiuUCEaSW4oy2z6dNWZgynKtVJ1PbhQsVxMdPGyt8e+fgasBGVlX
K2hIQQE1LuKbhQVqy2RRoomueWoMhe/+IwxVnbPm/naOQPA0aGfR7COJfHvSNFSV
6geXlqzKDWxFJICpSAMUfxi+uq/m2bcveBzjwrfKeH/Sr7rPxs6IzArW2NKBkf4f
3L6GTDTTIHiUfdap5vLo/v35wzK0L/69zvKxMd2mZAZ4MaiKAGI+cvDsXIKnw2tI
QoTG9mUrER+qm1zMjrvU5RHgeSs2fXdryQVb+9Uy63zel12/3qk=
=6Hrb
-----END PGP SIGNATURE-----

--lIrNkN/7tmsD/ALM--

