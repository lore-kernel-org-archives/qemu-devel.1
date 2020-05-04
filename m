Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A34CC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9B0206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9B0206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdd0-0005TN-35
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdVw-0001Lp-8z; Mon, 04 May 2020 12:00:16 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:56981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdVu-0005mW-P4; Mon, 04 May 2020 12:00:15 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MvKL3-1jEWKe0HpZ-00rG6w; Mon, 04 May 2020 18:00:01 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 03/19] timer/exynos4210_mct: Remove redundant statement in
 exynos4210_mct_write()
Date: Mon,  4 May 2020 17:59:40 +0200
Message-Id: <20200504155956.380695-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504155956.380695-1-laurent@vivier.eu>
References: <20200504155956.380695-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:paz9/bvncpBWsqHW9t2TuKD0ps6SneGJH8nwahoV+3Ri8q/Im0R
 wlkELu5ph6nHShm40akaOzorNnURt5WjuImtbVtLDW8l6wkJwSukYKQsJdj28mFOQ/kCkCy
 XQpw2PS5bx2j93h31Pa63eXA9oIj0UozsCQbdYoAoQBQ/59NtwHerKRDCrSG6Ee9EwyOt6a
 Uk8lOLTEK0DHmTR30T9ZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U1WhiSg4V3c=:fJ4/U+5NyAqn5h0JCB8Nj5
 XnNRLs3TS1OZ3B2kDchY6fOH/+V8oRJeDA9JoQzfjKiB46d9HlztumtuSTaeeDKdzDK5ATsX6
 +izdejLL7sN9RWLUlXe6wyes/Ujxel9lu9cSsRn/w3TwoSImRKVQTlUDjew3VzMwsChBqr03I
 mwNYz7Iphyim+6vtoGQ5fjWLppHdzYg2mmXuwFA6FaboDCHSnnfAr8IEdYjurhHy+IXUo1Se4
 y6fQv0jY3GDUuqfiHdZ2MVvkxIthYgih04yh9tJd4U1qzDV8mAF2wdAEGGmBPVoqaljvm2it4
 h2AI5JlVBAQjoEDkmRKb49jyLKiRINAdmDMc9S64kw/H2KzmnTuNFafAUHhXxYZ+mQLctcZld
 yAiy3qNhGAiobRf8/yPYCDCqtFg8hOYeO1MChLfxqMEM5jw8z74zdvtmLu+YaZj6c5ryDcD35
 3mJ6Nj0lMqinSSytR/csgy9sRsqWkuG1L0macXVo8O4lhcIEL81lX6CVx3bAPH1XZQpOZrok2
 F8RFUdDxO/R9zRXZ/KSXYZv2wRCPSkzZEzd0MOv5wtmjqVDf8bKa6JheCpGiDoL0B8FjXurXd
 oQ2tmYrPYbMkwIgJQGWMtwzQiuAwd1sgbSOtw0SK8ZcAojTDYk/ps/qBnsqImIQS42vQR7Lza
 XziOpj1GpHh9siS1rhGqOTbYnmQ51cU+JokXTg+QMwe3ZB8OMaW5vqSBdlsRbdXwDsZRwY0oC
 E7rsvaIczGNQcgcLyEvIqZGKmO6E+ppwiMbpqy3Z5iDuIAZjfJPfpfJ0Da9t8YpLwt+BKpjcz
 AK9SZ2Exp/WzjVdhX7TkGZVJ0G1hPTAlW2ihd083ALCkw/LD8UkFge6JMH1v9/PKFnm15jz
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 12:00:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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


