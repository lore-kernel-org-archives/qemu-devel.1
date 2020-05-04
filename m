Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17B5C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:07:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9410E206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9410E206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVZsm-0007Jc-O7
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjr-00033m-9p; Mon, 04 May 2020 07:58:23 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:41055)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjo-0001zK-VS; Mon, 04 May 2020 07:58:22 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MLyzP-1jnW5l0VaD-00HsQV; Mon, 04 May 2020 13:58:04 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 03/20] timer/exynos4210_mct: Remove redundant statement in
 exynos4210_mct_write()
Date: Mon,  4 May 2020 13:57:41 +0200
Message-Id: <20200504115758.283914-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504115758.283914-1-laurent@vivier.eu>
References: <20200504115758.283914-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rGPmTbt3LS78KZblEyLnOBFOGWdEOJIuW7LeCx9f7iNzdLmp2Lj
 MzlPvWoRUqDr4hftXRpUfCkZ+eu/L8o1FwdUoZIscg4UsGuLngTWEI8luCNcA9ULd8RyMpI
 ESycGUHZjkaBLlzuN0t6tG8TJKAdmFY0yhVhk/K4zwt6GCDOHxVNMdpiJD2JppGFgCN/1hC
 jZjpWN1myU3sPr5drXerg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oIhUnmCaHA8=:i1Umx/M5mqCude2CXClJ6q
 zhUjfRd7IHXVe4z3jLXwNQ1jk6UOfz/6jpQRFqr8ejnISHO3sODrX4ZQO8qlTrRMJ4hpOQqhw
 KpeLbs4SORsLKtma75BuEt4yU+CXbaDY2UFeDyb+75IFKLobS6bP+PfmqnmlG3yfTCGA9pWXk
 5HTzy+zLin6r1klIhXL5u4XacdP8O/yhLl41lEIl/4SWsh2XefzTWJdjAb1oVIhWlxroSxF98
 Qz34YvvF4qpvHXPnAYBcWqGt8umAT91rNwPxMvej+xcfgopk6mGzhA7IS8FNS/aUHZA4n8ohV
 ViCVTT0u43oMiUXHdnRgBchq9JYtBRC0RgnL+y9swFACaTM1T7KdxNKMj6SJ3h6cGnG/hGwtH
 0OyHBSGRzcbRIv+HhgIBXmpdibogFJz5MfkCiXK/aOgWAkM50xBtssSZ9nBcCaO9Wa8jXTrWn
 7Eeq9ZtfTGPjKXiK1htdyuGt6+VOQ/kgK+09NGctibO6ZULGT5dCdNi4fD7d3y0wXAqA1hKv9
 Sucaz4tDGof8Wd9a5x9OEYtUCq2OQpw6uJor8ogruV2ecoMeWOvbHK0wJeKKZxMYXZOeSSduj
 lGbUYYjxAkuSdRArSZSJgyEOZjRjVRTXc0zmQgEdYaC7UrO3QreSTfh5onc/o6Xe55lLHp3OR
 OlCJvV2uHtyphJGABHMlZwliok04mDBDMAnhD2D0YzXKGUfQHjDotIM1hmXwMZ221DwVCxzbx
 Zt817jB+p/i09Uv2Rtx1hXn9JUJsarLsFItHghBqq+2pJ5ehERtG4F+9yynucmQnQvYLT4t6K
 7X3K7ayZ9xoI+k5v6B8T0zirQ8GBUi3qYQIErnLV3RS3sWAbNp091P4ZGvMf/VZdJwY9Y8j
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 07:58:12
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <alistair.francis@wdc.com>,
 Euler Robot <euler.robot@huawei.com>, Chen Qun <kuhn.chenqun@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

Clang static code analyzer show warning:
hw/timer/exynos4210_mct.c:1370:9: warning: Value stored to 'index' is never read
        index = GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
        ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
hw/timer/exynos4210_mct.c:1399:9: warning: Value stored to 'index' is never read
        index = GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
        ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
hw/timer/exynos4210_mct.c:1441:9: warning: Value stored to 'index' is never read
        index = GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
        ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200325025919.21316-4-kuhn.chenqun@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/timer/exynos4210_mct.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index 944120aea59c..570cf7075bc5 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -1367,7 +1367,6 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
 
     case L0_TCNTB: case L1_TCNTB:
         lt_i = GET_L_TIMER_IDX(offset);
-        index = GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
 
         /*
          * TCNTB is updated to internal register only after CNT expired.
@@ -1396,7 +1395,6 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
 
     case L0_ICNTB: case L1_ICNTB:
         lt_i = GET_L_TIMER_IDX(offset);
-        index = GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
 
         s->l_timer[lt_i].reg.wstat |= L_WSTAT_ICNTB_WRITE;
         s->l_timer[lt_i].reg.cnt[L_REG_CNT_ICNTB] = value &
@@ -1438,8 +1436,6 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
 
     case L0_FRCNTB: case L1_FRCNTB:
         lt_i = GET_L_TIMER_IDX(offset);
-        index = GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
-
         DPRINTF("local timer[%d] FRCNTB write %llx\n", lt_i, value);
 
         s->l_timer[lt_i].reg.wstat |= L_WSTAT_FRCCNTB_WRITE;
-- 
2.26.2


