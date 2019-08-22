Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AB4C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 04:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593CD2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 04:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593CD2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0ewv-0005MT-7X
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 00:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i0evY-00047Y-7a
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 00:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i0evW-0002cX-SE
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 00:42:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32840)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i0evW-0002c3-L9
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 00:42:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B9F133084295;
 Thu, 22 Aug 2019 04:42:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com
 [10.36.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 562D060F88;
 Thu, 22 Aug 2019 04:42:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 66BC493C9; Thu, 22 Aug 2019 06:42:18 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 06:42:18 +0200
Message-Id: <20190822044218.9374-3-kraxel@redhat.com>
In-Reply-To: <20190822044218.9374-1-kraxel@redhat.com>
References: <20190822044218.9374-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 22 Aug 2019 04:42:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/2] input-linux: add shift+shift as a grab
 toggle
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
Cc: Niklas Haas <git@haasn.xyz>, Gerd Hoffmann <kraxel@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Niklas Haas <git@haasn.xyz>

We have ctrl-ctrl and alt-alt; why not shift-shift? That's my preferred
grab binding, personally.

Signed-off-by: Niklas Haas <git@haasn.xyz>
Message-id: 20190818105038.19520-1-qemu@haasn.xyz
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/input-linux.c | 4 ++++
 qapi/ui.json     | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/ui/input-linux.c b/ui/input-linux.c
index 59456fe7658b..a7b280b25b98 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -113,6 +113,10 @@ static bool input_linux_check_toggle(InputLinux *il)
         return il->keydown[KEY_LEFTALT] &&
             il->keydown[KEY_RIGHTALT];
 
+    case GRAB_TOGGLE_KEYS_SHIFT_SHIFT:
+        return il->keydown[KEY_LEFTSHIFT] &&
+            il->keydown[KEY_RIGHTSHIFT];
+
     case GRAB_TOGGLE_KEYS_META_META:
         return il->keydown[KEY_LEFTMETA] &&
             il->keydown[KEY_RIGHTMETA];
diff --git a/qapi/ui.json b/qapi/ui.json
index 59e412139adc..e04525d8b44b 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1025,7 +1025,8 @@
 #
 ##
 { 'enum': 'GrabToggleKeys',
-  'data': [ 'ctrl-ctrl', 'alt-alt', 'meta-meta', 'scrolllock', 'ctrl-scrolllock' ] }
+  'data': [ 'ctrl-ctrl', 'alt-alt', 'shift-shift','meta-meta', 'scrolllock',
+            'ctrl-scrolllock' ] }
 
 ##
 # @DisplayGTK:
-- 
2.18.1


