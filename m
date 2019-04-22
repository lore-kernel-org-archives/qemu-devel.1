Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F267C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 14:33:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5542920685
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 14:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="NKo75IKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5542920685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38146 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIa0N-0002lN-Kb
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 10:33:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hIZwG-0007ul-7i
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hIZgp-0005KX-Ml
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:13:00 -0400
Received: from m12-12.163.com ([220.181.12.12]:58409)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hIZgo-0005Iv-PQ
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=gdShkJ1fo0JQH71+PG
	Fu2AsM8rZr3exCeHfzyhjP5uA=; b=NKo75IKAH9uFcZ5PHMg2z7fw4Tj8qui1xg
	hcdAIxHnqxszMZB6pPaKeiaWsvfLFFvqkZhFFCIpuRWeTIeXMX60RfPAdYZNl1Ta
	tydPPba6yxrM7+oxQtKMv4qbrJ52nuM6kxnTfGa6S/bZP/7B5iy2JGLHlGkjgH0X
	pWwkFPadM=
Received: from localhost.localdomain (unknown [183.159.69.175])
	by smtp8 (Coremail) with SMTP id DMCowACXUzO0y71cvQ2cBg--.39054S2;
	Mon, 22 Apr 2019 22:12:05 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: jslaby@suse.cz,
	pbonzini@redhat.com
Date: Mon, 22 Apr 2019 07:11:53 -0700
Message-Id: <20190422141156.15746-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DMCowACXUzO0y71cvQ2cBg--.39054S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUUPEfDUUUU
X-Originating-IP: [183.159.69.175]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBaxWebVetvAtNfgAAsz
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.12
Subject: [Qemu-devel] [PATCH v3 0/3] hw: edu: some fixes
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
Cc: philmd@redhat.com, liq3ea@gmail.com, qemu-devel@nongnu.org,
	Li Qiang <liq3ea@163.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190422141153.0eAnIzZB6iVS9mPZoLaqELoCwIijXk9MWxiEqb6HV_M@z>

Recently I am considering write a driver for edu device.
After reading the spec, I found these three small issue.
Two first two related the MMIO access and the third is
related the DMA operation.

Change since v2:
Fix an error in patch 2
Fix some commit message and title.

Change since v1:
Fix format compile error

Li Qiang (3):
  edu: mmio: allow 64-bit access
  edu: mmio: allow 64-bit access in read dispatch
  edu: uses uint64_t in dma operation

 hw/misc/edu.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

-- 
2.17.1



