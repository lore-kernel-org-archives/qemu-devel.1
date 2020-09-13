Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E3DC43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 19:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B481A21D80
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 19:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCkokcLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B481A21D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHY7D-0008H8-Ow
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 15:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHY4r-0004Xi-U7
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 15:54:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51206
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHY4p-0002I8-7H
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 15:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600026858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NqVl6gN7jdmxdMWUHNKtIYsmgxfGAIKur+nDAT3Se9E=;
 b=SCkokcLvrMYfBnAM3I//sCetM6i3pyYApSCxtS4fhjswVviQ9kWNS0WijBs1LQ6gTpR1ew
 KyCFewGDBGnu6U6nOoPDNn6PKQZy+zW8JCVwbCFTX5vUwIaHI31tep1vQPQrcFgu5Hiuu9
 uS3tGAoSw7c6yeaQBVR3s0eFsUShMRk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-liVLPKxpN3aq3cBnVtGJZQ-1; Sun, 13 Sep 2020 15:54:16 -0400
X-MC-Unique: liVLPKxpN3aq3cBnVtGJZQ-1
Received: by mail-wr1-f71.google.com with SMTP id x15so5862190wrm.7
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 12:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NqVl6gN7jdmxdMWUHNKtIYsmgxfGAIKur+nDAT3Se9E=;
 b=B06S+40RPQM2rbaNYCswuO87IO7B8cSTiNvjCuyLJoN0rdoEt4i8Xxxd6yjK/WFtlY
 25HwE08gpb5EkMr00uZLybrsDZyDFWZvbncjZUnK9BWocW/U9cezf6/rWvels8pHmN09
 fpsoFIdMnEdy/RuLVIrS7YzuQ7DMJRPPkqXuBtor8fiSsrPr2j7kyX5jmHrK0y4F6sD7
 B+wP+YBvLGiidE4GW9Q6Sy+55kdXIog0kkM7jvKigxHcvU1WK/GF74+SPfsw3UU3u0sI
 mErCMAiMwqPjpBJBDFyXvA7GzedmFY7xLGieRxhbP3G/p80TIqXOzZP1zGFLAnatx9jr
 2LHQ==
X-Gm-Message-State: AOAM532hV7GSF/dAnZdOJePLHi8TrevVklbuEUhdMDMa4dJ0xCQV7o4W
 wJzu5htmRL98g3GGFMmOSLAHFDiRsiptSOFDrgrb7AqZ8/sYpb1OdQZcJnnDzcrLA06DdSzfypW
 GyABhVS0SHesnlqc=
X-Received: by 2002:a5d:6311:: with SMTP id i17mr11689499wru.243.1600026855312; 
 Sun, 13 Sep 2020 12:54:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyulBi4lh5itvxJwq/+H6e9XW2IkB7Y8Cv8cHB4Av2ZszWJJMtd9B8Iwa019XSvXoASyQUf0A==
X-Received: by 2002:a5d:6311:: with SMTP id i17mr11689487wru.243.1600026855136; 
 Sun, 13 Sep 2020 12:54:15 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id y1sm15454264wma.36.2020.09.13.12.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2020 12:54:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v5 5/8] qapi: Restrict query-uuid command to machine code
Date: Sun, 13 Sep 2020 21:53:45 +0200
Message-Id: <20200913195348.1064154-6-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200913195348.1064154-1-philmd@redhat.com>
References: <20200913195348.1064154-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 09:40:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only qemu-system-FOO and qemu-storage-daemon provide QMP
monitors, therefore such declarations and definitions are
irrelevant for user-mode emulation.

Restricting the query-uuid command to machine.json allows
pulling less declarations/definitions to user-mode.

Acked-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/machine.json | 30 ++++++++++++++++++++++++++++++
 qapi/misc.json    | 30 ------------------------------
 block/iscsi.c     |  2 +-
 stubs/uuid.c      |  2 +-
 4 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index dd2815fa670..9b849be2aa6 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -426,6 +426,36 @@
 ##
 { 'command': 'query-target', 'returns': 'TargetInfo' }
 
+##
+# @UuidInfo:
+#
+# Guest UUID information (Universally Unique Identifier).
+#
+# @UUID: the UUID of the guest
+#
+# Since: 0.14.0
+#
+# Notes: If no UUID was specified for the guest, a null UUID is returned.
+##
+{ 'struct': 'UuidInfo', 'data': {'UUID': 'str'} }
+
+##
+# @query-uuid:
+#
+# Query the guest UUID information.
+#
+# Returns: The @UuidInfo for the guest
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-uuid" }
+# <- { "return": { "UUID": "550e8400-e29b-41d4-a716-446655440000" } }
+#
+##
+{ 'command': 'query-uuid', 'returns': 'UuidInfo', 'allow-preconfig': true }
+
 ##
 # @GuidInfo:
 #
diff --git a/qapi/misc.json b/qapi/misc.json
index edcc91e1060..05db6295fe0 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -98,36 +98,6 @@
 ##
 { 'command': 'query-kvm', 'returns': 'KvmInfo' }
 
-##
-# @UuidInfo:
-#
-# Guest UUID information (Universally Unique Identifier).
-#
-# @UUID: the UUID of the guest
-#
-# Since: 0.14.0
-#
-# Notes: If no UUID was specified for the guest, a null UUID is returned.
-##
-{ 'struct': 'UuidInfo', 'data': {'UUID': 'str'} }
-
-##
-# @query-uuid:
-#
-# Query the guest UUID information.
-#
-# Returns: The @UuidInfo for the guest
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# -> { "execute": "query-uuid" }
-# <- { "return": { "UUID": "550e8400-e29b-41d4-a716-446655440000" } }
-#
-##
-{ 'command': 'query-uuid', 'returns': 'UuidInfo', 'allow-preconfig': true }
-
 ##
 # @IOThreadInfo:
 #
diff --git a/block/iscsi.c b/block/iscsi.c
index bd2122a3a44..e30a7e3606b 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -42,7 +42,7 @@
 #include "qemu/uuid.h"
 #include "sysemu/replay.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "crypto/secret.h"
diff --git a/stubs/uuid.c b/stubs/uuid.c
index 67f182fa3aa..e5112eb3f60 100644
--- a/stubs/uuid.c
+++ b/stubs/uuid.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qemu/uuid.h"
 
 UuidInfo *qmp_query_uuid(Error **errp)
-- 
2.26.2


