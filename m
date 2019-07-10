Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32906C73C65
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 01:11:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0055020645
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 01:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0055020645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl192-0004cc-U5
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 21:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48911)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hl13j-0000HL-6v
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 21:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hl13h-0004KL-2i
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 21:06:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58800)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hl13Z-0004EC-J1; Tue, 09 Jul 2019 21:06:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 79713D6F02;
 Wed, 10 Jul 2019 01:06:00 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AFFDB1001B1B;
 Wed, 10 Jul 2019 01:05:59 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 21:05:49 -0400
Message-Id: <20190710010556.32365-2-jsnow@redhat.com>
In-Reply-To: <20190710010556.32365-1-jsnow@redhat.com>
References: <20190710010556.32365-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 10 Jul 2019 01:06:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/8] iotests/257: add Pattern class
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just kidding, this is easier to manage with a full class instead of a
namedtuple.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/257 | 58 +++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index 75a651c7c3..f576a35a5c 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -19,7 +19,6 @@
 #
 # owner=3Djsnow@redhat.com
=20
-from collections import namedtuple
 import math
 import os
=20
@@ -29,10 +28,18 @@ from iotests import log, qemu_img
 SIZE =3D 64 * 1024 * 1024
 GRANULARITY =3D 64 * 1024
=20
-Pattern =3D namedtuple('Pattern', ['byte', 'offset', 'size'])
-def mkpattern(byte, offset, size=3DGRANULARITY):
-    """Constructor for Pattern() with default size"""
-    return Pattern(byte, offset, size)
+
+class Pattern:
+    def __init__(self, byte, offset, size=3DGRANULARITY):
+        self.byte =3D byte
+        self.offset =3D offset
+        self.size =3D size
+
+    def bits(self, granularity):
+        lower =3D math.floor(self.offset / granularity)
+        upper =3D math.floor((self.offset + self.size - 1) / granularity=
)
+        return set(range(lower, upper + 1))
+
=20
 class PatternGroup:
     """Grouping of Pattern objects. Initialize with an iterable of Patte=
rns."""
@@ -43,40 +50,39 @@ class PatternGroup:
         """Calculate the unique bits dirtied by this pattern grouping"""
         res =3D set()
         for pattern in self.patterns:
-            lower =3D math.floor(pattern.offset / granularity)
-            upper =3D math.floor((pattern.offset + pattern.size - 1) / g=
ranularity)
-            res =3D res | set(range(lower, upper + 1))
+            res =3D res | pattern.bits(granularity)
         return res
=20
+
 GROUPS =3D [
     PatternGroup([
         # Batch 0: 4 clusters
-        mkpattern('0x49', 0x0000000),
-        mkpattern('0x6c', 0x0100000),   # 1M
-        mkpattern('0x6f', 0x2000000),   # 32M
-        mkpattern('0x76', 0x3ff0000)]), # 64M - 64K
+        Pattern('0x49', 0x0000000),
+        Pattern('0x6c', 0x0100000),   # 1M
+        Pattern('0x6f', 0x2000000),   # 32M
+        Pattern('0x76', 0x3ff0000)]), # 64M - 64K
     PatternGroup([
         # Batch 1: 6 clusters (3 new)
-        mkpattern('0x65', 0x0000000),   # Full overwrite
-        mkpattern('0x77', 0x00f8000),   # Partial-left (1M-32K)
-        mkpattern('0x72', 0x2008000),   # Partial-right (32M+32K)
-        mkpattern('0x69', 0x3fe0000)]), # Adjacent-left (64M - 128K)
+        Pattern('0x65', 0x0000000),   # Full overwrite
+        Pattern('0x77', 0x00f8000),   # Partial-left (1M-32K)
+        Pattern('0x72', 0x2008000),   # Partial-right (32M+32K)
+        Pattern('0x69', 0x3fe0000)]), # Adjacent-left (64M - 128K)
     PatternGroup([
         # Batch 2: 7 clusters (3 new)
-        mkpattern('0x74', 0x0010000),   # Adjacent-right
-        mkpattern('0x69', 0x00e8000),   # Partial-left  (1M-96K)
-        mkpattern('0x6e', 0x2018000),   # Partial-right (32M+96K)
-        mkpattern('0x67', 0x3fe0000,
-                  2*GRANULARITY)]),     # Overwrite [(64M-128K)-64M)
+        Pattern('0x74', 0x0010000),   # Adjacent-right
+        Pattern('0x69', 0x00e8000),   # Partial-left  (1M-96K)
+        Pattern('0x6e', 0x2018000),   # Partial-right (32M+96K)
+        Pattern('0x67', 0x3fe0000,
+                2*GRANULARITY)]),     # Overwrite [(64M-128K)-64M)
     PatternGroup([
         # Batch 3: 8 clusters (5 new)
         # Carefully chosen such that nothing re-dirties the one cluster
         # that copies out successfully before failure in Group #1.
-        mkpattern('0xaa', 0x0010000,
-                  3*GRANULARITY),       # Overwrite and 2x Adjacent-righ=
t
-        mkpattern('0xbb', 0x00d8000),   # Partial-left (1M-160K)
-        mkpattern('0xcc', 0x2028000),   # Partial-right (32M+160K)
-        mkpattern('0xdd', 0x3fc0000)]), # New; leaving a gap to the righ=
t
+        Pattern('0xaa', 0x0010000,
+                3*GRANULARITY),       # Overwrite and 2x Adjacent-right
+        Pattern('0xbb', 0x00d8000),   # Partial-left (1M-160K)
+        Pattern('0xcc', 0x2028000),   # Partial-right (32M+160K)
+        Pattern('0xdd', 0x3fc0000)]), # New; leaving a gap to the right
 ]
=20
 class Drive:
--=20
2.21.0


