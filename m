Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D200C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E2D2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E2D2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAEmn-0003pd-ME
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 11:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1kAEm6-0002yC-VG
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:52:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:59266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1kAEm5-00085v-FG
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:52:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 62144AF0F;
 Mon, 24 Aug 2020 15:53:14 +0000 (UTC)
From: Bruce Rogers <brogers@suse.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: Fix chardev-baum.so name
Date: Mon, 24 Aug 2020 09:52:36 -0600
Message-Id: <20200824155236.789635-1-brogers@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=brogers@suse.com;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 01:06:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: pbonzini@redhat.com, Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Somehow in the conversion to meson, the module named chardev-baum got
renamed to chardev-brlapi. Change it back.

Signed-off-by: Bruce Rogers <brogers@suse.com>
---
 chardev/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/meson.build b/chardev/meson.build
index a46a6237be..7726837e34 100644
--- a/chardev/meson.build
+++ b/chardev/meson.build
@@ -39,7 +39,7 @@ chardev_modules = {}
 if config_host.has_key('CONFIG_BRLAPI') and sdl.found()
   module_ss = ss.source_set()
   module_ss.add(when: [sdl, brlapi], if_true: files('baum.c'))
-  chardev_modules += { 'brlapi': module_ss }
+  chardev_modules += { 'baum': module_ss }
 endif
 
 modules += { 'chardev': chardev_modules }
-- 
2.28.0


