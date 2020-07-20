Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A461C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:46:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67593208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Flshe1/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67593208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxSNR-0003Ri-K5
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 05:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jxRLC-0004Ba-VA
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 04:40:06 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:43412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jxRLA-0003tL-Ag
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 04:40:06 -0400
Received: by mail-pl1-x635.google.com with SMTP id x8so8365949plm.10
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 01:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/nuG2E0B/JbUdZcHseBuYWsvXaz85mIT+3czxv26BCc=;
 b=Flshe1/+f/7M8YrKHsjomEFIq3zb7FxYHCiVc6eABBz0nzDRzVPvS38+xWfleLIw0X
 hDZNB3spMHRaKM5hKX0ZSNT7bCe9zV3AWng+t34avar3xC+gUp67d7BsfZL1WXxfwTDe
 m7sg12f2RFM8PcqVqG+v+rXVNbhUE0WNohwvz/1EMvBZFu/yutPRro6S4uYh2AiY9Khr
 17v5EHMlVCILOLA2uKsta5ImGeZeGhXtNjaS8FVwbRjYqG8nVEFieZEkD4NU4ahhAVFS
 pxRxg/z74KF0fTr4on3AcqtfWKRRaIcpeI0s6X/PrnWmcnglycB1vnKUOK+8Ccew49XW
 mVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/nuG2E0B/JbUdZcHseBuYWsvXaz85mIT+3czxv26BCc=;
 b=QmG44q1tPTLcoaSX5feUh8o8+55psLJfDnP3xViAlPG4W+k19BVB4T9UtMX71R7xg7
 u8vECaqKiFD6UsVUO2HHDIFw8wOf8tMw3et5QLHCw7Z3xR7TqMXPN/6jR/eHeqKh+cga
 io3GVvKX+1jRFRs9hE9j0gswmQFo9SW8evAbQfL5SrPDO6bJAmdb53AaLMs80kfZiNKf
 lkUhQLIhqCuSbaGbRTt7sKHj22uUc8vUFWQq4kx5+BkWZrtaSlZaNnF23YAzT6/I6hLG
 U7K45iIGlyt2juXCTMwC9WZmU/yADunf3Ca/HnZDngSQpP9cTyF8FswLxQN9pa63+80t
 gUDQ==
X-Gm-Message-State: AOAM530gtg34BaqVh+q9RsguzSithBuUYrfclYE6GFq2sJKhtyANhHBj
 LK1a11w/rsK8Rk4zBFzDCGnxYw==
X-Google-Smtp-Source: ABdhPJyVGQZwDfUrNMaGzWwmGUHdlliGoYQSkZaQZE0R4lrvp/oqIjaVeFw0NFIwcFBc/z1SDtCV3A==
X-Received: by 2002:a17:902:ee94:: with SMTP id
 a20mr14781358pld.337.1595234402342; 
 Mon, 20 Jul 2020 01:40:02 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id o4sm11388151pjo.16.2020.07.20.01.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 01:40:01 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 0/2] Fix some PMP implementation
Date: Mon, 20 Jul 2020 16:39:55 +0800
Message-Id: <cover.1595234208.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=zong.li@sifive.com; helo=mail-pl1-x635.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 20 Jul 2020 05:44:42 -0400
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
Cc: Zong Li <zong.li@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch set contains the fixes for wrong index of pmpcfg CSR on rv64,
and the pmp range in CSR function table.

Zong Li (2):
  target/riscv: Fix the range of pmpcfg of CSR funcion table
  target/riscv/pmp.c: Fix the index offset on RV64

 target/riscv/csr.c | 2 +-
 target/riscv/pmp.c | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.27.0


