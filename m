Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6606CC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:47:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6DEC207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNopYSSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DEC207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw1v2-0000TF-3Q
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 05:47:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iw1m9-0003is-CB
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:38:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iw1ly-0003A1-Uy
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:37:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48255
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iw1lx-00038d-F7
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580121457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZt3ajN2VHIMjXYlDkItzFqDg6LU8TjAI6ZX5iuRc7s=;
 b=LNopYSSFBPpAVrZHQ1eCqyAA3hJtaDfNuAGeo77KL88I0nKb1L0buUPFChElMNL4chJqPx
 ChyO8gp9iDVZQabGdNLj8atFFWYatcyR9tp2Ialiom/6FlIzWebxG8KhS6+WZUASK+2yfa
 6Uzx2HVg79rOA2bXYkpyCe+/3MS1nxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-Sz3S7a3wM7m2t2O-nTWZ0w-1; Mon, 27 Jan 2020 05:37:30 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60298107ACCD;
 Mon, 27 Jan 2020 10:37:29 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A9EE5451F;
 Mon, 27 Jan 2020 10:37:26 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/13] add 'error' prefix to vreport
Date: Mon, 27 Jan 2020 12:36:46 +0200
Message-Id: <20200127103647.17761-13-mlevitsk@redhat.com>
In-Reply-To: <20200127103647.17761-1-mlevitsk@redhat.com>
References: <20200127103647.17761-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Sz3S7a3wM7m2t2O-nTWZ0w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This changes most of qemu's error messages,
but it feels like the right thing to do.

This is WIP patch, since I updated most of iotests but not all of them,
and will be updated if this patch is accepeted in the review.
Also few error message already have 'error' prefix, which should be removed=
.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
---
 monitor/hmp-cmds.c               |   2 +-
 tests/qemu-iotests/020.out       |   2 +-
 tests/qemu-iotests/026.out       | 260 +++++++++++++++----------------
 tests/qemu-iotests/036.out       |  16 +-
 tests/qemu-iotests/043.out       |   6 +-
 tests/qemu-iotests/049.out       |  30 ++--
 tests/qemu-iotests/051.pc.out    | 150 +++++++++---------
 tests/qemu-iotests/054.out       |   4 +-
 tests/qemu-iotests/060.out       |  20 +--
 tests/qemu-iotests/061.out       |  26 ++--
 tests/qemu-iotests/069.out       |   2 +-
 tests/qemu-iotests/071.out       |   4 +-
 tests/qemu-iotests/074.out       |   4 +-
 tests/qemu-iotests/079.out       |   2 +-
 tests/qemu-iotests/080.out       |  72 ++++-----
 tests/qemu-iotests/081.out       |   2 +-
 tests/qemu-iotests/082.out       |  38 ++---
 tests/qemu-iotests/083.out       |  68 ++++----
 tests/qemu-iotests/098.out       |   8 +-
 tests/qemu-iotests/103.out       |  14 +-
 tests/qemu-iotests/106.out       |   4 +-
 tests/qemu-iotests/111.out       |   2 +-
 tests/qemu-iotests/112.out       |  24 +--
 tests/qemu-iotests/113.out       |   6 +-
 tests/qemu-iotests/114.out       |   2 +-
 tests/qemu-iotests/122.out       |   4 +-
 tests/qemu-iotests/133.out       |  30 ++--
 tests/qemu-iotests/137.out       |  28 ++--
 tests/qemu-iotests/140.out       |   2 +-
 tests/qemu-iotests/142.out       |  38 ++---
 tests/qemu-iotests/143.out       |   2 +-
 tests/qemu-iotests/153.out       | 118 +++++++-------
 tests/qemu-iotests/162.out       |  10 +-
 tests/qemu-iotests/172.out       |  16 +-
 tests/qemu-iotests/178.out.qcow2 |  30 ++--
 tests/qemu-iotests/178.out.raw   |  26 ++--
 tests/qemu-iotests/182.out       |   2 +-
 tests/qemu-iotests/187.out       |   6 +-
 tests/qemu-iotests/188.out       |   2 +-
 tests/qemu-iotests/197.out       |   2 +-
 tests/qemu-iotests/205           |   2 +-
 tests/qemu-iotests/215.out       |   2 +-
 tests/qemu-iotests/217.out       |   2 +-
 tests/qemu-iotests/226.out       |  12 +-
 tests/qemu-iotests/232.out       |  12 +-
 tests/qemu-iotests/233.out       |  24 +--
 tests/qemu-iotests/242.out       |   2 +-
 tests/qemu-iotests/244.out       |  14 +-
 tests/qemu-iotests/249.out       |   6 +-
 tests/qemu-iotests/261.out       |  24 +--
 tests/qemu-iotests/267.out       |  16 +-
 tests/qemu-iotests/common.filter |   2 +-
 util/qemu-error.c                |   1 +
 53 files changed, 602 insertions(+), 601 deletions(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 1ddfe2fceb..6214e6ed57 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -60,7 +60,7 @@
 void hmp_handle_error(Monitor *mon, Error *err)
 {
     if (err) {
-        error_reportf_err(err, "Error: ");
+        error_report_err(err);
     }
 }
=20
diff --git a/tests/qemu-iotests/020.out b/tests/qemu-iotests/020.out
index 4b722b2dd0..41171a3795 100644
--- a/tests/qemu-iotests/020.out
+++ b/tests/qemu-iotests/020.out
@@ -1093,5 +1093,5 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1=
048576 backing_file=3Djson:{'driv
                              }}}
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Block job failed: No space left on device
+qemu-img: error: Block job failed: No space left on device
 *** done
diff --git a/tests/qemu-iotests/026.out b/tests/qemu-iotests/026.out
index ff0817b6f2..554eb0005b 100644
--- a/tests/qemu-iotests/026.out
+++ b/tests/qemu-iotests/026.out
@@ -3,7 +3,7 @@ Errors while writing 128 kB
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: l1_update; errno: 5; imm: off; once: on; write
+Event: l1_update; errno: 5; imm: off; once: on; write=20
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -13,21 +13,21 @@ write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: l1_update; errno: 5; imm: off; once: off; write
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+Event: l1_update; errno: 5; imm: off; once: off; write=20
+qemu-io: error: Failed to flush the L2 table cache: Input/output error
+qemu-io: error: Failed to flush the refcount block cache: Input/output err=
or
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: l1_update; errno: 5; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: error: Failed to flush the L2 table cache: Input/output error
+qemu-io: error: Failed to flush the refcount block cache: Input/output err=
or
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: l1_update; errno: 28; imm: off; once: on; write
+Event: l1_update; errno: 28; imm: off; once: on; write=20
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -37,21 +37,21 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: l1_update; errno: 28; imm: off; once: off; write
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Event: l1_update; errno: 28; imm: off; once: off; write=20
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: l1_update; errno: 28; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: l2_load; errno: 5; imm: off; once: on; write
+Event: l2_load; errno: 5; imm: off; once: on; write=20
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 write failed: Input/output error
@@ -67,7 +67,7 @@ read failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: l2_load; errno: 5; imm: off; once: off; write
+Event: l2_load; errno: 5; imm: off; once: off; write=20
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 write failed: Input/output error
@@ -83,7 +83,7 @@ read failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: l2_load; errno: 28; imm: off; once: on; write
+Event: l2_load; errno: 28; imm: off; once: on; write=20
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 write failed: No space left on device
@@ -99,7 +99,7 @@ read failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: l2_load; errno: 28; imm: off; once: off; write
+Event: l2_load; errno: 28; imm: off; once: off; write=20
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 write failed: No space left on device
@@ -115,7 +115,7 @@ read failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: l2_update; errno: 5; imm: off; once: on; write
+Event: l2_update; errno: 5; imm: off; once: on; write=20
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -125,21 +125,21 @@ write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: l2_update; errno: 5; imm: off; once: off; write
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+Event: l2_update; errno: 5; imm: off; once: off; write=20
+qemu-io: error: Failed to flush the L2 table cache: Input/output error
+qemu-io: error: Failed to flush the refcount block cache: Input/output err=
or
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: l2_update; errno: 5; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: error: Failed to flush the L2 table cache: Input/output error
+qemu-io: error: Failed to flush the refcount block cache: Input/output err=
or
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: l2_update; errno: 28; imm: off; once: on; write
+Event: l2_update; errno: 28; imm: off; once: on; write=20
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -149,21 +149,21 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: l2_update; errno: 28; imm: off; once: off; write
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Event: l2_update; errno: 28; imm: off; once: off; write=20
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: l2_update; errno: 28; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: l2_alloc_write; errno: 5; imm: off; once: on; write
+Event: l2_alloc_write; errno: 5; imm: off; once: on; write=20
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -173,21 +173,21 @@ write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: l2_alloc_write; errno: 5; imm: off; once: off; write
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+Event: l2_alloc_write; errno: 5; imm: off; once: off; write=20
+qemu-io: error: Failed to flush the L2 table cache: Input/output error
+qemu-io: error: Failed to flush the refcount block cache: Input/output err=
or
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: l2_alloc_write; errno: 5; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: error: Failed to flush the L2 table cache: Input/output error
+qemu-io: error: Failed to flush the refcount block cache: Input/output err=
or
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: l2_alloc_write; errno: 28; imm: off; once: on; write
+Event: l2_alloc_write; errno: 28; imm: off; once: on; write=20
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -197,21 +197,21 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: l2_alloc_write; errno: 28; imm: off; once: off; write
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Event: l2_alloc_write; errno: 28; imm: off; once: off; write=20
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: l2_alloc_write; errno: 28; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: write_aio; errno: 5; imm: off; once: on; write
+Event: write_aio; errno: 5; imm: off; once: on; write=20
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -221,21 +221,21 @@ write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: write_aio; errno: 5; imm: off; once: off; write
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+Event: write_aio; errno: 5; imm: off; once: off; write=20
+qemu-io: error: Failed to flush the L2 table cache: Input/output error
+qemu-io: error: Failed to flush the refcount block cache: Input/output err=
or
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: write_aio; errno: 5; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: error: Failed to flush the L2 table cache: Input/output error
+qemu-io: error: Failed to flush the refcount block cache: Input/output err=
or
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: write_aio; errno: 28; imm: off; once: on; write
+Event: write_aio; errno: 28; imm: off; once: on; write=20
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -245,21 +245,21 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: write_aio; errno: 28; imm: off; once: off; write
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Event: write_aio; errno: 28; imm: off; once: off; write=20
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: write_aio; errno: 28; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: refblock_load; errno: 5; imm: off; once: on; write
+Event: refblock_load; errno: 5; imm: off; once: on; write=20
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -269,21 +269,21 @@ write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: refblock_load; errno: 5; imm: off; once: off; write
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+Event: refblock_load; errno: 5; imm: off; once: off; write=20
+qemu-io: error: Failed to flush the L2 table cache: Input/output error
+qemu-io: error: Failed to flush the refcount block cache: Input/output err=
or
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: refblock_load; errno: 5; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: error: Failed to flush the L2 table cache: Input/output error
+qemu-io: error: Failed to flush the refcount block cache: Input/output err=
or
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: refblock_load; errno: 28; imm: off; once: on; write
+Event: refblock_load; errno: 28; imm: off; once: on; write=20
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -293,21 +293,21 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: refblock_load; errno: 28; imm: off; once: off; write
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Event: refblock_load; errno: 28; imm: off; once: off; write=20
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: refblock_load; errno: 28; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: refblock_update_part; errno: 5; imm: off; once: on; write
+Event: refblock_update_part; errno: 5; imm: off; once: on; write=20
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -317,21 +317,21 @@ write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: refblock_update_part; errno: 5; imm: off; once: off; write
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+Event: refblock_update_part; errno: 5; imm: off; once: off; write=20
+qemu-io: error: Failed to flush the L2 table cache: Input/output error
+qemu-io: error: Failed to flush the refcount block cache: Input/output err=
or
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: refblock_update_part; errno: 5; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: error: Failed to flush the L2 table cache: Input/output error
+qemu-io: error: Failed to flush the refcount block cache: Input/output err=
or
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: refblock_update_part; errno: 28; imm: off; once: on; write
+Event: refblock_update_part; errno: 28; imm: off; once: on; write=20
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -341,21 +341,21 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: refblock_update_part; errno: 28; imm: off; once: off; write
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Event: refblock_update_part; errno: 28; imm: off; once: off; write=20
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: refblock_update_part; errno: 28; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: refblock_alloc; errno: 5; imm: off; once: on; write
+Event: refblock_alloc; errno: 5; imm: off; once: on; write=20
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -365,21 +365,21 @@ write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: refblock_alloc; errno: 5; imm: off; once: off; write
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+Event: refblock_alloc; errno: 5; imm: off; once: off; write=20
+qemu-io: error: Failed to flush the L2 table cache: Input/output error
+qemu-io: error: Failed to flush the refcount block cache: Input/output err=
or
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: refblock_alloc; errno: 5; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: error: Failed to flush the L2 table cache: Input/output error
+qemu-io: error: Failed to flush the refcount block cache: Input/output err=
or
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: refblock_alloc; errno: 28; imm: off; once: on; write
+Event: refblock_alloc; errno: 28; imm: off; once: on; write=20
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -389,21 +389,21 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: refblock_alloc; errno: 28; imm: off; once: off; write
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Event: refblock_alloc; errno: 28; imm: off; once: off; write=20
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: refblock_alloc; errno: 28; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: cluster_alloc; errno: 5; imm: off; once: on; write
+Event: cluster_alloc; errno: 5; imm: off; once: on; write=20
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -413,7 +413,7 @@ write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: cluster_alloc; errno: 5; imm: off; once: off; write
+Event: cluster_alloc; errno: 5; imm: off; once: off; write=20
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -423,7 +423,7 @@ write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: cluster_alloc; errno: 28; imm: off; once: on; write
+Event: cluster_alloc; errno: 28; imm: off; once: on; write=20
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -433,7 +433,7 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: cluster_alloc; errno: 28; imm: off; once: off; write
+Event: cluster_alloc; errno: 28; imm: off; once: off; write=20
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -446,7 +446,7 @@ No errors were found on the image.
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: refblock_alloc_hookup; errno: 28; imm: off; once: on; write
+Event: refblock_alloc_hookup; errno: 28; imm: off; once: on; write=20
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -456,21 +456,21 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write=20
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: refblock_alloc_write; errno: 28; imm: off; once: on; write
+Event: refblock_alloc_write; errno: 28; imm: off; once: on; write=20
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -480,21 +480,21 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: refblock_alloc_write; errno: 28; imm: off; once: off; write
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Event: refblock_alloc_write; errno: 28; imm: off; once: off; write=20
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: refblock_alloc_write; errno: 28; imm: off; once: off; write -b
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: on; write
+Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: on; write=
=20
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -504,21 +504,21 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write=
=20
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write =
-b
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: refblock_alloc_write_table; errno: 28; imm: off; once: on; write
+Event: refblock_alloc_write_table; errno: 28; imm: off; once: on; write=20
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -528,21 +528,21 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write=
=20
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write -=
b
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: refblock_alloc_switch_table; errno: 28; imm: off; once: on; write
+Event: refblock_alloc_switch_table; errno: 28; imm: off; once: on; write=
=20
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -552,16 +552,16 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
-Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write=
=20
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write =
-b
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
=20
@@ -595,8 +595,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: l1_grow_write_table; errno: 5; imm: off; once: off
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: error: Failed to flush the L2 table cache: Input/output error
+qemu-io: error: Failed to flush the refcount block cache: Input/output err=
or
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -607,8 +607,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: l1_grow_write_table; errno: 28; imm: off; once: off
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -619,8 +619,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: l1_grow_activate_table; errno: 5; imm: off; once: off
-qemu-io: Failed to flush the L2 table cache: Input/output error
-qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: error: Failed to flush the L2 table cache: Input/output error
+qemu-io: error: Failed to flush the refcount block cache: Input/output err=
or
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
@@ -631,8 +631,8 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: l1_grow_activate_table; errno: 28; imm: off; once: off
-qemu-io: Failed to flush the L2 table cache: No space left on device
-qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: error: Failed to flush the L2 table cache: No space left on devic=
e
+qemu-io: error: Failed to flush the refcount block cache: No space left on=
 device
 write failed: No space left on device
 No errors were found on the image.
=20
diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
index 0b52b934e1..b08e7c1cc6 100644
--- a/tests/qemu-iotests/036.out
+++ b/tests/qemu-iotests/036.out
@@ -6,18 +6,18 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108=
864
 incompatible_features     [63]
 compatible_features       []
 autoclear_features        []
-qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Unsupported IMGFMT feature(s=
): Unknown incompatible feature: 8000000000000000
-qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Unsupported IMGFMT feature(s=
): Test feature
+qemu-img: error: Could not open 'TEST_DIR/t.IMGFMT': Unsupported IMGFMT fe=
ature(s): Unknown incompatible feature: 8000000000000000
+qemu-img: error: Could not open 'TEST_DIR/t.IMGFMT': Unsupported IMGFMT fe=
ature(s): Test feature
=20
 =3D=3D=3D Image with multiple incompatible feature bits =3D=3D=3D
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Unsupported IMGFMT feature(s=
): Unknown incompatible feature: e000000000000000
-qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Unsupported IMGFMT feature(s=
): Test feature, Unknown incompatible feature: 6000000000000000
-qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Unsupported IMGFMT feature(s=
): Test feature, Unknown incompatible feature: c000000000000000
-qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Unsupported IMGFMT feature(s=
): test1, test2, Unknown incompatible feature: 8000000000000000
-qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Unsupported IMGFMT feature(s=
): test1, test2, test3
-qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Unsupported IMGFMT feature(s=
): test2, Unknown incompatible feature: a000000000000000
+qemu-img: error: Could not open 'TEST_DIR/t.IMGFMT': Unsupported IMGFMT fe=
ature(s): Unknown incompatible feature: e000000000000000
+qemu-img: error: Could not open 'TEST_DIR/t.IMGFMT': Unsupported IMGFMT fe=
ature(s): Test feature, Unknown incompatible feature: 6000000000000000
+qemu-img: error: Could not open 'TEST_DIR/t.IMGFMT': Unsupported IMGFMT fe=
ature(s): Test feature, Unknown incompatible feature: c000000000000000
+qemu-img: error: Could not open 'TEST_DIR/t.IMGFMT': Unsupported IMGFMT fe=
ature(s): test1, test2, Unknown incompatible feature: 8000000000000000
+qemu-img: error: Could not open 'TEST_DIR/t.IMGFMT': Unsupported IMGFMT fe=
ature(s): test1, test2, test3
+qemu-img: error: Could not open 'TEST_DIR/t.IMGFMT': Unsupported IMGFMT fe=
ature(s): test2, Unknown incompatible feature: a000000000000000
 =3D=3D=3D Create image with unknown autoclear feature bit =3D=3D=3D
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
diff --git a/tests/qemu-iotests/043.out b/tests/qemu-iotests/043.out
index 0280f999ce..a6f307ceeb 100644
--- a/tests/qemu-iotests/043.out
+++ b/tests/qemu-iotests/043.out
@@ -2,19 +2,19 @@ QA output created by 043
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
=20
 =3D=3D backing file references self =3D=3D
-qemu-img: Backing file 'TEST_DIR/t.IMGFMT' creates an infinite loop.
+qemu-img: error: Backing file 'TEST_DIR/t.IMGFMT' creates an infinite loop=
.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
=20
 =3D=3D parent references self =3D=3D
-qemu-img: Backing file 'TEST_DIR/t.IMGFMT' creates an infinite loop.
+qemu-img: error: Backing file 'TEST_DIR/t.IMGFMT' creates an infinite loop=
.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.1.base
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.2.base
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.3.base
=20
 =3D=3D ancestor references another ancestor =3D=3D
-qemu-img: Backing file 'TEST_DIR/t.IMGFMT.2.base' creates an infinite loop=
.
+qemu-img: error: Backing file 'TEST_DIR/t.IMGFMT.2.base' creates an infini=
te loop.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.1.base
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.2.base
diff --git a/tests/qemu-iotests/049.out b/tests/qemu-iotests/049.out
index affa55b341..60d75f0290 100644
--- a/tests/qemu-iotests/049.out
+++ b/tests/qemu-iotests/049.out
@@ -92,39 +92,39 @@ Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D16492=
67441664 cluster_size=3D65536 l
 =3D=3D 3. Invalid sizes =3D=3D
=20
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- -1024
-qemu-img: Image size must be less than 8 EiB!
+qemu-img: error: Image size must be less than 8 EiB!
=20
 qemu-img create -f qcow2 -o size=3D-1024 TEST_DIR/t.qcow2
-qemu-img: TEST_DIR/t.qcow2: Value '-1024' is out of range for parameter 's=
ize'
+qemu-img: error: TEST_DIR/t.qcow2: Value '-1024' is out of range for param=
eter 'size'
=20
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- -1k
-qemu-img: Image size must be less than 8 EiB!
+qemu-img: error: Image size must be less than 8 EiB!
=20
 qemu-img create -f qcow2 -o size=3D-1k TEST_DIR/t.qcow2
-qemu-img: TEST_DIR/t.qcow2: Value '-1k' is out of range for parameter 'siz=
e'
+qemu-img: error: TEST_DIR/t.qcow2: Value '-1k' is out of range for paramet=
er 'size'
=20
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- 1kilobyte
-qemu-img: Invalid image size specified! You may use k, M, G, T, P or E suf=
fixes for
-qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabyt=
es.
+qemu-img: error: Invalid image size specified! You may use k, M, G, T, P o=
r E suffixes for=20
+qemu-img: error: kilobytes, megabytes, gigabytes, terabytes, petabytes and=
 exabytes.
=20
 qemu-img create -f qcow2 -o size=3D1kilobyte TEST_DIR/t.qcow2
-qemu-img: TEST_DIR/t.qcow2: Parameter 'size' expects a non-negative number=
 below 2^64
+qemu-img: error: TEST_DIR/t.qcow2: Parameter 'size' expects a non-negative=
 number below 2^64
 Optional suffix k, M, G, T, P or E means kilo-, mega-, giga-, tera-, peta-
 and exabytes, respectively.
=20
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- foobar
-qemu-img: Invalid image size specified! You may use k, M, G, T, P or E suf=
fixes for
-qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabyt=
es.
+qemu-img: error: Invalid image size specified! You may use k, M, G, T, P o=
r E suffixes for=20
+qemu-img: error: kilobytes, megabytes, gigabytes, terabytes, petabytes and=
 exabytes.
=20
 qemu-img create -f qcow2 -o size=3Dfoobar TEST_DIR/t.qcow2
-qemu-img: TEST_DIR/t.qcow2: Parameter 'size' expects a non-negative number=
 below 2^64
+qemu-img: error: TEST_DIR/t.qcow2: Parameter 'size' expects a non-negative=
 number below 2^64
 Optional suffix k, M, G, T, P or E means kilo-, mega-, giga-, tera-, peta-
 and exabytes, respectively.
=20
 =3D=3D 4. Specify size twice (-o and traditional parameter) =3D=3D
=20
 qemu-img create -f qcow2 -o size=3D10M TEST_DIR/t.qcow2 20M
-qemu-img: TEST_DIR/t.qcow2: The image size must be specified only once
+qemu-img: error: TEST_DIR/t.qcow2: The image size must be specified only o=
nce
=20
 =3D=3D Check correct interpretation of suffixes for cluster size =3D=3D
=20
@@ -167,11 +167,11 @@ qemu-img create -f qcow2 -o compat=3D1.1 TEST_DIR/t.q=
cow2 64M
 Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D1.1 cl=
uster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o compat=3D0.42 TEST_DIR/t.qcow2 64M
-qemu-img: TEST_DIR/t.qcow2: Invalid parameter '0.42'
+qemu-img: error: TEST_DIR/t.qcow2: Invalid parameter '0.42'
 Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D0.42 c=
luster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o compat=3Dfoobar TEST_DIR/t.qcow2 64M
-qemu-img: TEST_DIR/t.qcow2: Invalid parameter 'foobar'
+qemu-img: error: TEST_DIR/t.qcow2: Invalid parameter 'foobar'
 Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3Dfoobar=
 cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
=20
 =3D=3D Check preallocation option =3D=3D
@@ -183,7 +183,7 @@ qemu-img create -f qcow2 -o preallocation=3Dmetadata TE=
ST_DIR/t.qcow2 64M
 Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D=
65536 preallocation=3Dmetadata lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o preallocation=3D1234 TEST_DIR/t.qcow2 64M
-qemu-img: TEST_DIR/t.qcow2: Invalid parameter '1234'
+qemu-img: error: TEST_DIR/t.qcow2: Invalid parameter '1234'
 Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D=
65536 preallocation=3D1234 lazy_refcounts=3Doff refcount_bits=3D16
=20
 =3D=3D Check encryption option =3D=3D
@@ -206,7 +206,7 @@ qemu-img create -f qcow2 -o compat=3D0.10,lazy_refcount=
s=3Doff TEST_DIR/t.qcow2 64M
 Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D0.10 c=
luster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
=20
 qemu-img create -f qcow2 -o compat=3D0.10,lazy_refcounts=3Don TEST_DIR/t.q=
cow2 64M
-qemu-img: TEST_DIR/t.qcow2: Lazy refcounts only supported with compatibili=
ty level 1.1 and above (use version=3Dv3 or greater)
+qemu-img: error: TEST_DIR/t.qcow2: Lazy refcounts only supported with comp=
atibility level 1.1 and above (use version=3Dv3 or greater)
 Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D0.10 c=
luster_size=3D65536 lazy_refcounts=3Don refcount_bits=3D16
=20
 *** done
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index 0ea80d35f0..ddb035cf10 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -5,46 +5,46 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D13421=
7728 backing_file=3DTEST_DIR/
 =3D=3D=3D Unknown option =3D=3D=3D
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,unknown_opt=3D,if=
=3Dnone,id=3Ddrive0
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,unknown_opt=3D,if=
=3Dnone,id=3Ddrive0: Block format 'qcow2' does not support the option 'unkn=
own_opt'
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,unknown_opt=3D,if=
=3Dnone,id=3Ddrive0: error: Block format 'qcow2' does not support the optio=
n 'unknown_opt'
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,unknown_opt=3Don,if=
=3Dnone,id=3Ddrive0
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,unknown_opt=3Don,=
if=3Dnone,id=3Ddrive0: Block format 'qcow2' does not support the option 'un=
known_opt'
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,unknown_opt=3Don,=
if=3Dnone,id=3Ddrive0: error: Block format 'qcow2' does not support the opt=
ion 'unknown_opt'
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,unknown_opt=3D1234,=
if=3Dnone,id=3Ddrive0
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,unknown_opt=3D123=
4,if=3Dnone,id=3Ddrive0: Block format 'qcow2' does not support the option '=
unknown_opt'
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,unknown_opt=3D123=
4,if=3Dnone,id=3Ddrive0: error: Block format 'qcow2' does not support the o=
ption 'unknown_opt'
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,unknown_opt=3Dfoo,i=
f=3Dnone,id=3Ddrive0
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,unknown_opt=3Dfoo=
,if=3Dnone,id=3Ddrive0: Block format 'qcow2' does not support the option 'u=
nknown_opt'
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,unknown_opt=3Dfoo=
,if=3Dnone,id=3Ddrive0: error: Block format 'qcow2' does not support the op=
tion 'unknown_opt'
=20
=20
 =3D=3D=3D Unknown protocol option =3D=3D=3D
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,file.unknown_opt=3D
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,file.unknown_opt=
=3D: Block protocol 'file' doesn't support the option 'unknown_opt'
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,file.unknown_opt=
=3D: error: Block protocol 'file' doesn't support the option 'unknown_opt'
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,file.unknown_opt=3D=
on
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,file.unknown_opt=
=3Don: Block protocol 'file' doesn't support the option 'unknown_opt'
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,file.unknown_opt=
=3Don: error: Block protocol 'file' doesn't support the option 'unknown_opt=
'
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,file.unknown_opt=3D=
1234
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,file.unknown_opt=
=3D1234: Block protocol 'file' doesn't support the option 'unknown_opt'
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,file.unknown_opt=
=3D1234: error: Block protocol 'file' doesn't support the option 'unknown_o=
pt'
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,file.unknown_opt=3D=
foo
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,file.unknown_opt=
=3Dfoo: Block protocol 'file' doesn't support the option 'unknown_opt'
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,file.unknown_opt=
=3Dfoo: error: Block protocol 'file' doesn't support the option 'unknown_op=
t'
=20
=20
 =3D=3D=3D Invalid format =3D=3D=3D
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,format=3Dfoo
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dfoo: Unknown driver 'fo=
o'
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dfoo: error: Unknown dri=
ver 'foo'
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,driver=3Dfoo
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,driver=3Dfoo: Unknown driver 'fo=
o'
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,driver=3Dfoo: error: Unknown dri=
ver 'foo'
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,driver=3Draw,format=3Dqcow2
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,driver=3Draw,format=3Dqcow2: Can=
not specify both 'driver' and 'format'
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,driver=3Draw,format=3Dqcow2: err=
or: Cannot specify both 'driver' and 'format'
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,driver=3Dqcow2,format=3Dqcow2
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,driver=3Dqcow2,format=3Dqcow2: C=
annot specify both 'driver' and 'format'
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,driver=3Dqcow2,format=3Dqcow2: e=
rror: Cannot specify both 'driver' and 'format'
=20
=20
 =3D=3D=3D Node names =3D=3D=3D
@@ -54,27 +54,27 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,node-name=3Dx123456789012345678901=
2345678901
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,node-name=3Dx1234567890123456789=
012345678901: Node name too long
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,node-name=3Dx1234567890123456789=
012345678901: error: Node name too long
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,node-name=3DAll-Types.of_all0wed_c=
hars
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,node-name=3D123foo
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,node-name=3D123foo: Invalid node=
 name
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,node-name=3D123foo: error: Inval=
id node name
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,node-name=3D_foo
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,node-name=3D_foo: Invalid node n=
ame
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,node-name=3D_foo: error: Invalid=
 node name
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,node-name=3Dfoo#12
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,node-name=3Dfoo#12: Invalid node=
 name
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,node-name=3Dfoo#12: error: Inval=
id node name
=20
=20
 =3D=3D=3D Device without drive =3D=3D=3D
=20
 Testing: -device VIRTIO_SCSI -device scsi-hd
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device scsi-hd: drive property not set
+(qemu) QEMU_PROG: -device scsi-hd: error: drive property not set
=20
=20
 =3D=3D=3D Overriding backing file =3D=3D=3D
@@ -89,13 +89,13 @@ drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2"=
, "file": {"driver": "fil
 (qemu) quit
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,driver=3Draw,backing.file.filename=
=3DTEST_DIR/t.qcow2.orig
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,driver=3Draw,backing.file.filena=
me=3DTEST_DIR/t.qcow2.orig: Driver doesn't support backing files
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,driver=3Draw,backing.file.filena=
me=3DTEST_DIR/t.qcow2.orig: error: Driver doesn't support backing files
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,file.backing.driver=3Dfile,file.ba=
cking.filename=3DTEST_DIR/t.qcow2.orig
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,file.backing.driver=3Dfile,file.=
backing.filename=3DTEST_DIR/t.qcow2.orig: Driver doesn't support backing fi=
les
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,file.backing.driver=3Dfile,file.=
backing.filename=3DTEST_DIR/t.qcow2.orig: error: Driver doesn't support bac=
king files
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,file.backing.driver=3Dqcow2,file.b=
acking.file.filename=3DTEST_DIR/t.qcow2.orig
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,file.backing.driver=3Dqcow2,file=
.backing.file.filename=3DTEST_DIR/t.qcow2.orig: Driver doesn't support back=
ing files
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,file.backing.driver=3Dqcow2,file=
.backing.file.filename=3DTEST_DIR/t.qcow2.orig: error: Driver doesn't suppo=
rt backing files
=20
=20
 =3D=3D=3D Enable and disable lazy refcounting on the command line, plus so=
me invalid values =3D=3D=3D
@@ -110,20 +110,20 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=3D
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=3D=
: Parameter 'lazy-refcounts' expects 'on' or 'off'
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=3D=
: error: Parameter 'lazy-refcounts' expects 'on' or 'off'
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=3D42
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=3D=
42: Parameter 'lazy-refcounts' expects 'on' or 'off'
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=3D=
42: error: Parameter 'lazy-refcounts' expects 'on' or 'off'
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=3Dfo=
o
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=3D=
foo: Parameter 'lazy-refcounts' expects 'on' or 'off'
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=3D=
foo: error: Parameter 'lazy-refcounts' expects 'on' or 'off'
=20
=20
 =3D=3D=3D With version 2 images enabling lazy refcounts must fail =3D=3D=
=3D
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
 Testing: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=3Don
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=3D=
on: Lazy refcounts require a qcow2 image with at least qemu 1.1 compatibili=
ty level
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=3D=
on: error: Lazy refcounts require a qcow2 image with at least qemu 1.1 comp=
atibility level
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,format=3Dqcow2,lazy-refcounts=3Dof=
f
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -142,11 +142,11 @@ QEMU X.Y.Z monitor - type 'help' for more information
=20
 Testing: -drive if=3Dide
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: Initialization of device ide-hd failed: Device needs med=
ia, but drive is empty
+(qemu) QEMU_PROG: error: Initialization of device ide-hd failed: Device ne=
eds media, but drive is empty
=20
 Testing: -drive if=3Dvirtio
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -drive if=3Dvirtio: Device needs media, but drive is emp=
ty
+(qemu) QEMU_PROG: -drive if=3Dvirtio: error: Device needs media, but drive=
 is empty
=20
 Testing: -drive if=3Dnone,id=3Ddisk -device ide-cd,drive=3Ddisk
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -159,43 +159,43 @@ QEMU X.Y.Z monitor - type 'help' for more information
 Testing: -drive if=3Dnone,id=3Ddisk -device ide-drive,drive=3Ddisk
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) QEMU_PROG: -device ide-drive,drive=3Ddisk: warning: 'ide-drive' is =
deprecated, please use 'ide-hd' or 'ide-cd' instead
-QEMU_PROG: -device ide-drive,drive=3Ddisk: Device needs media, but drive i=
s empty
+QEMU_PROG: -device ide-drive,drive=3Ddisk: error: Device needs media, but =
drive is empty
=20
 Testing: -drive if=3Dnone,id=3Ddisk -device ide-hd,drive=3Ddisk
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device ide-hd,drive=3Ddisk: Device needs media, but dri=
ve is empty
+(qemu) QEMU_PROG: -device ide-hd,drive=3Ddisk: error: Device needs media, =
but drive is empty
=20
 Testing: -drive if=3Dnone,id=3Ddisk -device lsi53c895a -device scsi-disk,d=
rive=3Ddisk
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) QEMU_PROG: -device scsi-disk,drive=3Ddisk: warning: 'scsi-disk' is =
deprecated, please use 'scsi-hd' or 'scsi-cd' instead
-QEMU_PROG: -device scsi-disk,drive=3Ddisk: Device needs media, but drive i=
s empty
+QEMU_PROG: -device scsi-disk,drive=3Ddisk: error: Device needs media, but =
drive is empty
=20
 Testing: -drive if=3Dnone,id=3Ddisk -device lsi53c895a -device scsi-hd,dri=
ve=3Ddisk
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device scsi-hd,drive=3Ddisk: Device needs media, but dr=
ive is empty
+(qemu) QEMU_PROG: -device scsi-hd,drive=3Ddisk: error: Device needs media,=
 but drive is empty
=20
=20
 =3D=3D=3D Attach to node in non-default iothread =3D=3D=3D
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,node-name=3Ddisk -object=
 iothread,id=3Dthread0 -device virtio-scsi,iothread=3Dthread0,id=3Dvirtio-s=
csi0 -device scsi-hd,bus=3Dvirtio-scsi0.0,drive=3Ddisk,share-rw=3Don -devic=
e ide-hd,drive=3Ddisk,share-rw=3Don
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device ide-hd,drive=3Ddisk,share-rw=3Don: Cannot change=
 iothread of active block backend
+(qemu) QEMU_PROG: -device ide-hd,drive=3Ddisk,share-rw=3Don: error: Cannot=
 change iothread of active block backend
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,node-name=3Ddisk -object=
 iothread,id=3Dthread0 -device virtio-scsi,iothread=3Dthread0,id=3Dvirtio-s=
csi0 -device scsi-hd,bus=3Dvirtio-scsi0.0,drive=3Ddisk,share-rw=3Don -devic=
e virtio-blk-pci,drive=3Ddisk,share-rw=3Don
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device virtio-blk-pci,drive=3Ddisk,share-rw=3Don: Canno=
t change iothread of active block backend
+(qemu) QEMU_PROG: -device virtio-blk-pci,drive=3Ddisk,share-rw=3Don: error=
: Cannot change iothread of active block backend
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,node-name=3Ddisk -object=
 iothread,id=3Dthread0 -device virtio-scsi,iothread=3Dthread0,id=3Dvirtio-s=
csi0 -device scsi-hd,bus=3Dvirtio-scsi0.0,drive=3Ddisk,share-rw=3Don -devic=
e lsi53c895a,id=3Dlsi0 -device scsi-hd,bus=3Dlsi0.0,drive=3Ddisk,share-rw=
=3Don
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device scsi-hd,bus=3Dlsi0.0,drive=3Ddisk,share-rw=3Don:=
 HBA does not support iothreads
+(qemu) QEMU_PROG: -device scsi-hd,bus=3Dlsi0.0,drive=3Ddisk,share-rw=3Don:=
 error: HBA does not support iothreads
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,node-name=3Ddisk -object=
 iothread,id=3Dthread0 -device virtio-scsi,iothread=3Dthread0,id=3Dvirtio-s=
csi0 -device scsi-hd,bus=3Dvirtio-scsi0.0,drive=3Ddisk,share-rw=3Don -devic=
e virtio-scsi,id=3Dvirtio-scsi1 -device scsi-hd,bus=3Dvirtio-scsi1.0,drive=
=3Ddisk,share-rw=3Don
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device scsi-hd,bus=3Dvirtio-scsi1.0,drive=3Ddisk,share-=
rw=3Don: Cannot change iothread of active block backend
+(qemu) QEMU_PROG: -device scsi-hd,bus=3Dvirtio-scsi1.0,drive=3Ddisk,share-=
rw=3Don: error: Cannot change iothread of active block backend
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,node-name=3Ddisk -object=
 iothread,id=3Dthread0 -device virtio-scsi,iothread=3Dthread0,id=3Dvirtio-s=
csi0 -device scsi-hd,bus=3Dvirtio-scsi0.0,drive=3Ddisk,share-rw=3Don -devic=
e virtio-blk-pci,drive=3Ddisk,iohtread=3Diothread0,share-rw=3Don
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device virtio-blk-pci,drive=3Ddisk,iohtread=3Diothread0=
,share-rw=3Don: Cannot change iothread of active block backend
+(qemu) QEMU_PROG: -device virtio-blk-pci,drive=3Ddisk,iohtread=3Diothread0=
,share-rw=3Don: error: Cannot change iothread of active block backend
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,node-name=3Ddisk -object=
 iothread,id=3Dthread0 -device virtio-scsi,iothread=3Dthread0,id=3Dvirtio-s=
csi0 -device scsi-hd,bus=3Dvirtio-scsi0.0,drive=3Ddisk,share-rw=3Don -devic=
e virtio-scsi,id=3Dvirtio-scsi1,iothread=3Dthread0 -device scsi-hd,bus=3Dvi=
rtio-scsi1.0,drive=3Ddisk,share-rw=3Don
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -214,7 +214,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,if=3Dide,readonly=3Don
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: Initialization of device ide-hd failed: Block node is re=
ad-only
+(qemu) QEMU_PROG: error: Initialization of device ide-hd failed: Block nod=
e is read-only
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,if=3Dvirtio,readonly=3Don
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -231,11 +231,11 @@ QEMU X.Y.Z monitor - type 'help' for more information
 Testing: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,id=3Ddisk,readonly=3Don =
-device ide-drive,drive=3Ddisk
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) QEMU_PROG: -device ide-drive,drive=3Ddisk: warning: 'ide-drive' is =
deprecated, please use 'ide-hd' or 'ide-cd' instead
-QEMU_PROG: -device ide-drive,drive=3Ddisk: Block node is read-only
+QEMU_PROG: -device ide-drive,drive=3Ddisk: error: Block node is read-only
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,id=3Ddisk,readonly=3Don =
-device ide-hd,drive=3Ddisk
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device ide-hd,drive=3Ddisk: Block node is read-only
+(qemu) QEMU_PROG: -device ide-hd,drive=3Ddisk: error: Block node is read-o=
nly
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,id=3Ddisk,readonly=3Don =
-device lsi53c895a -device scsi-disk,drive=3Ddisk
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -270,7 +270,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
=20
 Testing: -drive driver=3Dnull-co,cache=3Dinvalid_value
-QEMU_PROG: -drive driver=3Dnull-co,cache=3Dinvalid_value: invalid cache op=
tion
+QEMU_PROG: -drive driver=3Dnull-co,cache=3Dinvalid_value: error: invalid c=
ache option
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,cache=3Dwriteback,backing.file.fil=
ename=3DTEST_DIR/t.qcow2.base,backing.cache.no-flush=3Don,backing.node-name=
=3Dbacking,backing.file.node-name=3Dbacking-file,file.node-name=3Dfile,if=
=3Dnone,id=3Ddrive0 -nodefaults
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -333,7 +333,7 @@ backing-file: TEST_DIR/t.qcow2.base (file, read-only)
 (qemu) quit
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,cache=3Dinvalid_value,backing.file=
.filename=3DTEST_DIR/t.qcow2.base,backing.cache.no-flush=3Don,backing.node-=
name=3Dbacking,backing.file.node-name=3Dbacking-file,file.node-name=3Dfile,=
if=3Dnone,id=3Ddrive0 -nodefaults
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,cache=3Dinvalid_value,backing.fi=
le.filename=3DTEST_DIR/t.qcow2.base,backing.cache.no-flush=3Don,backing.nod=
e-name=3Dbacking,backing.file.node-name=3Dbacking-file,file.node-name=3Dfil=
e,if=3Dnone,id=3Ddrive0: invalid cache option
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,cache=3Dinvalid_value,backing.fi=
le.filename=3DTEST_DIR/t.qcow2.base,backing.cache.no-flush=3Don,backing.nod=
e-name=3Dbacking,backing.file.node-name=3Dbacking-file,file.node-name=3Dfil=
e,if=3Dnone,id=3Ddrive0: error: invalid cache option
=20
=20
 =3D=3D=3D Specifying the protocol layer =3D=3D=3D
@@ -346,94 +346,94 @@ QEMU X.Y.Z monitor - type 'help' for more information
 =3D=3D=3D Leaving out required options =3D=3D=3D
=20
 Testing: -drive driver=3Dfile
-QEMU_PROG: -drive driver=3Dfile: The 'file' block driver requires a file n=
ame
+QEMU_PROG: -drive driver=3Dfile: error: The 'file' block driver requires a=
 file name
=20
 Testing: -drive driver=3Dfile,filename=3D
-QEMU_PROG: -drive driver=3Dfile,filename=3D: The 'file' block driver requi=
res a file name
+QEMU_PROG: -drive driver=3Dfile,filename=3D: error: The 'file' block drive=
r requires a file name
=20
 Testing: -drive driver=3Dnbd
-QEMU_PROG: -drive driver=3Dnbd: NBD server address missing
+QEMU_PROG: -drive driver=3Dnbd: error: NBD server address missing
=20
 Testing: -drive driver=3Draw
-QEMU_PROG: -drive driver=3Draw: A block device must be specified for "file=
"
+QEMU_PROG: -drive driver=3Draw: error: A block device must be specified fo=
r "file"
=20
 Testing: -drive file.driver=3Dfile
-QEMU_PROG: -drive file.driver=3Dfile: The 'file' block driver requires a f=
ile name
+QEMU_PROG: -drive file.driver=3Dfile: error: The 'file' block driver requi=
res a file name
=20
 Testing: -drive file.driver=3Dnbd
-QEMU_PROG: -drive file.driver=3Dnbd: NBD server address missing
+QEMU_PROG: -drive file.driver=3Dnbd: error: NBD server address missing
=20
 Testing: -drive file.driver=3Draw
-QEMU_PROG: -drive file.driver=3Draw: A block device must be specified for =
"file"
+QEMU_PROG: -drive file.driver=3Draw: error: A block device must be specifi=
ed for "file"
=20
 Testing: -drive foo=3Dbar
-QEMU_PROG: -drive foo=3Dbar: Must specify either driver or file
+QEMU_PROG: -drive foo=3Dbar: error: Must specify either driver or file
=20
=20
 =3D=3D=3D Specifying both an option and its legacy alias =3D=3D=3D
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,iops=3D1234,throttling.iops-total=
=3D5678
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,iops=3D1234,throttling.iops-tota=
l=3D5678: 'throttling.iops-total' and its alias 'iops' can't be used at the=
 same time
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,iops=3D1234,throttling.iops-tota=
l=3D5678: error: 'throttling.iops-total' and its alias 'iops' can't be used=
 at the same time
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,iops_rd=3D1234,throttling.iops-rea=
d=3D5678
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,iops_rd=3D1234,throttling.iops-r=
ead=3D5678: 'throttling.iops-read' and its alias 'iops_rd' can't be used at=
 the same time
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,iops_rd=3D1234,throttling.iops-r=
ead=3D5678: error: 'throttling.iops-read' and its alias 'iops_rd' can't be =
used at the same time
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,iops_wr=3D1234,throttling.iops-wri=
te=3D5678
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,iops_wr=3D1234,throttling.iops-w=
rite=3D5678: 'throttling.iops-write' and its alias 'iops_wr' can't be used =
at the same time
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,iops_wr=3D1234,throttling.iops-w=
rite=3D5678: error: 'throttling.iops-write' and its alias 'iops_wr' can't b=
e used at the same time
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,bps=3D1234,throttling.bps-total=3D=
5678
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,bps=3D1234,throttling.bps-total=
=3D5678: 'throttling.bps-total' and its alias 'bps' can't be used at the sa=
me time
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,bps=3D1234,throttling.bps-total=
=3D5678: error: 'throttling.bps-total' and its alias 'bps' can't be used at=
 the same time
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,bps_rd=3D1234,throttling.bps-read=
=3D5678
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,bps_rd=3D1234,throttling.bps-rea=
d=3D5678: 'throttling.bps-read' and its alias 'bps_rd' can't be used at the=
 same time
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,bps_rd=3D1234,throttling.bps-rea=
d=3D5678: error: 'throttling.bps-read' and its alias 'bps_rd' can't be used=
 at the same time
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,bps_wr=3D1234,throttling.bps-write=
=3D5678
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,bps_wr=3D1234,throttling.bps-wri=
te=3D5678: 'throttling.bps-write' and its alias 'bps_wr' can't be used at t=
he same time
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,bps_wr=3D1234,throttling.bps-wri=
te=3D5678: error: 'throttling.bps-write' and its alias 'bps_wr' can't be us=
ed at the same time
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,iops_max=3D1234,throttling.iops-to=
tal-max=3D5678
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,iops_max=3D1234,throttling.iops-=
total-max=3D5678: 'throttling.iops-total-max' and its alias 'iops_max' can'=
t be used at the same time
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,iops_max=3D1234,throttling.iops-=
total-max=3D5678: error: 'throttling.iops-total-max' and its alias 'iops_ma=
x' can't be used at the same time
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,iops_rd_max=3D1234,throttling.iops=
-read-max=3D5678
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,iops_rd_max=3D1234,throttling.io=
ps-read-max=3D5678: 'throttling.iops-read-max' and its alias 'iops_rd_max' =
can't be used at the same time
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,iops_rd_max=3D1234,throttling.io=
ps-read-max=3D5678: error: 'throttling.iops-read-max' and its alias 'iops_r=
d_max' can't be used at the same time
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,iops_wr_max=3D1234,throttling.iops=
-write-max=3D5678
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,iops_wr_max=3D1234,throttling.io=
ps-write-max=3D5678: 'throttling.iops-write-max' and its alias 'iops_wr_max=
' can't be used at the same time
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,iops_wr_max=3D1234,throttling.io=
ps-write-max=3D5678: error: 'throttling.iops-write-max' and its alias 'iops=
_wr_max' can't be used at the same time
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,bps_max=3D1234,throttling.bps-tota=
l-max=3D5678
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,bps_max=3D1234,throttling.bps-to=
tal-max=3D5678: 'throttling.bps-total-max' and its alias 'bps_max' can't be=
 used at the same time
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,bps_max=3D1234,throttling.bps-to=
tal-max=3D5678: error: 'throttling.bps-total-max' and its alias 'bps_max' c=
an't be used at the same time
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,bps_rd_max=3D1234,throttling.bps-r=
ead-max=3D5678
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,bps_rd_max=3D1234,throttling.bps=
-read-max=3D5678: 'throttling.bps-read-max' and its alias 'bps_rd_max' can'=
t be used at the same time
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,bps_rd_max=3D1234,throttling.bps=
-read-max=3D5678: error: 'throttling.bps-read-max' and its alias 'bps_rd_ma=
x' can't be used at the same time
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,bps_wr_max=3D1234,throttling.bps-w=
rite-max=3D5678
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,bps_wr_max=3D1234,throttling.bps=
-write-max=3D5678: 'throttling.bps-write-max' and its alias 'bps_wr_max' ca=
n't be used at the same time
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,bps_wr_max=3D1234,throttling.bps=
-write-max=3D5678: error: 'throttling.bps-write-max' and its alias 'bps_wr_=
max' can't be used at the same time
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,iops_size=3D1234,throttling.iops-s=
ize=3D5678
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,iops_size=3D1234,throttling.iops=
-size=3D5678: 'throttling.iops-size' and its alias 'iops_size' can't be use=
d at the same time
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,iops_size=3D1234,throttling.iops=
-size=3D5678: error: 'throttling.iops-size' and its alias 'iops_size' can't=
 be used at the same time
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,readonly=3Don,read-only=3Doff
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,readonly=3Don,read-only=3Doff: '=
read-only' and its alias 'readonly' can't be used at the same time
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,readonly=3Don,read-only=3Doff: e=
rror: 'read-only' and its alias 'readonly' can't be used at the same time
=20
=20
 =3D=3D=3D Catching negative/large throttling values =3D=3D=3D
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,iops=3D-1
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,iops=3D-1: bps/iops/max values m=
ust be within [0, 1000000000000000]
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,iops=3D-1: error: bps/iops/max v=
alues must be within [0, 1000000000000000]
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,bps=3D-2
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,bps=3D-2: bps/iops/max values mu=
st be within [0, 1000000000000000]
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,bps=3D-2: error: bps/iops/max va=
lues must be within [0, 1000000000000000]
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,bps_rd=3D-3
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,bps_rd=3D-3: bps/iops/max values=
 must be within [0, 1000000000000000]
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,bps_rd=3D-3: error: bps/iops/max=
 values must be within [0, 1000000000000000]
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,bps_rd_max=3D-3
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,bps_rd_max=3D-3: bps/iops/max va=
lues must be within [0, 1000000000000000]
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,bps_rd_max=3D-3: error: bps/iops=
/max values must be within [0, 1000000000000000]
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,throttling.iops-total=3D-4
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,throttling.iops-total=3D-4: bps/=
iops/max values must be within [0, 1000000000000000]
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,throttling.iops-total=3D-4: erro=
r: bps/iops/max values must be within [0, 1000000000000000]
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,throttling.bps-total=3D-5
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,throttling.bps-total=3D-5: bps/i=
ops/max values must be within [0, 1000000000000000]
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,throttling.bps-total=3D-5: error=
: bps/iops/max values must be within [0, 1000000000000000]
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,bps=3D0
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -448,22 +448,22 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,bps=3D1000000000000001
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,bps=3D1000000000000001: bps/iops=
/max values must be within [0, 1000000000000000]
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,bps=3D1000000000000001: error: b=
ps/iops/max values must be within [0, 1000000000000000]
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,bps=3D9999999999999999
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,bps=3D9999999999999999: bps/iops=
/max values must be within [0, 1000000000000000]
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,bps=3D9999999999999999: error: b=
ps/iops/max values must be within [0, 1000000000000000]
=20
=20
 =3D=3D=3D Parsing protocol from file name =3D=3D=3D
=20
 Testing: -hda foo:bar
-QEMU_PROG: -hda foo:bar: Unknown protocol 'foo'
+QEMU_PROG: -hda foo:bar: error: Unknown protocol 'foo'
=20
 Testing: -drive file=3Dfoo:bar
-QEMU_PROG: -drive file=3Dfoo:bar: Unknown protocol 'foo'
+QEMU_PROG: -drive file=3Dfoo:bar: error: Unknown protocol 'foo'
=20
 Testing: -drive file.filename=3Dfoo:bar
-QEMU_PROG: -drive file.filename=3Dfoo:bar: Could not open 'foo:bar': No su=
ch file or directory
+QEMU_PROG: -drive file.filename=3Dfoo:bar: error: Could not open 'foo:bar'=
: No such file or directory
=20
 Testing: -hda file:TEST_DIR/t.qcow2
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -474,7 +474,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
=20
 Testing: -drive file.filename=3Dfile:TEST_DIR/t.qcow2
-QEMU_PROG: -drive file.filename=3Dfile:TEST_DIR/t.qcow2: Could not open 'f=
ile:TEST_DIR/t.qcow2': No such file or directory
+QEMU_PROG: -drive file.filename=3Dfile:TEST_DIR/t.qcow2: error: Could not =
open 'file:TEST_DIR/t.qcow2': No such file or directory
=20
=20
 =3D=3D=3D Snapshot mode =3D=3D=3D
@@ -559,7 +559,7 @@ wrote 4096/4096 bytes at offset 0
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Testing: -drive driver=3Dnull-co,snapshot=3Don
-QEMU_PROG: -drive driver=3Dnull-co,snapshot=3Don: Could not get temporary =
filename: No such file or directory
+QEMU_PROG: -drive driver=3Dnull-co,snapshot=3Don: error: Could not get tem=
porary filename: No such file or directory
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,snapshot=3Don,read-only=3Don,if=3D=
none,id=3Ddrive0
 QEMU X.Y.Z monitor - type 'help' for more information
diff --git a/tests/qemu-iotests/054.out b/tests/qemu-iotests/054.out
index e6ec430edd..7cddf38bc0 100644
--- a/tests/qemu-iotests/054.out
+++ b/tests/qemu-iotests/054.out
@@ -1,10 +1,10 @@
 QA output created by 054
=20
 creating too large image (1 EB)
-qemu-img: TEST_DIR/t.IMGFMT: The image size is too large for file format '=
IMGFMT' (try using a larger cluster size)
+qemu-img: error: TEST_DIR/t.IMGFMT: The image size is too large for file f=
ormat 'IMGFMT' (try using a larger cluster size)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1152921504606846976
=20
 creating too large image (1 EB) using qcow2.py
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4294967296
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Image is too big
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2': Image is too big
 *** done
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index d27692a33c..1162a9372e 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -20,7 +20,7 @@ Format specific information:
     lazy refcounts: false
     refcount bits: 16
     corrupt: true
-qemu-io: can't open device TEST_DIR/t.IMGFMT: IMGFMT: Image is corrupt; ca=
nnot be opened read/write
+qemu-io: error: can't open device TEST_DIR/t.IMGFMT: IMGFMT: Image is corr=
upt; cannot be opened read/write
 no file open, try 'help open'
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -132,7 +132,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D671=
08864
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: L2 table offset 0x42a00 unaligned (L1 ind=
ex: 0); further corruption events will be suppressed
-qemu-img: Failed to turn zero into data clusters: Input/output error
+qemu-img: error: Failed to turn zero into data clusters: Input/output erro=
r
=20
 =3D=3D=3D Testing unaligned L2 entry =3D=3D=3D
=20
@@ -148,7 +148,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D671=
08864
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: Cluster allocation offset 0x52a00 unalign=
ed (L2 offset: 0x40000, L2 index: 0); further corruption events will be sup=
pressed
-qemu-img: Failed to turn zero into data clusters: Input/output error
+qemu-img: error: Failed to turn zero into data clusters: Input/output erro=
r
=20
 =3D=3D=3D Testing unaligned reftable entry =3D=3D=3D
=20
@@ -270,7 +270,7 @@ No errors were found on the image.
 =3D=3D=3D Testing zero refcount table size =3D=3D=3D
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-qemu-io: can't open device TEST_DIR/t.IMGFMT: Image does not contain a ref=
erence count table
+qemu-io: error: can't open device TEST_DIR/t.IMGFMT: Image does not contai=
n a reference count table
 ERROR cluster 0 refcount=3D0 reference=3D1
 ERROR cluster 3 refcount=3D0 reference=3D1
 Rebuilding refcount structure
@@ -299,7 +299,7 @@ Can't get refcount for cluster 2: Input/output error
 Can't get refcount for cluster 3: Input/output error
 Rebuilding refcount structure
 Repairing cluster 1 refcount=3D1 reference=3D0
-qemu-io: can't open device TEST_DIR/t.IMGFMT: Could not repair dirty image=
: Input/output error
+qemu-io: error: can't open device TEST_DIR/t.IMGFMT: Could not repair dirt=
y image: Input/output error
 --- Repairing ---
 Leaked cluster 1 refcount=3D1 reference=3D0
 Repairing cluster 1 refcount=3D1 reference=3D0
@@ -350,7 +350,7 @@ Can't get refcount for cluster 5: Input/output error
 Can't get refcount for cluster 6: Input/output error
 Rebuilding refcount structure
 Repairing cluster 1 refcount=3D1 reference=3D0
-qemu-img: Check failed: No medium found
+qemu-img: error: Check failed: No medium found
 Leaked cluster 1 refcount=3D1 reference=3D0
 Repairing cluster 1 refcount=3D1 reference=3D0
 The following inconsistencies were found and repaired:
@@ -365,7 +365,7 @@ No errors were found on the image.
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 qcow2: Marking image as corrupt: Refblock at 0xffffff00000000 is not cover=
ed by the refcount structures; further corruption events will be suppressed
-qemu-img: Failed to discard unused refblocks: Input/output error
+qemu-img: error: Failed to discard unused refblocks: Input/output error
 --- Checking and retrying ---
 virtual size: 64 MiB (67108864 bytes)
 No errors were found on the image.
@@ -376,7 +376,7 @@ virtual size: 32 MiB (33554432 bytes)
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 qcow2: Marking image as corrupt: Refblock at 0x1000000000 is not covered b=
y the refcount structures; further corruption events will be suppressed
-qemu-img: Failed to discard unused refblocks: Input/output error
+qemu-img: error: Failed to discard unused refblocks: Input/output error
 --- Checking and retrying ---
 virtual size: 64 MiB (67108864 bytes)
 No errors were found on the image.
@@ -387,7 +387,7 @@ virtual size: 32 MiB (33554432 bytes)
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 qcow2: Marking image as corrupt: Cannot get entry from refcount block cach=
e: Offset 0x200 is unaligned; further corruption events will be suppressed
-qemu-img: Failed to discard unused refblocks: Input/output error
+qemu-img: error: Failed to discard unused refblocks: Input/output error
 --- Repairing ---
 Repairing refcount block 1 is outside image
 ERROR refcount block 2 is not cluster aligned; refcount table entry corrup=
ted
@@ -397,7 +397,7 @@ Rebuilding refcount structure
 Repairing cluster 1 refcount=3D1 reference=3D0
 Repairing cluster 2 refcount=3D1 reference=3D0
 Repairing cluster 1048576 refcount=3D1 reference=3D0
-qemu-img: Check failed: No medium found
+qemu-img: error: Check failed: No medium found
 Leaked cluster 1 refcount=3D1 reference=3D0
 Leaked cluster 2 refcount=3D1 reference=3D0
 Leaked cluster 1048576 refcount=3D1 reference=3D0
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 8b3091a412..06245c0f99 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -349,20 +349,20 @@ No errors were found on the image.
 =3D=3D=3D Testing invalid configurations =3D=3D=3D
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-qemu-img: Lazy refcounts only supported with compatibility level 1.1 and a=
bove (use compat=3D1.1 or greater)
-qemu-img: Lazy refcounts only supported with compatibility level 1.1 and a=
bove (use compat=3D1.1 or greater)
-qemu-img: Unknown compatibility level 0.42
-qemu-img: Invalid parameter 'foo'
-qemu-img: Changing the cluster size is not supported
-qemu-img: Changing the encryption flag is not supported
-qemu-img: Cannot change preallocation mode
+qemu-img: error: Lazy refcounts only supported with compatibility level 1.=
1 and above (use compat=3D1.1 or greater)
+qemu-img: error: Lazy refcounts only supported with compatibility level 1.=
1 and above (use compat=3D1.1 or greater)
+qemu-img: error: Unknown compatibility level 0.42
+qemu-img: error: Invalid parameter 'foo'
+qemu-img: error: Changing the cluster size is not supported
+qemu-img: error: Changing the encryption flag is not supported
+qemu-img: error: Cannot change preallocation mode
=20
 =3D=3D=3D Testing correct handling of unset value =3D=3D=3D
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 Should work:
 Should not work:
-qemu-img: Changing the cluster size is not supported
+qemu-img: error: Changing the cluster size is not supported
=20
 =3D=3D=3D Testing zero expansion on inactive clusters =3D=3D=3D
=20
@@ -484,7 +484,7 @@ No errors were found on the image.
 =3D=3D=3D Testing version downgrade with external data file =3D=3D=3D
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 data_file=3DT=
EST_DIR/t.IMGFMT.data
-qemu-img: Cannot downgrade an image with a data file
+qemu-img: error: Cannot downgrade an image with a data file
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
@@ -501,10 +501,10 @@ No errors were found on the image.
 =3D=3D=3D Try changing the external data file =3D=3D=3D
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-qemu-img: data-file can only be set for images that use an external data f=
ile
+qemu-img: error: data-file can only be set for images that use an external=
 data file
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 data_file=3DT=
EST_DIR/t.IMGFMT.data
-qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Could not open 'foo': No suc=
h file or directory
+qemu-img: error: Could not open 'TEST_DIR/t.IMGFMT': Could not open 'foo':=
 No such file or directory
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
@@ -517,7 +517,7 @@ Format specific information:
     data file raw: false
     corrupt: false
=20
-qemu-img: Could not open 'TEST_DIR/t.IMGFMT': 'data-file' is required for =
this image
+qemu-img: error: Could not open 'TEST_DIR/t.IMGFMT': 'data-file' is requir=
ed for this image
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
@@ -556,7 +556,7 @@ Format specific information:
     data file raw: false
     corrupt: false
 No errors were found on the image.
-qemu-img: data-file-raw cannot be set on existing images
+qemu-img: error: data-file-raw cannot be set on existing images
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
diff --git a/tests/qemu-iotests/069.out b/tests/qemu-iotests/069.out
index c78e8c2b72..96e3ff2dd6 100644
--- a/tests/qemu-iotests/069.out
+++ b/tests/qemu-iotests/069.out
@@ -4,5 +4,5 @@ QA output created by 069
=20
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D131072
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D131072 backing_file=3D=
TEST_DIR/t.IMGFMT.base
-qemu-io: can't open device TEST_DIR/t.IMGFMT: Could not open backing file:=
 Could not open 'TEST_DIR/t.IMGFMT.base': No such file or directory
+qemu-io: error: can't open device TEST_DIR/t.IMGFMT: Could not open backin=
g file: Could not open 'TEST_DIR/t.IMGFMT.base': No such file or directory
 *** done
diff --git a/tests/qemu-iotests/071.out b/tests/qemu-iotests/071.out
index bca0c02f5c..30e5266583 100644
--- a/tests/qemu-iotests/071.out
+++ b/tests/qemu-iotests/071.out
@@ -86,7 +86,7 @@ read failed: Input/output error
 {"return": ""}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
-QEMU_PROG: Failed to flush the L2 table cache: Input/output error
-QEMU_PROG: Failed to flush the refcount block cache: Input/output error
+QEMU_PROG: error: Failed to flush the L2 table cache: Input/output error
+QEMU_PROG: error: Failed to flush the refcount block cache: Input/output e=
rror
=20
 *** done
diff --git a/tests/qemu-iotests/074.out b/tests/qemu-iotests/074.out
index ede66c3f81..cd8bcb3b67 100644
--- a/tests/qemu-iotests/074.out
+++ b/tests/qemu-iotests/074.out
@@ -3,14 +3,14 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D10737=
41824
 =3D=3D=3D IO: pattern 102
 wrote 512/512 bytes at offset 512
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Error while reading offset 0 of blkdebug:TEST_DIR/blkdebug.conf:=
TEST_DIR/t.IMGFMT: Input/output error
+qemu-img: error: Error while reading offset 0 of blkdebug:TEST_DIR/blkdebu=
g.conf:TEST_DIR/t.IMGFMT: Input/output error
 4
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
 Formatting 'TEST_DIR/t.IMGFMT.2', fmt=3DIMGFMT size=3D0
 =3D=3D=3D IO: pattern 102
 wrote 512/512 bytes at offset 512
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Error while reading offset 0 of blkdebug:TEST_DIR/blkdebug.conf:=
TEST_DIR/t.IMGFMT: Input/output error
+qemu-img: error: Error while reading offset 0 of blkdebug:TEST_DIR/blkdebu=
g.conf:TEST_DIR/t.IMGFMT: Input/output error
 Warning: Image size mismatch!
 4
 Cleanup
diff --git a/tests/qemu-iotests/079.out b/tests/qemu-iotests/079.out
index aab922fb36..e3b2cf0ba1 100644
--- a/tests/qemu-iotests/079.out
+++ b/tests/qemu-iotests/079.out
@@ -9,6 +9,6 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4294967=
296 preallocation=3Dmetadat
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4294967296 preallocati=
on=3Dmetadata
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4294967296 preallocati=
on=3Dmetadata
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4294967296 preallocati=
on=3Dmetadata
-qemu-img: TEST_DIR/t.IMGFMT: Cluster size must be a power of two between 5=
12 and 2048k
+qemu-img: error: TEST_DIR/t.IMGFMT: Cluster size must be a power of two be=
tween 512 and 2048k
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4294967296 preallocati=
on=3Dmetadata
 *** done
diff --git a/tests/qemu-iotests/080.out b/tests/qemu-iotests/080.out
index 45ab01db8e..b9f32f27d4 100644
--- a/tests/qemu-iotests/080.out
+++ b/tests/qemu-iotests/080.out
@@ -2,75 +2,75 @@ QA output created by 080
=20
 =3D=3D Huge header size =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-qemu-io: can't open device TEST_DIR/t.qcow2: qcow2 header exceeds cluster =
size
-qemu-io: can't open device TEST_DIR/t.qcow2: qcow2 header exceeds cluster =
size
+qemu-io: error: can't open device TEST_DIR/t.qcow2: qcow2 header exceeds c=
luster size
+qemu-io: error: can't open device TEST_DIR/t.qcow2: qcow2 header exceeds c=
luster size
=20
 =3D=3D Huge unknown header extension =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-qemu-io: can't open device TEST_DIR/t.qcow2: Invalid backing file offset
-qemu-io: can't open device TEST_DIR/t.qcow2: Header extension too large
-qemu-io: can't open device TEST_DIR/t.qcow2: Header extension too large
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Invalid backing file o=
ffset
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Header extension too l=
arge
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Header extension too l=
arge
=20
 =3D=3D Huge refcount table size =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-qemu-io: can't open device TEST_DIR/t.qcow2: Reference count table too lar=
ge
-qemu-io: can't open device TEST_DIR/t.qcow2: Reference count table too lar=
ge
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Reference count table =
too large
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Reference count table =
too large
=20
 =3D=3D Misaligned refcount table =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-qemu-io: can't open device TEST_DIR/t.qcow2: Reference count table offset =
invalid
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Reference count table =
offset invalid
=20
 =3D=3D Huge refcount offset =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-qemu-io: can't open device TEST_DIR/t.qcow2: Reference count table offset =
invalid
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Reference count table =
offset invalid
=20
 =3D=3D Invalid snapshot table =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-qemu-io: can't open device TEST_DIR/t.qcow2: Snapshot table too large
-qemu-io: can't open device TEST_DIR/t.qcow2: Snapshot table too large
-qemu-io: can't open device TEST_DIR/t.qcow2: Snapshot table offset invalid
-qemu-io: can't open device TEST_DIR/t.qcow2: Snapshot table offset invalid
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Snapshot table too lar=
ge
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Snapshot table too lar=
ge
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Snapshot table offset =
invalid
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Snapshot table offset =
invalid
=20
 =3D=3D Hitting snapshot table size limit =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-qemu-img: Could not create snapshot 'test': -27 (File too large)
+qemu-img: error: Could not create snapshot 'test': -27 (File too large)
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 =3D=3D Invalid L1 table =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-qemu-io: can't open device TEST_DIR/t.qcow2: Active L1 table too large
-qemu-io: can't open device TEST_DIR/t.qcow2: Active L1 table too large
-qemu-io: can't open device TEST_DIR/t.qcow2: Active L1 table offset invali=
d
-qemu-io: can't open device TEST_DIR/t.qcow2: Active L1 table offset invali=
d
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Active L1 table too la=
rge
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Active L1 table too la=
rge
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Active L1 table offset=
 invalid
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Active L1 table offset=
 invalid
=20
 =3D=3D Invalid L1 table (with internal snapshot in the image) =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-qemu-img: Could not open 'TEST_DIR/t.IMGFMT': L1 table is too small
+qemu-img: error: Could not open 'TEST_DIR/t.IMGFMT': L1 table is too small
=20
 =3D=3D Invalid backing file size =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-qemu-io: can't open device TEST_DIR/t.qcow2: Backing file name too long
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Backing file name too =
long
=20
 =3D=3D Invalid L2 entry (huge physical offset) =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Could not create snapshot 'test': -27 (File too large)
-qemu-img: Could not create snapshot 'test': -11 (Resource temporarily unav=
ailable)
+qemu-img: error: Could not create snapshot 'test': -27 (File too large)
+qemu-img: error: Could not create snapshot 'test': -11 (Resource temporari=
ly unavailable)
=20
 =3D=3D Invalid snapshot L1 table offset =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Failed to load snapshot: Snapshot L1 table offset invalid
-qemu-img: Snapshot L1 table offset invalid
-qemu-img: Failed to turn zero into data clusters: Invalid argument
-qemu-io: Failed to flush the refcount block cache: Invalid argument
+qemu-img: error: Failed to load snapshot: Snapshot L1 table offset invalid
+qemu-img: error: Snapshot L1 table offset invalid
+qemu-img: error: Failed to turn zero into data clusters: Invalid argument
+qemu-io: error: Failed to flush the refcount block cache: Invalid argument
 write failed: Invalid argument
-qemu-img: Snapshot L1 table offset invalid
-qemu-img: Could not apply snapshot 'test': Failed to load snapshot: Invali=
d argument
-qemu-img: Could not delete snapshot 'test': Snapshot L1 table offset inval=
id
+qemu-img: error: Snapshot L1 table offset invalid
+qemu-img: error: Could not apply snapshot 'test': Failed to load snapshot:=
 Invalid argument
+qemu-img: error: Could not delete snapshot 'test': Snapshot L1 table offse=
t invalid
 ERROR snapshot 1 (test) l1_offset=3D0x400200: L1 table is not cluster alig=
ned; snapshot table entry corrupted
 Leaked cluster 4 refcount=3D2 reference=3D1
 Leaked cluster 5 refcount=3D2 reference=3D1
@@ -86,14 +86,14 @@ This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Failed to load snapshot: Snapshot L1 table too large
-qemu-img: Snapshot L1 table too large
-qemu-img: Failed to turn zero into data clusters: File too large
-qemu-io: Failed to flush the refcount block cache: File too large
+qemu-img: error: Failed to load snapshot: Snapshot L1 table too large
+qemu-img: error: Snapshot L1 table too large
+qemu-img: error: Failed to turn zero into data clusters: File too large
+qemu-io: error: Failed to flush the refcount block cache: File too large
 write failed: File too large
-qemu-img: Snapshot L1 table too large
-qemu-img: Could not apply snapshot 'test': Failed to load snapshot: File t=
oo large
-qemu-img: Could not delete snapshot 'test': Snapshot L1 table too large
+qemu-img: error: Snapshot L1 table too large
+qemu-img: error: Could not apply snapshot 'test': Failed to load snapshot:=
 File too large
+qemu-img: error: Could not delete snapshot 'test': Snapshot L1 table too l=
arge
 ERROR snapshot 1 (test) l1_size=3D0x10000000: L1 table is too large; snaps=
hot table entry corrupted
 Leaked cluster 4 refcount=3D2 reference=3D1
 Leaked cluster 5 refcount=3D2 reference=3D1
diff --git a/tests/qemu-iotests/081.out b/tests/qemu-iotests/081.out
index 04091b64e5..129a628f87 100644
--- a/tests/qemu-iotests/081.out
+++ b/tests/qemu-iotests/081.out
@@ -70,7 +70,7 @@ read 10485760/10485760 bytes at offset 0
 10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 =3D=3D checking the blkverify mode with invalid settings =3D=3D
-qemu-io: can't open: blkverify=3Don can only be set if there are exactly t=
wo files and vote-threshold is 2
+qemu-io: error: can't open: blkverify=3Don can only be set if there are ex=
actly two files and vote-threshold is 2
=20
 =3D=3D dynamically adding a child to a quorum =3D=3D
 Testing:
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 9d4ed4dc9d..8391e485da 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -233,13 +233,13 @@ Testing: create -f qcow2 -u -o backing_file=3DTEST_DI=
R/t.qcow2,,? TEST_DIR/t.qcow2
 Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D134217728 backing_file=
=3DTEST_DIR/t.qcow2,,? cluster_size=3D65536 lazy_refcounts=3Doff refcount_b=
its=3D16
=20
 Testing: create -f qcow2 -o backing_file=3DTEST_DIR/t.qcow2, -o help TEST_=
DIR/t.qcow2 128M
-qemu-img: Invalid option list: backing_file=3DTEST_DIR/t.qcow2,
+qemu-img: error: Invalid option list: backing_file=3DTEST_DIR/t.qcow2,
=20
 Testing: create -f qcow2 -o backing_file=3DTEST_DIR/t.qcow2 -o ,help TEST_=
DIR/t.qcow2 128M
-qemu-img: Invalid option list: ,help
+qemu-img: error: Invalid option list: ,help
=20
 Testing: create -f qcow2 -o backing_file=3DTEST_DIR/t.qcow2 -o ,, -o help =
TEST_DIR/t.qcow2 128M
-qemu-img: Invalid option list: ,,
+qemu-img: error: Invalid option list: ,,
=20
 Testing: create -f qcow2 -o help
 Supported qcow2 options:
@@ -274,7 +274,7 @@ The protocol level may support further options.
 Specify the target filename to include those options.
=20
 Testing: create -f bochs -o help
-qemu-img: Format driver 'bochs' does not support image creation
+qemu-img: error: Format driver 'bochs' does not support image creation
=20
 =3D=3D=3D convert: Options specified more than once =3D=3D=3D
=20
@@ -507,19 +507,19 @@ Supported options:
   size=3D<size>            - Virtual disk size
=20
 Testing: convert -O qcow2 -o backing_file=3DTEST_DIR/t.qcow2,,help TEST_DI=
R/t.qcow2 TEST_DIR/t.qcow2.base
-qemu-img: Could not open 'TEST_DIR/t.qcow2.base': Could not open backing f=
ile: Could not open 'TEST_DIR/t.qcow2,help': No such file or directory
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2.base': Could not open ba=
cking file: Could not open 'TEST_DIR/t.qcow2,help': No such file or directo=
ry
=20
 Testing: convert -O qcow2 -o backing_file=3DTEST_DIR/t.qcow2,,? TEST_DIR/t=
.qcow2 TEST_DIR/t.qcow2.base
-qemu-img: Could not open 'TEST_DIR/t.qcow2.base': Could not open backing f=
ile: Could not open 'TEST_DIR/t.qcow2,?': No such file or directory
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2.base': Could not open ba=
cking file: Could not open 'TEST_DIR/t.qcow2,?': No such file or directory
=20
 Testing: convert -O qcow2 -o backing_file=3DTEST_DIR/t.qcow2, -o help TEST=
_DIR/t.qcow2 TEST_DIR/t.qcow2.base
-qemu-img: Invalid option list: backing_file=3DTEST_DIR/t.qcow2,
+qemu-img: error: Invalid option list: backing_file=3DTEST_DIR/t.qcow2,
=20
 Testing: convert -O qcow2 -o backing_file=3DTEST_DIR/t.qcow2 -o ,help TEST=
_DIR/t.qcow2 TEST_DIR/t.qcow2.base
-qemu-img: Invalid option list: ,help
+qemu-img: error: Invalid option list: ,help
=20
 Testing: convert -O qcow2 -o backing_file=3DTEST_DIR/t.qcow2 -o ,, -o help=
 TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
-qemu-img: Invalid option list: ,,
+qemu-img: error: Invalid option list: ,,
=20
 Testing: convert -O qcow2 -o help
 Supported qcow2 options:
@@ -554,21 +554,21 @@ The protocol level may support further options.
 Specify the target filename to include those options.
=20
 Testing: convert -O bochs -o help
-qemu-img: Format driver 'bochs' does not support image creation
+qemu-img: error: Format driver 'bochs' does not support image creation
=20
 =3D=3D=3D convert: -C and other options =3D=3D=3D
=20
 Testing: convert -C -S 4k -O qcow2 TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.targe=
t
-qemu-img: Cannot enable copy offloading when -S is used
+qemu-img: error: Cannot enable copy offloading when -S is used
=20
 Testing: convert -C -S 8k -O qcow2 TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.targe=
t
-qemu-img: Cannot enable copy offloading when -S is used
+qemu-img: error: Cannot enable copy offloading when -S is used
=20
 Testing: convert -C -c -O qcow2 TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.target
-qemu-img: Cannot enable copy offloading when -c is used
+qemu-img: error: Cannot enable copy offloading when -c is used
=20
 Testing: convert -C --salvage -O qcow2 TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.t=
arget
-qemu-img: Cannot use copy offloading in salvaging mode
+qemu-img: error: Cannot use copy offloading in salvaging mode
=20
 =3D=3D=3D amend: Options specified more than once =3D=3D=3D
=20
@@ -814,13 +814,13 @@ Testing: amend -f qcow2 -o backing_file=3DTEST_DIR/t.=
qcow2,,? TEST_DIR/t.qcow2
 Testing: rebase -u -b  -f qcow2 TEST_DIR/t.qcow2
=20
 Testing: amend -f qcow2 -o backing_file=3DTEST_DIR/t.qcow2, -o help TEST_D=
IR/t.qcow2
-qemu-img: Invalid option list: backing_file=3DTEST_DIR/t.qcow2,
+qemu-img: error: Invalid option list: backing_file=3DTEST_DIR/t.qcow2,
=20
 Testing: amend -f qcow2 -o backing_file=3DTEST_DIR/t.qcow2 -o ,help TEST_D=
IR/t.qcow2
-qemu-img: Invalid option list: ,help
+qemu-img: error: Invalid option list: ,help
=20
 Testing: amend -f qcow2 -o backing_file=3DTEST_DIR/t.qcow2 -o ,, -o help T=
EST_DIR/t.qcow2
-qemu-img: Invalid option list: ,,
+qemu-img: error: Invalid option list: ,,
=20
 Testing: amend -f qcow2 -o help
 Creation options for 'qcow2':
@@ -847,8 +847,8 @@ Creation options for 'qcow2':
 Note that not all of these options may be amendable.
=20
 Testing: amend -o help
-qemu-img: Expecting one image file name
+qemu-img: error: Expecting one image file name
=20
 Testing: amend -f bochs -o help
-qemu-img: Format driver 'bochs' does not support option amendment
+qemu-img: error: Format driver 'bochs' does not support option amendment
 *** done
diff --git a/tests/qemu-iotests/083.out b/tests/qemu-iotests/083.out
index 2090ee693c..696fb5ff75 100644
--- a/tests/qemu-iotests/083.out
+++ b/tests/qemu-iotests/083.out
@@ -1,43 +1,43 @@
 QA output created by 083
 =3D=3D=3D Check disconnect before neg1 =3D=3D=3D
=20
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: error: can't open device nbd+tcp://127.0.0.1:PORT/foo
=20
 =3D=3D=3D Check disconnect after neg1 =3D=3D=3D
=20
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: error: can't open device nbd+tcp://127.0.0.1:PORT/foo
=20
 =3D=3D=3D Check disconnect 8 neg1 =3D=3D=3D
=20
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: error: can't open device nbd+tcp://127.0.0.1:PORT/foo
=20
 =3D=3D=3D Check disconnect 16 neg1 =3D=3D=3D
=20
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: error: can't open device nbd+tcp://127.0.0.1:PORT/foo
=20
 =3D=3D=3D Check disconnect before export =3D=3D=3D
=20
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: error: can't open device nbd+tcp://127.0.0.1:PORT/foo
=20
 =3D=3D=3D Check disconnect after export =3D=3D=3D
=20
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: error: can't open device nbd+tcp://127.0.0.1:PORT/foo
=20
 =3D=3D=3D Check disconnect 4 export =3D=3D=3D
=20
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: error: can't open device nbd+tcp://127.0.0.1:PORT/foo
=20
 =3D=3D=3D Check disconnect 12 export =3D=3D=3D
=20
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: error: can't open device nbd+tcp://127.0.0.1:PORT/foo
=20
 =3D=3D=3D Check disconnect 16 export =3D=3D=3D
=20
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: error: can't open device nbd+tcp://127.0.0.1:PORT/foo
=20
 =3D=3D=3D Check disconnect before neg2 =3D=3D=3D
=20
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: error: can't open device nbd+tcp://127.0.0.1:PORT/foo
=20
 =3D=3D=3D Check disconnect after neg2 =3D=3D=3D
=20
@@ -45,11 +45,11 @@ read failed: Input/output error
=20
 =3D=3D=3D Check disconnect 8 neg2 =3D=3D=3D
=20
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: error: can't open device nbd+tcp://127.0.0.1:PORT/foo
=20
 =3D=3D=3D Check disconnect 10 neg2 =3D=3D=3D
=20
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/foo
+qemu-io: error: can't open device nbd+tcp://127.0.0.1:PORT/foo
=20
 =3D=3D=3D Check disconnect before request =3D=3D=3D
=20
@@ -86,23 +86,23 @@ read 512/512 bytes at offset 0
=20
 =3D=3D=3D Check disconnect before neg-classic =3D=3D=3D
=20
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/
+qemu-io: error: can't open device nbd+tcp://127.0.0.1:PORT/
=20
 =3D=3D=3D Check disconnect 8 neg-classic =3D=3D=3D
=20
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/
+qemu-io: error: can't open device nbd+tcp://127.0.0.1:PORT/
=20
 =3D=3D=3D Check disconnect 16 neg-classic =3D=3D=3D
=20
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/
+qemu-io: error: can't open device nbd+tcp://127.0.0.1:PORT/
=20
 =3D=3D=3D Check disconnect 24 neg-classic =3D=3D=3D
=20
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/
+qemu-io: error: can't open device nbd+tcp://127.0.0.1:PORT/
=20
 =3D=3D=3D Check disconnect 28 neg-classic =3D=3D=3D
=20
-qemu-io: can't open device nbd+tcp://127.0.0.1:PORT/
+qemu-io: error: can't open device nbd+tcp://127.0.0.1:PORT/
=20
 =3D=3D=3D Check disconnect after neg-classic =3D=3D=3D
=20
@@ -110,43 +110,43 @@ read failed: Input/output error
=20
 =3D=3D=3D Check disconnect before neg1 =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
+qemu-io: error: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.so=
ck
=20
 =3D=3D=3D Check disconnect after neg1 =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
+qemu-io: error: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.so=
ck
=20
 =3D=3D=3D Check disconnect 8 neg1 =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
+qemu-io: error: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.so=
ck
=20
 =3D=3D=3D Check disconnect 16 neg1 =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
+qemu-io: error: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.so=
ck
=20
 =3D=3D=3D Check disconnect before export =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
+qemu-io: error: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.so=
ck
=20
 =3D=3D=3D Check disconnect after export =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
+qemu-io: error: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.so=
ck
=20
 =3D=3D=3D Check disconnect 4 export =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
+qemu-io: error: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.so=
ck
=20
 =3D=3D=3D Check disconnect 12 export =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
+qemu-io: error: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.so=
ck
=20
 =3D=3D=3D Check disconnect 16 export =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
+qemu-io: error: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.so=
ck
=20
 =3D=3D=3D Check disconnect before neg2 =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
+qemu-io: error: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.so=
ck
=20
 =3D=3D=3D Check disconnect after neg2 =3D=3D=3D
=20
@@ -154,11 +154,11 @@ read failed: Input/output error
=20
 =3D=3D=3D Check disconnect 8 neg2 =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
+qemu-io: error: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.so=
ck
=20
 =3D=3D=3D Check disconnect 10 neg2 =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
+qemu-io: error: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.so=
ck
=20
 =3D=3D=3D Check disconnect before request =3D=3D=3D
=20
@@ -195,23 +195,23 @@ read 512/512 bytes at offset 0
=20
 =3D=3D=3D Check disconnect before neg-classic =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///?socket=3DSOCK_DIR/nbd.sock
+qemu-io: error: can't open device nbd+unix:///?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect 8 neg-classic =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///?socket=3DSOCK_DIR/nbd.sock
+qemu-io: error: can't open device nbd+unix:///?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect 16 neg-classic =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///?socket=3DSOCK_DIR/nbd.sock
+qemu-io: error: can't open device nbd+unix:///?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect 24 neg-classic =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///?socket=3DSOCK_DIR/nbd.sock
+qemu-io: error: can't open device nbd+unix:///?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect 28 neg-classic =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///?socket=3DSOCK_DIR/nbd.sock
+qemu-io: error: can't open device nbd+unix:///?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect after neg-classic =3D=3D=3D
=20
diff --git a/tests/qemu-iotests/098.out b/tests/qemu-iotests/098.out
index 7634d0e8b0..d22713052d 100644
--- a/tests/qemu-iotests/098.out
+++ b/tests/qemu-iotests/098.out
@@ -6,7 +6,7 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D67=
108864
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Could not empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFM=
T: Input/output error
+qemu-img: error: Could not empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/=
t.IMGFMT: Input/output error
 No errors were found on the image.
=20
 =3D=3D=3D empty_image_prepare =3D=3D=3D
@@ -15,7 +15,7 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D=
67108864
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Could not empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFM=
T: Input/output error
+qemu-img: error: Could not empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/=
t.IMGFMT: Input/output error
 Leaked cluster 4 refcount=3D1 reference=3D0
 Leaked cluster 5 refcount=3D1 reference=3D0
 Repairing cluster 4 refcount=3D1 reference=3D0
@@ -28,7 +28,7 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D=
67108864
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Could not empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFM=
T: Input/output error
+qemu-img: error: Could not empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/=
t.IMGFMT: Input/output error
 ERROR cluster 0 refcount=3D0 reference=3D1
 ERROR cluster 1 refcount=3D0 reference=3D1
 ERROR cluster 3 refcount=3D0 reference=3D1
@@ -42,7 +42,7 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D=
67108864
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.base
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Could not empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFM=
T: Input/output error
+qemu-img: error: Could not empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/=
t.IMGFMT: Input/output error
 ERROR cluster 0 refcount=3D0 reference=3D1
 ERROR cluster 1 refcount=3D0 reference=3D1
 ERROR cluster 3 refcount=3D0 reference=3D1
diff --git a/tests/qemu-iotests/103.out b/tests/qemu-iotests/103.out
index 16704cf499..983212f9cf 100644
--- a/tests/qemu-iotests/103.out
+++ b/tests/qemu-iotests/103.out
@@ -5,13 +5,13 @@ wrote 65536/65536 bytes at offset 0
=20
 =3D=3D=3D Testing invalid option combinations =3D=3D=3D
=20
-qemu-io: can't open device TEST_DIR/t.IMGFMT: cache-size, l2-cache-size an=
d refcount-cache-size may not be set at the same time
-qemu-io: can't open device TEST_DIR/t.IMGFMT: l2-cache-size may not exceed=
 cache-size
-qemu-io: can't open device TEST_DIR/t.IMGFMT: refcount-cache-size may not =
exceed cache-size
-qemu-io: can't open device TEST_DIR/t.IMGFMT: cache-size, l2-cache-size an=
d refcount-cache-size may not be set at the same time
-qemu-io: can't open device TEST_DIR/t.IMGFMT: L2 cache entry size must be =
a power of two between 512 and the cluster size (65536)
-qemu-io: can't open device TEST_DIR/t.IMGFMT: L2 cache entry size must be =
a power of two between 512 and the cluster size (65536)
-qemu-io: can't open device TEST_DIR/t.IMGFMT: L2 cache entry size must be =
a power of two between 512 and the cluster size (65536)
+qemu-io: error: can't open device TEST_DIR/t.IMGFMT: cache-size, l2-cache-=
size and refcount-cache-size may not be set at the same time
+qemu-io: error: can't open device TEST_DIR/t.IMGFMT: l2-cache-size may not=
 exceed cache-size
+qemu-io: error: can't open device TEST_DIR/t.IMGFMT: refcount-cache-size m=
ay not exceed cache-size
+qemu-io: error: can't open device TEST_DIR/t.IMGFMT: cache-size, l2-cache-=
size and refcount-cache-size may not be set at the same time
+qemu-io: error: can't open device TEST_DIR/t.IMGFMT: L2 cache entry size m=
ust be a power of two between 512 and the cluster size (65536)
+qemu-io: error: can't open device TEST_DIR/t.IMGFMT: L2 cache entry size m=
ust be a power of two between 512 and the cluster size (65536)
+qemu-io: error: can't open device TEST_DIR/t.IMGFMT: L2 cache entry size m=
ust be a power of two between 512 and the cluster size (65536)
=20
 =3D=3D=3D Testing valid option combinations =3D=3D=3D
=20
diff --git a/tests/qemu-iotests/106.out b/tests/qemu-iotests/106.out
index c459957660..3c1fbcbb70 100644
--- a/tests/qemu-iotests/106.out
+++ b/tests/qemu-iotests/106.out
@@ -40,10 +40,10 @@ Image resized.
 =3D=3D=3D Testing image shrinking =3D=3D=3D
=20
 --- growth_mode=3Dfalloc ---
-qemu-img: Preallocation can only be used for growing images
+qemu-img: error: Preallocation can only be used for growing images
=20
 --- growth_mode=3Dfull ---
-qemu-img: Preallocation can only be used for growing images
+qemu-img: error: Preallocation can only be used for growing images
=20
 --- growth_mode=3Doff ---
 Image resized.
diff --git a/tests/qemu-iotests/111.out b/tests/qemu-iotests/111.out
index 5279c462fc..fc13d8a635 100644
--- a/tests/qemu-iotests/111.out
+++ b/tests/qemu-iotests/111.out
@@ -1,4 +1,4 @@
 QA output created by 111
-qemu-img: TEST_DIR/t.IMGFMT: Could not open 'TEST_DIR/t.IMGFMT.inexistent'=
: No such file or directory
+qemu-img: error: TEST_DIR/t.IMGFMT: Could not open 'TEST_DIR/t.IMGFMT.inex=
istent': No such file or directory
 Could not open backing image to determine size.
 *** done
diff --git a/tests/qemu-iotests/112.out b/tests/qemu-iotests/112.out
index ae0318cabe..ff5c3e8cfb 100644
--- a/tests/qemu-iotests/112.out
+++ b/tests/qemu-iotests/112.out
@@ -2,13 +2,13 @@ QA output created by 112
=20
 =3D=3D=3D refcount_bits limits =3D=3D=3D
=20
-qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two and may=
 not exceed 64 bits
+qemu-img: error: TEST_DIR/t.IMGFMT: Refcount width must be a power of two =
and may not exceed 64 bits
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two and may=
 not exceed 64 bits
+qemu-img: error: TEST_DIR/t.IMGFMT: Refcount width must be a power of two =
and may not exceed 64 bits
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 refcount_bits=
=3D-1
-qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two and may=
 not exceed 64 bits
+qemu-img: error: TEST_DIR/t.IMGFMT: Refcount width must be a power of two =
and may not exceed 64 bits
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two and may=
 not exceed 64 bits
+qemu-img: error: TEST_DIR/t.IMGFMT: Refcount width must be a power of two =
and may not exceed 64 bits
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 refcount bits: 1
@@ -21,9 +21,9 @@ refcount bits: 16
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 refcount bits: 16
-qemu-img: TEST_DIR/t.IMGFMT: Different refcount widths than 16 bits requir=
e compatibility level 1.1 or above (use version=3Dv3 or greater)
+qemu-img: error: TEST_DIR/t.IMGFMT: Different refcount widths than 16 bits=
 require compatibility level 1.1 or above (use version=3Dv3 or greater)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-qemu-img: TEST_DIR/t.IMGFMT: Different refcount widths than 16 bits requir=
e compatibility level 1.1 or above (use version=3Dv3 or greater)
+qemu-img: error: TEST_DIR/t.IMGFMT: Different refcount widths than 16 bits=
 require compatibility level 1.1 or above (use version=3Dv3 or greater)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
=20
 =3D=3D=3D Snapshot limit on refcount_bits=3D1 =3D=3D=3D
@@ -32,7 +32,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108=
864
 refcount bits: 1
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Could not create snapshot 'foo': -22 (Invalid argument)
+qemu-img: error: Could not create snapshot 'foo': -22 (Invalid argument)
 Leaked cluster 6 refcount=3D1 reference=3D0
=20
 1 leaked clusters were found on the image.
@@ -44,7 +44,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108=
864
 refcount bits: 2
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Could not create snapshot 'baz': -22 (Invalid argument)
+qemu-img: error: Could not create snapshot 'baz': -22 (Invalid argument)
 Leaked cluster 7 refcount=3D1 reference=3D0
=20
 1 leaked clusters were found on the image.
@@ -75,7 +75,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108=
864
 refcount bits: 64
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Could not create snapshot 'foo': -22 (Invalid argument)
+qemu-img: error: Could not create snapshot 'foo': -22 (Invalid argument)
 Leaked cluster 5 refcount=3D18446744073709551615 reference=3D1
 Leaked cluster 6 refcount=3D1 reference=3D0
=20
@@ -98,19 +98,19 @@ refcount bits: 64
=20
 =3D=3D=3D Amend to compat=3D0.10 =3D=3D=3D
=20
-qemu-img: compat=3D0.10 requires refcount_bits=3D16
+qemu-img: error: compat=3D0.10 requires refcount_bits=3D16
 refcount bits: 64
 No errors were found on the image.
 refcount bits: 16
 refcount bits: 16
-qemu-img: Refcount widths other than 16 bits require compatibility level 1=
.1 or above (use compat=3D1.1 or greater)
+qemu-img: error: Refcount widths other than 16 bits require compatibility =
level 1.1 or above (use compat=3D1.1 or greater)
 refcount bits: 16
=20
 =3D=3D=3D Amend with snapshot =3D=3D=3D
=20
 wrote 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Cannot decrease refcount entry width to 1 bits: Cluster at offse=
t 0x50000 has a refcount of 2
+qemu-img: error: Cannot decrease refcount entry width to 1 bits: Cluster a=
t offset 0x50000 has a refcount of 2
 No errors were found on the image.
 refcount bits: 16
 No errors were found on the image.
diff --git a/tests/qemu-iotests/113.out b/tests/qemu-iotests/113.out
index 3557e2bbf0..4d3386fa49 100644
--- a/tests/qemu-iotests/113.out
+++ b/tests/qemu-iotests/113.out
@@ -2,15 +2,15 @@ QA output created by 113
=20
 =3D=3D=3D Unsupported image creation in qemu-img create =3D=3D=3D
=20
-qemu-img: nbd://example.com: Format driver 'bochs' does not support image =
creation
+qemu-img: error: nbd://example.com: Format driver 'bochs' does not support=
 image creation
=20
 =3D=3D=3D Unsupported image creation in qemu-img convert =3D=3D=3D
=20
-qemu-img: Format driver 'bochs' does not support image creation
+qemu-img: error: Format driver 'bochs' does not support image creation
=20
 =3D=3D=3D Unsupported format in qemu-img amend =3D=3D=3D
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
-qemu-img: Format driver 'IMGFMT' does not support option amendment
+qemu-img: error: Format driver 'IMGFMT' does not support option amendment
=20
 *** done
diff --git a/tests/qemu-iotests/114.out b/tests/qemu-iotests/114.out
index 67adef37a4..4960bb52cf 100644
--- a/tests/qemu-iotests/114.out
+++ b/tests/qemu-iotests/114.out
@@ -7,7 +7,7 @@ virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
 backing file: TEST_DIR/t.IMGFMT.base
 backing file format: foo
-qemu-io: can't open device TEST_DIR/t.qcow2: Could not open backing file: =
Unknown driver 'foo'
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Could not open backing=
 file: Unknown driver 'foo'
 no file open, try 'help open'
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
index 849b6cc2ef..ce69c388f4 100644
--- a/tests/qemu-iotests/122.out
+++ b/tests/qemu-iotests/122.out
@@ -79,8 +79,8 @@ read 65536/65536 bytes at offset 4194304
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 8388608
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Having a backing file for the target makes no sense when concate=
nating multiple input images
-qemu-img: Having a backing file for the target makes no sense when concate=
nating multiple input images
+qemu-img: error: Having a backing file for the target makes no sense when =
concatenating multiple input images
+qemu-img: error: Having a backing file for the target makes no sense when =
concatenating multiple input images
=20
 =3D=3D=3D Compression with misaligned allocations and image sizes =3D=3D=
=3D
=20
diff --git a/tests/qemu-iotests/133.out b/tests/qemu-iotests/133.out
index 1491ef45a9..076ce0e6b1 100644
--- a/tests/qemu-iotests/133.out
+++ b/tests/qemu-iotests/133.out
@@ -4,18 +4,18 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108=
864 backing_file=3DTEST_DIR/t
=20
 =3D=3D=3D Check that node-name can't be changed =3D=3D=3D
=20
-qemu-io: Cannot change the option 'node-name'
-qemu-io: Cannot change the option 'node-name'
-qemu-io: Cannot change the option 'node-name'
+qemu-io: error: Cannot change the option 'node-name'
+qemu-io: error: Cannot change the option 'node-name'
+qemu-io: error: Cannot change the option 'node-name'
=20
 =3D=3D=3D Check that unchanged node-name is okay =3D=3D=3D
=20
=20
 =3D=3D=3D Check that driver can't be changed =3D=3D=3D
=20
-qemu-io: Cannot change the option 'driver'
-qemu-io: Cannot change the option 'driver'
-qemu-io: Cannot change the option 'driver'
+qemu-io: error: Cannot change the option 'driver'
+qemu-io: error: Cannot change the option 'driver'
+qemu-io: error: Cannot change the option 'driver'
=20
 =3D=3D=3D Check that unchanged driver is okay =3D=3D=3D
=20
@@ -27,16 +27,16 @@ format name: null-co
=20
 =3D=3D=3D Check that mixing -c/-r/-w and their corresponding options is fo=
rbidden =3D=3D=3D
=20
-qemu-io: Cannot set both -r/-w and 'read-only'
-qemu-io: Cannot set both -r/-w and 'read-only'
-qemu-io: Cannot set both -c and the cache options
-qemu-io: Cannot set both -c and the cache options
-qemu-io: Cannot set both -c and the cache options
+qemu-io: error: Cannot set both -r/-w and 'read-only'
+qemu-io: error: Cannot set both -r/-w and 'read-only'
+qemu-io: error: Cannot set both -c and the cache options
+qemu-io: error: Cannot set both -c and the cache options
+qemu-io: error: Cannot set both -c and the cache options
=20
 =3D=3D=3D Check that invalid options are handled correctly =3D=3D=3D
=20
-qemu-io: Parameter 'read-only' expects 'on' or 'off'
-qemu-io: Parameter 'cache.no-flush' expects 'on' or 'off'
-qemu-io: Parameter 'cache.direct' expects 'on' or 'off'
-qemu-io: Parameter 'auto-read-only' expects 'on' or 'off'
+qemu-io: error: Parameter 'read-only' expects 'on' or 'off'
+qemu-io: error: Parameter 'cache.no-flush' expects 'on' or 'off'
+qemu-io: error: Parameter 'cache.direct' expects 'on' or 'off'
+qemu-io: error: Parameter 'auto-read-only' expects 'on' or 'off'
 *** done
diff --git a/tests/qemu-iotests/137.out b/tests/qemu-iotests/137.out
index 86377c80cd..e88776f57d 100644
--- a/tests/qemu-iotests/137.out
+++ b/tests/qemu-iotests/137.out
@@ -15,30 +15,30 @@ read 33554432/33554432 bytes at offset 0
=20
 =3D=3D=3D Try setting some invalid values =3D=3D=3D
=20
-qemu-io: Parameter 'lazy-refcounts' expects 'on' or 'off'
-qemu-io: cache-size, l2-cache-size and refcount-cache-size may not be set =
at the same time
-qemu-io: l2-cache-size may not exceed cache-size
-qemu-io: refcount-cache-size may not exceed cache-size
-qemu-io: L2 cache entry size must be a power of two between 512 and the cl=
uster size (65536)
-qemu-io: L2 cache entry size must be a power of two between 512 and the cl=
uster size (65536)
-qemu-io: Refcount cache size too big
-qemu-io: Conflicting values for qcow2 options 'overlap-check' ('constant')=
 and 'overlap-check.template' ('all')
-qemu-io: Unsupported value 'blubb' for qcow2 option 'overlap-check'. Allow=
ed are any of the following: none, constant, cached, all
-qemu-io: Unsupported value 'blubb' for qcow2 option 'overlap-check'. Allow=
ed are any of the following: none, constant, cached, all
-qemu-io: Cache clean interval too big
+qemu-io: error: Parameter 'lazy-refcounts' expects 'on' or 'off'
+qemu-io: error: cache-size, l2-cache-size and refcount-cache-size may not =
be set at the same time
+qemu-io: error: l2-cache-size may not exceed cache-size
+qemu-io: error: refcount-cache-size may not exceed cache-size
+qemu-io: error: L2 cache entry size must be a power of two between 512 and=
 the cluster size (65536)
+qemu-io: error: L2 cache entry size must be a power of two between 512 and=
 the cluster size (65536)
+qemu-io: error: Refcount cache size too big
+qemu-io: error: Conflicting values for qcow2 options 'overlap-check' ('con=
stant') and 'overlap-check.template' ('all')
+qemu-io: error: Unsupported value 'blubb' for qcow2 option 'overlap-check'=
. Allowed are any of the following: none, constant, cached, all
+qemu-io: error: Unsupported value 'blubb' for qcow2 option 'overlap-check'=
. Allowed are any of the following: none, constant, cached, all
+qemu-io: error: Cache clean interval too big
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D36028797018963968
-qemu-io: L2 cache size too big
+qemu-io: error: L2 cache size too big
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
=20
 =3D=3D=3D Test transaction semantics =3D=3D=3D
=20
-qemu-io: Unsupported value 'blubb' for qcow2 option 'overlap-check'. Allow=
ed are any of the following: none, constant, cached, all
+qemu-io: error: Unsupported value 'blubb' for qcow2 option 'overlap-check'=
. Allowed are any of the following: none, constant, cached, all
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 ./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_IO=
}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"=
 )
 OK: Dirty bit not set
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-qemu-io: Parameter 'lazy-refcounts' expects 'on' or 'off'
+qemu-io: error: Parameter 'lazy-refcounts' expects 'on' or 'off'
 qcow2: Marking image as corrupt: Preventing invalid allocation of L2 table=
 at offset 0; further corruption events will be suppressed
 write failed: Input/output error
 *** done
diff --git a/tests/qemu-iotests/140.out b/tests/qemu-iotests/140.out
index 86b985da75..24cb816f24 100644
--- a/tests/qemu-iotests/140.out
+++ b/tests/qemu-iotests/140.out
@@ -12,7 +12,7 @@ read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 { 'execute': 'eject', 'arguments': { 'device': 'drv' }}
 {"return": {}}
-qemu-io: can't open device nbd+unix:///drv?socket=3DSOCK_DIR/nbd: Requeste=
d export not available
+qemu-io: error: can't open device nbd+unix:///drv?socket=3DSOCK_DIR/nbd: R=
equested export not available
 server reported: export 'drv' not present
 { 'execute': 'quit' }
 {"return": {}}
diff --git a/tests/qemu-iotests/142.out b/tests/qemu-iotests/142.out
index 3667e38def..a63c49044b 100644
--- a/tests/qemu-iotests/142.out
+++ b/tests/qemu-iotests/142.out
@@ -26,7 +26,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) quit
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,cache=3Dinvalid_value
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,cache=3Dinvalid_value: invalid c=
ache option
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,cache=3Dinvalid_value: error: in=
valid cache option
=20
=20
 =3D=3D=3D Check inheritance of cache modes =3D=3D=3D
@@ -71,13 +71,13 @@ cache.writeback=3Doff on none0
     Cache mode:       writeback
=20
 cache.writeback=3Doff on file
-QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,file.cache.writebac=
k=3Doff: Block protocol 'file' doesn't support the option 'cache.writeback'
+QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,file.cache.writebac=
k=3Doff: error: Block protocol 'file' doesn't support the option 'cache.wri=
teback'
=20
 cache.writeback=3Doff on backing
-QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,backing.cache.write=
back=3Doff: Could not open backing file: Block format 'qcow2' does not supp=
ort the option 'cache.writeback'
+QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,backing.cache.write=
back=3Doff: error: Could not open backing file: Block format 'qcow2' does n=
ot support the option 'cache.writeback'
=20
 cache.writeback=3Doff on backing-file
-QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,backing.file.cache.=
writeback=3Doff: Could not open backing file: Block protocol 'file' doesn't=
 support the option 'cache.writeback'
+QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,backing.file.cache.=
writeback=3Doff: error: Could not open backing file: Block protocol 'file' =
doesn't support the option 'cache.writeback'
=20
=20
 cache.no-flush=3Don on none0
@@ -147,13 +147,13 @@ cache.writeback=3Doff on none0
     Cache mode:       writeback
=20
 cache.writeback=3Doff on file
-QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,file.cache.writebac=
k=3Doff: Block protocol 'file' doesn't support the option 'cache.writeback'
+QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,file.cache.writebac=
k=3Doff: error: Block protocol 'file' doesn't support the option 'cache.wri=
teback'
=20
 cache.writeback=3Doff on backing
-QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,backing.cache.write=
back=3Doff: Could not open backing file: Block format 'qcow2' does not supp=
ort the option 'cache.writeback'
+QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,backing.cache.write=
back=3Doff: error: Could not open backing file: Block format 'qcow2' does n=
ot support the option 'cache.writeback'
=20
 cache.writeback=3Doff on backing-file
-QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,backing.file.cache.=
writeback=3Doff: Could not open backing file: Block protocol 'file' doesn't=
 support the option 'cache.writeback'
+QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,backing.file.cache.=
writeback=3Doff: error: Could not open backing file: Block protocol 'file' =
doesn't support the option 'cache.writeback'
=20
=20
 cache.no-flush=3Don on none0
@@ -223,13 +223,13 @@ cache.writeback=3Doff on none0
     Cache mode:       writeback, direct
=20
 cache.writeback=3Doff on file
-QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,file.cache.writebac=
k=3Doff: Block protocol 'file' doesn't support the option 'cache.writeback'
+QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,file.cache.writebac=
k=3Doff: error: Block protocol 'file' doesn't support the option 'cache.wri=
teback'
=20
 cache.writeback=3Doff on backing
-QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,backing.cache.write=
back=3Doff: Could not open backing file: Block format 'qcow2' does not supp=
ort the option 'cache.writeback'
+QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,backing.cache.write=
back=3Doff: error: Could not open backing file: Block format 'qcow2' does n=
ot support the option 'cache.writeback'
=20
 cache.writeback=3Doff on backing-file
-QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,backing.file.cache.=
writeback=3Doff: Could not open backing file: Block protocol 'file' doesn't=
 support the option 'cache.writeback'
+QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,backing.file.cache.=
writeback=3Doff: error: Could not open backing file: Block protocol 'file' =
doesn't support the option 'cache.writeback'
=20
=20
 cache.no-flush=3Don on none0
@@ -299,13 +299,13 @@ cache.writeback=3Doff on none0
     Cache mode:       writeback, direct
=20
 cache.writeback=3Doff on file
-QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,file.cache.writebac=
k=3Doff: Block protocol 'file' doesn't support the option 'cache.writeback'
+QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,file.cache.writebac=
k=3Doff: error: Block protocol 'file' doesn't support the option 'cache.wri=
teback'
=20
 cache.writeback=3Doff on backing
-QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,backing.cache.write=
back=3Doff: Could not open backing file: Block format 'qcow2' does not supp=
ort the option 'cache.writeback'
+QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,backing.cache.write=
back=3Doff: error: Could not open backing file: Block format 'qcow2' does n=
ot support the option 'cache.writeback'
=20
 cache.writeback=3Doff on backing-file
-QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,backing.file.cache.=
writeback=3Doff: Could not open backing file: Block protocol 'file' doesn't=
 support the option 'cache.writeback'
+QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,backing.file.cache.=
writeback=3Doff: error: Could not open backing file: Block protocol 'file' =
doesn't support the option 'cache.writeback'
=20
=20
 cache.no-flush=3Don on none0
@@ -375,13 +375,13 @@ cache.writeback=3Doff on none0
     Cache mode:       writeback
=20
 cache.writeback=3Doff on file
-QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,file.cache.writebac=
k=3Doff: Block protocol 'file' doesn't support the option 'cache.writeback'
+QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,file.cache.writebac=
k=3Doff: error: Block protocol 'file' doesn't support the option 'cache.wri=
teback'
=20
 cache.writeback=3Doff on backing
-QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,backing.cache.write=
back=3Doff: Could not open backing file: Block format 'qcow2' does not supp=
ort the option 'cache.writeback'
+QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,backing.cache.write=
back=3Doff: error: Could not open backing file: Block format 'qcow2' does n=
ot support the option 'cache.writeback'
=20
 cache.writeback=3Doff on backing-file
-QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,backing.file.cache.=
writeback=3Doff: Could not open backing file: Block protocol 'file' doesn't=
 support the option 'cache.writeback'
+QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,backing.file.cache.=
writeback=3Doff: error: Could not open backing file: Block protocol 'file' =
doesn't support the option 'cache.writeback'
=20
=20
 cache.no-flush=3Don on none0
@@ -704,13 +704,13 @@ cache.writeback=3Doff on none0
     Cache mode:       writeback, direct
=20
 cache.writeback=3Doff on file
-QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,file.cache.writebac=
k=3Doff: Block protocol 'file' doesn't support the option 'cache.writeback'
+QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,file.cache.writebac=
k=3Doff: error: Block protocol 'file' doesn't support the option 'cache.wri=
teback'
=20
 cache.writeback=3Doff on backing
-QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,backing.cache.write=
back=3Doff: Could not open backing file: Block format 'qcow2' does not supp=
ort the option 'cache.writeback'
+QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,backing.cache.write=
back=3Doff: error: Could not open backing file: Block format 'qcow2' does n=
ot support the option 'cache.writeback'
=20
 cache.writeback=3Doff on backing-file
-QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,backing.file.cache.=
writeback=3Doff: Could not open backing file: Block protocol 'file' doesn't=
 support the option 'cache.writeback'
+QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,backing.file.filename=
=3DTEST_DIR/t.qcow2.base,node-name=3Dimage,backing.node-name=3Dbacking,back=
ing.file.node-name=3Dbacking-file,file.node-name=3Dfile,backing.file.cache.=
writeback=3Doff: error: Could not open backing file: Block protocol 'file' =
doesn't support the option 'cache.writeback'
=20
=20
 cache.no-flush=3Don on none0
diff --git a/tests/qemu-iotests/143.out b/tests/qemu-iotests/143.out
index 1f4001c601..8db19060f6 100644
--- a/tests/qemu-iotests/143.out
+++ b/tests/qemu-iotests/143.out
@@ -3,7 +3,7 @@ QA output created by 143
 {"return": {}}
 { 'execute': 'nbd-server-start', 'arguments': { 'addr': { 'type': 'unix', =
'data': { 'path': 'SOCK_DIR/nbd' }}}}
 {"return": {}}
-qemu-io: can't open device nbd+unix:///no_such_export?socket=3DSOCK_DIR/nb=
d: Requested export not available
+qemu-io: error: can't open device nbd+unix:///no_such_export?socket=3DSOCK=
_DIR/nbd: Requested export not available
 server reported: export 'no_such_export' not present
 { 'execute': 'quit' }
 {"return": {}}
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index f7464dd8d3..99e7659899 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -1,6 +1,6 @@
 QA output created by 153
 =3D=3D readonly=3Doff,force-share=3Don should be rejected =3D=3D
-QEMU_PROG: -drive if=3Dnone,file=3Dnull-co://,readonly=3Doff,force-share=
=3Don: force-share=3Don can only be used with read-only images
+QEMU_PROG: -drive if=3Dnone,file=3Dnull-co://,readonly=3Doff,force-share=
=3Don: error: force-share=3Don can only be used with read-only images
=20
 =3D=3D Creating base image =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D33554432
@@ -11,11 +11,11 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D335=
54432 backing_file=3DTEST_DIR/t
 =3D=3D Launching QEMU, opts: '' =3D=3D
=20
 =3D=3D Launching another QEMU, opts: '' =3D=3D
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,: Failed to get "write=
" lock
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,: error: Failed to get=
 "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 =3D=3D Launching another QEMU, opts: 'read-only=3Don' =3D=3D
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,read-only=3Don: Failed=
 to get shared "write" lock
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,read-only=3Don: error:=
 Failed to get shared "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 =3D=3D Launching another QEMU, opts: 'read-only=3Don,force-share=3Don' =3D=
=3D
@@ -23,89 +23,89 @@ Is another process using the image [TEST_DIR/t.qcow2]?
 =3D=3D Running utility commands  =3D=3D
=20
 _qemu_io_wrapper -c read 0 512 TEST_DIR/t.qcow2
-qemu-io: can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Failed to get "write" =
lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 _qemu_io_wrapper -r -c read 0 512 TEST_DIR/t.qcow2
-qemu-io: can't open device TEST_DIR/t.qcow2: Failed to get shared "write" =
lock
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Failed to get shared "=
write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 _qemu_io_wrapper -c open  TEST_DIR/t.qcow2 -c read 0 512
-qemu-io: can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Failed to get "write" =
lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 no file open, try 'help open'
=20
 _qemu_io_wrapper -c open -r  TEST_DIR/t.qcow2 -c read 0 512
-qemu-io: can't open device TEST_DIR/t.qcow2: Failed to get shared "write" =
lock
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Failed to get shared "=
write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 no file open, try 'help open'
=20
 _qemu_img_wrapper info TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" =
lock
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "=
write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 _qemu_img_wrapper check TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" =
lock
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "=
write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 _qemu_img_wrapper compare TEST_DIR/t.qcow2 TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" =
lock
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "=
write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 _qemu_img_wrapper map TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" =
lock
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "=
write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 _qemu_img_wrapper amend -o  TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" =
lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 _qemu_img_wrapper commit TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" =
lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 _qemu_img_wrapper resize TEST_DIR/t.qcow2 32M
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" =
lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 _qemu_img_wrapper rebase TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" =
lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 _qemu_img_wrapper snapshot -l TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" =
lock
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "=
write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 _qemu_img_wrapper convert TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.convert
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" =
lock
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "=
write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 _qemu_img_wrapper dd if=3DTEST_DIR/t.qcow2 of=3DTEST_DIR/t.qcow2.convert b=
s=3D512 count=3D1
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" =
lock
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "=
write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 _qemu_img_wrapper bench -c 1 TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "write" =
lock
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2': Failed to get shared "=
write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 _qemu_img_wrapper bench -w -c 1 TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" =
lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 _qemu_img_wrapper create -f qcow2 TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.bas=
e
-qemu-img: TEST_DIR/t.qcow2: Failed to get "write" lock
+qemu-img: error: TEST_DIR/t.qcow2: Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 file format: IMGFMT
=20
 =3D=3D Running utility commands -U =3D=3D
=20
 _qemu_io_wrapper -U -c read 0 512 TEST_DIR/t.qcow2
-qemu-io: can't open device TEST_DIR/t.qcow2: force-share=3Don can only be =
used with read-only images
+qemu-io: error: can't open device TEST_DIR/t.qcow2: force-share=3Don can o=
nly be used with read-only images
=20
 _qemu_io_wrapper -U -r -c read 0 512 TEST_DIR/t.qcow2
=20
 _qemu_io_wrapper -c open -U TEST_DIR/t.qcow2 -c read 0 512
-qemu-io: can't open device TEST_DIR/t.qcow2: force-share=3Don can only be =
used with read-only images
+qemu-io: error: can't open device TEST_DIR/t.qcow2: force-share=3Don can o=
nly be used with read-only images
 no file open, try 'help open'
=20
 _qemu_io_wrapper -c open -r -U TEST_DIR/t.qcow2 -c read 0 512
@@ -119,19 +119,19 @@ _qemu_img_wrapper compare -U TEST_DIR/t.qcow2 TEST_DI=
R/t.qcow2
 _qemu_img_wrapper map -U TEST_DIR/t.qcow2
=20
 _qemu_img_wrapper amend -o  -U TEST_DIR/t.qcow2
-qemu-img: unrecognized option '-U'
+qemu-img: error: unrecognized option '-U'
 Try 'qemu-img --help' for more information
=20
 _qemu_img_wrapper commit -U TEST_DIR/t.qcow2
-qemu-img: unrecognized option '-U'
+qemu-img: error: unrecognized option '-U'
 Try 'qemu-img --help' for more information
=20
 _qemu_img_wrapper resize -U TEST_DIR/t.qcow2 32M
-qemu-img: unrecognized option '-U'
+qemu-img: error: unrecognized option '-U'
 Try 'qemu-img --help' for more information
=20
 _qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" =
lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 _qemu_img_wrapper snapshot -l -U TEST_DIR/t.qcow2
@@ -143,7 +143,7 @@ _qemu_img_wrapper dd -U if=3DTEST_DIR/t.qcow2 of=3DTEST=
_DIR/t.qcow2.convert bs=3D512 c
 _qemu_img_wrapper bench -U -c 1 TEST_DIR/t.qcow2
=20
 _qemu_img_wrapper bench -U -w -c 1 TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': force-share=3Don can only be =
used with read-only images
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2': force-share=3Don can o=
nly be used with read-only images
 { 'execute': 'quit' }
=20
 Round done
@@ -157,7 +157,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D335=
54432 backing_file=3DTEST_DIR/t
 =3D=3D Launching QEMU, opts: 'read-only=3Don' =3D=3D
=20
 =3D=3D Launching another QEMU, opts: '' =3D=3D
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,: Failed to get "write=
" lock
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,: error: Failed to get=
 "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 =3D=3D Launching another QEMU, opts: 'read-only=3Don' =3D=3D
@@ -167,13 +167,13 @@ Is another process using the image [TEST_DIR/t.qcow2]=
?
 =3D=3D Running utility commands  =3D=3D
=20
 _qemu_io_wrapper -c read 0 512 TEST_DIR/t.qcow2
-qemu-io: can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Failed to get "write" =
lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 _qemu_io_wrapper -r -c read 0 512 TEST_DIR/t.qcow2
=20
 _qemu_io_wrapper -c open  TEST_DIR/t.qcow2 -c read 0 512
-qemu-io: can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Failed to get "write" =
lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 no file open, try 'help open'
=20
@@ -188,19 +188,19 @@ _qemu_img_wrapper compare TEST_DIR/t.qcow2 TEST_DIR/t=
.qcow2
 _qemu_img_wrapper map TEST_DIR/t.qcow2
=20
 _qemu_img_wrapper amend -o  TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" =
lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 _qemu_img_wrapper commit TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" =
lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 _qemu_img_wrapper resize TEST_DIR/t.qcow2 32M
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" =
lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 _qemu_img_wrapper rebase TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" =
lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 _qemu_img_wrapper snapshot -l TEST_DIR/t.qcow2
@@ -212,23 +212,23 @@ _qemu_img_wrapper dd if=3DTEST_DIR/t.qcow2 of=3DTEST_=
DIR/t.qcow2.convert bs=3D512 coun
 _qemu_img_wrapper bench -c 1 TEST_DIR/t.qcow2
=20
 _qemu_img_wrapper bench -w -c 1 TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" =
lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 _qemu_img_wrapper create -f qcow2 TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.bas=
e
-qemu-img: TEST_DIR/t.qcow2: Failed to get "write" lock
+qemu-img: error: TEST_DIR/t.qcow2: Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 file format: IMGFMT
=20
 =3D=3D Running utility commands -U =3D=3D
=20
 _qemu_io_wrapper -U -c read 0 512 TEST_DIR/t.qcow2
-qemu-io: can't open device TEST_DIR/t.qcow2: force-share=3Don can only be =
used with read-only images
+qemu-io: error: can't open device TEST_DIR/t.qcow2: force-share=3Don can o=
nly be used with read-only images
=20
 _qemu_io_wrapper -U -r -c read 0 512 TEST_DIR/t.qcow2
=20
 _qemu_io_wrapper -c open -U TEST_DIR/t.qcow2 -c read 0 512
-qemu-io: can't open device TEST_DIR/t.qcow2: force-share=3Don can only be =
used with read-only images
+qemu-io: error: can't open device TEST_DIR/t.qcow2: force-share=3Don can o=
nly be used with read-only images
 no file open, try 'help open'
=20
 _qemu_io_wrapper -c open -r -U TEST_DIR/t.qcow2 -c read 0 512
@@ -242,19 +242,19 @@ _qemu_img_wrapper compare -U TEST_DIR/t.qcow2 TEST_DI=
R/t.qcow2
 _qemu_img_wrapper map -U TEST_DIR/t.qcow2
=20
 _qemu_img_wrapper amend -o  -U TEST_DIR/t.qcow2
-qemu-img: unrecognized option '-U'
+qemu-img: error: unrecognized option '-U'
 Try 'qemu-img --help' for more information
=20
 _qemu_img_wrapper commit -U TEST_DIR/t.qcow2
-qemu-img: unrecognized option '-U'
+qemu-img: error: unrecognized option '-U'
 Try 'qemu-img --help' for more information
=20
 _qemu_img_wrapper resize -U TEST_DIR/t.qcow2 32M
-qemu-img: unrecognized option '-U'
+qemu-img: error: unrecognized option '-U'
 Try 'qemu-img --help' for more information
=20
 _qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
-qemu-img: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" lock
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2': Failed to get "write" =
lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 _qemu_img_wrapper snapshot -l -U TEST_DIR/t.qcow2
@@ -266,7 +266,7 @@ _qemu_img_wrapper dd -U if=3DTEST_DIR/t.qcow2 of=3DTEST=
_DIR/t.qcow2.convert bs=3D512 c
 _qemu_img_wrapper bench -U -c 1 TEST_DIR/t.qcow2
=20
 _qemu_img_wrapper bench -U -w -c 1 TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': force-share=3Don can only be =
used with read-only images
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2': force-share=3Don can o=
nly be used with read-only images
 { 'execute': 'quit' }
=20
 Round done
@@ -327,12 +327,12 @@ file format: IMGFMT
 =3D=3D Running utility commands -U =3D=3D
=20
 _qemu_io_wrapper -U -c read 0 512 TEST_DIR/t.qcow2
-qemu-io: can't open device TEST_DIR/t.qcow2: force-share=3Don can only be =
used with read-only images
+qemu-io: error: can't open device TEST_DIR/t.qcow2: force-share=3Don can o=
nly be used with read-only images
=20
 _qemu_io_wrapper -U -r -c read 0 512 TEST_DIR/t.qcow2
=20
 _qemu_io_wrapper -c open -U TEST_DIR/t.qcow2 -c read 0 512
-qemu-io: can't open device TEST_DIR/t.qcow2: force-share=3Don can only be =
used with read-only images
+qemu-io: error: can't open device TEST_DIR/t.qcow2: force-share=3Don can o=
nly be used with read-only images
 no file open, try 'help open'
=20
 _qemu_io_wrapper -c open -r -U TEST_DIR/t.qcow2 -c read 0 512
@@ -346,15 +346,15 @@ _qemu_img_wrapper compare -U TEST_DIR/t.qcow2 TEST_DI=
R/t.qcow2
 _qemu_img_wrapper map -U TEST_DIR/t.qcow2
=20
 _qemu_img_wrapper amend -o  -U TEST_DIR/t.qcow2
-qemu-img: unrecognized option '-U'
+qemu-img: error: unrecognized option '-U'
 Try 'qemu-img --help' for more information
=20
 _qemu_img_wrapper commit -U TEST_DIR/t.qcow2
-qemu-img: unrecognized option '-U'
+qemu-img: error: unrecognized option '-U'
 Try 'qemu-img --help' for more information
=20
 _qemu_img_wrapper resize -U TEST_DIR/t.qcow2 32M
-qemu-img: unrecognized option '-U'
+qemu-img: error: unrecognized option '-U'
 Try 'qemu-img --help' for more information
=20
 _qemu_img_wrapper rebase -U TEST_DIR/t.qcow2 -b TEST_DIR/t.qcow2.base
@@ -368,23 +368,23 @@ _qemu_img_wrapper dd -U if=3DTEST_DIR/t.qcow2 of=3DTE=
ST_DIR/t.qcow2.convert bs=3D512 c
 _qemu_img_wrapper bench -U -c 1 TEST_DIR/t.qcow2
=20
 _qemu_img_wrapper bench -U -w -c 1 TEST_DIR/t.qcow2
-qemu-img: Could not open 'TEST_DIR/t.qcow2': force-share=3Don can only be =
used with read-only images
+qemu-img: error: Could not open 'TEST_DIR/t.qcow2': force-share=3Don can o=
nly be used with read-only images
 { 'execute': 'quit' }
=20
 Round done
=20
 =3D=3D Two devices with the same image (read-only=3Doff - read-only=3Doff)=
 =3D=3D
-QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,read-only=3Doff: Faile=
d to get "write" lock
+QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,read-only=3Doff: error=
: Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 =3D=3D Two devices with the same image (read-only=3Doff - read-only=3Don) =
=3D=3D
-QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,read-only=3Don: Failed=
 to get shared "write" lock
+QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,read-only=3Don: error:=
 Failed to get shared "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 =3D=3D Two devices with the same image (read-only=3Doff - read-only=3Don,f=
orce-share=3Don) =3D=3D
=20
 =3D=3D Two devices with the same image (read-only=3Don - read-only=3Doff) =
=3D=3D
-QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,read-only=3Doff: Faile=
d to get "write" lock
+QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2,read-only=3Doff: error=
: Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 =3D=3D Two devices with the same image (read-only=3Don - read-only=3Don) =
=3D=3D
@@ -405,13 +405,13 @@ Formatting 'TEST_DIR/t.IMGFMT.c', fmt=3DIMGFMT size=
=3D33554432 backing_file=3DTEST_DIR
 =3D=3D Two devices sharing the same file in backing chain =3D=3D
=20
 =3D=3D Backing image also as an active device =3D=3D
-QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2: Failed to get "write"=
 lock
+QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2: error: Failed to get =
"write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 =3D=3D Backing image also as an active device (ro) =3D=3D
=20
 =3D=3D Symbolic link =3D=3D
-QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2: Failed to get "write"=
 lock
+QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2: error: Failed to get =
"write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 =3D=3D Active commit to intermediate layer should work when base in use =
=3D=3D
@@ -426,7 +426,7 @@ Adding drive
 {"return": "OKrn"}
=20
 _qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
-qemu-io: can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Failed to get "write" =
lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 Creating overlay with qemu-img when the guest is running should be allowed
=20
@@ -447,7 +447,7 @@ _qemu_img_wrapper info TEST_DIR/t.qcow2
 {"return": ""}
=20
 _qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
-qemu-io: can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Failed to get "write" =
lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 Closing the other
 { 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'driv=
e_del d1' } }
@@ -464,10 +464,10 @@ virtual size: 1 GiB (1073741824 bytes)
 disk size: unavailable
=20
 Conflict:
-qemu-img: --force-share/-U conflicts with image options
+qemu-img: error: --force-share/-U conflicts with image options
=20
 No conflict:
=20
 Conflict:
-qemu-io: -U conflicts with image options
+qemu-io: error: -U conflicts with image options
 *** done
diff --git a/tests/qemu-iotests/162.out b/tests/qemu-iotests/162.out
index 5a00d36d17..dc73df631c 100644
--- a/tests/qemu-iotests/162.out
+++ b/tests/qemu-iotests/162.out
@@ -1,15 +1,15 @@
 QA output created by 162
=20
 =3D=3D=3D NBD =3D=3D=3D
-qemu-img: Could not open 'json:{"driver": "nbd", "host": -1}': address res=
olution failed for -1:10809: Name or service not known
+qemu-img: error: Could not open 'json:{"driver": "nbd", "host": -1}': addr=
ess resolution failed for -1:10809: Name or service not known
 image: nbd://localhost:PORT
 image: nbd+unix://?socket=3D42
=20
 =3D=3D=3D SSH =3D=3D=3D
-qemu-img: Could not open 'json:{"driver": "ssh", "host": "localhost", "por=
t": "0", "path": "/foo"}': Failed to connect socket: Connection refused
-qemu-img: Could not open 'driver=3Dssh,host=3Dlocalhost,port=3D0,path=3D/f=
oo': Failed to connect socket: Connection refused
-qemu-img: Could not open 'json:{"driver": "ssh", "host": "localhost", "por=
t": 0.42, "path": "/foo"}': Parameter 'port' expects a number
-qemu-img: Could not open 'driver=3Dssh,host=3Dlocalhost,port=3D0.42,path=
=3D/foo': Parameter 'port' expects a number
+qemu-img: error: Could not open 'json:{"driver": "ssh", "host": "localhost=
", "port": "0", "path": "/foo"}': Failed to connect socket: Connection refu=
sed
+qemu-img: error: Could not open 'driver=3Dssh,host=3Dlocalhost,port=3D0,pa=
th=3D/foo': Failed to connect socket: Connection refused
+qemu-img: error: Could not open 'json:{"driver": "ssh", "host": "localhost=
", "port": 0.42, "path": "/foo"}': Parameter 'port' expects a number
+qemu-img: error: Could not open 'driver=3Dssh,host=3Dlocalhost,port=3D0.42=
,path=3D/foo': Parameter 'port' expects a number
=20
 =3D=3D=3D blkdebug =3D=3D=3D
 image: blkdebug:42:null-co://
diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
index 7abbe82427..6d07b96028 100644
--- a/tests/qemu-iotests/172.out
+++ b/tests/qemu-iotests/172.out
@@ -724,10 +724,10 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=3Dnone,file=
=3DTEST_DIR/t.qcow2.2 -device fl
                 drive-type =3D "144"
=20
 Testing: -fda TEST_DIR/t.qcow2 -drive if=3Dnone,file=3DTEST_DIR/t.qcow2.2 =
-device floppy,drive=3Dnone0,unit=3D0
-QEMU_PROG: -device floppy,drive=3Dnone0,unit=3D0: Floppy unit 0 is in use
+QEMU_PROG: -device floppy,drive=3Dnone0,unit=3D0: error: Floppy unit 0 is =
in use
=20
 Testing: -fdb TEST_DIR/t.qcow2 -drive if=3Dnone,file=3DTEST_DIR/t.qcow2.2 =
-device floppy,drive=3Dnone0,unit=3D1
-QEMU_PROG: -device floppy,drive=3Dnone0,unit=3D1: Floppy unit 1 is in use
+QEMU_PROG: -device floppy,drive=3Dnone0,unit=3D1: error: Floppy unit 1 is =
in use
=20
=20
 =3D=3D=3D Mixing -drive and -device =3D=3D=3D
@@ -809,7 +809,7 @@ Testing: -drive if=3Dfloppy,file=3DTEST_DIR/t.qcow2 -dr=
ive if=3Dnone,file=3DTEST_DIR/t.q
                 drive-type =3D "144"
=20
 Testing: -drive if=3Dfloppy,file=3DTEST_DIR/t.qcow2 -drive if=3Dnone,file=
=3DTEST_DIR/t.qcow2.2 -device floppy,drive=3Dnone0,unit=3D0
-QEMU_PROG: -device floppy,drive=3Dnone0,unit=3D0: Floppy unit 0 is in use
+QEMU_PROG: -device floppy,drive=3Dnone0,unit=3D0: error: Floppy unit 0 is =
in use
=20
=20
 =3D=3D=3D Mixing -global and -device =3D=3D=3D
@@ -967,16 +967,16 @@ Testing: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2 -dr=
ive if=3Dnone,file=3DTEST_DIR/t.qco
                 drive-type =3D "144"
=20
 Testing: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2 -drive if=3Dnone,file=3D=
TEST_DIR/t.qcow2.2 -global isa-fdc.driveA=3Dnone0 -device floppy,drive=3Dno=
ne1,unit=3D0
-QEMU_PROG: -device floppy,drive=3Dnone1,unit=3D0: Floppy unit 0 is in use
+QEMU_PROG: -device floppy,drive=3Dnone1,unit=3D0: error: Floppy unit 0 is =
in use
=20
 Testing: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2 -drive if=3Dnone,file=3D=
TEST_DIR/t.qcow2.2 -global isa-fdc.driveB=3Dnone0 -device floppy,drive=3Dno=
ne1,unit=3D1
-QEMU_PROG: -device floppy,drive=3Dnone1,unit=3D1: Floppy unit 1 is in use
+QEMU_PROG: -device floppy,drive=3Dnone1,unit=3D1: error: Floppy unit 1 is =
in use
=20
=20
 =3D=3D=3D Too many floppy drives =3D=3D=3D
=20
 Testing: -drive if=3Dfloppy,file=3DTEST_DIR/t.qcow2 -drive if=3Dnone,file=
=3DTEST_DIR/t.qcow2.2 -drive if=3Dnone,file=3DTEST_DIR/t.qcow2.3 -global is=
a-fdc.driveB=3Dnone0 -device floppy,drive=3Dnone1
-QEMU_PROG: -device floppy,drive=3Dnone1: Can't create floppy unit 2, bus s=
upports only 2 units
+QEMU_PROG: -device floppy,drive=3Dnone1: error: Can't create floppy unit 2=
, bus supports only 2 units
=20
=20
 =3D=3D=3D Creating an empty drive with anonymous BB =3D=3D=3D
@@ -1204,10 +1204,10 @@ Testing: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2 -=
device floppy,drive=3Dnone0,physica
                 drive-type =3D "144"
=20
 Testing: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2 -device floppy,drive=3Dn=
one0,logical_block_size=3D4096
-QEMU_PROG: -device floppy,drive=3Dnone0,logical_block_size=3D4096: Physica=
l and logical block size must be 512 for floppy
+QEMU_PROG: -device floppy,drive=3Dnone0,logical_block_size=3D4096: error: =
Physical and logical block size must be 512 for floppy
=20
 Testing: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2 -device floppy,drive=3Dn=
one0,physical_block_size=3D1024
-QEMU_PROG: -device floppy,drive=3Dnone0,physical_block_size=3D1024: Physic=
al and logical block size must be 512 for floppy
+QEMU_PROG: -device floppy,drive=3Dnone0,physical_block_size=3D1024: error:=
 Physical and logical block size must be 512 for floppy
=20
=20
 =3D=3D=3D Writethrough caching =3D=3D=3D
diff --git a/tests/qemu-iotests/178.out.qcow2 b/tests/qemu-iotests/178.out.=
qcow2
index 9e7d8c44df..1131c41853 100644
--- a/tests/qemu-iotests/178.out.qcow2
+++ b/tests/qemu-iotests/178.out.qcow2
@@ -2,19 +2,19 @@ QA output created by 178
 =3D=3D Input validation =3D=3D
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
-qemu-img: Either --size N or one filename must be specified.
-qemu-img: --size N cannot be used together with a filename.
-qemu-img: At most one filename argument is allowed.
-qemu-img: --object, --image-opts, -f, and -l require a filename argument.
-qemu-img: --object, --image-opts, -f, and -l require a filename argument.
-qemu-img: --object, --image-opts, -f, and -l require a filename argument.
-qemu-img: --object, --image-opts, -f, and -l require a filename argument.
-qemu-img: Invalid option list: ,
-qemu-img: Invalid parameter 'snapshot.foo'
-qemu-img: Failed in parsing snapshot param 'snapshot.foo'
-qemu-img: --output must be used with human or json as argument.
-qemu-img: Image size must be less than 8 EiB!
-qemu-img: Unknown file format 'foo'
+qemu-img: error: Either --size N or one filename must be specified.
+qemu-img: error: --size N cannot be used together with a filename.
+qemu-img: error: At most one filename argument is allowed.
+qemu-img: error: --object, --image-opts, -f, and -l require a filename arg=
ument.
+qemu-img: error: --object, --image-opts, -f, and -l require a filename arg=
ument.
+qemu-img: error: --object, --image-opts, -f, and -l require a filename arg=
ument.
+qemu-img: error: --object, --image-opts, -f, and -l require a filename arg=
ument.
+qemu-img: error: Invalid option list: ,
+qemu-img: error: Invalid parameter 'snapshot.foo'
+qemu-img: error: Failed in parsing snapshot param 'snapshot.foo'
+qemu-img: error: --output must be used with human or json as argument.
+qemu-img: error: Image size must be less than 8 EiB!
+qemu-img: error: Unknown file format 'foo'
=20
 =3D=3D Size calculation for a new file (human) =3D=3D
=20
@@ -30,7 +30,7 @@ required size: 168034304
 fully allocated size: 1099679662080
 required size: 343650009088
 fully allocated size: 2252143463694336
-qemu-img: The image size is too large (try using a larger cluster size)
+qemu-img: error: The image size is too large (try using a larger cluster s=
ize)
=20
 =3D=3D Empty qcow2 input image (human) =3D=3D
=20
@@ -167,7 +167,7 @@ converted image file size in bytes: 8716288
     "required": 343650009088,
     "fully-allocated": 2252143463694336
 }
-qemu-img: The image size is too large (try using a larger cluster size)
+qemu-img: error: The image size is too large (try using a larger cluster s=
ize)
=20
 =3D=3D Empty qcow2 input image (json) =3D=3D
=20
diff --git a/tests/qemu-iotests/178.out.raw b/tests/qemu-iotests/178.out.ra=
w
index 6478365905..bfda347e59 100644
--- a/tests/qemu-iotests/178.out.raw
+++ b/tests/qemu-iotests/178.out.raw
@@ -2,19 +2,19 @@ QA output created by 178
 =3D=3D Input validation =3D=3D
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
-qemu-img: Either --size N or one filename must be specified.
-qemu-img: --size N cannot be used together with a filename.
-qemu-img: At most one filename argument is allowed.
-qemu-img: --object, --image-opts, -f, and -l require a filename argument.
-qemu-img: --object, --image-opts, -f, and -l require a filename argument.
-qemu-img: --object, --image-opts, -f, and -l require a filename argument.
-qemu-img: --object, --image-opts, -f, and -l require a filename argument.
-qemu-img: Invalid option list: ,
-qemu-img: Invalid parameter 'snapshot.foo'
-qemu-img: Failed in parsing snapshot param 'snapshot.foo'
-qemu-img: --output must be used with human or json as argument.
-qemu-img: Image size must be less than 8 EiB!
-qemu-img: Unknown file format 'foo'
+qemu-img: error: Either --size N or one filename must be specified.
+qemu-img: error: --size N cannot be used together with a filename.
+qemu-img: error: At most one filename argument is allowed.
+qemu-img: error: --object, --image-opts, -f, and -l require a filename arg=
ument.
+qemu-img: error: --object, --image-opts, -f, and -l require a filename arg=
ument.
+qemu-img: error: --object, --image-opts, -f, and -l require a filename arg=
ument.
+qemu-img: error: --object, --image-opts, -f, and -l require a filename arg=
ument.
+qemu-img: error: Invalid option list: ,
+qemu-img: error: Invalid parameter 'snapshot.foo'
+qemu-img: error: Failed in parsing snapshot param 'snapshot.foo'
+qemu-img: error: --output must be used with human or json as argument.
+qemu-img: error: Image size must be less than 8 EiB!
+qemu-img: error: Unknown file format 'foo'
=20
 =3D=3D Size calculation for a new file (human) =3D=3D
=20
diff --git a/tests/qemu-iotests/182.out b/tests/qemu-iotests/182.out
index a8eea166c3..0b3d4b524f 100644
--- a/tests/qemu-iotests/182.out
+++ b/tests/qemu-iotests/182.out
@@ -3,7 +3,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D3355443=
2
 Starting QEMU
=20
 Starting a second QEMU using the same image should fail
-QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,id=3Ddrive0,file.locki=
ng=3Don: Failed to get "write" lock
+QEMU_PROG: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,id=3Ddrive0,file.locki=
ng=3Don: error: Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
=20
 =3D=3D=3D Testing reopen =3D=3D=3D
diff --git a/tests/qemu-iotests/187.out b/tests/qemu-iotests/187.out
index 86203d8abc..17beda25d0 100644
--- a/tests/qemu-iotests/187.out
+++ b/tests/qemu-iotests/187.out
@@ -3,16 +3,16 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108=
864
=20
 Start from read-only
=20
-qemu-io: Block node is read-only
+qemu-io: error: Block node is read-only
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: Block node is read-only
+qemu-io: error: Block node is read-only
=20
 Start from read-write
=20
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: Block node is read-only
+qemu-io: error: Block node is read-only
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
diff --git a/tests/qemu-iotests/188.out b/tests/qemu-iotests/188.out
index c568ef3701..44cff331f0 100644
--- a/tests/qemu-iotests/188.out
+++ b/tests/qemu-iotests/188.out
@@ -14,7 +14,7 @@ read 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 =3D=3D verify open failure with wrong password =3D=3D
-qemu-io: can't open: Invalid password, cannot unlock any keyslot
+qemu-io: error: can't open: Invalid password, cannot unlock any keyslot
=20
 =3D=3D verify that has_zero_init returns false when preallocating =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=3DIMGFMT size=3D16777216
diff --git a/tests/qemu-iotests/197.out b/tests/qemu-iotests/197.out
index 7ca46be6e4..411c14e2db 100644
--- a/tests/qemu-iotests/197.out
+++ b/tests/qemu-iotests/197.out
@@ -16,7 +16,7 @@ read 2147483136/2147483136 bytes at offset 1024
 2 GiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 1024/1024 bytes at offset 3221226496
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: can't open device TEST_DIR/t.wrap.qcow2: Can't use copy-on-read o=
n read-only device
+qemu-io: error: can't open device TEST_DIR/t.wrap.qcow2: Can't use copy-on=
-read on read-only device
 2 GiB (0x80010000) bytes     allocated at offset 0 bytes (0x0)
 1023.938 MiB (0x3fff0000) bytes not allocated at offset 2 GiB (0x80010000)
 64 KiB (0x10000) bytes     allocated at offset 3 GiB (0xc0000000)
diff --git a/tests/qemu-iotests/205 b/tests/qemu-iotests/205
index 4bb2c21e8b..9e80fc7d15 100755
--- a/tests/qemu-iotests/205
+++ b/tests/qemu-iotests/205
@@ -78,7 +78,7 @@ class TestNbdServerRemove(iotests.QMPTestCase):
=20
     def assertConnectFailed(self, qemu_io_output):
         self.assertEqual(filter_qemu_io(qemu_io_output).strip(),
-                         "qemu-io: can't open device " + nbd_uri +
+                         "qemu-io: error: can't open device " + nbd_uri +
                          ": Requested export not available\n"
                          "server reported: export 'exp' not present")
=20
diff --git a/tests/qemu-iotests/215.out b/tests/qemu-iotests/215.out
index 5a2fe40d03..9917f48205 100644
--- a/tests/qemu-iotests/215.out
+++ b/tests/qemu-iotests/215.out
@@ -16,7 +16,7 @@ read 2147483136/2147483136 bytes at offset 1024
 2 GiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 1024/1024 bytes at offset 3221226496
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: can't open device TEST_DIR/t.wrap.qcow2: Block node is read-only
+qemu-io: error: can't open device TEST_DIR/t.wrap.qcow2: Block node is rea=
d-only
 2 GiB (0x80010000) bytes     allocated at offset 0 bytes (0x0)
 1023.938 MiB (0x3fff0000) bytes not allocated at offset 2 GiB (0x80010000)
 64 KiB (0x10000) bytes     allocated at offset 3 GiB (0xc0000000)
diff --git a/tests/qemu-iotests/217.out b/tests/qemu-iotests/217.out
index e3fc40a8c7..702c6d825b 100644
--- a/tests/qemu-iotests/217.out
+++ b/tests/qemu-iotests/217.out
@@ -10,7 +10,7 @@ Snapshot list:
 (Snapshot filtered)
=20
 qcow2_free_clusters failed: Input/output error
-qemu-img: Could not delete snapshot 'foo': Failed to free the cluster and =
L1 table: Input/output error
+qemu-img: error: Could not delete snapshot 'foo': Failed to free the clust=
er and L1 table: Input/output error
=20
 --- Checking test image ---
 Leaked cluster 4 refcount=3D2 reference=3D1
diff --git a/tests/qemu-iotests/226.out b/tests/qemu-iotests/226.out
index 42be973ff2..5b06a97430 100644
--- a/tests/qemu-iotests/226.out
+++ b/tests/qemu-iotests/226.out
@@ -3,24 +3,24 @@ QA output created by 226
 =3D=3D=3D Testing with driver:file =3D=3D=3D
=20
 =3D=3D Testing RO =3D=3D
-qemu-io: can't open: A regular file was expected by the 'file' driver, but=
 something else was given
+qemu-io: error: can't open: A regular file was expected by the 'file' driv=
er, but something else was given
 qemu-io: warning: Opening a character device as a file using the 'file' dr=
iver is deprecated
 =3D=3D Testing RW =3D=3D
-qemu-io: can't open: Could not open 'TEST_DIR/t.IMGFMT': Is a directory
+qemu-io: error: can't open: Could not open 'TEST_DIR/t.IMGFMT': Is a direc=
tory
 qemu-io: warning: Opening a character device as a file using the 'file' dr=
iver is deprecated
=20
 =3D=3D=3D Testing with driver:host_device =3D=3D=3D
=20
 =3D=3D Testing RO =3D=3D
-qemu-io: can't open: 'host_device' driver expects either a character or bl=
ock device
+qemu-io: error: can't open: 'host_device' driver expects either a characte=
r or block device
 =3D=3D Testing RW =3D=3D
-qemu-io: can't open: Could not open 'TEST_DIR/t.IMGFMT': Is a directory
+qemu-io: error: can't open: Could not open 'TEST_DIR/t.IMGFMT': Is a direc=
tory
=20
 =3D=3D=3D Testing with driver:host_cdrom =3D=3D=3D
=20
 =3D=3D Testing RO =3D=3D
-qemu-io: can't open: 'host_cdrom' driver expects either a character or blo=
ck device
+qemu-io: error: can't open: 'host_cdrom' driver expects either a character=
 or block device
 =3D=3D Testing RW =3D=3D
-qemu-io: can't open: Could not open 'TEST_DIR/t.IMGFMT': Is a directory
+qemu-io: error: can't open: Could not open 'TEST_DIR/t.IMGFMT': Is a direc=
tory
=20
 *** done
diff --git a/tests/qemu-iotests/232.out b/tests/qemu-iotests/232.out
index 3bd1a920af..b338f2239c 100644
--- a/tests/qemu-iotests/232.out
+++ b/tests/qemu-iotests/232.out
@@ -21,11 +21,11 @@ NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
 NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
 NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
=20
-QEMU_PROG: -drive driver=3Dfile,file=3DTEST_DIR/t.IMGFMT,if=3Dnone,read-on=
ly=3Doff,auto-read-only=3Doff: Could not open 'TEST_DIR/t.IMGFMT': Permissi=
on denied
+QEMU_PROG: -drive driver=3Dfile,file=3DTEST_DIR/t.IMGFMT,if=3Dnone,read-on=
ly=3Doff,auto-read-only=3Doff: error: Could not open 'TEST_DIR/t.IMGFMT': P=
ermission denied
 NODE_NAME: TEST_DIR/t.IMGFMT (file)
 NODE_NAME: TEST_DIR/t.IMGFMT (file)
=20
-QEMU_PROG: -drive driver=3Dfile,file=3DTEST_DIR/t.IMGFMT,if=3Dnone,auto-re=
ad-only=3Doff: Could not open 'TEST_DIR/t.IMGFMT': Permission denied
+QEMU_PROG: -drive driver=3Dfile,file=3DTEST_DIR/t.IMGFMT,if=3Dnone,auto-re=
ad-only=3Doff: error: Could not open 'TEST_DIR/t.IMGFMT': Permission denied
 NODE_NAME: TEST_DIR/t.IMGFMT (file)
 NODE_NAME: TEST_DIR/t.IMGFMT (file)
=20
@@ -49,11 +49,11 @@ node0: TEST_DIR/t.IMGFMT (file, read-only)
 node0: TEST_DIR/t.IMGFMT (file, read-only)
 node0: TEST_DIR/t.IMGFMT (file, read-only)
=20
-QEMU_PROG: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-name=
=3Dnode0,read-only=3Doff,auto-read-only=3Doff: Could not open 'TEST_DIR/t.I=
MGFMT': Permission denied
+QEMU_PROG: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-name=
=3Dnode0,read-only=3Doff,auto-read-only=3Doff: error: Could not open 'TEST_=
DIR/t.IMGFMT': Permission denied
 node0: TEST_DIR/t.IMGFMT (file)
-QEMU_PROG: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-name=
=3Dnode0,read-only=3Doff: Could not open 'TEST_DIR/t.IMGFMT': Permission de=
nied
+QEMU_PROG: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-name=
=3Dnode0,read-only=3Doff: error: Could not open 'TEST_DIR/t.IMGFMT': Permis=
sion denied
=20
-QEMU_PROG: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-name=
=3Dnode0,auto-read-only=3Doff: Could not open 'TEST_DIR/t.IMGFMT': Permissi=
on denied
+QEMU_PROG: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-name=
=3Dnode0,auto-read-only=3Doff: error: Could not open 'TEST_DIR/t.IMGFMT': P=
ermission denied
 node0: TEST_DIR/t.IMGFMT (file)
-QEMU_PROG: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-name=
=3Dnode0: Could not open 'TEST_DIR/t.IMGFMT': Permission denied
+QEMU_PROG: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-name=
=3Dnode0: error: Could not open 'TEST_DIR/t.IMGFMT': Permission denied
 *** done
diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
index c3c344811b..df7e588b36 100644
--- a/tests/qemu-iotests/233.out
+++ b/tests/qemu-iotests/233.out
@@ -14,16 +14,16 @@ wrote 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 =3D=3D check TLS client to plain server fails =3D=3D
-qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT,tls-cr=
eds=3Dtls0': Denied by server for option 5 (starttls)
+qemu-img: error: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT=
,tls-creds=3Dtls0': Denied by server for option 5 (starttls)
 server reported: TLS not configured
-qemu-nbd: Denied by server for option 5 (starttls)
+qemu-nbd: error: Denied by server for option 5 (starttls)
 server reported: TLS not configured
=20
 =3D=3D check plain client to TLS server fails =3D=3D
-qemu-img: Could not open 'nbd://localhost:PORT': TLS negotiation required =
before option 7 (go)
+qemu-img: error: Could not open 'nbd://localhost:PORT': TLS negotiation re=
quired before option 7 (go)
 Did you forget a valid tls-creds?
 server reported: Option 0x7 not permitted before TLS
-qemu-nbd: TLS negotiation required before option 3 (list)
+qemu-nbd: error: TLS negotiation required before option 3 (list)
 Did you forget a valid tls-creds?
 server reported: Option 0x3 not permitted before TLS
=20
@@ -47,8 +47,8 @@ exports available: 1
    base:allocation
=20
 =3D=3D check TLS with different CA fails =3D=3D
-qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT,tls-cr=
eds=3Dtls0': The certificate hasn't got a known issuer
-qemu-nbd: The certificate hasn't got a known issuer
+qemu-img: error: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT=
,tls-creds=3Dtls0': The certificate hasn't got a known issuer
+qemu-nbd: error: The certificate hasn't got a known issuer
=20
 =3D=3D perform I/O over TLS =3D=3D
 read 1048576/1048576 bytes at offset 1048576
@@ -59,12 +59,12 @@ read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 =3D=3D check TLS with authorization =3D=3D
-qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT,tls-cr=
eds=3Dtls0': Failed to read option reply: Cannot read from TLS channel: Sof=
tware caused connection abort
-qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT,tls-cr=
eds=3Dtls0': Failed to read option reply: Cannot read from TLS channel: Sof=
tware caused connection abort
+qemu-img: error: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT=
,tls-creds=3Dtls0': Failed to read option reply: Cannot read from TLS chann=
el: Software caused connection abort
+qemu-img: error: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT=
,tls-creds=3Dtls0': Failed to read option reply: Cannot read from TLS chann=
el: Software caused connection abort
=20
 =3D=3D final server log =3D=3D
-qemu-nbd: option negotiation failed: Verify failed: No certificate was fou=
nd.
-qemu-nbd: option negotiation failed: Verify failed: No certificate was fou=
nd.
-qemu-nbd: option negotiation failed: TLS x509 authz check for CN=3Dlocalho=
st,O=3DCthulhu Dark Lord Enterprises client1,L=3DR'lyeh,C=3DSouth Pacific i=
s denied
-qemu-nbd: option negotiation failed: TLS x509 authz check for CN=3Dlocalho=
st,O=3DCthulhu Dark Lord Enterprises client3,L=3DR'lyeh,C=3DSouth Pacific i=
s denied
+qemu-nbd: error: option negotiation failed: Verify failed: No certificate =
was found.
+qemu-nbd: error: option negotiation failed: Verify failed: No certificate =
was found.
+qemu-nbd: error: option negotiation failed: TLS x509 authz check for CN=3D=
localhost,O=3DCthulhu Dark Lord Enterprises client1,L=3DR'lyeh,C=3DSouth Pa=
cific is denied
+qemu-nbd: error: option negotiation failed: TLS x509 authz check for CN=3D=
localhost,O=3DCthulhu Dark Lord Enterprises client3,L=3DR'lyeh,C=3DSouth Pa=
cific is denied
 *** done
diff --git a/tests/qemu-iotests/242.out b/tests/qemu-iotests/242.out
index 7ac8404d11..fe729faa3e 100644
--- a/tests/qemu-iotests/242.out
+++ b/tests/qemu-iotests/242.out
@@ -143,7 +143,7 @@ Test 5
 {"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 16384, "name": "bitmap-0", "node": "drive0", "persistent": true=
}}
 {"return": {}}
 Write an unknown bitmap flag '0x4' into a new QCOW2 image at offset 327695
-qemu-img: Could not open 'TEST_IMG': Bitmap 'bitmap-0' doesn't satisfy the=
 constraints
+qemu-img: error: Could not open 'TEST_IMG': Bitmap 'bitmap-0' doesn't sati=
sfy the constraints
=20
 Unset the unknown bitmap flag '0x4' in the bitmap directory entry:
=20
diff --git a/tests/qemu-iotests/244.out b/tests/qemu-iotests/244.out
index 6a3d0067cc..6e8b9a9a2b 100644
--- a/tests/qemu-iotests/244.out
+++ b/tests/qemu-iotests/244.out
@@ -9,22 +9,22 @@ read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: can't open device TEST_DIR/t.qcow2: Could not open 'inexistent': =
No such file or directory
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Could not open 'inexis=
tent': No such file or directory
 no file open, try 'help open'
=20
 Data file required, but without data file name in the image:
-qemu-io: can't open device TEST_DIR/t.qcow2: 'data-file' is required for t=
his image
+qemu-io: error: can't open device TEST_DIR/t.qcow2: 'data-file' is require=
d for this image
 no file open, try 'help open'
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-io: can't open device TEST_DIR/t.qcow2: Could not open 'inexistent': =
No such file or directory
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Could not open 'inexis=
tent': No such file or directory
 no file open, try 'help open'
=20
 Setting data-file for an image with internal data:
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-qemu-io: can't open device TEST_DIR/t.qcow2: 'data-file' can only be set f=
or images with an external data file
+qemu-io: error: can't open device TEST_DIR/t.qcow2: 'data-file' can only b=
e set for images with an external data file
 no file open, try 'help open'
-qemu-io: can't open device TEST_DIR/t.qcow2: Could not open 'inexistent': =
No such file or directory
+qemu-io: error: can't open device TEST_DIR/t.qcow2: Could not open 'inexis=
tent': No such file or directory
 no file open, try 'help open'
=20
 =3D=3D=3D Conflicting features =3D=3D=3D
@@ -33,7 +33,7 @@ Convert to compressed target with data file:
 Formatting 'TEST_DIR/t.IMGFMT.src', fmt=3DIMGFMT size=3D67108864
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: error while writing sector 0: Operation not supported
+qemu-img: error: error while writing sector 0: Operation not supported
=20
 Convert uncompressed, then write compressed data manually:
 Images are identical.
@@ -41,7 +41,7 @@ write failed: Operation not supported
 No errors were found on the image.
=20
 Take an internal snapshot:
-qemu-img: Could not create snapshot 'test': -95 (Operation not supported)
+qemu-img: error: Could not create snapshot 'test': -95 (Operation not supp=
orted)
 No errors were found on the image.
=20
 =3D=3D=3D Standalone image with external data file (efficient) =3D=3D=3D
diff --git a/tests/qemu-iotests/249.out b/tests/qemu-iotests/249.out
index 51307ed0f7..4ce35e2f6a 100644
--- a/tests/qemu-iotests/249.out
+++ b/tests/qemu-iotests/249.out
@@ -8,7 +8,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576=
 backing_file=3DTEST_DIR/t.
 =3D=3D=3D Send a write command to a drive opened in read-only mode (1)
=20
 { 'execute': 'human-monitor-command', 'arguments': {'command-line': 'qemu-=
io none0 "aio_write 0 2k"'}}
-{"return": "Block node is read-onlyrn"}
+{"return": "error: Block node is read-onlyrn"}
=20
 =3D=3D=3D Run block-commit on base using an invalid filter node name
=20
@@ -20,7 +20,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D10485=
76 backing_file=3DTEST_DIR/t.
 =3D=3D=3D Send a write command to a drive opened in read-only mode (2)
=20
 { 'execute': 'human-monitor-command', 'arguments': {'command-line': 'qemu-=
io none0 "aio_write 0 2k"'}}
-{"return": "Block node is read-onlyrn"}
+{"return": "error: Block node is read-onlyrn"}
=20
 =3D=3D=3D Run block-commit on base using the default filter node name
=20
@@ -37,5 +37,5 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D10485=
76 backing_file=3DTEST_DIR/t.
 =3D=3D=3D Send a write command to a drive opened in read-only mode (3)
=20
 { 'execute': 'human-monitor-command', 'arguments': {'command-line': 'qemu-=
io none0 "aio_write 0 2k"'}}
-{"return": "Block node is read-onlyrn"}
+{"return": "error: Block node is read-onlyrn"}
 *** done
diff --git a/tests/qemu-iotests/261.out b/tests/qemu-iotests/261.out
index 2600354566..176fee892e 100644
--- a/tests/qemu-iotests/261.out
+++ b/tests/qemu-iotests/261.out
@@ -162,12 +162,12 @@ Snapshots in TEST_DIR/t.IMGFMT:
=20
 =3D=3D=3D Reject too much unknown extra data =3D=3D=3D
=20
-qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Too much extra metadata in s=
napshot table entry 3
+qemu-img: error: Could not open 'TEST_DIR/t.IMGFMT': Too much extra metada=
ta in snapshot table entry 3
 You can force-remove this extra metadata with qemu-img check -r all
=20
-qemu-img: ERROR failed to read the snapshot table: Too much extra metadata=
 in snapshot table entry 3
+qemu-img: error: ERROR failed to read the snapshot table: Too much extra m=
etadata in snapshot table entry 3
 You can force-remove this extra metadata with qemu-img check -r all
-qemu-img: Check failed: File too large
+qemu-img: error: Check failed: File too large
=20
 Discarding too much extra metadata in snapshot table entry 3 (65536 > 1024=
)
 ERROR cluster 10 refcount=3D0 reference=3D1
@@ -185,12 +185,12 @@ No errors were found on the image.
 =3D=3D=3D Snapshot table too big =3D=3D=3D
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Snapshot table is too big
+qemu-img: error: Could not open 'TEST_DIR/t.IMGFMT': Snapshot table is too=
 big
 You can force-remove all 1 overhanging snapshots with qemu-img check -r al=
l
=20
-qemu-img: ERROR failed to read the snapshot table: Snapshot table is too b=
ig
+qemu-img: error: ERROR failed to read the snapshot table: Snapshot table i=
s too big
 You can force-remove all 1 overhanging snapshots with qemu-img check -r al=
l
-qemu-img: Check failed: File too large
+qemu-img: error: Check failed: File too large
=20
 Discarding 1 overhanging snapshots (snapshot table is too big)
 Leaked cluster 14 refcount=3D1 reference=3D0
@@ -217,12 +217,12 @@ No errors were found on the image.
=20
 Snapshot table size should equal 67108872: 67108872
=20
-qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Too much extra metadata in s=
napshot table entry 505
+qemu-img: error: Could not open 'TEST_DIR/t.IMGFMT': Too much extra metada=
ta in snapshot table entry 505
 You can force-remove this extra metadata with qemu-img check -r all
=20
-qemu-img: ERROR failed to read the snapshot table: Too much extra metadata=
 in snapshot table entry 505
+qemu-img: error: ERROR failed to read the snapshot table: Too much extra m=
etadata in snapshot table entry 505
 You can force-remove this extra metadata with qemu-img check -r all
-qemu-img: Check failed: File too large
+qemu-img: error: Check failed: File too large
=20
 Discarding too much extra metadata in snapshot table entry 505 (116944 > 1=
024)
 Discarding 1 overhanging snapshots (snapshot table is too big)
@@ -241,11 +241,11 @@ No errors were found on the image.
 =3D=3D=3D Too many snapshots =3D=3D=3D
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Snapshot table too large
+qemu-img: error: Could not open 'TEST_DIR/t.IMGFMT': Snapshot table too la=
rge
=20
-qemu-img: ERROR snapshot table too large
+qemu-img: error: ERROR snapshot table too large
 You can force-remove all 65536 overhanging snapshots with qemu-img check -=
r all
-qemu-img: Check failed: File too large
+qemu-img: error: Check failed: File too large
=20
 Discarding 65536 overhanging snapshots
 Leaked cluster 14 refcount=3D1 reference=3D0
diff --git a/tests/qemu-iotests/267.out b/tests/qemu-iotests/267.out
index 8dddb4baa4..7e3f77c259 100644
--- a/tests/qemu-iotests/267.out
+++ b/tests/qemu-iotests/267.out
@@ -6,11 +6,11 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D13421=
7728
 Testing:
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
-Error: No block device can accept snapshots
+error: No block device can accept snapshots
 (qemu) info snapshots
 No available block device supports snapshots
 (qemu) loadvm snap0
-Error: No block device supports snapshots
+error: No block device supports snapshots
 (qemu) quit
=20
=20
@@ -20,11 +20,11 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134=
217728
 Testing: -drive driver=3Dfile,file=3DTEST_DIR/t.IMGFMT,if=3Dnone
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
-Error: Device 'none0' is writable but does not support snapshots
+error: Device 'none0' is writable but does not support snapshots
 (qemu) info snapshots
 No available block device supports snapshots
 (qemu) loadvm snap0
-Error: Device 'none0' is writable but does not support snapshots
+error: Device 'none0' is writable but does not support snapshots
 (qemu) quit
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
@@ -56,11 +56,11 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134=
217728
 Testing: -drive driver=3Dfile,file=3DTEST_DIR/t.IMGFMT,if=3Dvirtio
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
-Error: Device 'virtio0' is writable but does not support snapshots
+error: Device 'virtio0' is writable but does not support snapshots
 (qemu) info snapshots
 No available block device supports snapshots
 (qemu) loadvm snap0
-Error: Device 'virtio0' is writable but does not support snapshots
+error: Device 'virtio0' is writable but does not support snapshots
 (qemu) quit
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
@@ -81,11 +81,11 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134=
217728
 Testing: -blockdev driver=3Dfile,filename=3DTEST_DIR/t.IMGFMT,node-name=3D=
file
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
-Error: Device '' is writable but does not support snapshots
+error: Device '' is writable but does not support snapshots
 (qemu) info snapshots
 No available block device supports snapshots
 (qemu) loadvm snap0
-Error: Device '' is writable but does not support snapshots
+error: Device '' is writable but does not support snapshots
 (qemu) quit
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.f=
ilter
index 3f8ee3e5f7..0f19eeeeca 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -58,7 +58,7 @@ _filter_imgfmt()
 _filter_qemu_img_check()
 {
     $SED -e '/allocated.*fragmented.*compressed clusters/d' \
-        -e 's/qemu-img: This image format does not support checks/No error=
s were found on the image./' \
+        -e 's/qemu-img: error: This image format does not support checks/N=
o errors were found on the image./' \
         -e '/Image end offset: [0-9]\+/d'
 }
=20
diff --git a/util/qemu-error.c b/util/qemu-error.c
index dac7c7dc50..03ab07341c 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -217,6 +217,7 @@ static void vreport(report_type type, const char *fmt, =
va_list ap)
=20
     switch (type) {
     case REPORT_TYPE_ERROR:
+        error_printf("error: ");
         break;
     case REPORT_TYPE_WARNING:
         error_printf("warning: ");
--=20
2.17.2


