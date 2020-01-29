Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F581C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:21:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5906A206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZIp7+PR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5906A206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwwdx-0005PW-EO
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 18:21:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwwYN-0005kB-VM
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:15:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwwYL-0002S2-N4
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:15:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29445
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwwYL-0002Po-Gg
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580339721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5CilYfwG0byQCecdDk/ryf/x/D5vhk9mReliBiNHBq0=;
 b=YZIp7+PRhOpLTHjJiS4rdr0DBiZn6gowCgIOzv6O07InmNsh6cwQpYwAMWGoJyWTNB3yQr
 7GzkmBKhBrVncwyUQaTnXDspJHnDBbZcns0ZNAXXiJ9f7WM4xUaYpYST5/AJdzGeAdffyb
 fpj3vbPy5Sop8PzMg0s6h5mbpwHoUnU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-vAOA7oOKPDmJtAJ5rUcvAA-1; Wed, 29 Jan 2020 18:15:18 -0500
X-MC-Unique: vAOA7oOKPDmJtAJ5rUcvAA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB97E108838D;
 Wed, 29 Jan 2020 23:15:16 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-184.brq.redhat.com [10.40.205.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED0C95E241;
 Wed, 29 Jan 2020 23:15:06 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/10] tests/qemu-iotests: Explicit usage of Python 3
Date: Thu, 30 Jan 2020 00:14:00 +0100
Message-Id: <20200129231402.23384-9-philmd@redhat.com>
In-Reply-To: <20200129231402.23384-1-philmd@redhat.com>
References: <20200129231402.23384-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the program search path to find the Python 3 interpreter.

Patch created mechanically by running:

  $ sed -i "s,^#\!/usr/bin/\(env\ \)\?python$,#\!/usr/bin/env python3," \
      $(git grep -lF '#!/usr/bin/env python' | xargs grep -L 'if __name__=
.*__main__')

Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/qemu-iotests/149 | 2 +-
 tests/qemu-iotests/194 | 2 +-
 tests/qemu-iotests/202 | 2 +-
 tests/qemu-iotests/203 | 2 +-
 tests/qemu-iotests/206 | 2 +-
 tests/qemu-iotests/207 | 2 +-
 tests/qemu-iotests/208 | 2 +-
 tests/qemu-iotests/209 | 2 +-
 tests/qemu-iotests/210 | 2 +-
 tests/qemu-iotests/211 | 2 +-
 tests/qemu-iotests/212 | 2 +-
 tests/qemu-iotests/213 | 2 +-
 tests/qemu-iotests/216 | 2 +-
 tests/qemu-iotests/218 | 2 +-
 tests/qemu-iotests/219 | 2 +-
 tests/qemu-iotests/222 | 2 +-
 tests/qemu-iotests/224 | 2 +-
 tests/qemu-iotests/228 | 2 +-
 tests/qemu-iotests/234 | 2 +-
 tests/qemu-iotests/235 | 2 +-
 tests/qemu-iotests/236 | 2 +-
 tests/qemu-iotests/237 | 2 +-
 tests/qemu-iotests/238 | 2 +-
 tests/qemu-iotests/242 | 2 +-
 tests/qemu-iotests/246 | 2 +-
 tests/qemu-iotests/248 | 2 +-
 tests/qemu-iotests/254 | 2 +-
 tests/qemu-iotests/255 | 2 +-
 tests/qemu-iotests/256 | 2 +-
 tests/qemu-iotests/260 | 2 +-
 tests/qemu-iotests/262 | 2 +-
 tests/qemu-iotests/264 | 2 +-
 tests/qemu-iotests/266 | 2 +-
 tests/qemu-iotests/277 | 2 +-
 tests/qemu-iotests/280 | 2 +-
 35 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
index 8ab42e94c6..0a7b765d07 100755
--- a/tests/qemu-iotests/149
+++ b/tests/qemu-iotests/149
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Copyright (C) 2016 Red Hat, Inc.
 #
diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index 72e47e8833..9dc1bd3510 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Copyright (C) 2017 Red Hat, Inc.
 #
diff --git a/tests/qemu-iotests/202 b/tests/qemu-iotests/202
index 581ca34d79..920a8683ef 100755
--- a/tests/qemu-iotests/202
+++ b/tests/qemu-iotests/202
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Copyright (C) 2017 Red Hat, Inc.
 #
diff --git a/tests/qemu-iotests/203 b/tests/qemu-iotests/203
index 4874a1a0d8..49eff5d405 100755
--- a/tests/qemu-iotests/203
+++ b/tests/qemu-iotests/203
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Copyright (C) 2017 Red Hat, Inc.
 #
diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
index 9f16a7df8d..e2b50ae24d 100755
--- a/tests/qemu-iotests/206
+++ b/tests/qemu-iotests/206
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test qcow2 and file image creation
 #
diff --git a/tests/qemu-iotests/207 b/tests/qemu-iotests/207
index 812ab34e47..3d9c1208ca 100755
--- a/tests/qemu-iotests/207
+++ b/tests/qemu-iotests/207
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test ssh image creation
 #
diff --git a/tests/qemu-iotests/208 b/tests/qemu-iotests/208
index 546eb1de3e..1c3fc8c7fd 100755
--- a/tests/qemu-iotests/208
+++ b/tests/qemu-iotests/208
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Copyright (C) 2018 Red Hat, Inc.
 #
diff --git a/tests/qemu-iotests/209 b/tests/qemu-iotests/209
index e0f464bcbe..65c1a1e70a 100755
--- a/tests/qemu-iotests/209
+++ b/tests/qemu-iotests/209
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Tests for NBD BLOCK_STATUS extension
 #
diff --git a/tests/qemu-iotests/210 b/tests/qemu-iotests/210
index 4ca0fe26ef..e49896e23d 100755
--- a/tests/qemu-iotests/210
+++ b/tests/qemu-iotests/210
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test luks and file image creation
 #
diff --git a/tests/qemu-iotests/211 b/tests/qemu-iotests/211
index 8834ebfe85..163994d559 100755
--- a/tests/qemu-iotests/211
+++ b/tests/qemu-iotests/211
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test VDI and file image creation
 #
diff --git a/tests/qemu-iotests/212 b/tests/qemu-iotests/212
index 8f3ccc7b15..800f92dd84 100755
--- a/tests/qemu-iotests/212
+++ b/tests/qemu-iotests/212
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test parallels and file image creation
 #
diff --git a/tests/qemu-iotests/213 b/tests/qemu-iotests/213
index 3fc8dc6eaa..1eee45276a 100755
--- a/tests/qemu-iotests/213
+++ b/tests/qemu-iotests/213
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test vhdx and file image creation
 #
diff --git a/tests/qemu-iotests/216 b/tests/qemu-iotests/216
index 3c0ae54b44..372f042d3e 100755
--- a/tests/qemu-iotests/216
+++ b/tests/qemu-iotests/216
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Copy-on-read tests using a COR filter node
 #
diff --git a/tests/qemu-iotests/218 b/tests/qemu-iotests/218
index 2554d84581..1325ba9eaa 100755
--- a/tests/qemu-iotests/218
+++ b/tests/qemu-iotests/218
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # This test covers what happens when a mirror block job is cancelled
 # in various phases of its existence.
diff --git a/tests/qemu-iotests/219 b/tests/qemu-iotests/219
index 655f54d881..b8774770c4 100755
--- a/tests/qemu-iotests/219
+++ b/tests/qemu-iotests/219
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Copyright (C) 2018 Red Hat, Inc.
 #
diff --git a/tests/qemu-iotests/222 b/tests/qemu-iotests/222
index 3f9f934ad8..bf1718e179 100644
--- a/tests/qemu-iotests/222
+++ b/tests/qemu-iotests/222
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # This test covers the basic fleecing workflow, which provides a
 # point-in-time snapshot of a node that can be queried over NBD.
diff --git a/tests/qemu-iotests/224 b/tests/qemu-iotests/224
index b4dfaa639f..e91fb26fd8 100755
--- a/tests/qemu-iotests/224
+++ b/tests/qemu-iotests/224
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test json:{} filenames with qemu-internal BDSs
 # (the one of commit, to be precise)
diff --git a/tests/qemu-iotests/228 b/tests/qemu-iotests/228
index 9a50afd205..64bc82ee23 100755
--- a/tests/qemu-iotests/228
+++ b/tests/qemu-iotests/228
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test for when a backing file is considered overridden (thus, a
 # json:{} filename is generated for the overlay) and when it is not
diff --git a/tests/qemu-iotests/234 b/tests/qemu-iotests/234
index 59a7f949ec..324c1549fd 100755
--- a/tests/qemu-iotests/234
+++ b/tests/qemu-iotests/234
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Copyright (C) 2018 Red Hat, Inc.
 #
diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
index 3d7533980d..760826128e 100755
--- a/tests/qemu-iotests/235
+++ b/tests/qemu-iotests/235
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Simple mirror test
 #
diff --git a/tests/qemu-iotests/236 b/tests/qemu-iotests/236
index 79a6381f8e..8ce927a16c 100755
--- a/tests/qemu-iotests/236
+++ b/tests/qemu-iotests/236
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test bitmap merges.
 #
diff --git a/tests/qemu-iotests/237 b/tests/qemu-iotests/237
index a2242a4736..50ba364a3e 100755
--- a/tests/qemu-iotests/237
+++ b/tests/qemu-iotests/237
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test vmdk and file image creation
 #
diff --git a/tests/qemu-iotests/238 b/tests/qemu-iotests/238
index e5ac2b2ff8..d4e060228c 100755
--- a/tests/qemu-iotests/238
+++ b/tests/qemu-iotests/238
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Regression test for throttle group member unregister segfault with iot=
hread
 #
diff --git a/tests/qemu-iotests/242 b/tests/qemu-iotests/242
index c176e92da6..97617876bc 100755
--- a/tests/qemu-iotests/242
+++ b/tests/qemu-iotests/242
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test for qcow2 bitmap printed information
 #
diff --git a/tests/qemu-iotests/246 b/tests/qemu-iotests/246
index b0997a392f..59a216a839 100755
--- a/tests/qemu-iotests/246
+++ b/tests/qemu-iotests/246
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test persistent bitmap resizing.
 #
diff --git a/tests/qemu-iotests/248 b/tests/qemu-iotests/248
index f26b4bb2aa..68c374692e 100755
--- a/tests/qemu-iotests/248
+++ b/tests/qemu-iotests/248
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test resume mirror after auto pause on ENOSPC
 #
diff --git a/tests/qemu-iotests/254 b/tests/qemu-iotests/254
index 09584f3f7d..ee66c986db 100755
--- a/tests/qemu-iotests/254
+++ b/tests/qemu-iotests/254
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test external snapshot with bitmap copying and moving.
 #
diff --git a/tests/qemu-iotests/255 b/tests/qemu-iotests/255
index 0ba03d9e61..4a4818bafb 100755
--- a/tests/qemu-iotests/255
+++ b/tests/qemu-iotests/255
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test commit job graph modifications while requests are active
 #
diff --git a/tests/qemu-iotests/256 b/tests/qemu-iotests/256
index c594a43205..e34074c83e 100755
--- a/tests/qemu-iotests/256
+++ b/tests/qemu-iotests/256
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test incremental/backup across iothread contexts
 #
diff --git a/tests/qemu-iotests/260 b/tests/qemu-iotests/260
index 4f6082c9d2..30c0de380d 100755
--- a/tests/qemu-iotests/260
+++ b/tests/qemu-iotests/260
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Tests for temporary external snapshot when we have bitmaps.
 #
diff --git a/tests/qemu-iotests/262 b/tests/qemu-iotests/262
index bbcb5260a6..8835dce7be 100755
--- a/tests/qemu-iotests/262
+++ b/tests/qemu-iotests/262
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Copyright (C) 2019 Red Hat, Inc.
 #
diff --git a/tests/qemu-iotests/264 b/tests/qemu-iotests/264
index 131366422b..879123a343 100755
--- a/tests/qemu-iotests/264
+++ b/tests/qemu-iotests/264
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test nbd reconnect
 #
diff --git a/tests/qemu-iotests/266 b/tests/qemu-iotests/266
index c353cf88ee..91bdf8729e 100755
--- a/tests/qemu-iotests/266
+++ b/tests/qemu-iotests/266
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test VPC and file image creation
 #
diff --git a/tests/qemu-iotests/277 b/tests/qemu-iotests/277
index 1f72dca2d4..04aa15a3d5 100755
--- a/tests/qemu-iotests/277
+++ b/tests/qemu-iotests/277
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test NBD client reconnection
 #
diff --git a/tests/qemu-iotests/280 b/tests/qemu-iotests/280
index 85e9114c5e..69288fdd0e 100755
--- a/tests/qemu-iotests/280
+++ b/tests/qemu-iotests/280
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Copyright (C) 2019 Red Hat, Inc.
 #
--=20
2.21.1


