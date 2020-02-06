Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CDFC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:40:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4406121775
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5dSwLdc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4406121775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izosZ-0003kI-JI
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:40:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izob3-0001YW-Tk
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:22:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izoau-0007VB-PP
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33325
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izoau-0007S9-KY
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581024112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wO959a/hfl/gPifTUzf0nOJRNQgwzuT0MaHHsqF78LI=;
 b=T5dSwLdcPGhE9SY/wsOeZqWt+xEBbCY39PfBi1hJm7vdUM1bP19uM2dF05QKl1I3+cvR97
 myTnfq96iYBpxRSKdijlvGOsM3VU7FX9OTPemTm5BzaVPF62ygi0aeUUarEj1bQlGM71kZ
 PoC8T8DnjhKQdUCEuPRTffbiFreDO9g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-IG9xhWgsOPKnhIz-_LI-Fg-1; Thu, 06 Feb 2020 16:21:50 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C0C710509A3;
 Thu,  6 Feb 2020 21:21:49 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8FD660BEC;
 Thu,  6 Feb 2020 21:21:43 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 33/46] tests/qemu-iotests: Explicit usage of Python 3 (scripts
 with __main__)
Date: Thu,  6 Feb 2020 22:19:23 +0100
Message-Id: <20200206211936.17098-34-philmd@redhat.com>
In-Reply-To: <20200206211936.17098-1-philmd@redhat.com>
References: <20200206211936.17098-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: IG9xhWgsOPKnhIz-_LI-Fg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
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
Message-Id: <20200130163232.10446-4-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/qemu-iotests/030                   | 2 +-
 tests/qemu-iotests/040                   | 2 +-
 tests/qemu-iotests/041                   | 2 +-
 tests/qemu-iotests/044                   | 2 +-
 tests/qemu-iotests/045                   | 2 +-
 tests/qemu-iotests/055                   | 2 +-
 tests/qemu-iotests/056                   | 2 +-
 tests/qemu-iotests/057                   | 2 +-
 tests/qemu-iotests/065                   | 2 +-
 tests/qemu-iotests/093                   | 2 +-
 tests/qemu-iotests/096                   | 2 +-
 tests/qemu-iotests/118                   | 2 +-
 tests/qemu-iotests/124                   | 2 +-
 tests/qemu-iotests/129                   | 2 +-
 tests/qemu-iotests/132                   | 2 +-
 tests/qemu-iotests/136                   | 2 +-
 tests/qemu-iotests/139                   | 2 +-
 tests/qemu-iotests/147                   | 2 +-
 tests/qemu-iotests/148                   | 2 +-
 tests/qemu-iotests/151                   | 2 +-
 tests/qemu-iotests/152                   | 2 +-
 tests/qemu-iotests/155                   | 2 +-
 tests/qemu-iotests/163                   | 2 +-
 tests/qemu-iotests/165                   | 2 +-
 tests/qemu-iotests/169                   | 2 +-
 tests/qemu-iotests/196                   | 2 +-
 tests/qemu-iotests/199                   | 2 +-
 tests/qemu-iotests/205                   | 2 +-
 tests/qemu-iotests/245                   | 2 +-
 tests/qemu-iotests/257                   | 2 +-
 tests/qemu-iotests/258                   | 2 +-
 tests/qemu-iotests/281                   | 2 +-
 tests/qemu-iotests/nbd-fault-injector.py | 2 +-
 tests/qemu-iotests/qcow2.py              | 2 +-
 tests/qemu-iotests/qed.py                | 2 +-
 35 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 0990681c1e..aa911d266a 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Tests for image streaming.
 #
diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 74f62c3c4a..2e7ee0e84f 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Tests for image block commit.
 #
diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index c07437fda1..219b120b57 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Tests for image mirroring.
 #
diff --git a/tests/qemu-iotests/044 b/tests/qemu-iotests/044
index 8b2afa2a11..7e99ea7c68 100755
--- a/tests/qemu-iotests/044
+++ b/tests/qemu-iotests/044
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Tests growing a large refcount table.
 #
diff --git a/tests/qemu-iotests/045 b/tests/qemu-iotests/045
index 01cc038884..5acc89099c 100755
--- a/tests/qemu-iotests/045
+++ b/tests/qemu-iotests/045
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Tests for fdsets and getfd.
 #
diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index c732a112d6..82b9f5f47d 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Tests for drive-backup and blockdev-backup
 #
diff --git a/tests/qemu-iotests/056 b/tests/qemu-iotests/056
index f39287c162..f73fc74457 100755
--- a/tests/qemu-iotests/056
+++ b/tests/qemu-iotests/056
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Tests for drive-backup
 #
diff --git a/tests/qemu-iotests/057 b/tests/qemu-iotests/057
index 9fbba759b6..a8b4bb60e0 100755
--- a/tests/qemu-iotests/057
+++ b/tests/qemu-iotests/057
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Tests for internal snapshot.
 #
diff --git a/tests/qemu-iotests/065 b/tests/qemu-iotests/065
index 5b21eb96bd..6426474271 100755
--- a/tests/qemu-iotests/065
+++ b/tests/qemu-iotests/065
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test for additional information emitted by qemu-img info on qcow2
 # images
diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
index f03fa24a07..32ded11430 100755
--- a/tests/qemu-iotests/093
+++ b/tests/qemu-iotests/093
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Tests for IO throttling
 #
diff --git a/tests/qemu-iotests/096 b/tests/qemu-iotests/096
index ab9cb47822..5915f92786 100755
--- a/tests/qemu-iotests/096
+++ b/tests/qemu-iotests/096
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test that snapshots move the throttling configuration to the active
 # layer
diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
index e20080e9a6..adc8a848b5 100755
--- a/tests/qemu-iotests/118
+++ b/tests/qemu-iotests/118
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test case for the QMP 'change' command and all other associated
 # commands
diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
index d3e851e1ae..3705cbb6b3 100755
--- a/tests/qemu-iotests/124
+++ b/tests/qemu-iotests/124
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Tests for incremental drive-backup
 #
diff --git a/tests/qemu-iotests/129 b/tests/qemu-iotests/129
index cd6b9e9ce7..b0da4a5541 100755
--- a/tests/qemu-iotests/129
+++ b/tests/qemu-iotests/129
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Tests that "bdrv_drain_all" doesn't drain block jobs
 #
diff --git a/tests/qemu-iotests/132 b/tests/qemu-iotests/132
index 0f2a106c81..39ea43067e 100755
--- a/tests/qemu-iotests/132
+++ b/tests/qemu-iotests/132
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test mirror with unmap
 #
diff --git a/tests/qemu-iotests/136 b/tests/qemu-iotests/136
index 012ea111ac..d59400c9fc 100755
--- a/tests/qemu-iotests/136
+++ b/tests/qemu-iotests/136
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Tests for block device statistics
 #
diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
index cbb5a76530..6b1a444364 100755
--- a/tests/qemu-iotests/139
+++ b/tests/qemu-iotests/139
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test cases for the QMP 'blockdev-del' command
 #
diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
index 2b6f859a09..f4b0a11dba 100755
--- a/tests/qemu-iotests/147
+++ b/tests/qemu-iotests/147
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test case for NBD's blockdev-add interface
 #
diff --git a/tests/qemu-iotests/148 b/tests/qemu-iotests/148
index 8c11c53cba..90931948e3 100755
--- a/tests/qemu-iotests/148
+++ b/tests/qemu-iotests/148
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test the rate limit of QMP events
 #
diff --git a/tests/qemu-iotests/151 b/tests/qemu-iotests/151
index 76ae265cc1..f2df72c29c 100755
--- a/tests/qemu-iotests/151
+++ b/tests/qemu-iotests/151
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Tests for active mirroring
 #
diff --git a/tests/qemu-iotests/152 b/tests/qemu-iotests/152
index 732bf5f062..cc2ea09654 100755
--- a/tests/qemu-iotests/152
+++ b/tests/qemu-iotests/152
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Tests for drive-mirror with source size unaligned to granularity
 #
diff --git a/tests/qemu-iotests/155 b/tests/qemu-iotests/155
index e19485911c..e35b1d534b 100755
--- a/tests/qemu-iotests/155
+++ b/tests/qemu-iotests/155
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test whether the backing BDSs are correct after completion of a
 # mirror block job; in "existing" modes (drive-mirror with
diff --git a/tests/qemu-iotests/163 b/tests/qemu-iotests/163
index d94728e080..5a3cc840a5 100755
--- a/tests/qemu-iotests/163
+++ b/tests/qemu-iotests/163
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Tests for shrinking images
 #
diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
index 951ea011a2..b60a803dae 100755
--- a/tests/qemu-iotests/165
+++ b/tests/qemu-iotests/165
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Tests for persistent dirty bitmaps.
 #
diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
index 9656a7f620..2c5a132aa3 100755
--- a/tests/qemu-iotests/169
+++ b/tests/qemu-iotests/169
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Tests for dirty bitmaps migration.
 #
diff --git a/tests/qemu-iotests/196 b/tests/qemu-iotests/196
index 92fe9244f8..e8fcf37273 100755
--- a/tests/qemu-iotests/196
+++ b/tests/qemu-iotests/196
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test clearing unknown autoclear_features flag by qcow2 after
 # migration. This test mimics migration to older qemu.
diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index a2c8ecab5a..40774eed74 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Tests for dirty bitmaps postcopy migration.
 #
diff --git a/tests/qemu-iotests/205 b/tests/qemu-iotests/205
index 4bb2c21e8b..43432cb599 100755
--- a/tests/qemu-iotests/205
+++ b/tests/qemu-iotests/205
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Tests for qmp command nbd-server-remove.
 #
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index d12b253065..489bf78bd0 100644
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test cases for the QMP 'x-blockdev-reopen' command
 #
diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index a9828251cf..004a433b8b 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test bitmap-sync backups (incremental, differential, and partials)
 #
diff --git a/tests/qemu-iotests/258 b/tests/qemu-iotests/258
index b84cf02254..091755a45c 100755
--- a/tests/qemu-iotests/258
+++ b/tests/qemu-iotests/258
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Very specific tests for adjacent commit/stream block jobs
 #
diff --git a/tests/qemu-iotests/281 b/tests/qemu-iotests/281
index 269d583b2c..0bf973bca6 100755
--- a/tests/qemu-iotests/281
+++ b/tests/qemu-iotests/281
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Test cases for blockdev + IOThread interactions
 #
diff --git a/tests/qemu-iotests/nbd-fault-injector.py b/tests/qemu-iotests/=
nbd-fault-injector.py
index 7e2dab6ea4..b158dd65a2 100755
--- a/tests/qemu-iotests/nbd-fault-injector.py
+++ b/tests/qemu-iotests/nbd-fault-injector.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # NBD server - fault injection utility
 #
 # Configuration file syntax:
diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
index 91e4420b9f..1c4fa2b09f 100755
--- a/tests/qemu-iotests/qcow2.py
+++ b/tests/qemu-iotests/qcow2.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
=20
 from __future__ import print_function
 import sys
diff --git a/tests/qemu-iotests/qed.py b/tests/qemu-iotests/qed.py
index 8adaaf46c4..36bca1de23 100755
--- a/tests/qemu-iotests/qed.py
+++ b/tests/qemu-iotests/qed.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # Tool to manipulate QED image files
 #
--=20
2.21.1


