Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F1BCA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 089BE20862
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089BE20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPaWG-0001jI-GC
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 19:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iPaTc-0008KT-T5
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iPaTb-0003Uu-Py
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59422)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iPaTb-0003TN-JD
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:35 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C34ED8553F
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 23:00:34 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id 6so523842qtu.7
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 16:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=F1hfahIKykEC1dF86on2fG9+aTlh1MBf7UtW/TDv/qU=;
 b=qM9F56aZESQxVvhkI4ULuPAwEbSGeKgZJs2Smuv0tTsCed9y+6F6KAqg6wHKQJ7sXQ
 6CA+zrAhhMhl6L1B+4WRTFm3KPk3rr6d8rPFLlk5yGfVzNBoJefO5V2fxYXR04oC0ADj
 Z+J2asVtNci00ShJhgprxw6nhxUeBNv3Ogc90lMMQaGtUk6Sj4rVegUEgJoKW3nPMfG4
 l4wJ04G4bumhg0K+807mQ4s0F2pEwY5uqWtAnbG0XpwKvo2s4ENR+BpLFSYV7vkHlGX1
 qoWghxCl3PBrkJ/hbi/O1bBUwXXCn0kNnbWDUedkeq9uxKyNryxOMYlgU4M9mDoufd/G
 Z7+w==
X-Gm-Message-State: APjAAAVSKihF0+NiXtIQQK6VibgWn1QZhBgK7HRU+XkGp06uIsHGoY/+
 F3SvCdmKiKt397lcJbsDtgVVbwKH3zCQOqQ2PtiUexc9i6znjK+9rALJXXMXvp/vUU3F7vsGhGu
 CaUEETU6Wvh0l1V4=
X-Received: by 2002:a05:620a:8d9:: with SMTP id
 z25mr8114175qkz.483.1572390033657; 
 Tue, 29 Oct 2019 16:00:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqww9/VwAm9jG4ANdcpvAaAMcebpdrUQJHBE/pfwoy/s2AQV6dg89Kzcx4z7D4Bm27HrFLSaEg==
X-Received: by 2002:a05:620a:8d9:: with SMTP id
 z25mr8114138qkz.483.1572390033310; 
 Tue, 29 Oct 2019 16:00:33 -0700 (PDT)
Received: from redhat.com (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id k17sm325117qkg.63.2019.10.29.16.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 16:00:32 -0700 (PDT)
Date: Tue, 29 Oct 2019 19:00:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/14] qapi: add unplug primary event
Message-ID: <20191029225932.14585-6-mst@redhat.com>
References: <20191029225932.14585-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029225932.14585-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jens Freimann <jfreimann@redhat.com>

This event is emitted when we sent a request to unplug a
failover primary device from the Guest OS and it includes the
device id of the primary device.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Message-Id: <20191029114905.6856-6-jfreimann@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/migration.json | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/qapi/migration.json b/qapi/migration.json
index 82feb5bd39..e9e7a97c03 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1448,3 +1448,22 @@
 # Since: 3.0
 ##
 { 'command': 'migrate-pause', 'allow-oob': true }
+
+##
+# @UNPLUG_PRIMARY:
+#
+# Emitted from source side of a migration when migration state is
+# WAIT_UNPLUG. Device was unplugged by guest operating system.
+# Device resources in QEMU are kept on standby to be able to re-plug it in case
+# of migration failure.
+#
+# @device-id: QEMU device id of the unplugged device
+#
+# Since: 4.2
+#
+# Example:
+#   {"event": "UNPLUG_PRIMARY", "data": {"device-id": "hostdev0"} }
+#
+##
+{ 'event': 'UNPLUG_PRIMARY',
+  'data': { 'device-id': 'str' } }
-- 
MST


