Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04035C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C83E6206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83E6206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdfq-0002vy-P4
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdWC-0001ZQ-FV; Mon, 04 May 2020 12:00:32 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:45005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdW4-0005vt-CF; Mon, 04 May 2020 12:00:30 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M6DnM-1jTPWT0W6a-006j4Z; Mon, 04 May 2020 18:00:17 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 18/19] hw/timer/stm32f2xx_timer: Remove dead assignment
Date: Mon,  4 May 2020 17:59:55 +0200
Message-Id: <20200504155956.380695-19-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504155956.380695-1-laurent@vivier.eu>
References: <20200504155956.380695-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qxdoGuaJgcZVXFMomeoMipdxOGTmfRSKzrzZ1+ElAkoow+kUJ83
 u8od6N6H5ai8BOX1hN9KMddULnYP4insHijJG6CkRSw+xhEO7zs0AfMIjHu6q1q3zLon1uV
 iUhPOeshATsMc3vRBaou2OlM8jJnTNUXGoHHfkQO6/5OJssIJkLuNVOpTb0yuccM9TfcCRo
 2BqepeuXLSb/FVAglxl4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L5QC1KieNE4=:BOwao/wXgbG5vjRfiqbkCo
 pnDCpd0wOj2sXIdKAL0yDgJ+sgwfEKQEUs35OJ6uoOO3rujEnQlDaxODQpS7GQ/bDUxIE8cX7
 zJYA7IhAkeHOdyAZdvAFkOOym+pepR+k9Eaa/pOW0VgJxN+UKehkbZuxBoeSTwxGEK/+Hh5Nw
 5hNscS7h47/hGJ2p5ZE0yg3fCP3mGv8ppFk90xPhadHw0q2PKJo4R1PCkbYrgyXoI4IhQilXO
 3o2zhs1pIc/mVa4l6SpdsXMKHg6GKHxB2ZDZ/R/LOuNek5Fx6FWDNrJUezjq+1LJwF8sqXssx
 FoCmgctiVDKxh16ipZ4HtbrGFZkb29O6fvXf2+xWp959LdCIQ5l1MLu0ZGI3y0OFW07rgGhDX
 crt0Xu0UbEkDyFNo40/m8xO5LmsYQ6MqB1bs664d3/xkGn5fs6Yz3J7wyghYm9Qx4MMnSxmQY
 4jjK6pMWxu27VXy1TDMMZA+djTdEPVvw2f17x9lwAD6/7wSSBm+j0r1hZJUkXMxD/RqEW8U5C
 c62MXpzdinOXUNmaBDt15KhMGr25UIsxlbnsqBSLT6DcOM+pl3M377wzKLOGQF7oYQuWuE5uB
 5X6k/hx0dr53at3PaZrhNO6Gl7/ORQ1xm4Y/gR6CiUPU4Cs+QF9/A/Oz/c2UkBhYP+/YkJ9zS
 MOcr8duDlXLEGkgThtqV1X3006g8bJLcJ8RFiSABaMnDktySh8huYW/HtUuM2nQuJqjgAqAms
 uNlF2OUdjNgPG0SFdlLyAOHixxe0beOroXKi2ESMHUnppLDXOHH0gu7Qc+Cx5zmLAzchAt1kb
 oMJbEUirqm1VdCTnAB9ewn41+7/ovtiPELzRX6lDPATayCcH0LaxNVHvFW0/eiOGkYNuSIB
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 12:00:20
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Fix warning reported by Clang static code analyzer:

    CC      hw/timer/stm32f2xx_timer.o
  hw/timer/stm32f2xx_timer.c:225:9: warning: Value stored to 'value' is never read
          value = timer_val;
          ^       ~~~~~~~~~

Reported-by: Clang Static Analyzer
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200422133152.16770-9-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/timer/stm32f2xx_timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index 06ec8a02c250..ba8694dcd349 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -222,7 +222,6 @@ static void stm32f2xx_timer_write(void *opaque, hwaddr offset,
     case TIM_PSC:
         timer_val = stm32f2xx_ns_to_ticks(s, now) - s->tick_offset;
         s->tim_psc = value & 0xFFFF;
-        value = timer_val;
         break;
     case TIM_CNT:
         timer_val = value;
-- 
2.26.2


