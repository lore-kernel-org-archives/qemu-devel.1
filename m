Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D19CC10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14FF2205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxMH+o87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FF2205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDe1v-0008Q8-TZ
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 20:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDdEr-0005Y9-Ex
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDdEp-0001Et-2X
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:04:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27394
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDdEo-00018M-TJ
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584317047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JhEb4Fw98Hx85uciQ4N5nkgUEmDVM0SFls1vrHfkKXw=;
 b=DxMH+o87xsJJW09LVIosbNUb6/hWlOx9toPg6dEyuqbIVaD6YecptkSjPii76vhgrYeg6L
 ruWHqXW3c1wti5uZiqhdY6QDSPYX8rlTptA9nqIesDj7SlLIlEONpvZkBzBTBIdXZmRZA0
 CcDrR2E543dQ9grh3IqOgVVSlWWRM6g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4--HfcXVt8PRWe6Ut2AXIEGg-1; Sun, 15 Mar 2020 20:04:05 -0400
X-MC-Unique: -HfcXVt8PRWe6Ut2AXIEGg-1
Received: by mail-wr1-f71.google.com with SMTP id 94so3452794wrr.3
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 17:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/2Hixt+DAyk9U4012uc1/q9PdUELc/grv+MCT0aAnGc=;
 b=EDeVIGRzKIdJgSKB6u6+1XkeTt8ULlIox+INbHILCMeHe47VGkEb/6K/6SLHk6OUnU
 hBBIFv/IyQflr/Chf0pI5xSohYdg1753asmTaXYuslfveCV0ipkImRPA9jfImgYdWJFr
 vMIVk/JSVhtf7GB7insjwIyOfkakMRHexI9nPGcCmNB8PeRj2+dlJVR70shjwnUsAtuX
 oeLtDEQ8pPTjQ1hvgCxKr9/WtiIHhnjBQeZWTo90WTAY9VtbpMs4XeP8mwVbU/QTNmha
 XfpElAqB/ryAy4xuxFlazhOsIncNAS2Lymij0L4QHRLOK5yMle1pl4OIooAvegWi9k3f
 +6qw==
X-Gm-Message-State: ANhLgQ2tcGXAPYzBcKGHazwCT4FVi0Y6UF0cB4RaxIzx6gUDdazIhsoo
 atlVzON9nbPJfd1WttAouZNB6UJiCNUo+NOkyhdhrqDDtcQJ+7LL7o/MrHd5pG7Ma9oQwMS9ok3
 pgfgz276iu4AtILM=
X-Received: by 2002:a7b:c3cb:: with SMTP id t11mr25535069wmj.154.1584317044284; 
 Sun, 15 Mar 2020 17:04:04 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuOAHaRJoRQHYm0owc0Ej2+MNRAQ3gm/TG9MCh7hR4HAEyCwJVpvNADjk83wAdsJO0cCG7Ubg==
X-Received: by 2002:a7b:c3cb:: with SMTP id t11mr25535033wmj.154.1584317044034; 
 Sun, 15 Mar 2020 17:04:04 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id f15sm27533041wmj.25.2020.03.15.17.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 17:04:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/8] qapi/misc: Restrict LostTickPolicy enum to machine code
Date: Mon, 16 Mar 2020 01:03:42 +0100
Message-Id: <20200316000348.29692-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316000348.29692-1-philmd@redhat.com>
References: <20200316000348.29692-1-philmd@redhat.com>
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
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>
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
index c18fe681fb..2725d835ad 100644
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
 # @add_client:
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


