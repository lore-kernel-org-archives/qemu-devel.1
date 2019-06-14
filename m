Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFF5C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 10:11:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432B620665
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 10:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432B620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49838 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbjBc-0005mT-GP
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 06:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48728)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbj7u-0003nq-Ok
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbj7s-0000P9-Se
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:08:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33406)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hbj7p-0000FS-6b; Fri, 14 Jun 2019 06:08:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 67F6386676;
 Fri, 14 Jun 2019 10:08:00 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 416F01001B1B;
 Fri, 14 Jun 2019 10:07:54 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 12:07:13 +0200
Message-Id: <20190614100718.14019-5-philmd@redhat.com>
In-Reply-To: <20190614100718.14019-1-philmd@redhat.com>
References: <20190614100718.14019-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 14 Jun 2019 10:08:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 4/9] configure: Link test before
 auto-enabling libusbredir library
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Bharata B Rao <bharata@linux.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Niels de Vos <ndevos@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similarly to commit a73e82ef912, test the library links correctly
before considering it as usable.

This fixes using ./configure --static on Ubuntu 18.04:

  $ make subdir-aarch64-softmmu
  [...]
    LINK    aarch64-softmmu/qemu-system-aarch64
  /usr/bin/ld: cannot find -lusbredirparser
  collect2: error: ld returned 1 exit status
  Makefile:204: recipe for target 'qemu-system-aarch64' failed
  make[1]: *** [qemu-system-aarch64] Error 1

  $ fgrep redir config-host.mak
  USB_REDIR_LIBS=3D-lusbredirparser

  $ lsb_release -cri
  Distributor ID: Ubuntu
  Release:        18.04
  Codename:       bionic

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 configure | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 2ebaa32746..0dd6e8bed3 100755
--- a/configure
+++ b/configure
@@ -4918,9 +4918,19 @@ fi
 # check for usbredirparser for usb network redirection support
 if test "$usb_redir" !=3D "no" ; then
     if $pkg_config --atleast-version=3D0.6 libusbredirparser-0.5; then
-        usb_redir=3D"yes"
         usb_redir_cflags=3D$($pkg_config --cflags libusbredirparser-0.5)
         usb_redir_libs=3D$($pkg_config --libs libusbredirparser-0.5)
+        # Packaging for the static libraries is not always correct.
+        # At least ubuntu 18.04 ships only shared libraries.
+        write_c_skeleton
+        if ! compile_prog "$usb_redir_cflags" "$usb_redir_libs" ; then
+            if test "$usb_redir" =3D "yes" ; then
+              error_exit "usbredir check failed."
+            fi
+            usb_redir=3D"no"
+        else
+            usb_redir=3D"yes"
+        fi
     else
         if test "$usb_redir" =3D "yes"; then
             feature_not_found "usb-redir" "Install usbredir devel"
--=20
2.20.1


