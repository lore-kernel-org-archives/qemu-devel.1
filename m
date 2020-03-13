Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4293C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:54:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D56920658
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QdbvHBpS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D56920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpRl-00046X-Nu
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59241)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpGH-0001Ua-KD
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpGG-0005Wp-1G
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:42:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37921
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpGF-0005VE-TY
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584124939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JokUaNXemH+e02pjR2cVsAOreQCfGYVkBInLDbeWKU0=;
 b=QdbvHBpSRBWmaQTo6uxmOpKGPLcWvcrbVYw6zT3ZV+KBpYbszMKTuzAEbK/0bhfeHLPu3T
 NLiMEQq3ZYdOd+NtbKfVZwKKzMIEZMUmZr2tH6xA/7WNLRLZQbuunNLXEQ73LwHX67YQAv
 l59++35d8OcaGzQw4ks2/1cDfQnMkg0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-n0FRUUjWPtuRBQ_c4BYHvg-1; Fri, 13 Mar 2020 14:42:17 -0400
X-MC-Unique: n0FRUUjWPtuRBQ_c4BYHvg-1
Received: by mail-wr1-f72.google.com with SMTP id x14so4689701wrv.23
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+EZUdVixSOyONgm7Ekn0bMyU5n+tkPuu1vAqJOdo3vQ=;
 b=oYR8tlbOtZUO3PQA2afE4FpIJpVDFur2n2B3l3WYgS53cLO8mvSuodq875SAq8XtHj
 AMvjfGu+h19sSiDK4kjvuEiu5PbVBOLxLVSjOXAtygWARz6ssDtyyNRRmFoy3pXxoF+Z
 HFNCc9oHTV43w6d1cvSVG81k0vURuwvuY8OPc1Ufu+HIKWNRzn6g98ziLQq5/kfV4gQG
 bU77gqQIrb026pfKOKcYSA61AqlN37nHSNZyshLZz4oJMD+0OOGTWXEeBudi6MLbr5E4
 3Flhjmd132RPwQJV1gXxLNh9O9rlWFdXTg07UNTrWwFv65/Y9QwUzCUJuAA5nD+FzDqo
 RcRA==
X-Gm-Message-State: ANhLgQ22FJs9wJxdWbSUVF7y9NGFF+FHq+E1GYm4oVuSMw/Y89VDe+oy
 nbQumldR/Yk4/hDCluN2ZDhVVm7jZkqVVhyY1c93n1chdjrUpASCeDXPRNIxHSXCe/3vORribVm
 TyQPDkaKjhskailM=
X-Received: by 2002:a1c:ab54:: with SMTP id u81mr7062909wme.166.1584124935482; 
 Fri, 13 Mar 2020 11:42:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtz2W40y1WSruy3nOsBZAcb5SulySG1WXeknfOgkzQLCNic0qE4KdC64TLw+MpYiFKDbtU3zw==
X-Received: by 2002:a1c:ab54:: with SMTP id u81mr7062880wme.166.1584124935132; 
 Fri, 13 Mar 2020 11:42:15 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id c23sm18325188wme.39.2020.03.13.11.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:42:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/9] qapi/misc: Restrict balloon-related commands to machine
 code
Date: Fri, 13 Mar 2020 19:41:48 +0100
Message-Id: <20200313184153.11275-5-philmd@redhat.com>
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
X-Received-From: 205.139.110.120
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
 qapi/machine.json          | 83 ++++++++++++++++++++++++++++++++++++++
 qapi/misc.json             | 83 --------------------------------------
 include/sysemu/balloon.h   |  2 +-
 balloon.c                  |  2 +-
 hw/virtio/virtio-balloon.c |  2 +-
 monitor/hmp-cmds.c         |  1 +
 6 files changed, 87 insertions(+), 86 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 07ffc07ba2..c096efbea3 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -915,3 +915,86 @@
   'data': 'NumaOptions',
   'allow-preconfig': true
 }
+
+##
+# @balloon:
+#
+# Request the balloon driver to change its balloon size.
+#
+# @value: the target size of the balloon in bytes
+#
+# Returns: - Nothing on success
+#          - If the balloon driver is enabled but not functional because t=
he KVM
+#            kernel module cannot support it, KvmMissingCap
+#          - If no balloon device is present, DeviceNotActive
+#
+# Notes: This command just issues a request to the guest.  When it returns=
,
+#        the balloon size may not have changed.  A guest can change the ba=
lloon
+#        size independent of this command.
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "balloon", "arguments": { "value": 536870912 } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'balloon', 'data': {'value': 'int'} }
+
+##
+# @BalloonInfo:
+#
+# Information about the guest balloon device.
+#
+# @actual: the number of bytes the balloon currently contains
+#
+# Since: 0.14.0
+#
+##
+{ 'struct': 'BalloonInfo', 'data': {'actual': 'int' } }
+
+##
+# @query-balloon:
+#
+# Return information about the balloon device.
+#
+# Returns: - @BalloonInfo on success
+#          - If the balloon driver is enabled but not functional because t=
he KVM
+#            kernel module cannot support it, KvmMissingCap
+#          - If no balloon device is present, DeviceNotActive
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-balloon" }
+# <- { "return": {
+#          "actual": 1073741824,
+#       }
+#    }
+#
+##
+{ 'command': 'query-balloon', 'returns': 'BalloonInfo' }
+
+##
+# @BALLOON_CHANGE:
+#
+# Emitted when the guest changes the actual BALLOON level. This value is
+# equivalent to the @actual field return by the 'query-balloon' command
+#
+# @actual: actual level of the guest memory balloon in bytes
+#
+# Note: this event is rate-limited.
+#
+# Since: 1.2
+#
+# Example:
+#
+# <- { "event": "BALLOON_CHANGE",
+#      "data": { "actual": 944766976 },
+#      "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
+#
+##
+{ 'event': 'BALLOON_CHANGE',
+  'data': { 'actual': 'int' } }
diff --git a/qapi/misc.json b/qapi/misc.json
index f827bdc8f6..74cbe253f2 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -154,63 +154,6 @@
 { 'command': 'query-iothreads', 'returns': ['IOThreadInfo'],
   'allow-preconfig': true }
=20
-##
-# @BalloonInfo:
-#
-# Information about the guest balloon device.
-#
-# @actual: the number of bytes the balloon currently contains
-#
-# Since: 0.14.0
-#
-##
-{ 'struct': 'BalloonInfo', 'data': {'actual': 'int' } }
-
-##
-# @query-balloon:
-#
-# Return information about the balloon device.
-#
-# Returns: - @BalloonInfo on success
-#          - If the balloon driver is enabled but not functional because t=
he KVM
-#            kernel module cannot support it, KvmMissingCap
-#          - If no balloon device is present, DeviceNotActive
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# -> { "execute": "query-balloon" }
-# <- { "return": {
-#          "actual": 1073741824,
-#       }
-#    }
-#
-##
-{ 'command': 'query-balloon', 'returns': 'BalloonInfo' }
-
-##
-# @BALLOON_CHANGE:
-#
-# Emitted when the guest changes the actual BALLOON level. This value is
-# equivalent to the @actual field return by the 'query-balloon' command
-#
-# @actual: actual level of the guest memory balloon in bytes
-#
-# Note: this event is rate-limited.
-#
-# Since: 1.2
-#
-# Example:
-#
-# <- { "event": "BALLOON_CHANGE",
-#      "data": { "actual": 944766976 },
-#      "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
-#
-##
-{ 'event': 'BALLOON_CHANGE',
-  'data': { 'actual': 'int' } }
-
 ##
 # @PciMemoryRange:
 #
@@ -719,32 +662,6 @@
 ##
 { 'command': 'inject-nmi' }
=20
-##
-# @balloon:
-#
-# Request the balloon driver to change its balloon size.
-#
-# @value: the target size of the balloon in bytes
-#
-# Returns: - Nothing on success
-#          - If the balloon driver is enabled but not functional because t=
he KVM
-#            kernel module cannot support it, KvmMissingCap
-#          - If no balloon device is present, DeviceNotActive
-#
-# Notes: This command just issues a request to the guest.  When it returns=
,
-#        the balloon size may not have changed.  A guest can change the ba=
lloon
-#        size independent of this command.
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# -> { "execute": "balloon", "arguments": { "value": 536870912 } }
-# <- { "return": {} }
-#
-##
-{ 'command': 'balloon', 'data': {'value': 'int'} }
-
 ##
 # @human-monitor-command:
 #
diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
index aea0c44985..b3de4b92b9 100644
--- a/include/sysemu/balloon.h
+++ b/include/sysemu/balloon.h
@@ -15,7 +15,7 @@
 #define QEMU_BALLOON_H
=20
 #include "exec/cpu-common.h"
-#include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-types-machine.h"
=20
 typedef void (QEMUBalloonEvent)(void *opaque, ram_addr_t target);
 typedef void (QEMUBalloonStatus)(void *opaque, BalloonInfo *info);
diff --git a/balloon.c b/balloon.c
index f104b42961..ee9c59252d 100644
--- a/balloon.c
+++ b/balloon.c
@@ -30,7 +30,7 @@
 #include "sysemu/balloon.h"
 #include "trace-root.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qapi/qmp/qerror.h"
=20
 static QEMUBalloonEvent *balloon_event_fn;
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a4729f7fc9..07ad36b143 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -24,7 +24,7 @@
 #include "hw/virtio/virtio-balloon.h"
 #include "exec/address-spaces.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-misc.h"
+#include "qapi/qapi-events-machine.h"
 #include "qapi/visitor.h"
 #include "trace.h"
 #include "qemu/error-report.h"
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 58724031ea..97cd340b2e 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -32,6 +32,7 @@
 #include "qapi/qapi-commands-block.h"
 #include "qapi/qapi-commands-char.h"
 #include "qapi/qapi-commands-control.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-net.h"
--=20
2.21.1


