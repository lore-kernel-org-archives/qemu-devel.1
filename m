Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE3EC43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 05:00:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4EB1206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 05:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GY9LrQ8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4EB1206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39310 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJsyW-00055T-4B
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 01:00:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsmp-0000dE-QC
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsan-0004At-D1
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:11 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:47038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJsan-00049A-6F
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:09 -0400
Received: by mail-wr1-x443.google.com with SMTP id t17so2382916wrw.13
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 21:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=4Mki3u5Axs2FRS0efXqNNApR2bF0/XeWqjcomZbqTxU=;
	b=GY9LrQ8IXGtICPBhlkwWI1Xv0AGIkzI93Bea1Qe+6wuRhePkBO0RchOaQOQhb5+thX
	O4vExu7u4rJos4hsfUxZbuzf+AHEybcLYzp+fDxJOPBOkr1uIXn2hEraEYrT5fasOktq
	t2W2CAP52p1Wb/UHvWPx9JdRNC/XogYWFoyjWzRtWFS96sLTltFVJ9SALPOOHYafYXsr
	mCmCYIjoqIRHEF7xOQhJQYZphr8UngKqavxjRF6TECNTdQSiq0T7bRzYPxzNjtsAmc8F
	Tj1GLR3gIhkv/J+HEoXesJJsdcb6MxNxqMOouklNn/2pDQquahdlt6BFNw4DaXiBiawv
	3Jfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=4Mki3u5Axs2FRS0efXqNNApR2bF0/XeWqjcomZbqTxU=;
	b=A6qafwQ/R33WgYxltt6vX93PVDjUhBAKoNW8c9UDxiaCQwUvBwPsI7eaMmCLejMBdE
	RIMGCPn2mLaGRM8CfzO/VLgDELh3eVEAtcNz9kF0PMguyL4js8RRZ/ho9RTFdG93uDsw
	47HFR24vb50LoVyb8i2+OxCwq6URpeT8A5tX8UOpc/aHmAcjGFHIqfxJ/LiTsQ1NqGpB
	wXLyP4hxXpYnRaChsNTH/RLulzvaV23YI9Kn5/UB0rTkiu9+N1iRD8wGFU3EjfQIElQx
	FNPI4bvlKqMDjGUbu0crTSTdno+OO+s8BEsgr0oB8Pq0BCY32H6Ym7Ox94zNthdqj85H
	z2Iw==
X-Gm-Message-State: APjAAAXiUVvm32lPe2EfGFctOZj0WY1rbIdwBaVqDpZHdIJx/8tLHaWq
	CPrRjRhvOzD0CX+ia/8uqN8ujc5B
X-Google-Smtp-Source: APXvYqy4l75JK9ebm/d+exmSLvOQROFD05CGum7rENOo39xEaxPQCEHpRo6ynEBK0A2GP/gHiWKHWQ==
X-Received: by 2002:adf:db8a:: with SMTP id u10mr15817205wri.82.1556253366949; 
	Thu, 25 Apr 2019 21:36:06 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id h5sm3467088wmf.38.2019.04.25.21.36.05
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 21:36:06 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 07:35:37 +0300
Message-Id: <20190426043558.6888-1-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v7 00/21] gdbstub: Refactor command packets
 handler
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
Cc: alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426043537.U42G_yf2M7eK5GU8JjuhzHjqGG6SgkWZaczKpplZRsA@z>

This patch series refactors the old gdbstub command packets handler
with a new infrastructure which should ease extending and adding new
and missing gdb command packets.

version 7 changes:
- Fixed few checkpatch complaints
- Feedback from Alex Bennee

version 4-6 changes:
- mostly feedback from Richard Henderson

version 3 changes
- Split the single patch to many individual patches for easier reviewing

version 2 changes
- Code convention fixes

Jon Doron (21):
  gdbstub: Add infrastructure to parse cmd packets
  gdbstub: Implement deatch (D pkt) with new infra
  gdbstub: Implement thread_alive (T pkt) with new infra
  gdbstub: Implement continue (c pkt) with new infra
  gdbstub: Implement continue with signal (C pkt) with new infra
  gdbstub: Implement set_thread (H pkt) with new infra
  gdbstub: Implement insert breakpoint (Z pkt) with new infra
  gdbstub: Implement remove breakpoint (z pkt) with new infra
  gdbstub: Implement set register (P pkt) with new infra
  gdbstub: Implement get register (p pkt) with new infra
  gdbstub: Implement write memory (M pkt) with new infra
  gdbstub: Implement read memory (m pkt) with new infra
  gdbstub: Implement write all registers (G pkt) with new infra
  gdbstub: Implement read all registers (g pkt) with new infra
  gdbstub: Implement file io (F pkt) with new infra
  gdbstub: Implement step (s pkt) with new infra
  gdbstub: Implement v commands with new infra
  gdbstub: Implement generic query (q pkt) with new infra
  gdbstub: Implement generic set (Q pkt) with new infra
  gdbstub: Implement target halted (? pkt) with new infra
  gdbstub: Clear unused variables in gdb_handle_packet

 gdbstub.c | 1671 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 1185 insertions(+), 486 deletions(-)

-- 
2.20.1


