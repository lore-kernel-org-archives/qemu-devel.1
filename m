Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88791FA372B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 19:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 615062064B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 19:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615062064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKoyR-0006Mv-4i
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 15:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iKovF-0002Fh-L0
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 15:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iKovE-0002kX-8j
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 15:25:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33072)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>)
 id 1iKovB-0002iH-LK; Wed, 16 Oct 2019 15:25:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DCE3DC057F23;
 Wed, 16 Oct 2019 19:25:20 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8558160BF7;
 Wed, 16 Oct 2019 19:25:15 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/10] image-fuzzer: Run using python3
Date: Wed, 16 Oct 2019 16:24:29 -0300
Message-Id: <20191016192430.25098-10-ehabkost@redhat.com>
In-Reply-To: <20191016192430.25098-1-ehabkost@redhat.com>
References: <20191016192430.25098-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Wed, 16 Oct 2019 19:25:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

image-fuzzer is now supposed to be ready to run using Python 3.
Remove the __future__ imports and change the interpreter line to
"#!/usr/bin/env python3".

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/image-fuzzer/qcow2/__init__.py | 1 -
 tests/image-fuzzer/qcow2/layout.py   | 1 -
 tests/image-fuzzer/runner.py         | 3 +--
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/tests/image-fuzzer/qcow2/__init__.py b/tests/image-fuzzer/qc=
ow2/__init__.py
index 09ef59821b..ed3af5da86 100644
--- a/tests/image-fuzzer/qcow2/__init__.py
+++ b/tests/image-fuzzer/qcow2/__init__.py
@@ -1,2 +1 @@
-from __future__ import absolute_import
 from .layout import create_image
diff --git a/tests/image-fuzzer/qcow2/layout.py b/tests/image-fuzzer/qcow=
2/layout.py
index 01bff4d05e..57ebe86e9a 100644
--- a/tests/image-fuzzer/qcow2/layout.py
+++ b/tests/image-fuzzer/qcow2/layout.py
@@ -16,7 +16,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
=20
-from __future__ import absolute_import
 import random
 import struct
 from . import fuzz
diff --git a/tests/image-fuzzer/runner.py b/tests/image-fuzzer/runner.py
index 94cab5bd93..0793234815 100755
--- a/tests/image-fuzzer/runner.py
+++ b/tests/image-fuzzer/runner.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
=20
 # Tool for running fuzz tests
 #
@@ -18,7 +18,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
=20
-from __future__ import print_function
 import sys
 import os
 import signal
--=20
2.21.0


