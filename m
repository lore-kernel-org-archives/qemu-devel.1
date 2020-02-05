Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408EFC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 16:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CE4521741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 16:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FbExG4IZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE4521741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izNbK-0001XH-9F
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 11:32:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jusual@redhat.com>) id 1izNZJ-00087l-HF
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:30:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jusual@redhat.com>) id 1izNZI-0001Vc-C3
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:30:25 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58207
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jusual@redhat.com>) id 1izNZI-0001Sv-7t
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:30:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580920223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=t6JJqOsIC0sjR5SET7Vkcoe5+YylPvMgXs6rhxviKlc=;
 b=FbExG4IZf2IqcwFfBc+9DILQyAnTBX27O71zbbYIMq34pdNmUbTksobo9dqpiqxcrQUddG
 ggeh5p1qPF+/uuHEVtSux7GW85Gh9wDC8Ro/SZGHHWTUmcmYVJB6CHsg2ufKO4QWYSb48B
 TXRLy2Os3uWi0SeQwkku+srp1hR3m3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-H1pXfWPuOxOkNpAYQ2B0Bw-1; Wed, 05 Feb 2020 11:30:21 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7A1D800D55;
 Wed,  5 Feb 2020 16:30:20 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.2.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 55B2B8DC09;
 Wed,  5 Feb 2020 16:30:13 +0000 (UTC)
From: Julia Suvorova <jusual@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qemu-img: Place the '-i aio' option in alphabetical order
Date: Wed,  5 Feb 2020 17:30:08 +0100
Message-Id: <20200205163008.204493-1-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: H1pXfWPuOxOkNpAYQ2B0Bw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Julia Suvorova <jusual@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The '-i AIO' option was accidentally placed after '-n' and '-t'. Move it
after '--flush-interval'.

Signed-off-by: Julia Suvorova <jusual@redhat.com>
---
 docs/interop/qemu-img.rst | 8 ++++----
 qemu-img-cmds.hx          | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/docs/interop/qemu-img.rst b/docs/interop/qemu-img.rst
index fa27e5c7b4..42e4451db4 100644
--- a/docs/interop/qemu-img.rst
+++ b/docs/interop/qemu-img.rst
@@ -247,7 +247,7 @@ Command description:
   Amends the image format specific *OPTIONS* for the image file
   *FILENAME*. Not all file formats support this operation.
=20
-.. option:: bench [-c COUNT] [-d DEPTH] [-f FMT] [--flush-interval=3DFLUSH=
_INTERVAL] [-n] [-i AIO] [--no-drain] [-o OFFSET] [--pattern=3DPATTERN] [-q=
] [-s BUFFER_SIZE] [-S STEP_SIZE] [-t CACHE] [-w] [-U] FILENAME
+.. option:: bench [-c COUNT] [-d DEPTH] [-f FMT] [--flush-interval=3DFLUSH=
_INTERVAL] [-i AIO] [-n] [--no-drain] [-o OFFSET] [--pattern=3DPATTERN] [-q=
] [-s BUFFER_SIZE] [-S STEP_SIZE] [-t CACHE] [-w] [-U] FILENAME
=20
   Run a simple sequential I/O benchmark on the specified image. If ``-w`` =
is
   specified, a write test is performed, otherwise a read test is performed=
.
@@ -264,13 +264,13 @@ Command description:
   ``--no-drain`` is specified, a flush is issued without draining the requ=
est
   queue first.
=20
+  if ``-i`` is specified, *AIO* option can be used to specify different
+  AIO backends: ``threads``, ``native`` or ``io_uring``.
+
   If ``-n`` is specified, the native AIO backend is used if possible. On
   Linux, this option only works if ``-t none`` or ``-t directsync`` is
   specified as well.
=20
-  if ``-i`` is specified, *AIO* option can be used to specify different
-  AIO backends: ``threads``, ``native`` or ``io_uring``.
-
   For write tests, by default a buffer filled with zeros is written. This =
can be
   overridden with a pattern byte specified by *PATTERN*.
=20
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 3fd836ca90..d7fbc6b1f4 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -16,9 +16,9 @@ SRST
 ERST
=20
 DEF("bench", img_bench,
-    "bench [-c count] [-d depth] [-f fmt] [--flush-interval=3Dflush_interv=
al] [-n] [--no-drain] [-o offset] [--pattern=3Dpattern] [-q] [-s buffer_siz=
e] [-S step_size] [-t cache] [-i aio] [-w] [-U] filename")
+    "bench [-c count] [-d depth] [-f fmt] [--flush-interval=3Dflush_interv=
al] [-i aio] [-n] [--no-drain] [-o offset] [--pattern=3Dpattern] [-q] [-s b=
uffer_size] [-S step_size] [-t cache] [-w] [-U] filename")
 SRST
-.. option:: bench [-c COUNT] [-d DEPTH] [-f FMT] [--flush-interval=3DFLUSH=
_INTERVAL] [-n] [--no-drain] [-o OFFSET] [--pattern=3DPATTERN] [-q] [-s BUF=
FER_SIZE] [-S STEP_SIZE] [-t CACHE] [-i AIO] [-w] [-U] FILENAME
+.. option:: bench [-c COUNT] [-d DEPTH] [-f FMT] [--flush-interval=3DFLUSH=
_INTERVAL] [-i AIO] [-n] [--no-drain] [-o OFFSET] [--pattern=3DPATTERN] [-q=
] [-s BUFFER_SIZE] [-S STEP_SIZE] [-t CACHE] [-w] [-U] FILENAME
 ERST
 DEF("check", img_check,
     "check [--object objectdef] [--image-opts] [-q] [-f fmt] [--output=3Do=
fmt] [-r [leaks | all]] [-T src_cache] [-U] filename")
--=20
2.24.1


