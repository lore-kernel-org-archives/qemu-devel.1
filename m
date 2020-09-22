Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A0BC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 20:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5289E221E8
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 20:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5289E221E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKodV-0007NQ-0w
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 16:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@ens-lyon.org>)
 id 1kKocY-0006pB-Ce
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 16:10:38 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:60816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@ens-lyon.org>)
 id 1kKocW-0007Az-CR
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 16:10:38 -0400
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id 070D5C30;
 Tue, 22 Sep 2020 22:10:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HGplNU9oF2B4; Tue, 22 Sep 2020 22:10:30 +0200 (CEST)
Received: from function (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr
 [90.50.148.204])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id 3CDA4BA6;
 Tue, 22 Sep 2020 22:10:30 +0200 (CEST)
Received: from samy by function with local (Exim 4.94)
 (envelope-from <samuel.thibault@ens-lyon.org>)
 id 1kKocO-000AmF-9k; Tue, 22 Sep 2020 22:10:28 +0200
Date: Tue, 22 Sep 2020 22:10:28 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] ui: Fix default window_id value
Message-ID: <20200922201028.uyy2malfqxkqbyxm@function>
References: <20200914100637.eeommoflirxrgaeh@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200914100637.eeommoflirxrgaeh@function>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Received-SPF: neutral client-ip=2a0c:e300::1;
 envelope-from=samuel.thibault@ens-lyon.org; helo=hera.aquilenet.fr
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

./chardev/baum.c expects the default window_id value to be -1, and not 0
which could be confused with a proper window id (when numbered from 0 by
the ui backend).

This fixes getting Braille output with the curses and gtk frontends.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Fixes: f29b3431f62 ("console: move window ID code from baum to sdl")
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

---
It would be useful to backport this to stable trees.

diff --git a/ui/console.c b/ui/console.c
index f8d7643fe4..beb733c833 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1310,6 +1310,7 @@ static QemuConsole *new_console(DisplayState *ds, console_type_t console_type,
     }
     s->ds = ds;
     s->console_type = console_type;
+    s->window_id = -1;
 
     if (QTAILQ_EMPTY(&consoles)) {
         s->index = 0;

