Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32770C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:29:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BC72074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="FSAv9Bo1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BC72074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEDeH-0006xS-5S
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kEDdR-0006Bx-UG; Fri, 04 Sep 2020 11:28:18 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48130)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kEDdN-0004g4-QU; Fri, 04 Sep 2020 11:28:17 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id DD8FEBF7D3;
 Fri,  4 Sep 2020 15:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1599233291;
 bh=IvQifLIBpg1LyDw9ZTIanqh9tJ9F09sVxi6p9CgdAxA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FSAv9Bo1zZXqnAns444mqO6eRxxnWCgC55ytfWEv7w/o7afIQ3ZpNPUdYSodK0G2c
 Hk3fpSN6LuCKGQwNrlsRPjfpxv8vrjDOI1Uvvn+Hvo4zwMcqx6/h1nqDeyJ7dlRcE9
 tR4V/uEUEYCgUbWbSzPchlbB34Xo6jjHSMiHSNOqezlRQbf80rYm2E3YpvrB21SZh/
 wRzDyvIwQ1tA234yVcCrEjeIs6UIipBloKe/Lhl3UQ/hDViAOXAD4ygi633QJf50yD
 61Xhe3kuFKXkWZVpYcz3apI13QXq0n9O7xnP0ixLYxfC/QDszycKPqwt0DoHVrJi99
 x1A6/mHdD0Xvw==
Date: Fri, 4 Sep 2020 17:28:07 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 0/3] block/nvme: Use NvmeBar structure from "block/nvme.h"
Message-ID: <20200904152807.GA584438@apples.localdomain>
References: <20200904124130.583838-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20200904124130.583838-1-philmd@redhat.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 10:20:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep  4 14:41, Philippe Mathieu-Daud=C3=A9 wrote:
> Cleanups in the NVMeRegs structure:
> - Use the already existing NvmeBar structure from "block/nvme.h"
> - Pair doorbell registers
>=20
> Based-on: <20200903122803.405265-1-philmd@redhat.com>
>=20
> Philippe Mathieu-Daud=C3=A9 (3):
>   block/nvme: Group controller registers in NVMeRegs structure
>   block/nvme: Use generic NvmeBar structure
>   block/nvme: Pair doorbell registers
>=20
>  block/nvme.c | 43 +++++++++++++++----------------------------
>  1 file changed, 15 insertions(+), 28 deletions(-)
>=20

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAl9SXQAACgkQTeGvMW1P
DenioAf/X7uBDwlJOXY9lPgpjhQVB4KIjNEP2WpBoYsPXgtCLkT7ezA7ZRlgBcy2
JgrdUEREuWgJu2K/n2sA9Be3/7NRDpWq1VBrO+aLNSF+F2Nps4JyrfjIxOxmN2cI
VeYGKPr5oITurdiWYTNL148ZIQhsJDMShOTHQMPm+o7NKedzXs+loI20KPbOWLeS
n9bqk5zPOn02KOJ5OhNP7qTbezqISnPaK6+A/4YZQ5IOGs4E64FrRSU88A5/dHCu
UAsQz3mKu35vi+oeWBsR+iQNG0Sz/YFKm4AH9BBfcs4X7n4XcD781QdZGLN/rSSu
T6yPhaokVJb3C+Ma63vpmHPSem5CyA==
=pqim
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--

