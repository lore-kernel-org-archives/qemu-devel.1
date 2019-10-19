Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D78CA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D4CD2082C
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=startmail.com header.i=@startmail.com header.b="qQtR562K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4CD2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=startmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLqiY-0003pi-OR
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hanetzer@startmail.com>) id 1iLqhJ-0003A5-Eh
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:31:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hanetzer@startmail.com>) id 1iLqhI-0000S1-AK
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:31:17 -0400
Received: from mx-out1.startmail.com ([145.131.90.139]:55441)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hanetzer@startmail.com>)
 id 1iLqhG-0000QN-NK; Sat, 19 Oct 2019 11:31:15 -0400
Date: Sat, 19 Oct 2019 10:31:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
 s=2017-11; t=1571499072;
 bh=9rIekv0PCJoqVBGP+FMcx1qXdTLiKspakw2PKXCG6DU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qQtR562KyxLnq16Wz4BiJIZYqKPrfQx3zHr34IxPLNF72EXY2ShAxZ+ircm0tgnB7
 gbH68aI4dw7WRayAiZ1HUAIOZ/rUJPPJnrl2++IAxdTSGBVBYCzaXWvI0nQ7iE+lNb
 4JhREcWa467y6MgtHly1H42w1Iu1c33okDHCAPiiQLhAIcJn6lLIgJqI+SOC43xCol
 x3XELQAFecoPaaqdRsX8uGQdJCisv7IjTOi3F9EVBnK7WyiKVQyHvWpzFozzX6PP5/
 Vgf3nWDFEUSgLk5I4XTI9FL17LYZknNk0Aik7yrOpTWEq/INbaIWWe2hBNPWmwrY+Q
 2et3Ks6ae6G+A==
From: "Marty E. Plummer" <hanetzer@startmail.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: qemu/powernv: coreboot support?
Message-ID: <20191019153108.gkupn3tnihspq7th@proprietary-killer>
References: <20191018172622.kz4smemh5cwesfit@proprietary-killer>
 <21ba3404-dcd3-fe06-7725-d58e249f9fd2@kaod.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <21ba3404-dcd3-fe06-7725-d58e249f9fd2@kaod.org>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 145.131.90.139
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
Cc: Joel Stanley <joel@jms.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 19, 2019 at 03:46:59PM +0200, C=E9dric Le Goater wrote:
> On 18/10/2019 19:28, Marty E. Plummer wrote:
> > Hello,
> >=20
> > First off, thank you for the work you've done on the ppc64 support, i=
t
> > has been very useful. I'm currently working on a coreboot port for th=
e
> > talos ii line of systems (which means more ppc64 support, support
> > specifically for the power9 sforza chip, and specific mainboard suppo=
rt.
> > My plate is very full lol) and have been using qemu to debug the
> > bootblock.
> >=20
> > It has been very useful for that, but I'm now at the point where I ne=
ed
> > to jump to romstage, and that's where it gets tricky. qemu parses the=
 rom
> > image and looks for a ffs header, locates skiboot on it, and jumps st=
raight
> > to that. Not exactly ideal for debugging something not produced from =
op-build.
>=20
> yes. I suppose you are using my branch powernv-4.2 which adds PNOR supp=
ort
> and a way to boot directly from PNOR. In that case, QEMU parses the PNO=
R
> file to extract the PAYLOAD partition (skiboot). skiboot also detects t=
he
> flash and extract the kernel and initramfs from the PNOR.
>=20
> However, you can bypass all this internal boot process by simply passin=
g
> a -bios option and not passing a MTD device.
>=20
Doing so gives me the following error:
qemu-system-ppc64: Could not load OPAL firmware 'build/coreboot.rom'
(this is after I patched the 4mb size limit up)
> I haven't published the PNOR support and the boot from PNOR yet. Lack
> of time and because sPAPR is the priority.
>=20
> > Do you think it would be within your wheelhouse to provide a generic,=
 non-ffs
> > pnor interface for loading arbitary rom images?=20
>=20
> I should probably send the PNOR patchset now so that we can discuss on=20
> a better way to satisfy all needs. =20
>=20
> > It would be of great help if
> > you could. (This would still hopefully have the bmc support code as
> > well, as I'm still needing to support a system using one).
>=20
> We have support for Aspeed machines AST2400, AST2500 and AST2600. It=20
> is possible to interconnect them through the BT device. Or you can use
> the IPMI BT simulator of QEMU on the PowerNV machine
>=20
> Thanks,
>=20
> C.=20
>=20

