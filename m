Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45B5C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909A4205F4
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909A4205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiI3z-0005fq-Ro
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 08:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48712)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hiI2D-0003uf-Jb
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 08:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hiI2C-0000ZW-NZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 08:37:21 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:59395)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hiI2C-0000XR-C6; Tue, 02 Jul 2019 08:37:20 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Macaw-1iErd03xqU-00c6SQ; Tue, 02 Jul 2019 14:37:17 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 14:37:10 +0200
Message-Id: <20190702123713.14396-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rWVCyKkBuYTSSJprfohFkj8FG89hgMcnmXadjVMUTFvUQ8TN5zt
 n3NVrrwkzbroVIiRrXzh6//TdRv4ZDLxyVZGQMtVYYqxhHGCRAsw6N8a8Fz5PSh5VNDL23u
 C8minrkn8/cx+SEJOmpUyyZhcyW53PTJuW41SVgdo46Sx75QQdZiQ2etD30mbr1AMEI/tt3
 e8V1x8b4PxizCNcaFiVWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S5ws0Kipkmg=:8p+qFk0t7kKS1k4oDVAzm8
 5XFAAF/e5ZeBrEYZITHaRmvQ16bxyH1L+aVLAvQDqcTnqRJHIA6fvgXep2MKTYMH87XyJpVbv
 hLEbOuIsdH7Js+zDvLrP0h7zKAxKvDVF90ImqUntS3k/sG3J5hg4ui5+P6+Mqgng3s02Lvnh4
 sDbW6u2LpY+UpqxIjFcxUSY0TsvP3PIZcuIsm9EbcinAQQIq66V1mwb4InFgeDdjs8YppHYky
 iKwpFm6vNESPHjaN7fp+BgflFBCRre6ge9ddWCAL6uMmmCM6Ob44x5wfYMQ6GG6PoymwMCfUW
 xkmJ5D6IcxjwveFxxKk8fQPwlr45h67s57j76TpN6qDO7BAsLx6pANSD4eBAHpyA7rTBEGvuf
 eCwBqJOhPaUVDmAOXCN0CAILusqMlEYCX2K6HpcJ531k9GImAXkJwtXjPOJ7sSFcJ0W/AwuKw
 E0WC4fLtHEp2Mf6QY21085x1HYSpukpjY+/F389m197SPR5FwHd7YXEgEkVOnzdvwtlQVMUXf
 CwuY2BGGdyd8TiLdnOfntZwLDGkmiVwzAjbFu7uq0pWmfoMTliSqr4h0rqsLevaPiuYtwOUZ9
 qQ5eOjtjbWTTszjR/pnPAX7HS9gj4/FojpP8Ujq8WuU/DZRv/0QDZecUM+oSAX6nLDpslL/pa
 /vbg4Y8CU0+4YIZNpUqX3NFn18u+K6pQauFp08O6Dfh2BYRiQZRQX7ijVHoiMdeJRGj8Ze4DY
 7xdU1sLxw/S9QVYnNg2RvHa/MYWaXd94g9zmoMspueIpB2X/DhF4rngZUJU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
Subject: [Qemu-devel] [PULL 0/3] Trivial branch patches
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Amit Shah <amit@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 7d0e02405fc02a181319b1ab8681d2f72246b7c6:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull-request' into staging (2019-07-01 17:40:32 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/trivial-branch-pull-request

for you to fetch changes up to 7c955080d40ccc7952a0479bc160f2b048c0af53:

  docs/devel/testing: Fix typo in dockerfile path (2019-07-02 10:12:32 +0200)

----------------------------------------------------------------
Fix typo, fix sys_cache_info() on FreeBSD/powerpc,
change virtio-rng default to urandom

----------------------------------------------------------------

Justin Hibbits (1):
  Fix cacheline detection on FreeBSD/powerpc.

Kashyap Chamarthy (1):
  VirtIO-RNG: Update default entropy source to `/dev/urandom`

Liam Merwick (1):
  docs/devel/testing: Fix typo in dockerfile path

 backends/rng-random.c  | 2 +-
 docs/devel/testing.rst | 2 +-
 qemu-options.hx        | 2 +-
 util/cacheinfo.c       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.21.0


