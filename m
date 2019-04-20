Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF07C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:25:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 963B02087F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9kU0ONf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963B02087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37946 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkMy-0006L6-TF
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:25:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shahab.vahedi@gmail.com>) id 1hHkMA-00062C-5T
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shahab.vahedi@gmail.com>) id 1hHkM9-0000xr-12
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:24:14 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:44351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shahab.vahedi@gmail.com>)
	id 1hHkM8-0000x3-OI
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:24:12 -0400
Received: by mail-ed1-x544.google.com with SMTP id i13so5955246edf.11
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=1gKIOZ+EXCFm3CByrF/iqwgRHqRDMVkQpp4q3TfVLv4=;
	b=C9kU0ONf7xFphzkpjo9vnfYm/Rsu+njlvONktZ5eeS8gEBxSD4rk3Nc8/xlDm2MjL1
	k9vuh5ZJaJiNSfEIrrD3RRQDqLJDSsMh/w6ny249kJNiqd2308sRK8l4/Ew6V7tNUpoD
	/NKiXpQFv3MpnhtFsYVvydp/iCkmSTXM6Mxws2kxy/wS5d6LekaP4NkXrNFjTr6gbKE4
	bjAezq8VUJw5cpj6MLh++39MpokoGYsuZWbWH90XWzRFbZnGMxQieEXNXLAGwt7lZlQS
	csnWV1g05QIGH+ABI2IJP/X7TUuHi/PPfQHGhc2pD8kFxwb5+TmavIMWOojHUs/uDHvF
	CnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=1gKIOZ+EXCFm3CByrF/iqwgRHqRDMVkQpp4q3TfVLv4=;
	b=GT5OSaLSU0UVtM4riE93TiNe1mSNsrLsPOWgS2IcUKcwws8vWkZMAoQGU3GCfVG6qf
	vycoiO+g/yq42bxUEOxXJ+XXF0LiSmfhfg4Y9rijTKFoQwYnI770PLfPPOKyhISRXIM9
	LaEi2FdjU365cm5I6J3jECdxSeC4zVEhbnCnDs/7Z2x78b8sgepIu17NmYcOsyEdL1/1
	8NhJKgTfY0OcWhqu9cHeAARO+lJJUpxTaRWw6hDxhwhccS34K0hYAcdUBtk60kNFWror
	xkLB4+EIXaRAMHIZgdUPJAqMAa6K9PHi1fkBc4KG7dFe+dFgwg9jyBx2vgSEiyDUXBJp
	Zcxg==
X-Gm-Message-State: APjAAAWHX1Clypq259AOO+qkWkFqc2wf3ngvOOVtFQK09kkF5Qr41n0U
	+jQsWWzP1ghBrU5FXUVNTnccdrlxCLA=
X-Google-Smtp-Source: APXvYqxKfCPbP8XezfacX6Ul3Ou3Q7/sq2Edp7ckqoJKzcosJsFzNJVHmCm1X4QdFdqlaIpzxyGMeQ==
X-Received: by 2002:a17:906:348d:: with SMTP id
	g13mr3857557ejb.114.1555745050575; 
	Sat, 20 Apr 2019 00:24:10 -0700 (PDT)
Received: from localhost.localdomain
	(ip-217-103-128-141.ip.prioritytelecom.net. [217.103.128.141])
	by smtp.gmail.com with ESMTPSA id p91sm924635edd.44.2019.04.20.00.24.09
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sat, 20 Apr 2019 00:24:09 -0700 (PDT)
From: Shahab Vahedi <shahab.vahedi@gmail.com>
To: qemu-devel@nongnu.org (open list:Overall)
Date: Sat, 20 Apr 2019 09:22:37 +0200
Message-Id: <20190420072236.12347-1-shahab.vahedi@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: [Qemu-devel] [PATCH v3] cputlb: Fix io_readx() to respect the
 access_type
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
Cc: Shahab Vahedi <shahab.vahedi@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420072237.CglzwurWvWdBT1eCoOsNNX0ii_cOJ_Vj4W8oVmtcjPw@z>

This change adapts io_readx() to its input access_type. Currently
io_readx() treats any memory access as a read, although it has an
input argument "MMUAccessType access_type". This results in:

1) Calling the tlb_fill() only with MMU_DATA_LOAD
2) Considering only entry->addr_read as the tlb_addr

Buglink: https://bugs.launchpad.net/qemu/+bug/1825359

Signed-off-by: Shahab Vahedi <shahab.vahedi@gmail.com>
---
Changelog:
v3
  - Only handle read/fetch. There must be no write access.

v2
  - Extra space before closing parenthesis is removed

v1
  - Initial submit

 accel/tcg/cputlb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 88cc8389e9..6d50fcc52d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -868,6 +868,9 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     bool locked = false;
     MemTxResult r;
 
+    /* Only support for reading/fetching IO */
+    assert(access_type == MMU_DATA_LOAD || access_type == MMU_INST_FETCH);
+
     if (recheck) {
         /*
          * This is a TLB_RECHECK access, where the MMU protection
@@ -878,10 +881,11 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
         CPUTLBEntry *entry;
         target_ulong tlb_addr;
 
-        tlb_fill(cpu, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
+        tlb_fill(cpu, addr, size, access_type, mmu_idx, retaddr);
 
         entry = tlb_entry(env, mmu_idx, addr);
-        tlb_addr = entry->addr_read;
+        tlb_addr = (access_type == MMU_DATA_LOAD) ?
+            entry->addr_read : entry->addr_code;
         if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
             /* RAM access */
             uintptr_t haddr = addr + entry->addend;
-- 
2.21.0


