Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73241C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:37:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B01320FC3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gc6M8yD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B01320FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfkq-00007W-F4
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfF4-0004p6-V4
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:05:06 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:43949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfF1-0000R9-8H
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:05:05 -0400
Received: by mail-qk1-x742.google.com with SMTP id j68so142460qkb.10
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=47Bm+ilUjsoqQoc0Msg5H7tt6ZAFbVXOlvVANVjxWdA=;
 b=Gc6M8yD2PJf+m4eJQn/d9k5M5bF7YfbYtb14NoW536wuiAoo+dXW3ZBDn1/7DaX/xD
 wWSNbu0aiTUfBQXtFSKfy/s0o3LbEYwSMRKh91MReJaPxx4HpdIX1bDoeCrQY64WHaqX
 AV1PRhuchKh+lf8Gkqwj8TArkBvxOnMF0v3QF9234LlToVzhm6B39EmAzyniQhWg1yDO
 PzoHtpmJskKHhKADgbh7tcPg4o+wO8S08xySwvTSOPkj6bbxveDDJiqEeXVPhVmioGj+
 wlM6JIN+dPBop+VXHI8V/uid2htTKct6d7aMW7iJwI0zzFSXtJ8slA6YOtrOc6CqoaUh
 iBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=47Bm+ilUjsoqQoc0Msg5H7tt6ZAFbVXOlvVANVjxWdA=;
 b=PnmEglxs0panLFS277ix4vG1RsKNEVS9kekmHdySBvwmzkgmmiZ7wfn+PlseiHf6en
 o7AdCPu0IShisWDF7MMiYVwxN3in3/nm/YFs3b/8JIsbs0P8SD9lw9vN5x6i6o7kZwCl
 0Mx9NpqmEYYtuhGObAw8NAXDdjXOlAffjzhkmltBJGqVGOd9AIaCcThf0cMNlbI8goAa
 fTwtfJ3+PnPn30vIMbTPO1rfCKL0kneM6gYTV1kISyirTL2njJmhFxXoqdMPx/Xiq4Cv
 t8o10YOt61ZpbDAIKIZV7hrEDbhrPtI6bk9ruRtB9C0zl78hVjN8dN5ghgN0Dlnt/Ppi
 ZTLA==
X-Gm-Message-State: AOAM531+PEDtHEIrMjZczQeNZ557bkAlDC7SFF38cvbjkq8S644dZk7x
 hElCM256VUlAgKOOfkctZ6RwpNlmMeqZpw==
X-Google-Smtp-Source: ABdhPJzXnIjcO/f0aD77Htf4KnucFW8nSv7G9/x9WMjQqmt2CCNHQoUrDa/BcrvOEEPsqONI9zmDJg==
X-Received: by 2002:a37:4ed2:: with SMTP id c201mr609785qkb.138.1592427901325; 
 Wed, 17 Jun 2020 14:05:01 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:05:00 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 73/73] cputlb: queue async flush jobs without the BQL
Date: Wed, 17 Jun 2020 17:02:31 -0400
Message-Id: <20200617210231.4393-74-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x742.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: robert.foley@linaro.org, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

This yields sizable scalability improvements, as the below results show.

Host: Two Intel Xeon Silver 4114 20-core CPUs at 2.20 GHz

VM: Ubuntu 18.04 ppc64

                   Speedup vs a single thread for kernel build                  
                                                                               
  7 +-----------------------------------------------------------------------+  
    |         +          +         +         +         +          +         |  
    |                                    ###########       baseline ******* |  
    |                               #####           ####   cpu lock ####### |  
    |                             ##                    ####                |  
  6 |-+                         ##                          ##            +-|  
    |                         ##                              ####          |  
    |                       ##                                    ###       |  
    |                     ##        *****                            #      |  
    |                   ##      ****     ***                          #     |  
    |                 ##     ***            *                               |  
  5 |-+             ##    ***                ****                         +-|  
    |              #  ****                       **                         |  
    |             # **                             **                       |  
    |             #*                                 **                     |  
    |          #*                                          **               |  
    |         #*                                             *              |  
    |         #                                               ******        |  
    |        #                                                      **      |  
    |       #                                                         *     |  
  3 |-+     #                                                             +-|  
    |      #                                                                |  
    |      #                                                                |  
    |     #                                                                 |  
    |     #                                                                 |  
  2 |-+  #                                                                +-|  
    |    #                                                                  |  
    |   #                                                                   |  
    |   #                                                                   |  
    |  #                                                                    |  
    |  #      +          +         +         +         +          +         |  
  1 +-----------------------------------------------------------------------+  
    0         5          10        15        20        25         30        35  
                                   Guest vCPUs  
Pictures are also here:
https://drive.google.com/file/d/1ASg5XyP9hNfN9VysXC3qe5s9QSJlwFAt/view?usp=sharing

Some notes:
- baseline corresponds to the commit before this series
- cpu-lock is this series

Single-threaded performance is affected very lightly. Results
below for debian aarch64 bootup+test for the entire series
on an Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz host:

- Before:

 Performance counter stats for 'taskset -c 0 ../img/aarch64/die.sh' (10 runs):

       7269.033478      task-clock (msec)         #    0.998 CPUs utilized
      ( +-  0.06% )
    30,659,870,302      cycles                    #    4.218 GHz
      ( +-  0.06% )
    54,790,540,051      instructions              #    1.79  insns per cycle
      ( +-  0.05% )
     9,796,441,380      branches                  # 1347.695 M/sec
      ( +-  0.05% )
       165,132,201      branch-misses             #    1.69% of all branches
      ( +-  0.12% )

       7.287011656 seconds time elapsed
 ( +-  0.10% )

- After:

       7375.924053      task-clock (msec)         #    0.998 CPUs utilized
      ( +-  0.13% )
    31,107,548,846      cycles                    #    4.217 GHz
      ( +-  0.12% )
    55,355,668,947      instructions              #    1.78  insns per cycle
      ( +-  0.05% )
     9,929,917,664      branches                  # 1346.261 M/sec
      ( +-  0.04% )
       166,547,442      branch-misses             #    1.68% of all branches
      ( +-  0.09% )

       7.389068145 seconds time elapsed
 ( +-  0.13% )

That is, a 1.37% slowdown.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
[Updated the speedup chart results for re-based series.]
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 accel/tcg/cputlb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 1e815357c7..7f75054643 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -299,7 +299,7 @@ static void flush_all_helper(CPUState *src, run_on_cpu_func fn,
 
     CPU_FOREACH(cpu) {
         if (cpu != src) {
-            async_run_on_cpu(cpu, fn, d);
+            async_run_on_cpu_no_bql(cpu, fn, d);
         }
     }
 }
@@ -367,8 +367,8 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
     tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
 
     if (cpu->created && !qemu_cpu_is_self(cpu)) {
-        async_run_on_cpu(cpu, tlb_flush_by_mmuidx_async_work,
-                         RUN_ON_CPU_HOST_INT(idxmap));
+        async_run_on_cpu_no_bql(cpu, tlb_flush_by_mmuidx_async_work,
+                                RUN_ON_CPU_HOST_INT(idxmap));
     } else {
         tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
     }
@@ -562,7 +562,7 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, uint16_t idxmap)
          * we can stuff idxmap into the low TARGET_PAGE_BITS, avoid
          * allocating memory for this operation.
          */
-        async_run_on_cpu(cpu, tlb_flush_page_by_mmuidx_async_1,
+        async_run_on_cpu_no_bql(cpu, tlb_flush_page_by_mmuidx_async_1,
                          RUN_ON_CPU_TARGET_PTR(addr | idxmap));
     } else {
         TLBFlushPageByMMUIdxData *d = g_new(TLBFlushPageByMMUIdxData, 1);
@@ -570,7 +570,7 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, uint16_t idxmap)
         /* Otherwise allocate a structure, freed by the worker.  */
         d->addr = addr;
         d->idxmap = idxmap;
-        async_run_on_cpu(cpu, tlb_flush_page_by_mmuidx_async_2,
+        async_run_on_cpu_no_bql(cpu, tlb_flush_page_by_mmuidx_async_2,
                          RUN_ON_CPU_HOST_PTR(d));
     }
 }
-- 
2.17.1


