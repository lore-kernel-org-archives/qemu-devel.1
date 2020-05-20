Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF1FC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:44:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AB1F207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4mHNTkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB1F207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKKv-0002ug-Qx
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbKJz-0001Eg-KK
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:43:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39448
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbKJy-0006ct-AC
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589964205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dq4/sHXrghcxAuE9e4HtETpvu3EFqiazCzugnZPczUk=;
 b=X4mHNTkZRgIZgls2CulsikFpGt/K+A/xbVoDD4gYA4lC65lTvyJH2b1gb9xZ2KYNDxXau2
 CJZchfROtm/3be2puu5K/xhmZ74c4avmVRO9lDevQLXKL0hVN3WYE3aXyLPDb07JoRENWb
 uv08FIhOk2InTIIvFSAdcIxO4cTTU+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-O2fLU_EoOuWNCTKbFe0xqA-1; Wed, 20 May 2020 04:43:23 -0400
X-MC-Unique: O2fLU_EoOuWNCTKbFe0xqA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 217A21800D42;
 Wed, 20 May 2020 08:43:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3919100164D;
 Wed, 20 May 2020 08:43:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A46C89D54; Wed, 20 May 2020 10:43:16 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/11] ui/gtk: remove unused variable ignore_keys
Date: Wed, 20 May 2020 10:43:10 +0200
Message-Id: <20200520084316.22057-6-kraxel@redhat.com>
In-Reply-To: <20200520084316.22057-1-kraxel@redhat.com>
References: <20200520084316.22057-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since the removal of GTK2 code in commit 89d85cde75 the code
around ignore_keys is unused. See commit 1a01716a30 "gtk: Avoid
accel key leakage into guest on console switch" why it was only
needed for GTK2.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Message-id: 20200516072014.7766-5-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 0e9503a0d1d9..354dd90e1898 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -168,8 +168,6 @@ struct GtkDisplayState {
 
     bool external_pause_update;
 
-    bool ignore_keys;
-
     DisplayOptions *opts;
 };
 
@@ -1095,14 +1093,8 @@ static gboolean gd_text_key_down(GtkWidget *widget,
 static gboolean gd_key_event(GtkWidget *widget, GdkEventKey *key, void *opaque)
 {
     VirtualConsole *vc = opaque;
-    GtkDisplayState *s = vc->s;
     int qcode;
 
-    if (s->ignore_keys) {
-        s->ignore_keys = (key->type == GDK_KEY_PRESS);
-        return TRUE;
-    }
-
 #ifdef WIN32
     /* on windows, we ought to ignore the reserved key event? */
     if (key->hardware_keycode == 0xff)
@@ -1204,7 +1196,6 @@ static void gd_menu_switch_vc(GtkMenuItem *item, void *opaque)
         gtk_notebook_set_current_page(nb, page);
         gtk_widget_grab_focus(vc->focus);
     }
-    s->ignore_keys = false;
 }
 
 static void gd_accel_switch_vc(void *opaque)
-- 
2.18.4


