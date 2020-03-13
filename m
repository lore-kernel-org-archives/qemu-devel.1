Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62242C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E53620658
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6pBjyLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E53620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpQ9-0001WW-Au
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpGC-0001FI-TP
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpGB-0005NV-FC
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:42:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56964
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpGB-0005Kq-AA
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584124933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vTQj/CuraqaEI9qDf4IXecW3ZSVpPZJ56FMzGpZyIT0=;
 b=B6pBjyLyTEUwJqZQVmOh/3FmoxSD1QxZXx1UXGEPTrvYtk4G5khBGFQsM6gn5+g4L38cLV
 9/EJnkRZRKpAQcHQb/Jm+YRdbd2xeEYWQJtMK3E05R2ZEUyrryHYHkTo6Y0rw3k3xOJg5A
 0mdtIw1AS45OVW6ne5elf5DhXwyF4+Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-ppCwk4ZMMdSK-DiKQiX2Jg-1; Fri, 13 Mar 2020 14:42:12 -0400
X-MC-Unique: ppCwk4ZMMdSK-DiKQiX2Jg-1
Received: by mail-wr1-f71.google.com with SMTP id j17so4728530wru.19
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6BA/ayS7bx6RNJ1ANrutCVjpBouFGlBaWUedscA9deQ=;
 b=GlxSeA3g6vTF2W7jJ+FgZxc+LEYX5ruknH8ba7ku0NmgYu9iSEcWHLSrEO3D1ZyvmV
 IaqISXHa07pUXF5kQYD6PrbXgDAd8UfgVu+qawQBQrAz0SPJcjd5VZ+kW4s93Wzch7n6
 QBKR4L4Ig4HBwAaq/p+N0pATRZ36yqYLTn1wghKjbfBk4LkVVrACi6cg3fdxCjhcWIDZ
 7TgGGofTkx2mM63kei3KK4xyZx+pWJftdMkNGEugp7h2phHDNMvn8o7rCVs8Vk3PQZHT
 cOcdEanymsPWVmmS8PUyHkvtQP3RhkOgYZfgqZhnEtI9OiUV0dFzwd2gvFPuRaPZp7NM
 F97Q==
X-Gm-Message-State: ANhLgQ0PoLE7WXXRP5cKIu8s0k2YH0WiZ04+pFxHRz4dAbx7ee/S6T6e
 dvIUEiReDB1o3AukVBD3dXVQRVazr8Dqb3FTfeaIx/OYfeDzcB18G3TQjnLfxJfGLTZOyOVt5hy
 3YLEyRBSap/7etts=
X-Received: by 2002:a5d:4d51:: with SMTP id a17mr1885088wru.285.1584124930482; 
 Fri, 13 Mar 2020 11:42:10 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsPSfJJWGlZeTRLMSIZDbub+F3/I7ELWsUxQYHzbN1CTOauijAugkpIvd3Dl5CCINUMPWZllw==
X-Received: by 2002:a5d:4d51:: with SMTP id a17mr1885052wru.285.1584124930178; 
 Fri, 13 Mar 2020 11:42:10 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id f207sm19637801wme.9.2020.03.13.11.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:42:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/9] qapi/misc: Restrict LostTickPolicy enum to machine code
Date: Fri, 13 Mar 2020 19:41:47 +0100
Message-Id: <20200313184153.11275-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200313184153.11275-1-philmd@redhat.com>
References: <20200313184153.11275-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Ben Warren <ben@skyportsystems.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Igor Mammedov <imammedo@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 qapi/machine.json            | 32 ++++++++++++++++++++++++++++++++
 qapi/misc.json               | 32 --------------------------------
 include/hw/rtc/mc146818rtc.h |  2 +-
 hw/core/qdev-properties.c    |  1 +
 hw/i386/kvm/i8254.c          |  2 +-
 5 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index de05730704..07ffc07ba2 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -415,6 +415,38 @@
 ##
 { 'command': 'query-target', 'returns': 'TargetInfo' }
=20
+##
+# @LostTickPolicy:
+#
+# Policy for handling lost ticks in timer devices.  Ticks end up getting
+# lost when, for example, the guest is paused.
+#
+# @discard: throw away the missed ticks and continue with future injection
+#           normally.  The guest OS will see the timer jump ahead by a
+#           potentially quite significant amount all at once, as if the
+#           intervening chunk of time had simply not existed; needless to
+#           say, such a sudden jump can easily confuse a guest OS which is
+#           not specifically prepared to deal with it.  Assuming the guest
+#           OS can deal correctly with the time jump, the time in the gues=
t
+#           and in the host should now match.
+#
+# @delay: continue to deliver ticks at the normal rate.  The guest OS will
+#         not notice anything is amiss, as from its point of view time wil=
l
+#         have continued to flow normally.  The time in the guest should n=
ow
+#         be behind the time in the host by exactly the amount of time dur=
ing
+#         which ticks have been missed.
+#
+# @slew: deliver ticks at a higher rate to catch up with the missed ticks.
+#        The guest OS will not notice anything is amiss, as from its point
+#        of view time will have continued to flow normally.  Once the time=
r
+#        has managed to catch up with all the missing ticks, the time in
+#        the guest and in the host should match.
+#
+# Since: 2.0
+##
+{ 'enum': 'LostTickPolicy',
+  'data': ['discard', 'delay', 'slew' ] }
+
 ##
 # @NumaOptionsType:
 #
diff --git a/qapi/misc.json b/qapi/misc.json
index e84e6823e9..f827bdc8f6 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -7,38 +7,6 @@
=20
 { 'include': 'common.json' }
=20
-##
-# @LostTickPolicy:
-#
-# Policy for handling lost ticks in timer devices.  Ticks end up getting
-# lost when, for example, the guest is paused.
-#
-# @discard: throw away the missed ticks and continue with future injection
-#           normally.  The guest OS will see the timer jump ahead by a
-#           potentially quite significant amount all at once, as if the
-#           intervening chunk of time had simply not existed; needless to
-#           say, such a sudden jump can easily confuse a guest OS which is
-#           not specifically prepared to deal with it.  Assuming the guest
-#           OS can deal correctly with the time jump, the time in the gues=
t
-#           and in the host should now match.
-#
-# @delay: continue to deliver ticks at the normal rate.  The guest OS will
-#         not notice anything is amiss, as from its point of view time wil=
l
-#         have continued to flow normally.  The time in the guest should n=
ow
-#         be behind the time in the host by exactly the amount of time dur=
ing
-#         which ticks have been missed.
-#
-# @slew: deliver ticks at a higher rate to catch up with the missed ticks.
-#        The guest OS will not notice anything is amiss, as from its point
-#        of view time will have continued to flow normally.  Once the time=
r
-#        has managed to catch up with all the missing ticks, the time in
-#        the guest and in the host should match.
-#
-# Since: 2.0
-##
-{ 'enum': 'LostTickPolicy',
-  'data': ['discard', 'delay', 'slew' ] }
-
 ##
 # @NameInfo:
 #
diff --git a/include/hw/rtc/mc146818rtc.h b/include/hw/rtc/mc146818rtc.h
index 10c93a096a..58a7748c66 100644
--- a/include/hw/rtc/mc146818rtc.h
+++ b/include/hw/rtc/mc146818rtc.h
@@ -9,7 +9,7 @@
 #ifndef HW_RTC_MC146818RTC_H
 #define HW_RTC_MC146818RTC_H
=20
-#include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-types-machine.h"
 #include "qemu/queue.h"
 #include "qemu/timer.h"
 #include "hw/isa/isa.h"
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 2047114fca..59380ed761 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -4,6 +4,7 @@
 #include "qapi/error.h"
 #include "hw/pci/pci.h"
 #include "qapi/qapi-types-block.h"
+#include "qapi/qapi-types-machine.h"
 #include "qapi/qapi-types-misc.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/ctype.h"
diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 876f5aa6fa..22ba6149b5 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -25,7 +25,7 @@
=20
 #include "qemu/osdep.h"
 #include <linux/kvm.h>
-#include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-types-machine.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
--=20
2.21.1


