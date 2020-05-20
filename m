Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77F1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:45:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65255207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWCBaHGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65255207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKMJ-0006jc-H7
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbKJx-0001Bp-Bn
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:43:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32368
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbKJw-0006cT-M0
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589964203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bI/D6N0281xdiiHd5BdG07m8MXj2btuupYQGpk8O9Zc=;
 b=iWCBaHGBBlhsApj8zBh7Ub0dPZImzVbfOvAeIN0dt5d2tjJHBvgd2mP6KS5Dhh8G4GlIxB
 2WacRI/ww37A6Tdib8pbbh0Pkkd0DV1N6X288dUjvwLbabvRSGnENgCz2Wzhmb5OfRicYt
 FLjbtFE4A9MGMWG0WN/E/mMbJZAONts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-igxrhstTM9iSM8qP_Xbjaw-1; Wed, 20 May 2020 04:43:21 -0400
X-MC-Unique: igxrhstTM9iSM8qP_Xbjaw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B357819200C0;
 Wed, 20 May 2020 08:43:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8264F5D9CA;
 Wed, 20 May 2020 08:43:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9B92C9DB0; Wed, 20 May 2020 10:43:16 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/11] ui/gtk: remove unused code
Date: Wed, 20 May 2020 10:43:09 +0200
Message-Id: <20200520084316.22057-5-kraxel@redhat.com>
In-Reply-To: <20200520084316.22057-1-kraxel@redhat.com>
References: <20200520084316.22057-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker Rümelin <vr_qemu@t-online.de>

This code was last used before commit 2ec78706d1 "ui: convert
GTK and SDL1 frontends to keycodemapdb".

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Message-id: 20200516072014.7766-4-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 655b26de384e..0e9503a0d1d9 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -112,15 +112,6 @@
 # define VTE_CHECK_VERSION(a, b, c) 0
 #endif
 
-/* Some older mingw versions lack this constant or have
- * it conditionally defined */
-#ifdef _WIN32
-# ifndef MAPVK_VK_TO_VSC
-#  define MAPVK_VK_TO_VSC 0
-# endif
-#endif
-
-
 #define HOTKEY_MODIFIERS        (GDK_CONTROL_MASK | GDK_MOD1_MASK)
 
 static const guint16 *keycode_map;
-- 
2.18.4


