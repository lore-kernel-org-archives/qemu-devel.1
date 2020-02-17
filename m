Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E82C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 20:21:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E4FD2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 20:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hy3NBkdW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4FD2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3mtn-00033U-Rt
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 15:21:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1j3moa-0004jt-T9
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 15:16:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1j3moZ-000420-L7
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 15:16:24 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37494
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1j3moZ-000419-G5
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 15:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581970582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fJjBI1dy7R3Dxj50kPLKDRnj/NpAtKSBOBq9y0nigaI=;
 b=hy3NBkdWPgqCEymrbmQeT6f9cnDfCMsT4jwTgtZReNLy+xoWR/pmzZ+UCfZV+ptXYaI7tA
 HRLLDpEbz5mXdaELrDJWLhZu+aZYv0VDtLokWN5NeuiOgnpKgEdbKRVrrc5SZTGHnq0OUE
 +lckdzXvb9gyrJolUCJSWn70xuBhKzs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-qb2IIZ0FPHuPKYY8iKbINQ-1; Mon, 17 Feb 2020 15:16:15 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 892AA100550E;
 Mon, 17 Feb 2020 20:16:14 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CEB7B5D9E2;
 Mon, 17 Feb 2020 20:16:13 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 1/6] travis.yml: Bump default environment to Ubuntu Bionic
Date: Mon, 17 Feb 2020 15:16:04 -0500
Message-Id: <20200217201609.788825-2-wainersm@redhat.com>
In-Reply-To: <20200217201609.788825-1-wainersm@redhat.com>
References: <20200217201609.788825-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: qb2IIZ0FPHuPKYY8iKbINQ-1
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
Cc: fam@euphon.net, philmd@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently some KVM tests are skipped because Travis' Ubuntu 16.04 (Xenial)
does not provide nested virtualization (unlike Travis' Ubuntu 18.04). So
this switch the default job environment from Ubuntu Xenial to 18.04 (Bionic=
).

Notes:

1. The Ubuntu Bionic's libssh-dev package has a bug [1] that prevents QEMU
  from being built with ssh support. Therefore, the libssh-dev is not even
  installed in the job environment until a fix is not shipped.

  [1] https://bugs.launchpad.net/qemu/+bug/1838763

2. The '[aarch64] GCC check-tcg' and '[ppc64] GCC check-tcg' jobs
  explicitly use Xenial so they aren't converted on this patch.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 .travis.yml | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 5887055951..e46c44bbee 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,7 +1,7 @@
-# The current Travis default is a VM based 16.04 Xenial on GCE
+# The current Travis default is a VM based 18.04 Xenial on GCE
 # Additional builds with specific requirements for a full VM need to
 # be added as additional matrix: entries later on
-dist: xenial
+dist: bionic
 language: c
 compiler:
   - gcc
@@ -9,7 +9,7 @@ cache:
   # There is one cache per branch and compiler version.
   # characteristics of each job are used to identify the cache:
   # - OS name (currently, linux, osx, or windows)
-  # - OS distribution (for Linux, xenial, trusty, or precise)
+  # - OS distribution (for Linux, bionic, xenial, trusty, or precise)
   # - macOS image name (e.g., xcode7.2)
   # - Names and values of visible environment variables set in .travis.yml=
 or Settings panel
   timeout: 1200
@@ -43,7 +43,9 @@ addons:
       - libseccomp-dev
       - libspice-protocol-dev
       - libspice-server-dev
-      - libssh-dev
+# It should not install libssh-dev until the following bug is fixed:
+# https://bugs.launchpad.net/qemu/+bug/1838763
+#     - libssh-dev
       - liburcu-dev
       - libusb-1.0-0-dev
       - libvdeplug-dev
@@ -184,8 +186,7 @@ matrix:
=20
=20
     # Check we can build docs and tools (out of tree)
-    - name: "tools and docs (bionic)"
-      dist: bionic
+    - name: "tools and docs"
       env:
         - BUILD_DIR=3D"out-of-tree/build/dir" SRC_DIR=3D"../../.."
         - BASE_CONFIG=3D"--enable-tools --enable-docs"
@@ -480,7 +481,6 @@ matrix:
=20
     - name: "[s390x] GCC check-tcg"
       arch: s390x
-      dist: bionic
       addons:
         apt_packages:
           - libaio-dev
--=20
2.24.1


