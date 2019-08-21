Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1F1C3A59E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 00:30:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8F5D21848
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 00:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="T1KgJfCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F5D21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0b00-0002sL-Jf
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 20:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0ayY-00012t-8g
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 20:29:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0ayX-0008Ss-6c
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 20:29:14 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:52847)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0ayV-0008Nf-Tq; Wed, 21 Aug 2019 20:29:13 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46DQPn5nB5z9sDQ; Thu, 22 Aug 2019 10:29:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566433741;
 bh=77SmNPou0+UjeYeA+y5OAPXWVesHTPL+b8y7GNEt6QE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T1KgJfCtYZ+gqKnI9FY3fO77YNocp+84tQyUTm1iGjvAZVCD3Imvbxju6povBlH1n
 jIudJ0/FnYA8uTmREM8sHKqY/m+e2Iw0Fa2Bv90+sBbB+bJg88ahRUBOPfH+pvzcjP
 aLJwX0S54v/2RPtuYAM/TlN/6U9oxBIsl57OL+EY=
Date: Thu, 22 Aug 2019 08:47:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Joel Stanley <joel@jms.id.au>
Message-ID: <20190821224737.GF20890@umbus>
References: <20190821030945.473-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2NLGdgz3UMHa/lqP"
Content-Disposition: inline
In-Reply-To: <20190821030945.473-1-joel@jms.id.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v2] ppc/pnv: Set default ram size to 1.75GB
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


--2NLGdgz3UMHa/lqP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2019 at 12:39:45PM +0930, Joel Stanley wrote:
> This makes the powernv machine easier for end users as the default
> initrd address (1.5GB) is now within RAM.
>=20
> This uses less than 2GB of RAM to ensure 32 bit Qemu still works.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Applied to ppc-for-4.2, in place of the earlier version.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2NLGdgz3UMHa/lqP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1dygkACgkQbDjKyiDZ
s5LDIxAA1iFHtwk8y94HH7KAjfJKURcEJB92gLFAAPhEtas1lmP4D2DhYJWrMXHO
BXK0WiQiMyIrpig/tSCsWoSJomvzm0D8Yghc7pyYtQRe4WV+QSuLC4MmwWrWt4XO
k8sjWhSOcvtFUiBDZYVWry6Deuka1VrAlp9Zi8XTX0oFVN6zoR+GGvyiGsQSuULb
ZZghwrAuWwNNv7jTGVi30vQyniw5G+DlYRuvkxxSI9Fst4gbLeduAZM4MlihS23A
6uBLu2iB4TfEKqB1/u9bSwBUsvQEqWl3yPl6SBBlxEPrEZCwojzAZhyDo1EP1Nmb
QX91S0j7Y/8cXs91w/J5SOgpJH0N3J3psaHMSPffdylPFdxWfHwX8ztLiNWJYD8g
fnphLFFmaeYNrMqaC+0goXospPwKUNdtkO8WD5E4y+tOlja57plIchTqVKnxpVjs
NbSdwpPd5uFigEfRbEYUyy9tsxWYMVVhUC7m82oyVZtpzz/4d9IEg/2HPOGjqGNW
OzLVV8qE/zYOeZJbuJukbyq/vM9ynSVU4Nn6aUJmCBdQtjGPac6sUtFrX6RM0QRw
kq/rRt89CzHogycV6PZ2ruRdsUEfLR1zEb3TzbCad0gyz6Swqks6c1HBliDQa5L6
ysGRb/hVjujZPQIO0pkgXCGz3l7jDWZtXvYr/uWJ6z3bwdldOaY=
=VC5t
-----END PGP SIGNATURE-----

--2NLGdgz3UMHa/lqP--

