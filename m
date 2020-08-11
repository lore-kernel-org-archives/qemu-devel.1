Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA80EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D215204FD
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Y/s45AAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D215204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5QAk-0007Bh-JM
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 05:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1k5Q8V-00046k-ME
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 04:59:59 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1k5Q8T-0005UP-QU
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 04:59:59 -0400
Received: by mail-pg1-x543.google.com with SMTP id o5so6410572pgb.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 01:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=M1/+lOZ3eparg8aTsL9UyW6fv03iFO6q1sofLNzR6pU=;
 b=Y/s45AAZ/jqdV/jvhnnTqDk/ExAahyjXO3UrxR3kS8ruuKalIhkmD0j+myFvHhyAjQ
 1OziUe8NX45n8d5bdQSGGomsR0NWEpMA2YtcsSuZvaL2vftf3zvy3zLzbheiJ5bju30L
 bO3EOr9dFm0amFZ/GWtFmPJFkGjnFAz/XqtQMFeZ1Zutu9TYEFaUXJC+nNDWlBW5rRKk
 EmBySFG5oboS+5Pre7JBvkPg/sMtxNG0BS+vDsi1Rsi4+IfiBTka4DxkblPsOOxmSudy
 Q+VG/seKa6SJsBV4MgmqpLhNXT4IH08CS8QunTGre3r8KFz3XVmiMgwdfSY0LawAZjqj
 ueng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=M1/+lOZ3eparg8aTsL9UyW6fv03iFO6q1sofLNzR6pU=;
 b=XVD1VDXU9BahFz3pb3mrDAOI3rJsAbeYPwyLDEX/2siFCdt0pTNUTjwExFU8cj0ti1
 d+yt4z2p4lZWmYB1l/L+iOWhh2TzqICgh35mX8IY7PVbAiEVNTKLyZBnLeS0zGXvLzAK
 zIXd6wrL+f630jP0DWbVQWfhMIwQCEkpsVU2z7zGeQjNLtQvF6/VLD3Hil0xLd12VhLi
 7NCtMaMzBDOUkBbv7ooF8xaLB1RzX3ITCBNkUPuhxOjslKSlxxffreDhe/+Edcv9hW/l
 /bRWghalhcpZHJfejBW5byffAfjmaT1DWPHkUTZGKueObdCZZ3KnxAPDfs9ljANuEiri
 68wA==
X-Gm-Message-State: AOAM532l7O/jPc60zo4BJp21Ujia7dj94Qjs4SLyFAt6DTC6hSfDpv5/
 ZZPeZCiM2b+pLBEJZQpUbVNN6S/t9v2eyw==
X-Google-Smtp-Source: ABdhPJzrJ4IuuFf+rKOGWkFJpKbJDJCIsdRwm1IsxT0xFwEpUmIrrvgkM4jh57nMkxlln4EUVnBfwg==
X-Received: by 2002:a63:f84f:: with SMTP id v15mr22210pgj.386.1597136396176;
 Tue, 11 Aug 2020 01:59:56 -0700 (PDT)
Received: from gamma11.internal.sifive.com ([64.62.193.194])
 by smtp.gmail.com with ESMTPSA id w10sm1282499pjq.46.2020.08.11.01.59.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Aug 2020 01:59:55 -0700 (PDT)
From: Chih-Min Chao <chihmin.chao@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 3/3] target/riscv: support 'x-k' in cpu option
Date: Tue, 11 Aug 2020 01:59:26 -0700
Message-Id: <1597136381-17296-4-git-send-email-chihmin.chao@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597136381-17296-1-git-send-email-chihmin.chao@sifive.com>
References: <1597136381-17296-1-git-send-email-chihmin.chao@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=chihmin.chao@sifive.com; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Chih-Min Chao <chihmin.chao@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

zfh extension is still a draft and is not included in master spec. The
related field, 'k', in MISA is also undecided but has been discussed in
reference link.

  ref:
     zfh spec: https://github.com/riscv/riscv-isa-manual/tree/zfh
     misa field: https://github.com/riscv/riscv-isa-manual/issues/414

Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>
---
 target/riscv/cpu.c | 4 ++++
 target/riscv/cpu.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 228b9bd..8ad8782 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -469,6 +469,9 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
             }
             set_vext_version(env, vext_version);
         }
+        if (cpu->cfg.ext_k) {
+            target_misa |= RVZfh;
+        }
 
         set_misa(env, RVXLEN | target_misa);
     }
@@ -509,6 +512,7 @@ static Property riscv_cpu_properties[] = {
     /* This is experimental so mark with 'x-' */
     DEFINE_PROP_BOOL("x-h", RISCVCPU, cfg.ext_h, false),
     DEFINE_PROP_BOOL("x-v", RISCVCPU, cfg.ext_v, false),
+    DEFINE_PROP_BOOL("x-k", RISCVCPU, cfg.ext_k, false),
     DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
     DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
     DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6a077c1..bdef2a8 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -281,6 +281,7 @@ typedef struct RISCVCPU {
         bool ext_u;
         bool ext_h;
         bool ext_v;
+        bool ext_k;
         bool ext_counters;
         bool ext_ifencei;
         bool ext_icsr;
-- 
2.7.4


