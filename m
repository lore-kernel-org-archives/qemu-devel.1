Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1510C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 14:55:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9376B20854
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 14:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="eYrXOUD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9376B20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42195 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHrPA-00035X-It
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 10:55:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHrNi-000254-KZ
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 10:54:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHrL7-0001AM-5k
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 10:51:37 -0400
Received: from m12-13.163.com ([220.181.12.13]:58199)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHrL4-00015s-SS
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 10:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=ZH7W34CBqLbmRFqQFr
	lysI2NzwAN4KzYkySetwhA70Y=; b=eYrXOUD1EjqK9R/i0bt01AUsEQJOrn3sUS
	mGcwBwvOCaP+7FUSoBGn+Zq4F1fbOxFXbVmRZKATzB6/KPUK0RrNIrGCjqghQs7x
	M35kydJivaTFiOJ1pGP34B9R70Vj8IxUtDMKLKuJC2IxPMzI4nKRFgPk3BKjKXYR
	ovnd/jPp4=
Received: from localhost.localdomain (unknown [183.159.69.175])
	by smtp9 (Coremail) with SMTP id DcCowABXKKbvMbtc5Pi_Ag--.9861S2;
	Sat, 20 Apr 2019 22:51:28 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: jslaby@suse.cz,
	pbonzini@redhat.com
Date: Sat, 20 Apr 2019 07:51:17 -0700
Message-Id: <20190420145120.122847-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DcCowABXKKbvMbtc5Pi_Ag--.9861S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUUBMNUUUUU
X-Originating-IP: [183.159.69.175]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiTwacbVsGO5mIJwACsq
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.13
Subject: [Qemu-devel] [PATCH 0/3] hw: edu: some fixes
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
Message-ID: <20190420145117.phLytQtD7IXWQd71WgpVUa6nwCr2Cn2zN9fzpj9aWJc@z>

Recently I am considering write a driver for edu device.
After reading the spec, I found these three small issue.
Two first two related the MMIO access and the third is
related the DMA operation.

Li Qiang (3):
  edu: mmio: set 'max_access_size' to 8
  edu: mmio: allow mmio read dispatch accept 8 bytes
  edu: uses uint64_t in dma operation

 hw/misc/edu.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

-- 
2.17.1



