Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A587AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 749612173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFiwLNxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749612173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVCp-0001al-LQ
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:03:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV3v-00060R-4V
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV3u-0007dx-0j
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:07 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:37413)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV3t-0007aA-PN
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:05 -0500
Received: by mail-wr1-x430.google.com with SMTP id w15so17133180wru.4
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vEcKGbffw+zE4Kg4OdL7gu3XD1/KfyZzBwjSGef9vFo=;
 b=gFiwLNxUbQtwii3YYDbZYXfolO42rfZ7BTquom3jfPXkAjXvwWuiSmeyjiHRIZ88UI
 unggrtDCYPGQcrXeI1/e3Xg6IhSG7EwNo4QhG0wOqgGHasFRyjkiBFu2VFC9Nb7hbIwZ
 qmN39pMQsRl8HxeRW1UVqmmLCjtrSJTsZ3yml/k4dXf4HVFWswoQdSmf3B5yzLO63B1/
 w74Cvn/yUoUMA6t2vq9aPok2rE8j8nlF3MHNOmM07CQfv8Tntf8JdZ1bRnE/aScNr6Gx
 Fn3SVVbVdB9cf8h0pE6qv9FBeOwuSRYG8SzBgyWNuwqpQbCZV3Gtpj9G0kntBpj4obiZ
 DRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vEcKGbffw+zE4Kg4OdL7gu3XD1/KfyZzBwjSGef9vFo=;
 b=ceKoTsnKVPbIkHRc1CcBp91p53i5FXOBXnj0c8HpPE/i+xGXr9H3pjcoQ2GmXJPSqz
 eBAdBZPQMCE69SCvbKCV0zrVtnAb6o1Fb8rNtsem1ZX85E4es1Bw50E3wxnYrTU+fQvt
 6xuncXwuRYhpG56J8m0YUKxQz+6dpprVCV3nlwFnUl0vNrDLkugnj0e8EJoUzJa327i7
 7VuTVpGUWdSNijYDjjnTq1ctuqmnyvoHJgGpwovg6i/pGhF64Dy4xxLFieO6/4E57TGM
 vQ2Vov5QgHnFOGuM5UnJhkfMUqj/fHQBUVnsF4TOzimrjEdf/KWVRFtMNqmzru58MH1K
 ZMmA==
X-Gm-Message-State: APjAAAVHguUqTRJYG0hlfyu0BIWTKL8dE+EyM/y+QSQvtA5LojVVE3rR
 j+pygaiJMJIJOK1vyGzAUF5HGtl1
X-Google-Smtp-Source: APXvYqwD/T0o1Uralsbw9Ecld99e5r8JzPzqRbwrvsXkOF5kUv3rdajdurIRjNZHEPj8+vkTWo4EnA==
X-Received: by 2002:adf:8297:: with SMTP id 23mr28689780wrc.379.1580234043561; 
 Tue, 28 Jan 2020 09:54:03 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:54:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 006/142] configure: expand path variables for meson configure
Date: Tue, 28 Jan 2020 18:51:26 +0100
Message-Id: <20200128175342.9066-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/configure b/configure
index e85c8bc515..a9d0b92a55 100755
--- a/configure
+++ b/configure
@@ -405,16 +405,7 @@ DSOSUF=".so"
 LDFLAGS_SHARED="-shared"
 modules="no"
 prefix="/usr/local"
-mandir="\${prefix}/share/man"
-datadir="\${prefix}/share"
 firmwarepath="\${prefix}/share/qemu-firmware"
-qemu_docdir="\${prefix}/share/doc/qemu"
-bindir="\${prefix}/bin"
-libdir="\${prefix}/lib"
-libexecdir="\${prefix}/libexec"
-includedir="\${prefix}/include"
-sysconfdir="\${prefix}/etc"
-local_statedir="\${prefix}/var"
 confsuffix="/qemu"
 slirp=""
 oss_lib=""
@@ -933,12 +924,6 @@ if test "$mingw32" = "yes" ; then
     LIBS="-liberty $LIBS"
   fi
   prefix="c:/Program Files/QEMU"
-  mandir="\${prefix}"
-  datadir="\${prefix}"
-  qemu_docdir="\${prefix}"
-  bindir="\${prefix}"
-  sysconfdir="\${prefix}"
-  local_statedir=
   confsuffix=""
   libs_qga="-lws2_32 -lwinmm -lpowrprof -lwtsapi32 -lwininet -liphlpapi -lnetapi32 $libs_qga"
 fi
@@ -1548,6 +1533,26 @@ for opt do
   esac
 done
 
+libdir="${libdir:-$prefix/lib}"
+libexecdir="${libexecdir:-$prefix/libexec}"
+includedir="${includedir:-$prefix/include}"
+
+if test "$mingw32" = "yes" ; then
+    mandir="$prefix"
+    datadir="$prefix"
+    qemu_docdir="$prefix"
+    bindir="$prefix"
+    sysconfdir="$prefix"
+    local_statedir=
+else
+    mandir="${mandir:-$prefix/share/man}"
+    datadir="${datadir:-$prefix/share}"
+    qemu_docdir="${qemu_docdir:-$prefix/share/doc/qemu}"
+    bindir="${bindir:-$prefix/bin}"
+    sysconfdir="${sysconfdir:-$prefix/etc}"
+    local_statedir="${local_statedir:-$prefix/var}"
+fi
+
 case "$cpu" in
     ppc)
            CPU_CFLAGS="-m32"
-- 
2.21.0



