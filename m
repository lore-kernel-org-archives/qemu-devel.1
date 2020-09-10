Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952ADC2D0A7
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1386620882
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMkhvXWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1386620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGSiY-0005a2-4S
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 15:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSaq-0006rY-Mv
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:50:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37793
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSan-0000nx-DX
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599767448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=meSyVk5F9C2UK8oJsE6YKKdolkeEEIbEB3IIlhaqprI=;
 b=DMkhvXWWVNiTc6k+Bc7+JQZ0wRtH0j1+QanoSjYvAW3c3dgvabr3SmJ7aXLHRJ/hyCyK6/
 2EOD8uH951Sd2ImqCKq8FpGgI3nIGOgk+g1j+cgKArifm0+dKZXiTp99+GbGSxsoKRCo5Y
 Rt/hOyGSB8s8EDB+bQZJoHoJK7ApCfU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-mWlgypEPOqC7YQji-mn0Ww-1; Thu, 10 Sep 2020 15:50:46 -0400
X-MC-Unique: mWlgypEPOqC7YQji-mn0Ww-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04191425D1;
 Thu, 10 Sep 2020 19:50:46 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBB2B7E8F9;
 Thu, 10 Sep 2020 19:50:39 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/18] chardev: Rename WIN_STDIO_CHARDEV to CHARDEV_WIN_STDIO
Date: Thu, 10 Sep 2020 15:49:03 -0400
Message-Id: <20200910194903.4104696-19-ehabkost@redhat.com>
In-Reply-To: <20200910194903.4104696-1-ehabkost@redhat.com>
References: <20200910194903.4104696-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:07:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename instance and class type checkers to match the
TYPE_CHARDEV_* constant names and the QOM type name strings
("chardev-*").

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 chardev/char-win-stdio.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
index a4771ab82e..46f715afb1 100644
--- a/chardev/char-win-stdio.c
+++ b/chardev/char-win-stdio.c
@@ -40,13 +40,13 @@ struct WinStdioChardev {
 };
 typedef struct WinStdioChardev WinStdioChardev;
 
-DECLARE_INSTANCE_CHECKER(WinStdioChardev, WIN_STDIO_CHARDEV,
+DECLARE_INSTANCE_CHECKER(WinStdioChardev, CHARDEV_WIN_STDIO,
                          TYPE_CHARDEV_WIN_STDIO)
 
 static void win_stdio_wait_func(void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
-    WinStdioChardev *stdio = WIN_STDIO_CHARDEV(opaque);
+    WinStdioChardev *stdio = CHARDEV_WIN_STDIO(opaque);
     INPUT_RECORD       buf[4];
     int                ret;
     DWORD              dwSize;
@@ -79,7 +79,7 @@ static void win_stdio_wait_func(void *opaque)
 
 static DWORD WINAPI win_stdio_thread(LPVOID param)
 {
-    WinStdioChardev *stdio = WIN_STDIO_CHARDEV(param);
+    WinStdioChardev *stdio = CHARDEV_WIN_STDIO(param);
     int                ret;
     DWORD              dwSize;
 
@@ -118,7 +118,7 @@ static DWORD WINAPI win_stdio_thread(LPVOID param)
 static void win_stdio_thread_wait_func(void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
-    WinStdioChardev *stdio = WIN_STDIO_CHARDEV(opaque);
+    WinStdioChardev *stdio = CHARDEV_WIN_STDIO(opaque);
 
     if (qemu_chr_be_can_write(chr)) {
         qemu_chr_be_write(chr, &stdio->win_stdio_buf, 1);
@@ -129,7 +129,7 @@ static void win_stdio_thread_wait_func(void *opaque)
 
 static void qemu_chr_set_echo_win_stdio(Chardev *chr, bool echo)
 {
-    WinStdioChardev *stdio = WIN_STDIO_CHARDEV(chr);
+    WinStdioChardev *stdio = CHARDEV_WIN_STDIO(chr);
     DWORD              dwMode = 0;
 
     GetConsoleMode(stdio->hStdIn, &dwMode);
@@ -146,7 +146,7 @@ static void qemu_chr_open_stdio(Chardev *chr,
                                 bool *be_opened,
                                 Error **errp)
 {
-    WinStdioChardev *stdio = WIN_STDIO_CHARDEV(chr);
+    WinStdioChardev *stdio = CHARDEV_WIN_STDIO(chr);
     DWORD              dwMode;
     int                is_console = 0;
 
@@ -213,7 +213,7 @@ err1:
 
 static void char_win_stdio_finalize(Object *obj)
 {
-    WinStdioChardev *stdio = WIN_STDIO_CHARDEV(obj);
+    WinStdioChardev *stdio = CHARDEV_WIN_STDIO(obj);
 
     if (stdio->hInputReadyEvent != INVALID_HANDLE_VALUE) {
         CloseHandle(stdio->hInputReadyEvent);
-- 
2.26.2


