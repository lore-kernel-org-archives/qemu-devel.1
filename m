Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C62AC04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 19:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD747208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 19:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fintelia.io header.i=@fintelia.io header.b="iCGNNjFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD747208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fintelia.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34276 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQH5z-0004ZT-6f
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 15:58:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38969)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
	id 1hQH43-0002pf-Ql
	for qemu-devel@nongnu.org; Mon, 13 May 2019 15:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
	id 1hQGs2-0006DQ-29
	for qemu-devel@nongnu.org; Mon, 13 May 2019 15:44:23 -0400
Received: from rs224.mailgun.us ([209.61.151.224]:35386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from
	<bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
	id 1hQGs1-0006BQ-ON
	for qemu-devel@nongnu.org; Mon, 13 May 2019 15:44:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=fintelia.io; q=dns/txt;
	s=pic; 
	t=1557776656; h=Content-Transfer-Encoding: MIME-Version: Message-Id:
	Date: Subject: Cc: To: From: Sender;
	bh=JFArtSKxX6WxWKnDEeGgk0yfPgX6AyEApuoe0fykhQU=;
	b=iCGNNjFGvqSOur+4PA2HWAJUMHkGuaRttAPFSZPY5A8mjB1OMTgKa5Grbqz64TkkIMkdYdx+
	8GG5FOaioRdFsLPXqcSg3cs+FWtSjT7NTYXhHcTgdeZ+f8Q3xtz0vdO5XVc59gnCMF0rAKW2
	4upQ7YL4DB/QjGTygxu16BTPlwFQxZSepy6DteOD7rqZ/3UORVKri/9/y7gXaP0aLSUSfCPs
	l612nxvNcAcKQfSKxKD2CADCdKWNVCE+syO9F7Cg5PEJkH1tScV1uPwa1KVurwkRShoeSa9i
	NgzXLuNitL963+hZQt0z+3dFrAo4WF2I0WAOAS5PFn1MLSyEB+vX4w==
X-Mailgun-Sending-Ip: 209.61.151.224
X-Mailgun-Sid: WyJlMGM5NSIsICJxZW11LWRldmVsQG5vbmdudS5vcmciLCAiOWI0ZTc2Il0=
Received: from jonathan-ThinkPad-X1-Carbon.csail.mit.edu
	(30-9-187.wireless.csail.mit.edu [128.30.9.187])
	by mxa.mailgun.org with ESMTP id 5cd9c90e.7f66b0793030-smtp-out-n03;
	Mon, 13 May 2019 19:44:14 -0000 (UTC)
From: Jonathan Behrens <jonathan@fintelia.io>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 15:43:28 -0400
Message-Id: <20190513194328.11045-1-jonathan@fintelia.io>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.61.151.224
Subject: [Qemu-devel] [PATCH] cadence_gem: Don't define GEM_INT_Q1_MASK twice
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Jonathan Behrens <jonathan@fintelia.io>, Jason Wang <jasowang@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Jonathan Behrens <fintelia@gmail.com>,
	"open list:Xilinx Zynq" <qemu-arm@nongnu.org>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
---
 hw/net/cadence_gem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 7f63411430..37cb8a4e5c 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -146,7 +146,6 @@
 #define GEM_DESCONF7      (0x00000298/4)
 
 #define GEM_INT_Q1_STATUS               (0x00000400 / 4)
-#define GEM_INT_Q1_MASK                 (0x00000640 / 4)
 
 #define GEM_TRANSMIT_Q1_PTR             (0x00000440 / 4)
 #define GEM_TRANSMIT_Q7_PTR             (GEM_TRANSMIT_Q1_PTR + 6)
-- 
2.20.1

