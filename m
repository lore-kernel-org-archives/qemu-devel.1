Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE36C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 11:38:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99BBE206BA
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 11:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99BBE206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34646 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEuVt-0005YJ-S1
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 07:38:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1hEuV4-0005GT-8V
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:37:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1hEuV3-0003Ln-3a
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:37:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1hEuV2-0003LP-Rn
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:37:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2B0EE309264C;
	Fri, 12 Apr 2019 11:37:40 +0000 (UTC)
Received: from vader.redhat.com (ovpn-117-148.ams2.redhat.com [10.36.117.148])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A4F685D6A9;
	Fri, 12 Apr 2019 11:37:38 +0000 (UTC)
From: Eduardo Otubo <otubo@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 12 Apr 2019 13:37:30 +0200
Message-Id: <20190412113730.28828-2-otubo@redhat.com>
In-Reply-To: <20190412113730.28828-1-otubo@redhat.com>
References: <20190412113730.28828-1-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Fri, 12 Apr 2019 11:37:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/1] configure: Relax check for libseccomp
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
Cc: peter.maydell@linaro.org, deller@gmx.de, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412113730.pFHxwSK__Ifo1ji5L2-c-NsbV1XjMo5lB__cQ2g5vTM@z>

From: Helge Deller <deller@gmx.de>

All major distributions do support libseccomp version >=3D 2.3.0, so ther=
e
is no need to special-case on various architectures any longer.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Acked-by: Eduardo Otubo <otubo@redhat.com>
---
 configure | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/configure b/configure
index 1c563a7027..fcc56aa979 100755
--- a/configure
+++ b/configure
@@ -2377,36 +2377,16 @@ fi
 ##########################################
 # libseccomp check
=20
-libseccomp_minver=3D"2.2.0"
 if test "$seccomp" !=3D "no" ; then
-    case "$cpu" in
-    i386|x86_64|mips)
-        ;;
-    arm|aarch64)
-        libseccomp_minver=3D"2.2.3"
-        ;;
-    ppc|ppc64|s390x)
-        libseccomp_minver=3D"2.3.0"
-        ;;
-    *)
-        libseccomp_minver=3D""
-        ;;
-    esac
-
-    if test "$libseccomp_minver" !=3D "" &&
-       $pkg_config --atleast-version=3D$libseccomp_minver libseccomp ; t=
hen
+    libseccomp_minver=3D"2.3.0"
+    if $pkg_config --atleast-version=3D$libseccomp_minver libseccomp ; t=
hen
         seccomp_cflags=3D"$($pkg_config --cflags libseccomp)"
         seccomp_libs=3D"$($pkg_config --libs libseccomp)"
         seccomp=3D"yes"
     else
         if test "$seccomp" =3D "yes" ; then
-            if test "$libseccomp_minver" !=3D "" ; then
-                feature_not_found "libseccomp" \
-                    "Install libseccomp devel >=3D $libseccomp_minver"
-            else
-                feature_not_found "libseccomp" \
-                    "libseccomp is not supported for host cpu $cpu"
-            fi
+            feature_not_found "libseccomp" \
+                 "Install libseccomp devel >=3D $libseccomp_minver"
         fi
         seccomp=3D"no"
     fi
--=20
2.17.2


