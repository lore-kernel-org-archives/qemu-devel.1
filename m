Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B73AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16E7B21848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E7B21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Cel-0008TW-L6
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 12:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i1CbI-0006c1-8x
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i1CbH-0002wP-8S
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:39:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48350)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i1CbH-0002v7-2Z
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:39:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 55F26300BC7F;
 Fri, 23 Aug 2019 16:39:42 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-60.ams2.redhat.com
 [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C51326CE58;
 Fri, 23 Aug 2019 16:39:40 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 23 Aug 2019 17:39:31 +0100
Message-Id: <20190823163931.7442-5-berrange@redhat.com>
In-Reply-To: <20190823163931.7442-1-berrange@redhat.com>
References: <20190823163931.7442-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 23 Aug 2019 16:39:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/4] docs: add table of contents to
 CODING_STYLE.md
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 CODING_STYLE.md | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/CODING_STYLE.md b/CODING_STYLE.md
index f37b6c2d01..0841edb2f7 100644
--- a/CODING_STYLE.md
+++ b/CODING_STYLE.md
@@ -1,6 +1,37 @@
 QEMU Coding Style
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
+#### Table Of Contents
+
+  * [Whitespace](#whitespace)
+    + [Multiline Indent](#multiline-indent)
+  * [Line width](#line-width)
+  * [Naming](#naming)
+  * [Block structure](#block-structure)
+  * [Declarations](#declarations)
+  * [Conditional statements](#conditional-statements)
+  * [Comment style](#comment-style)
+  * [trace-events style](#trace-events-style)
+    + [0x prefix](#0x-prefix)
+    + ['#' printf flag](#----printf-flag)
+  * [Preprocessor](#preprocessor)
+    + [Variadic macros](#variadic-macros)
+    + [Include directives](#include-directives)
+  * [C types](#c-types)
+    + [Scalars](#scalars)
+    + [Pointers](#pointers)
+    + [Typedefs](#typedefs)
+    + [Reserved namespaces in C and POSIX](#reserved-namespaces-in-c-and=
-posix)
+  * [Low level memory management](#low-level-memory-management)
+  * [String manipulation](#string-manipulation)
+  * [Printf-style functions](#printf-style-functions)
+  * [C standard, implementation defined and undefined behaviors](#c-stan=
dard--implementation-defined-and-undefined-behaviors)
+  * [Error handling and reporting](#error-handling-and-reporting)
+    + [Reporting errors to the human user](#reporting-errors-to-the-huma=
n-user)
+    + [Propagating errors](#propagating-errors)
+    + [Handling errors](#handling-errors)
+  * [Automatic memory deallocation](#automatic-memory-deallocation)
+
 Please use the script checkpatch.pl in the scripts directory to check
 patches before submitting.
=20
--=20
2.21.0


