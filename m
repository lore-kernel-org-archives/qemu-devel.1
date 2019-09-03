Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4682CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:32:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ABB323402
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABB323402
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i58vE-000697-2Y
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 09:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i58qD-0002IL-6P
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i58qC-0000ma-2O
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:27:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49578)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i58qB-0000lC-TJ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:27:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 32F00307D868;
 Tue,  3 Sep 2019 13:27:23 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-102.brq.redhat.com [10.40.204.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 384A05C224;
 Tue,  3 Sep 2019 13:27:19 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 15:26:46 +0200
Message-Id: <20190903132649.20226-8-philmd@redhat.com>
In-Reply-To: <20190903132649.20226-1-philmd@redhat.com>
References: <20190903132649.20226-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 03 Sep 2019 13:27:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 07/10] .travis.yml: Document how the build
 matrix use caches
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will set the CACHE_NAME variable to improve the caching
of various jobs using the same characteristics. Document it
first.

See https://docs.travis-ci.com/user/caching/#caches-and-build-matrices

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .travis.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 640d84f201..c64a551829 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -6,6 +6,12 @@ language: c
 compiler:
   - gcc
 cache:
+  # There is one cache per branch and compiler version.
+  # characteristics of each job are used to identify the cache:
+  # - OS name (currently, linux, osx, or windows)
+  # - OS distribution (for Linux, xenial, trusty, or precise)
+  # - macOS image name (e.g., xcode7.2)
+  # - Names and values of visible environment variables set in .travis.y=
ml or Settings panel
   timeout: 1200
   ccache: true
   pip: true
--=20
2.20.1


