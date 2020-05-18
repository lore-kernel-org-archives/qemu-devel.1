Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5F6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:56:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B8F820758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nurR+oeq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8F820758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jai7n-0000e7-Dw
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jai4q-00035E-Or; Mon, 18 May 2020 11:53:16 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jai4p-00005Q-Qm; Mon, 18 May 2020 11:53:16 -0400
Received: by mail-wm1-x344.google.com with SMTP id w64so16421wmg.4;
 Mon, 18 May 2020 08:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bB9pDUjiIlea3U386GXuZY1NOAMaybVFycH+ZuoRiV0=;
 b=nurR+oeqvO38IlVAvYjrxVv0j0dklv6u3yVTDJ9MjtfJGYrgNsKLWs7v/EuSfT1Fyw
 0hekQj/tWlRwGvIoHSlzW9AuZtciTPQcEplw1Pk8G6K0Hbrx+YNLGqJqwsJiwTdGA5Ne
 v9/csSObyWiXDO8tXRQFSARTVgrKmme1B4xlK6G65N3bOCs9+um2jRul25Bre3/UOTza
 OGPqc/K941siuivQI1Wp+Y4WrR+at7LjrzQjI27bJrNP8FSbQYpiJjFPWWuWesiUuFfw
 ukETX0f+LCej7jAyGWg6NyrNnHEv4M8WOryfTbHiRYhmsQGp7mnvZiMDjtMW3y6pEggr
 wGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=bB9pDUjiIlea3U386GXuZY1NOAMaybVFycH+ZuoRiV0=;
 b=WlHbe+mo0ZyXgyxAuHxGxytWvHLKTCfimFvrizz/3t1QpNWNIpfkzTZQGO4kBCA72l
 72jyV28SJHFeO/8nPaCtH4HYkf7kV9DfYBWZmxg09JH1mE+4N+4bQjQG4uxxy7IarcNv
 8Itku3gFx/Oq9aLrI13ONJvtrOtGKO4w+5vDiXHiGHeAcZzwybZgCTSqeO2SG7ZO368A
 hKgcvaMwFGbievygCU9OfDFcig+S3gMZawdwduCwFH+8WMhMaGR6/8H+zCMAxDWEEVWU
 wDxaa3UAQtdPscqX9CpSO95FEuBUqMzqzGGxFtJbmVsHNvThEsOZ43xOk3ZmIbo92Mtw
 TeEA==
X-Gm-Message-State: AOAM532JFbHD+DQIWxHeSLZjLSPVp9mCn2JwRNg9sxFwnZ6aJ5FymaHA
 2eKToqB7FBjpwzCGoKdVb/hlra7jW2M=
X-Google-Smtp-Source: ABdhPJyfeaVjxI8bi3kpjnvht2g384iEYsz/UxrYeBJJDMzC5vFKDJec5j+2beg6JCmhPLXHZGmWsA==
X-Received: by 2002:a1c:6884:: with SMTP id
 d126mr20131549wmc.179.1589817193623; 
 Mon, 18 May 2020 08:53:13 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 7sm17647462wra.50.2020.05.18.08.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 08:53:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/7] disas: Let disas::read_memory() handler return EIO on
 error
Date: Mon, 18 May 2020 17:53:04 +0200
Message-Id: <20200518155308.15851-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200518155308.15851-1-f4bug@amsat.org>
References: <20200518155308.15851-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both cpu_memory_rw_debug() and address_space_read() return
an error on failed transaction. Check the returned value,
and return EIO in case of error.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 disas.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/disas.c b/disas.c
index 45285d3f63..c1397d3933 100644
--- a/disas.c
+++ b/disas.c
@@ -39,9 +39,11 @@ target_read_memory (bfd_vma memaddr,
                     struct disassemble_info *info)
 {
     CPUDebug *s = container_of(info, CPUDebug, info);
+    int r;
 
-    cpu_memory_rw_debug(s->cpu, memaddr, myaddr, length, 0);
-    return 0;
+    r = cpu_memory_rw_debug(s->cpu, memaddr, myaddr, length, 0);
+
+    return r ? EIO : 0;
 }
 
 /* Print an error message.  We can assume that this is in response to
@@ -718,10 +720,11 @@ physical_read_memory(bfd_vma memaddr, bfd_byte *myaddr, int length,
                      struct disassemble_info *info)
 {
     CPUDebug *s = container_of(info, CPUDebug, info);
+    MemTxResult res;
 
-    address_space_read(s->cpu->as, memaddr, MEMTXATTRS_UNSPECIFIED,
-                       myaddr, length);
-    return 0;
+    res = address_space_read(s->cpu->as, memaddr, MEMTXATTRS_UNSPECIFIED,
+                             myaddr, length);
+    return res == MEMTX_OK ? 0 : EIO;
 }
 
 /* Disassembler for the monitor.  */
-- 
2.21.3


