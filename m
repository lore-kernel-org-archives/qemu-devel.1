Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E47AC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:25:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5714620724
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWTxVMVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5714620724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRiP8-0003rK-Ay
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 16:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRiM0-0004ph-DH
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRiLz-0003WS-Rk
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:21:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22526
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRiLz-0003U3-0y
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587673303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tPIOoo9ftY2Y0yP1OPzgpA1jMu3wYHrPWEzYbrSHsC0=;
 b=RWTxVMVytfxOgyeBYOA88xdntqcb4yVLaFYoLBoPaENs+Rwu8u+lDnb2oMVjm+JeVceEPB
 eKf7QXu1nyvDRxqNl1qMbFBIrFr5i+WTATWmDRtzy/y+TZ7E6kecTBeByAMJFtT4UW9+z6
 wNLVWPLQETGyKH0EIvz4UvvIYAJtHaQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-FMlagvOiOguPjkD1qfGTHQ-1; Thu, 23 Apr 2020 16:21:41 -0400
X-MC-Unique: FMlagvOiOguPjkD1qfGTHQ-1
Received: by mail-wr1-f69.google.com with SMTP id i10so3385864wrq.8
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 13:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vj0j3jl3RruHPgtbUoMtt40YI86Ylpvpu3a4TUFv2dY=;
 b=YC3eKzcUBKPNHfdVPsJ4EgjVfARWxIaGObrewTBsuntMTM2cIm9tb2axKWptmovVNv
 V01tm7DSZunoSc1Ua0NItnJwE5lkhXBC/5SXgDQL3fQA4RfUg0LnYRNCxtoLH//CTqOM
 NIKGAKj3M+C7E10AfJxcEk84ZBFIBmhBzP2XRUzS1rGGEBFRpn74ibWngXN3mO2jLP0Z
 3KWl19jhWsD7j8n5UuBsQbJCMM3KvDoIlEKvdD0ww/f3zavVFTWW9jXNay9oGo5+a0jK
 rkBWzIY2nvFHvuEL3BNDea8MjwyIvW/gVvwPAzhJl1SCiQzm8YG1nbWdEAAHyaAaaCWx
 +oUg==
X-Gm-Message-State: AGi0PuYSOHrc8uEhMYQ0E1MdSmvMxeSflRxyBizhCeCP5vTbdObbGSjO
 JyMc+iYlBjVb/MnDV0ZwFVzibGeEue9GjYV27vawa9bZvxCecYxVsoPvJVjOKQdwL63rT/Mg85i
 Qj/ZaImqYEdiOhnc=
X-Received: by 2002:a1c:e906:: with SMTP id q6mr5779516wmc.62.1587673300285;
 Thu, 23 Apr 2020 13:21:40 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ3zhzGof0w8cR8tv/2XdV1bmsbwmF6riz6ZIDurnmMpSjKvwLvDe4tdg+eVKt+WKTDj8izBg==
X-Received: by 2002:a1c:e906:: with SMTP id q6mr5779497wmc.62.1587673299991;
 Thu, 23 Apr 2020 13:21:39 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id x18sm5121841wrs.11.2020.04.23.13.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 13:21:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/7] chardev: Reduce "char-mux.h" scope,
 rename it "chardev-internal.h"
Date: Thu, 23 Apr 2020 22:21:09 +0200
Message-Id: <20200423202112.644-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200423202112.644-1-philmd@redhat.com>
References: <20200423202112.644-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 02:14:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No file out of chardev/ requires access to this header,
restrict its scope.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/chardev/char-mux.h =3D> chardev/chardev-internal.h | 7 ++++---
 chardev/char-fe.c                                        | 2 +-
 chardev/char-mux.c                                       | 2 +-
 chardev/char.c                                           | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)
 rename include/chardev/char-mux.h =3D> chardev/chardev-internal.h (96%)

diff --git a/include/chardev/char-mux.h b/chardev/chardev-internal.h
similarity index 96%
rename from include/chardev/char-mux.h
rename to chardev/chardev-internal.h
index 417fe32eed..e0264ac349 100644
--- a/include/chardev/char-mux.h
+++ b/chardev/chardev-internal.h
@@ -1,5 +1,5 @@
 /*
- * QEMU System Emulator
+ * QEMU Character device internals
  *
  * Copyright (c) 2003-2008 Fabrice Bellard
  *
@@ -21,8 +21,8 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
  * THE SOFTWARE.
  */
-#ifndef CHAR_MUX_H
-#define CHAR_MUX_H
+#ifndef CHARDEV_INTERNAL_H
+#define CHARDEV_INTERNAL_H
=20
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
@@ -30,6 +30,7 @@
 #define MAX_MUX 4
 #define MUX_BUFFER_SIZE 32 /* Must be a power of 2.  */
 #define MUX_BUFFER_MASK (MUX_BUFFER_SIZE - 1)
+
 typedef struct MuxChardev {
     Chardev parent;
     CharBackend *backends[MAX_MUX];
diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index f3530a90e6..474715c5a9 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -29,7 +29,7 @@
=20
 #include "chardev/char-fe.h"
 #include "chardev/char-io.h"
-#include "chardev/char-mux.h"
+#include "chardev-internal.h"
=20
 int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
 {
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 46c44af67c..6f980bb836 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -29,7 +29,7 @@
 #include "chardev/char.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/sysemu.h"
-#include "chardev/char-mux.h"
+#include "chardev-internal.h"
=20
 /* MUX driver for serial I/O splitting */
=20
diff --git a/chardev/char.c b/chardev/char.c
index e77564060d..b672a41150 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -39,7 +39,7 @@
 #include "qemu/option.h"
 #include "qemu/id.h"
=20
-#include "chardev/char-mux.h"
+#include "chardev-internal.h"
=20
 /***********************************************************/
 /* character device */
--=20
2.21.1


