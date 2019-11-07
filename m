Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2246DC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E225D206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3xrzMXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E225D206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSkoA-0004Jb-Ny
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 11:38:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSkmb-0002bS-BQ
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSkmZ-0005T0-Cm
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22248
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSkmZ-0005SZ-8g
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573144634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U7Ajq2mAQ7rRIE9hi+u4n/l23R623DSEpIUL8mzmMIA=;
 b=A3xrzMXqTh2/hCexoDczoZZ6nCORl687zsRuEVuZVu2mBYyMBBfIYm4CZ+Wq2yb8qvWyII
 yxDk+3qQrmeiJlpKaxVVv8jGSn6oDscxZQv6c7PDzK3AqtHlPDBtP9gc7ky4NFmVWdC/Rl
 CyaZDbcyyBajd2Dx6Ks3s2fCPOn6DKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-eZs4l8n9NXmpQvwHHlZZTA-1; Thu, 07 Nov 2019 11:37:13 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C4581800D6B;
 Thu,  7 Nov 2019 16:37:12 +0000 (UTC)
Received: from localhost (ovpn-117-149.ams2.redhat.com [10.36.117.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E264A5C298;
 Thu,  7 Nov 2019 16:37:11 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 01/22] iotests: s/qocw2/qcow2/
Date: Thu,  7 Nov 2019 17:36:47 +0100
Message-Id: <20191107163708.833192-2-mreitz@redhat.com>
In-Reply-To: <20191107163708.833192-1-mreitz@redhat.com>
References: <20191107163708.833192-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: eZs4l8n9NXmpQvwHHlZZTA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Probably due to blind copy-pasting, we have several instances of "qocw2"
in our iotests.  Fix them.

Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/060 | 2 +-
 tests/qemu-iotests/061 | 2 +-
 tests/qemu-iotests/062 | 2 +-
 tests/qemu-iotests/066 | 2 +-
 tests/qemu-iotests/068 | 2 +-
 tests/qemu-iotests/108 | 2 +-
 tests/qemu-iotests/138 | 2 +-
 tests/qemu-iotests/261 | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index b91d8321bb..725e58a5a5 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -44,7 +44,7 @@ _filter_io_error()
 . ./common.rc
 . ./common.filter
=20
-# This tests qocw2-specific low-level functionality
+# This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index 4eac5b83bd..e1b8044630 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.rc
 . ./common.filter
=20
-# This tests qocw2-specific low-level functionality
+# This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/062 b/tests/qemu-iotests/062
index d5f818fcce..79738b1c26 100755
--- a/tests/qemu-iotests/062
+++ b/tests/qemu-iotests/062
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.rc
 . ./common.filter
=20
-# This tests qocw2-specific low-level functionality
+# This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto generic
=20
diff --git a/tests/qemu-iotests/066 b/tests/qemu-iotests/066
index 28f8c98412..cacbdb6ae0 100755
--- a/tests/qemu-iotests/066
+++ b/tests/qemu-iotests/066
@@ -36,7 +36,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.rc
 . ./common.filter
=20
-# This tests qocw2-specific low-level functionality
+# This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto generic
=20
diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
index 22f5ca3ba6..c164ccc64a 100755
--- a/tests/qemu-iotests/068
+++ b/tests/qemu-iotests/068
@@ -36,7 +36,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.rc
 . ./common.filter
=20
-# This tests qocw2-specific low-level functionality
+# This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto generic
=20
diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
index 9c08172237..872a9afec9 100755
--- a/tests/qemu-iotests/108
+++ b/tests/qemu-iotests/108
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.rc
 . ./common.filter
=20
-# This tests qocw2-specific low-level functionality
+# This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/138 b/tests/qemu-iotests/138
index 6a731370db..8b2f587af0 100755
--- a/tests/qemu-iotests/138
+++ b/tests/qemu-iotests/138
@@ -36,7 +36,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.rc
 . ./common.filter
=20
-# This tests qocw2-specific low-level functionality
+# This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/261 b/tests/qemu-iotests/261
index fb96bcfbe2..9f2817251f 100755
--- a/tests/qemu-iotests/261
+++ b/tests/qemu-iotests/261
@@ -40,7 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.rc
 . ./common.filter
=20
-# This tests qocw2-specific low-level functionality
+# This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
--=20
2.23.0


