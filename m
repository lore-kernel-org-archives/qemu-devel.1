Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8358BC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:52:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50B5520651
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B5520651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47767 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM7S2-0001Hb-HY
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:52:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hM7MB-0004XN-FG
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hM7M7-0003l6-So
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:46:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hM7M3-0002ym-QR; Thu, 02 May 2019 04:46:12 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11AFAF74A6;
	Thu,  2 May 2019 08:45:26 +0000 (UTC)
Received: from thuth.com (ovpn-116-131.ams2.redhat.com [10.36.116.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 46D7254FE5;
	Thu,  2 May 2019 08:45:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 10:45:02 +0200
Message-Id: <20190502084506.8009-4-thuth@redhat.com>
In-Reply-To: <20190502084506.8009-1-thuth@redhat.com>
References: <20190502084506.8009-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Thu, 02 May 2019 08:45:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 3/7] tests/qemu-iotests: Do not hard-code
 the path to bash
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
	Markus Armbruster <armbru@redhat.com>,
	Christophe Fergeau <cfergeau@redhat.com>, Max Reitz <mreitz@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502084502.OOyA1NF972IaJJezQzox1HL43Lsc73oQFZUGEcCCxK8@z>

bash is installed in a different directory on non-Linux systems like
FreeBSD. Do not hard-code /bin/bash here so that the tests can run
there, too.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/239 | 2 +-
 tests/qemu-iotests/240 | 2 +-
 tests/qemu-iotests/241 | 2 +-
 tests/qemu-iotests/243 | 2 +-
 tests/qemu-iotests/244 | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/239 b/tests/qemu-iotests/239
index 6f085d573d..b0991ffe59 100755
--- a/tests/qemu-iotests/239
+++ b/tests/qemu-iotests/239
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 #
 # Test case for dmg
 #
diff --git a/tests/qemu-iotests/240 b/tests/qemu-iotests/240
index 65cc3b39b1..d3e663ed65 100755
--- a/tests/qemu-iotests/240
+++ b/tests/qemu-iotests/240
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 #
 # Test hot plugging and unplugging with iothreads
 #
diff --git a/tests/qemu-iotests/241 b/tests/qemu-iotests/241
index 017a736aab..58b64ebf41 100755
--- a/tests/qemu-iotests/241
+++ b/tests/qemu-iotests/241
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 #
 # Test qemu-nbd vs. unaligned images
 #
diff --git a/tests/qemu-iotests/243 b/tests/qemu-iotests/243
index 5838c6e89c..e563761307 100755
--- a/tests/qemu-iotests/243
+++ b/tests/qemu-iotests/243
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 #
 # Test qcow2 preallocation
 #
diff --git a/tests/qemu-iotests/244 b/tests/qemu-iotests/244
index d8e7122305..13978f93d2 100755
--- a/tests/qemu-iotests/244
+++ b/tests/qemu-iotests/244
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 #
 # Test qcow2 with external data files
 #
--=20
2.21.0


