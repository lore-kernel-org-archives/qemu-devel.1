Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBFAC31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 10:11:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D8120665
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 10:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D8120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49836 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbjBU-0005X9-LY
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 06:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48563)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbj7W-0003eQ-Sw
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbj7V-00007Y-T9
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:07:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35636)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hbj7T-00005z-FF; Fri, 14 Jun 2019 06:07:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AECEA3082E23;
 Fri, 14 Jun 2019 10:07:38 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8355F1001B2F;
 Fri, 14 Jun 2019 10:07:32 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 12:07:10 +0200
Message-Id: <20190614100718.14019-2-philmd@redhat.com>
In-Reply-To: <20190614100718.14019-1-philmd@redhat.com>
References: <20190614100718.14019-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 14 Jun 2019 10:07:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 1/9] configure: Only generate GLUSTERFS
 variables if glusterfs is usable
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

It is pointless and confusing to have GLUSTERFS variables
in config-host.mak when glusterfs is not usable.

Reviewed-by: Niels de Vos <ndevos@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 configure | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/configure b/configure
index b091b82cb3..13fd4a1166 100755
--- a/configure
+++ b/configure
@@ -7118,30 +7118,30 @@ if test "$glusterfs" =3D "yes" ; then
   echo "CONFIG_GLUSTERFS=3Dm" >> $config_host_mak
   echo "GLUSTERFS_CFLAGS=3D$glusterfs_cflags" >> $config_host_mak
   echo "GLUSTERFS_LIBS=3D$glusterfs_libs" >> $config_host_mak
-fi
=20
-if test "$glusterfs_xlator_opt" =3D "yes" ; then
-  echo "CONFIG_GLUSTERFS_XLATOR_OPT=3Dy" >> $config_host_mak
-fi
+  if test "$glusterfs_xlator_opt" =3D "yes" ; then
+    echo "CONFIG_GLUSTERFS_XLATOR_OPT=3Dy" >> $config_host_mak
+  fi
=20
-if test "$glusterfs_discard" =3D "yes" ; then
-  echo "CONFIG_GLUSTERFS_DISCARD=3Dy" >> $config_host_mak
-fi
+  if test "$glusterfs_discard" =3D "yes" ; then
+    echo "CONFIG_GLUSTERFS_DISCARD=3Dy" >> $config_host_mak
+  fi
=20
-if test "$glusterfs_fallocate" =3D "yes" ; then
-  echo "CONFIG_GLUSTERFS_FALLOCATE=3Dy" >> $config_host_mak
-fi
+  if test "$glusterfs_fallocate" =3D "yes" ; then
+    echo "CONFIG_GLUSTERFS_FALLOCATE=3Dy" >> $config_host_mak
+  fi
=20
-if test "$glusterfs_zerofill" =3D "yes" ; then
-  echo "CONFIG_GLUSTERFS_ZEROFILL=3Dy" >> $config_host_mak
-fi
+  if test "$glusterfs_zerofill" =3D "yes" ; then
+    echo "CONFIG_GLUSTERFS_ZEROFILL=3Dy" >> $config_host_mak
+  fi
=20
-if test "$glusterfs_ftruncate_has_stat" =3D "yes" ; then
-  echo "CONFIG_GLUSTERFS_FTRUNCATE_HAS_STAT=3Dy" >> $config_host_mak
-fi
+  if test "$glusterfs_ftruncate_has_stat" =3D "yes" ; then
+    echo "CONFIG_GLUSTERFS_FTRUNCATE_HAS_STAT=3Dy" >> $config_host_mak
+  fi
=20
-if test "$glusterfs_iocb_has_stat" =3D "yes" ; then
-  echo "CONFIG_GLUSTERFS_IOCB_HAS_STAT=3Dy" >> $config_host_mak
+  if test "$glusterfs_iocb_has_stat" =3D "yes" ; then
+    echo "CONFIG_GLUSTERFS_IOCB_HAS_STAT=3Dy" >> $config_host_mak
+  fi
 fi
=20
 if test "$libssh2" =3D "yes" ; then
--=20
2.20.1


