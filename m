Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CAAC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:31:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B0892176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3nODk+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0892176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYUX-0002gj-1Z
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:31:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3A-0006Lh-4Z
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY38-0000ej-IC
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:31 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37887)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY38-0000az-9L
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:30 -0500
Received: by mail-wm1-x342.google.com with SMTP id f129so1610982wmf.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3VnxJZY4tD2v4gsJNEYlwpenNaYCda4MoHpaOzUowl4=;
 b=p3nODk+2jHEUOc4dsL39MrnoixejOfyMPbgVtW4GFUV76pRDQp+my4Ym7kRnW0wuQ/
 /fN2Q2lsk50Qv8gDffHgC9io/ofBvZrQO8dHlQsMFLl4N/ipw6rLv7ZRF0227zis+aR6
 8VY/x+pNLJsf2Kh3Akak3wwRmv7gmhH+uXC5ckHLlDaZ2hEy2k5C8VaiQ7aOi8VPEqwW
 +XNo9kabhSLOBhJ7SzK8G8I4jMHis5IThNd1UB4lVdbvBexeij76xPnqzXIwsEUo9QVt
 xzjTmLnxee3J1Ywos58Ja0eLh6dYDS/G/XjAP259F3LBswgswgpM+2UYne7zwyV181m4
 hITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3VnxJZY4tD2v4gsJNEYlwpenNaYCda4MoHpaOzUowl4=;
 b=E4DdhGymASa1mTNWhXJBFontRp1xF4oDjw3eb3wkfsLTjKypDL1msvA0oGECNfzzwf
 ubgC8L1bsHV5JmXgq+frxuwBTShegME7WV7FJazFjWtytQIRnROwnfS9nXht9haA241e
 vHOxTv4RTN/Sb+6uDTuyjBb1tqYxBm2KHvMrftAzM5OJMFQyiUXGuCvTsG3WM+dmh8Kr
 4BLYjPySh2mWC7eurAJG1opEcbFzRtuWKqJKoKU3abr3QcFPTX67vwiOwjr3T40FbBlo
 DydNJ8vDbxo7STq0t/VXjotsmRc3A6tx17FKw1hatR0jVXYiGX1rKoHVlveHhjQmryt0
 3stQ==
X-Gm-Message-State: APjAAAXODekHOlGQG4G0w4OsZALLBxnogA/EJZXw49MhIzi42O+CI8fY
 kWQ9Xvi8ST9Sr8GWOZK67WfaPO2j
X-Google-Smtp-Source: APXvYqz75hNPofecjyvZyeKJPfEJkrYw0UbOMRD9lRxrHneYDOkYkp5uYGsC2BUGTOKSeN6NWG8nUA==
X-Received: by 2002:a1c:1bc3:: with SMTP id b186mr2852139wmb.79.1576670608922; 
 Wed, 18 Dec 2019 04:03:28 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 33/87] build-sys: do not include Windows SLIRP dependencies in
 $LIBS
Date: Wed, 18 Dec 2019 13:01:59 +0100
Message-Id: <1576670573-48048-34-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When including the internal SLIRP library, we should add all the libraries that
it needs for the build.  Right now they are all included by QEMU, but -liphlpapi
is not needed without slirp.  Move it from LIBS to slirp_libs.

Based on a patch by Marc-André Lureau.

Acked-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 84b413d..55d386c 100755
--- a/configure
+++ b/configure
@@ -925,7 +925,7 @@ if test "$mingw32" = "yes" ; then
   DSOSUF=".dll"
   # MinGW needs -mthreads for TLS and macro _MT.
   QEMU_CFLAGS="-mthreads $QEMU_CFLAGS"
-  LIBS="-lwinmm -lws2_32 -liphlpapi $LIBS"
+  LIBS="-lwinmm -lws2_32 $LIBS"
   write_c_skeleton;
   if compile_prog "" "-liberty" ; then
     LIBS="-liberty $LIBS"
@@ -6027,6 +6027,9 @@ case "$slirp" in
     mkdir -p slirp
     slirp_cflags="-I\$(SRC_PATH)/slirp/src -I\$(BUILD_DIR)/slirp/src"
     slirp_libs="-L\$(BUILD_DIR)/slirp -lslirp"
+    if test "$mingw32" = "yes" ; then
+      slirp_libs="$slirp_libs -lws2_32 -liphlpapi"
+    fi
     ;;
 
   system)
-- 
1.8.3.1



