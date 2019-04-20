Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2625C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 16:18:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7D220854
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 16:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="nneB8Cyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7D220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43122 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHshK-00079i-1N
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 12:18:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHsdo-0004qO-3h
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 12:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHsdj-0001rC-PX
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 12:14:59 -0400
Received: from m12-13.163.com ([220.181.12.13]:43288)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHsdj-0001n1-5r
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 12:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=oUyQJU8PGlb+A9HVQ7
	lz4sdA2kihCE8VrMC1bhuKSQM=; b=nneB8CyzlBBbAiKrdAFcbaNAth16+swYyE
	5FRW2CovR3foF56uznOcLgKROs5doi/CMdGn/zj3yoDc+MYJHSS5PscEkgYS99Z9
	ihtzU70q65KnRKT2geuZa1wr9SKxKmr5TCSMxKIZM+/rbMuel+8OuvejHNymvzSS
	M1fON0I/s=
Received: from localhost.localdomain (unknown [183.159.69.175])
	by smtp9 (Coremail) with SMTP id DcCowAAXzKN4RbtcjaXHAg--.9660S2;
	Sun, 21 Apr 2019 00:14:48 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: jslaby@suse.cz,
	pbonzini@redhat.com
Date: Sat, 20 Apr 2019 09:14:43 -0700
Message-Id: <20190420161446.2274-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DcCowAAXzKN4RbtcjaXHAg--.9660S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RKFApUUUUU
X-Originating-IP: [183.159.69.175]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiKRmcbVXlqvBTMwAAsL
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.13
Subject: [Qemu-devel] [PATCH v2 0/3] hw: edu: some fixes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Li Qiang <liq3ea@163.com>, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420161443.hYwcqwojtXDGy0VXwNFJ2EFY20h_6OpPqCYle-m3ywk@z>

Recently I am considering write a driver for edu device.
After reading the spec, I found these three small issue.
Two first two related the MMIO access and the third is
related the DMA operation.

Change since v1:
Fix format compile error on Windows

Li Qiang (3):
  edu: mmio: set 'max_access_size' to 8
  edu: mmio: allow mmio read dispatch accept 8 bytes
  edu: uses uint64_t in dma operation

 hw/misc/edu.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

-- 
2.17.1



