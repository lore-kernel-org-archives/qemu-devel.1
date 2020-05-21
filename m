Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A644C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECCF22072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zuhg0Qro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCF22072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboy5-0003LD-45
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJU-0005Bk-Kp
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:56 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:45014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJT-00070A-9a
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:56 -0400
Received: by mail-qk1-x742.google.com with SMTP id b6so7816260qkh.11
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Un0q+TORCXPo2kVgpbtgd18wfbS4+otCPFQoRusR5X8=;
 b=Zuhg0QrosnDSJQQxuQjaE/0Eu0Js7LvHll0Nvbo2CnQtqJVgS+XrY6NeZ7LnkEqn48
 T+zYdv2JQVHfhRdFU28o9OsIloC3ngptnf8RMaWErOGe4W9kF4y7Qx7vEcjiKwdGC29T
 jGhVIo6VQRIuMRcLHUVaMlBU6cxWMlgKfOG4E2Bj0PJd1NFQbUziCU02+IsapsMZhVny
 O2RESxqHKCLGIShZNIPbvlGwfgTNzJFubrWvZV8/oyIJDPQXBtpVWGLRC0NZDxqxAJuM
 NIHb+7PqRHhbxm46gw0Nbnl87ZbVQ9gdVkxvp35bk5ZQkvNDQa5dNUhy31L5pSxNVNYN
 UzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Un0q+TORCXPo2kVgpbtgd18wfbS4+otCPFQoRusR5X8=;
 b=T0v23/QoqMWsQB0WuhBgmc6jddcEU19q1lrQFlHUX/ccNJzldD0aK6GNuNaX5QdMVj
 XcYTC+bVkF6xmQuPdFu1TR6vCNwJw3RiKlJPKC7OHHxey79Qp19SfsVLbaaiKHOHMH4L
 n0CNkyEBCcbX9jijZLJkcucxQCEzUsDz2xMtYYQtfq9MpFHuzibN/GxQ9ADCC99ES2GY
 saP2K3DC4VGsHYecuaE7XvvQ5qOrsc28rfpsUaEV2bc5E5X0tsq/rWDn7p6pvx1IgBhh
 0sG4UjiWxBpm3ZsySSU9Qmd/Wd5xBYETjr4oKGweG5MWNrAi6GHKYZod+O2Ieus0+X14
 oohA==
X-Gm-Message-State: AOAM5331HJKBjXpP2iY0Q4HoIJbGwxbcqJv7p3PFrRU3Ah5M3yQU+Zn5
 z8WXjBHAAiJF19FJYY3VEPszxDe49U158g==
X-Google-Smtp-Source: ABdhPJzMblJhAhzoYHS5DfaBinSuUyW+zVxNd3v3lVSB1hOavCWX4tXZAOwexRuTdCuRP+tE4cWLqQ==
X-Received: by 2002:a05:620a:1524:: with SMTP id
 n4mr10997938qkk.490.1590079493846; 
 Thu, 21 May 2020 09:44:53 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:53 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 74/74] cputlb: queue async flush jobs without the BQL
Date: Thu, 21 May 2020 12:40:11 -0400
Message-Id: <20200521164011.638-75-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
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
Cc: richard.henderson@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

This yields sizable scalability improvements, as the below results show.

Host: Two Intel Xeon Silver 4114 10-core CPUs at 2.20 GHz

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
index eb2cf9de5e..50bc76fb61 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -284,7 +284,7 @@ static void flush_all_helper(CPUState *src, run_on_cpu_func fn,
 
     CPU_FOREACH(cpu) {
         if (cpu != src) {
-            async_run_on_cpu(cpu, fn, d);
+            async_run_on_cpu_no_bql(cpu, fn, d);
         }
     }
 }
@@ -352,8 +352,8 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
     tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
 
     if (cpu->created && !qemu_cpu_is_self(cpu)) {
-        async_run_on_cpu(cpu, tlb_flush_by_mmuidx_async_work,
-                         RUN_ON_CPU_HOST_INT(idxmap));
+        async_run_on_cpu_no_bql(cpu, tlb_flush_by_mmuidx_async_work,
+                                RUN_ON_CPU_HOST_INT(idxmap));
     } else {
         tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
     }
@@ -547,7 +547,7 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, uint16_t idxmap)
          * we can stuff idxmap into the low TARGET_PAGE_BITS, avoid
          * allocating memory for this operation.
          */
-        async_run_on_cpu(cpu, tlb_flush_page_by_mmuidx_async_1,
+        async_run_on_cpu_no_bql(cpu, tlb_flush_page_by_mmuidx_async_1,
                          RUN_ON_CPU_TARGET_PTR(addr | idxmap));
     } else {
         TLBFlushPageByMMUIdxData *d = g_new(TLBFlushPageByMMUIdxData, 1);
@@ -555,7 +555,7 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, uint16_t idxmap)
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


