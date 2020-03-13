Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F24AC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9F0206E7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGShbtDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9F0206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpJV-0007Hz-5R
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpGO-0001i2-Tx
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpGK-0005jT-9X
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:42:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50973
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpGK-0005iX-5D
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584124943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=icvsAljHCvMOvrCYpqizBXKfThlHp6MVycf3qobY6O0=;
 b=ZGShbtDvIXZBGM9kSuPYsiwpYYVhnSxv8Bf3Zozx6NHk8LoalaKcr+WLfUTs291A6UWp3/
 nLCuCbc9W3w7nrtP6HhRavFawGmucJmrwwVWlxbjZputdLkeye0Z/nHKZk0q2UrRPqtTg9
 cauVttPNGKuxUra1vc77t1OHrQJh0po=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-oFgS-J4_M9uE2arrU2rRFw-1; Fri, 13 Mar 2020 14:42:21 -0400
X-MC-Unique: oFgS-J4_M9uE2arrU2rRFw-1
Received: by mail-wr1-f71.google.com with SMTP id c6so4685936wrm.18
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tWYpPXM4ob5O9NHPJVJk5pAHGrKHnH0gc4Gbe7NXkpg=;
 b=ZLyYAJusKGdUKGg0qHoNlpeXaNUAg/YAda8xs7hDa/5HVjnn2bX1mDCzhOo4ftBrps
 hYE/S11CX3Q9UDQanOYoaAFFDM7p94tJr7p32EvCRNXIAwmUg9luaaC4xilYI600/VgD
 1jHUoz4ZqnbhIba5iFh8jsa4jckUM0xuWIq5nGGMl6PR8TdW6gOnEktnObUJMxNhqpE9
 50Afnwv7xO+reXhAMCITleeW64qw0cMKf2ljhXvghFh5HkhIfydMfjZ72BoZYGOwJ0G0
 5qTjcA6xWwu35BWJywgFaVzBlNICkM8s5r6jC3213TMx+HpGnjSRNn0TeJiyoWxXnEv0
 1Nyg==
X-Gm-Message-State: ANhLgQ0bIK0ZQGKwjii+hyAB8yhN8ciAjOlYZgh7PSy572hJfg6zuuN0
 PqB284Tpr34/VWULItrmEUAQ3L9IL0K4Zk0TWQ4uX7/7z5lCu4qqRUJCZMQxdKe/+LA1nPu+Vri
 epKaYAicQJWCxopg=
X-Received: by 2002:a5d:5512:: with SMTP id b18mr18771695wrv.215.1584124940660; 
 Fri, 13 Mar 2020 11:42:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs0VUlU5DssYZDnreWuJZwLltrmFuSNqz/2k0gHNsivWnegCyHm4fcmYUDpkxcEbESKsDvhrw==
X-Received: by 2002:a5d:5512:: with SMTP id b18mr18771675wrv.215.1584124940326; 
 Fri, 13 Mar 2020 11:42:20 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id f15sm17861272wmj.25.2020.03.13.11.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:42:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/9] qapi/misc: Move query-uuid command with block code
Date: Fri, 13 Mar 2020 19:41:49 +0100
Message-Id: <20200313184153.11275-6-philmd@redhat.com>
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
 [fuzzy]
X-Received-From: 207.211.31.120
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
 qapi/block-core.json | 30 ++++++++++++++++++++++++++++++
 qapi/misc.json       | 30 ------------------------------
 block/iscsi.c        |  2 +-
 stubs/uuid.c         |  2 +-
 4 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 91586fb1fb..5c3fa6c5d0 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5415,3 +5415,33 @@
 { 'command': 'blockdev-snapshot-delete-internal-sync',
   'data': { 'device': 'str', '*id': 'str', '*name': 'str'},
   'returns': 'SnapshotInfo' }
+
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
+{ 'command': 'query-uuid', 'returns': 'UuidInfo', 'allow-preconfig': true =
}
diff --git a/qapi/misc.json b/qapi/misc.json
index 74cbe253f2..18cd0719f3 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -65,36 +65,6 @@
 ##
 { 'command': 'query-kvm', 'returns': 'KvmInfo' }
=20
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
-{ 'command': 'query-uuid', 'returns': 'UuidInfo', 'allow-preconfig': true =
}
-
 ##
 # @IOThreadInfo:
 #
diff --git a/block/iscsi.c b/block/iscsi.c
index 682abd8e09..68ed5cf3f8 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -42,7 +42,7 @@
 #include "qemu/uuid.h"
 #include "sysemu/replay.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-block-core.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "crypto/secret.h"
diff --git a/stubs/uuid.c b/stubs/uuid.c
index 67f182fa3a..9ef75fdae4 100644
--- a/stubs/uuid.c
+++ b/stubs/uuid.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-block-core.h"
 #include "qemu/uuid.h"
=20
 UuidInfo *qmp_query_uuid(Error **errp)
--=20
2.21.1


