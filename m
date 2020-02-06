Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F5AC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8F220658
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TaFN27jr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8F220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46513 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izonU-0001Y8-GI
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:34:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izob5-0001cn-BW
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:22:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izob4-0007iA-3g
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:22:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34042
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izob3-0007fQ-VX
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581024119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eBsFygIM+QteXl/1AwPhb7g0Ek/QxeUhQ7Th78lp3JQ=;
 b=TaFN27jrDILFDMujhIPMRrKFrMQ23jjDnSb8c7F2u5uDjAv/SAd/5HdoUgq2v5yjBEGUK9
 rPQdytDzoWiOoieeqjQQsFlDX/37/aGacNiB3WAoOGz9r1VDMALxhHy3edHzZ8HnzPTzyH
 zq9wZGz6JTC4Y8AOyeOtruLioEaX4fM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-z_cQOcSmNKGtrqSMI-ShJw-1; Thu, 06 Feb 2020 16:21:56 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08F518024D6;
 Thu,  6 Feb 2020 21:21:55 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6DAA60BEC;
 Thu,  6 Feb 2020 21:21:49 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 34/46] tests: Explicit usage of Python 3
Date: Thu,  6 Feb 2020 22:19:24 +0100
Message-Id: <20200206211936.17098-35-philmd@redhat.com>
In-Reply-To: <20200206211936.17098-1-philmd@redhat.com>
References: <20200206211936.17098-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: z_cQOcSmNKGtrqSMI-ShJw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the program search path to find the Python 3 interpreter.

Patch created mechanically by running:

  $ sed -i "s,^#\!/usr/bin/\(env\ \)\?python$,#\!/usr/bin/env python3," \
       $(git grep -l 'if __name__.*__main__')

Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200130163232.10446-5-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/docker/travis.py         | 2 +-
 tests/qapi-schema/test-qapi.py | 2 +-
 tests/vm/centos                | 2 +-
 tests/vm/fedora                | 2 +-
 tests/vm/freebsd               | 2 +-
 tests/vm/netbsd                | 2 +-
 tests/vm/openbsd               | 2 +-
 tests/vm/ubuntu.i386           | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/docker/travis.py b/tests/docker/travis.py
index e1433012bd..62fccc5ebb 100755
--- a/tests/docker/travis.py
+++ b/tests/docker/travis.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Travis YAML config parser
 #
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.p=
y
index bad14edb47..503fb8ad25 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # QAPI parser test harness
 #
diff --git a/tests/vm/centos b/tests/vm/centos
index f2f0befd84..a41ff109eb 100755
--- a/tests/vm/centos
+++ b/tests/vm/centos
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # CentOS image
 #
diff --git a/tests/vm/fedora b/tests/vm/fedora
index 8e270fc0f0..4d7d6049f4 100755
--- a/tests/vm/fedora
+++ b/tests/vm/fedora
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Fedora VM image
 #
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 33a736298a..fb54334696 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # FreeBSD VM image
 #
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index ec6f3563b2..c5069a45f4 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # NetBSD VM image
 #
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index d6173506f7..22cd9513dd 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # OpenBSD VM image
 #
diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 3834cd7a8d..48e9cb1ad3 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Ubuntu i386 image
 #
--=20
2.21.1


