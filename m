Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9244C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:15:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD1802081C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1802081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54006 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMEMi-0005Zs-S9
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 12:15:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMEL5-0004H6-Cg
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMEL4-0002MP-Cm
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hMEL4-0002MD-6v
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 80EF73086237;
	Thu,  2 May 2019 16:13:37 +0000 (UTC)
Received: from thuth.com (ovpn-116-131.ams2.redhat.com [10.36.116.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 149BA1837B;
	Thu,  2 May 2019 16:13:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Thu,  2 May 2019 18:13:09 +0200
Message-Id: <20190502161310.15624-8-thuth@redhat.com>
In-Reply-To: <20190502161310.15624-1-thuth@redhat.com>
References: <20190502161310.15624-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Thu, 02 May 2019 16:13:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 7/8] configure: Relax check for libseccomp
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
Cc: Eduardo Otubo <otubo@redhat.com>, Helge Deller <deller@gmx.de>,
	Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502161309.ZgHmxllqlJv8LRK34vl4mmXSNB7VSHOYimbJy3dIamY@z>

From: Helge Deller <deller@gmx.de>

All major distributions do support libseccomp version >=3D 2.3.0, so ther=
e
is no need to special-case on various architectures any longer.

Signed-off-by: Helge Deller <deller@gmx.de>
Message-Id: <20190404183923.GA22347@ls3530.dellerweb.de>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Eduardo Otubo <otubo@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/configure b/configure
index f14b25c49c..3a9bee2621 100755
--- a/configure
+++ b/configure
@@ -2374,36 +2374,16 @@ fi
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
2.21.0


