Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9E7C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0072C22CE3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0072C22CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Vjk-00017r-4W
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Sandra_Loosemore@mentor.com>) id 1i0Ul0-0003Nf-3J
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Sandra_Loosemore@mentor.com>) id 1i0Ukx-0005Or-UV
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:50:49 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:13357)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Sandra_Loosemore@mentor.com>)
 id 1i0Ukx-0005KR-Mx
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:50:47 -0400
IronPort-SDR: +A+Wp4hBlLGtkKtUrUkTwM0tpxuDyz31rUSjuQ9UZHUha7K3ja8HpGqxnsOzU5Z0yFPZFOj9PR
 MbE25HIO64Kerwj/57s3gAen1QNasel2C2joid7Me+MHCh4O54GBmsbyNnMckQj65xmMHSItc1
 x/R+5hy4qU7477XDAyC/ax+WXSGg6e70uGUmdvOOZyKxbLROLqEt/JF3CenKPjk+obePP5Vf83
 gauuqy0vZkvujyPN2DvxJQhvooFxMurPYWYZ6JvNUVbrf/aB0+hGavnBVhZsXPkDhCnVCVBSBo
 uvI=
X-IronPort-AV: E=Sophos;i="5.64,412,1559548800"; d="scan'208";a="40657526"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa4.mentor.iphmx.com with ESMTP; 21 Aug 2019 09:50:45 -0800
IronPort-SDR: EIO72mkLIWJFWvMcIj73Pw/rRibRaAhNqYhIxnWsXWujDSMhmMqu8cQeHWi9LYsIWbTNhVPS7F
 f36DyAHM0rk2fiKxZZHUYITC7j3QI87/B9VVHTlrac8r2fh20YKKIuC5qfqEPRLjDBGoUYDGgn
 qrJkSTCSOWqwfUrPem7Y61vROpbxqv+ci+e/lLWdqa5Vw21SrRJjHwxHJFWyvanv05mu3EG6gO
 JGLJK4G7lg+YlDATd9PKEpRfcWHIcSuldZgZkNmWq5qE1UWNpcuSBXnxFCtq0Uq1YBVx2A7en7
 gVw=
From: Sandra Loosemore <sandra@codesourcery.com>
To: <qemu-devel@nongnu.org>
Date: Wed, 21 Aug 2019 11:50:27 -0600
Message-ID: <20190821175029.21868-1-sandra@codesourcery.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SVR-ORW-MBX-07.mgc.mentorg.com (147.34.90.207) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.137.252
Subject: [Qemu-devel] [PATCH V2 0/2] Fix bug in nios2 and m68k semihosting
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
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I noticed recently that the exit semihosting call on nios2 was
ignoring its parameter and always returning status 0 instead.  It
turns out the handler was retrieving the value of the wrong register.
Since the nios2 semihosting implementation was basically
cut-and-pasted from that for m68k, I checked m68k also and it had the
same bug.  This set of patches fixes both of them.

There are no changes to the actual patches from V1, only more
informative commit messages with links to the respective semihosting
protocol documents in newlib.

Sandra Loosemore (2):
  target/nios2: Fix bug in semihosted exit handling
  target/m68k: Fix bug in semihosted exit handling

 target/m68k/m68k-semi.c   | 4 ++--
 target/nios2/nios2-semi.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.8.1


