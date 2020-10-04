Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA62C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 13:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D0520735
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 13:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D0520735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rwth-aachen.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP4Er-000051-PA
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 09:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jan.Weinstock@rwth-aachen.de>)
 id 1kP1UX-0003DF-VI
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 06:43:45 -0400
Received: from mail-out-1.itc.rwth-aachen.de ([2a00:8a60:1:e501::5:46]:53320)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jan.Weinstock@rwth-aachen.de>)
 id 1kP1US-0001NL-U0
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 06:43:43 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AUBgBlpnlf/54agoZggQmDIYIfXYQ9k?=
 =?us-ascii?q?QsInEwLAQEBAQEBAQEBCAEtAgQBAYRKgjgCJTgTAhABAQYBAQEBAQYEhlWGHAQ?=
 =?us-ascii?q?LAQVBNQImAkkWDQEFAgEBgyKCfQGnM38zhVSDQIFCCQGBBCqGW4ZWgVw/gTgMg?=
 =?us-ascii?q?xuFCoJKgmAEkzmkFAeBX4ELmlUFKZIdjwEBsyoCAgICCQIVgWuBek0kXAmCU1A?=
 =?us-ascii?q?XAg2OKxeOJkAyNwIGCgEBAwl8jUwBAQ?=
X-IPAS-Result: =?us-ascii?q?A2AUBgBlpnlf/54agoZggQmDIYIfXYQ9kQsInEwLAQEBAQE?=
 =?us-ascii?q?BAQEBCAEtAgQBAYRKgjgCJTgTAhABAQYBAQEBAQYEhlWGHAQLAQVBNQImAkkWD?=
 =?us-ascii?q?QEFAgEBgyKCfQGnM38zhVSDQIFCCQGBBCqGW4ZWgVw/gTgMgxuFCoJKgmAEkzm?=
 =?us-ascii?q?kFAeBX4ELmlUFKZIdjwEBsyoCAgICCQIVgWuBek0kXAmCU1AXAg2OKxeOJkAyN?=
 =?us-ascii?q?wIGCgEBAwl8jUwBAQ?=
X-IronPort-AV: E=Sophos;i="5.77,335,1596492000"; d="scan'208";a="122639189"
Received: from rwthex-w2-a.rwth-ad.de ([134.130.26.158])
 by mail-in-1.itc.rwth-aachen.de with ESMTP; 04 Oct 2020 12:42:22 +0200
Received: from [IPv6:2a02:908:1089:e060:794d:ff8:62d5:f86c]
 (2a02:908:1089:e060:794d:ff8:62d5:f86c) by rwthex-w2-a.rwth-ad.de
 (2a00:8a60:1:e500::26:158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2044.4; Sun, 4 Oct
 2020 12:42:21 +0200
To: <qemu-devel@nongnu.org>
From: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
Subject: [PATCH] SDL: enable OpenGL context creation
Message-ID: <b2ba98b3-2975-0d4d-1c56-f659923c714d@rwth-aachen.de>
Date: Sun, 4 Oct 2020 12:42:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2a02:908:1089:e060:794d:ff8:62d5:f86c]
X-ClientProxiedBy: rwthex-w2-b.rwth-ad.de (2a00:8a60:1:e500::26:159) To
 rwthex-w2-a.rwth-ad.de (2a00:8a60:1:e500::26:158)
Received-SPF: pass client-ip=2a00:8a60:1:e501::5:46;
 envelope-from=Jan.Weinstock@rwth-aachen.de; helo=mail-out-1.itc.rwth-aachen.de
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 04 Oct 2020 09:33:35 -0400
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
Cc: kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need to specify SDL_WINDOW_OPENGL if we want to create an OpenGL 
context on it, i.e. when using '-device virtio-gpu-pci,virgl=on'

Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
---
  ui/sdl2.c | 5 +++++
  1 file changed, 5 insertions(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index abad7f981e..189d26e2a9 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -84,6 +84,11 @@ void sdl2_window_create(struct sdl2_console *scon)
      if (scon->hidden) {
          flags |= SDL_WINDOW_HIDDEN;
      }
+#ifdef CONFIG_OPENGL
+    if (scon->opengl) {
+        flags |= SDL_WINDOW_OPENGL;
+    }
+#endif

      scon->real_window = SDL_CreateWindow("", SDL_WINDOWPOS_UNDEFINED,
                                           SDL_WINDOWPOS_UNDEFINED,
-- 
2.17.1

