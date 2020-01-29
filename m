Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404C9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09DF920678
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAxlsxA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DF920678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52777 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwwaN-0000dO-4p
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 18:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwwXg-0004RX-EV
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:14:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwwXf-00018I-7A
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:14:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32826
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwwXf-00017i-42
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:14:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580339678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Ci9BaCxgdIZecqR9n7oGxc4Blyawh6fanmUu+mUzfA=;
 b=FAxlsxA8E+e5MVh0i6UCT+S6Un8Ow3z/5LZPwIX+jJImszzbOblLgQYM1ecZc9MCaL/SJU
 eKsrGOFwuYxQi3IUxfoI8jg1B7B72zc4pcBQWXlWBnYzAjv2giPl2Ni9jb20wVDRHhuRfQ
 vFZXVDpLqI/wHSODoV/Lp63mW7/QPfs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-EevXuBfKPmSuYscTDRQ0-A-1; Wed, 29 Jan 2020 18:14:37 -0500
X-MC-Unique: EevXuBfKPmSuYscTDRQ0-A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C583107ACC9;
 Wed, 29 Jan 2020 23:14:35 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-184.brq.redhat.com [10.40.205.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 389445E241;
 Wed, 29 Jan 2020 23:14:26 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/10] tests: Explicit usage of Python 3
Date: Thu, 30 Jan 2020 00:13:55 +0100
Message-Id: <20200129231402.23384-4-philmd@redhat.com>
In-Reply-To: <20200129231402.23384-1-philmd@redhat.com>
References: <20200129231402.23384-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
       $(git grep -l 'if __name__.*__main__')

Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
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
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
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


