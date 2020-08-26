Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16881C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9D592083B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByHSiUMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D592083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtJY-0004Rw-4a
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAtGK-0006Kz-2E
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21273)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAtEN-000388-KH
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598439877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D1g26c41eGJ9JbqAKW+ebPsU6Pne8C9pH3fo35R4NN0=;
 b=ByHSiUMjwH1mMcavTFx5hTYPAuLyBMQxKTBxnjK60gULEn9hBPj4QX6V0qiE+CH1+UrgTV
 LMv05GN/7F8+pPbPII4M2L7yRBMrXDyK97UegAXPHEjYyGSU5FijzifbLPb3HBBX1+J1/m
 Gx4OV+HbVx8cMS4xPzZ8reoo2+ei/04=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-XPrvDIJvORq-V-t20je54w-1; Wed, 26 Aug 2020 07:04:35 -0400
X-MC-Unique: XPrvDIJvORq-V-t20je54w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 839E856BE4;
 Wed, 26 Aug 2020 11:04:34 +0000 (UTC)
Received: from localhost (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DED2139A55;
 Wed, 26 Aug 2020 11:04:30 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/8] configure: rename confsuffix option
Date: Wed, 26 Aug 2020 15:04:12 +0400
Message-Id: <20200826110419.528931-2-marcandre.lureau@redhat.com>
In-Reply-To: <20200826110419.528931-1-marcandre.lureau@redhat.com>
References: <20200826110419.528931-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 23:30:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: sw@weilnetz.de, berrange@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The value is used to construct conf/mod/data directories.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configure | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index b1e11397a8..0e04c47722 100755
--- a/configure
+++ b/configure
@@ -474,7 +474,7 @@ modules="no"
 module_upgrades="no"
 prefix="/usr/local"
 firmwarepath="\${prefix}/share/qemu-firmware"
-confsuffix="/qemu"
+qemu_suffix="/qemu"
 slirp=""
 oss_lib=""
 bsd="no"
@@ -1010,7 +1010,7 @@ if test "$mingw32" = "yes" ; then
     LIBS="-liberty $LIBS"
   fi
   prefix="c:/Program Files/QEMU"
-  confsuffix=""
+  qemu_suffix=""
   libs_qga="-lws2_32 -lwinmm -lpowrprof -lwtsapi32 -lwininet -liphlpapi -lnetapi32 $libs_qga"
 fi
 
@@ -1118,7 +1118,7 @@ for opt do
   ;;
   --datadir=*) datadir="$optarg"
   ;;
-  --with-confsuffix=*) confsuffix="$optarg"
+  --with-suffix=*) qemu_suffix="$optarg"
   ;;
   --docdir=*) qemu_docdir="$optarg"
   ;;
@@ -1823,16 +1823,16 @@ Advanced options (experts only):
   --with-git=GIT           use specified git [$git]
   --static                 enable static build [$static]
   --mandir=PATH            install man pages in PATH
-  --datadir=PATH           install firmware in PATH$confsuffix
-  --docdir=PATH            install documentation in PATH$confsuffix
+  --datadir=PATH           install firmware in PATH$qemu_suffix
+  --docdir=PATH            install documentation in PATH$qemu_suffix
   --bindir=PATH            install binaries in PATH
   --libdir=PATH            install libraries in PATH
   --libexecdir=PATH        install helper binaries in PATH
-  --sysconfdir=PATH        install config in PATH$confsuffix
+  --sysconfdir=PATH        install config in PATH$qemu_suffix
   --localstatedir=PATH     install local state in PATH (set at runtime on win32)
   --firmwarepath=PATH      search PATH for firmware files
   --efi-aarch64=PATH       PATH of efi file to use for aarch64 VMs.
-  --with-confsuffix=SUFFIX suffix for QEMU data inside datadir/libdir/sysconfdir [$confsuffix]
+  --with-suffix=SUFFIX     suffix for QEMU data inside datadir/libdir/sysconfdir [$qemu_suffix]
   --with-pkgversion=VERS   use specified string as sub-version of the package
   --enable-debug           enable common debug build options
   --enable-sanitizers      enable default sanitizers
@@ -6467,9 +6467,9 @@ EOF
     fi
 fi
 
-qemu_confdir=$sysconfdir$confsuffix
-qemu_moddir=$libdir$confsuffix
-qemu_datadir=$datadir$confsuffix
+qemu_confdir=$sysconfdir$qemu_suffix
+qemu_moddir=$libdir$qemu_suffix
+qemu_datadir=$datadir$qemu_suffix
 qemu_localedir="$datadir/locale"
 qemu_icondir="$datadir/icons"
 qemu_desktopdir="$datadir/applications"
-- 
2.26.2


