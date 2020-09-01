Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F36C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F70206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSUC6Boa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F70206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2Q8-0006f6-MP
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD2KP-0003Mi-Q8
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:11:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35938)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD2KN-0006qG-NT
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598951503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3z48+mTQRrcGpLheH51SDHiog+LS5vtfZFJ1Ox8RXDw=;
 b=aSUC6BoacAtC/Z7stZSwkJmuUNyEC95ZSjmVjnVLIwuH+I9ka4KGqQzMHhVIxmhwAbK3+e
 qYijmao+zhLgJbJHIqZMC+DnpdHZTIQiX6uqySIYIbkEWZtcz78L9hX/q2WD1LLXO6YTGy
 Te71grvEgmfuK5fGuNIhgGXAIwoTnF4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-IBTMCpEhMc6aD0kml3OIfg-1; Tue, 01 Sep 2020 05:11:41 -0400
X-MC-Unique: IBTMCpEhMc6aD0kml3OIfg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88667801AC9
 for <qemu-devel@nongnu.org>; Tue,  1 Sep 2020 09:11:40 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 397AE60C04;
 Tue,  1 Sep 2020 09:11:40 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/24] configure: rename confsuffix option
Date: Tue,  1 Sep 2020 05:11:19 -0400
Message-Id: <20200901091132.29601-12-pbonzini@redhat.com>
In-Reply-To: <20200901091132.29601-1-pbonzini@redhat.com>
References: <20200901091132.29601-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 01:27:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The value is used to construct conf/mod/data directories.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200826110419.528931-2-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index e8946aeefb..46fe7914c3 100755
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
@@ -1012,7 +1012,7 @@ if test "$mingw32" = "yes" ; then
     LIBS="-liberty $LIBS"
   fi
   prefix="c:/Program Files/QEMU"
-  confsuffix=""
+  qemu_suffix=""
   libs_qga="-lws2_32 -lwinmm -lpowrprof -lwtsapi32 -lwininet -liphlpapi -lnetapi32 $libs_qga"
 fi
 
@@ -1122,7 +1122,7 @@ for opt do
   ;;
   --datadir=*) datadir="$optarg"
   ;;
-  --with-confsuffix=*) confsuffix="$optarg"
+  --with-suffix=*) qemu_suffix="$optarg"
   ;;
   --docdir=*) qemu_docdir="$optarg"
   ;;
@@ -1832,16 +1832,16 @@ Advanced options (experts only):
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
@@ -6449,9 +6449,9 @@ EOF
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



