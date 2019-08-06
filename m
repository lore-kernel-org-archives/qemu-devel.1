Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D00C433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 07:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6403B2070C
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 07:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsMHLsYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6403B2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huteK-0000m7-Mm
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 03:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39692)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hutcr-00062n-4y
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 03:11:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hutcq-0002Ja-9J
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 03:11:17 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50227)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hutcq-0002J8-3l
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 03:11:16 -0400
Received: by mail-wm1-x341.google.com with SMTP id v15so77042500wml.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 00:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ISCXSuP/8F/E4NmvMxriKXqE9RtwYHC6S116zsIjPhM=;
 b=XsMHLsYt2F1ev3t9MK2uSN55BkyjnPqwgSP43OK85wUxqDSWYa3VnQOJ5S3pbpl0uL
 Ae+g4iDWzhjyoAOAdY+oZpopwD6fQpYmnf/Llg0m9NiEb8q+sr5DO8q4+cHJ13+hzHtA
 UNmrdZBvJnRmVQO7Lu+FY6gb9xUrJcQvH4Ahy0dc/CBRVQROnVSSnDnqscTYGv/6dPE3
 t/WmU2y2jkW/RW8rvjOLGnu5sBoUANR17Xnqt/WVMA79hTyVGwM9Gt6xCNsbxomWPtVS
 4coGBz7+d1DeRfvyiOvwgJwBO94GjTLRWlHy+bYsMBibQmntJrfG6kQ86Tn6/bFMzEZU
 yj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=ISCXSuP/8F/E4NmvMxriKXqE9RtwYHC6S116zsIjPhM=;
 b=FRv3Wwn0lBKIreiUxFmotutKWBzdT9clLWzrb+YX010KgCRgwkoMSagMJas9Dgflxg
 RZ4vTV6JzySGfIFpLFSdSU2WLgqJCMK6B4BIkhdECWkdMF8op+G39uNv0ZtR2X4867XH
 V8RAn8ykHqfxQ0nfQ+lgMC256lE4PyQfJF3J8vm7aFgvfLk8cH3qs9TIYOdNJJpWo6+S
 m6P4G4oP2bKHYYPEztEcqLSSxDOhry2yonVgYd106RZO5ex3NZq3YctKhpXeJsQlnrsR
 QpcgjXfuYiM9/8fWTrckSGNj++R+i/V/wKKGrtkrRuKyDNT2tUqAsbAVD3HUO6REmDqK
 QZWQ==
X-Gm-Message-State: APjAAAXWqxNpWaRMnGc6/hepp7A2PcEuUplcZXV7ct2yuvEWaWaJOR1t
 DNtQZu5UDdkYG8JB9YKoyR2LNHSJ
X-Google-Smtp-Source: APXvYqxYxNagC+b/9k/9bUQV8HYUgwiHXy98qsB/ABz93AJoSPlapUsOFu1SnvR4c1o4N5bqnRvneQ==
X-Received: by 2002:a05:600c:212:: with SMTP id
 18mr2751270wmi.88.1565075474950; 
 Tue, 06 Aug 2019 00:11:14 -0700 (PDT)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id l8sm167825586wrg.40.2019.08.06.00.11.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Aug 2019 00:11:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  6 Aug 2019 09:11:12 +0200
Message-Id: <1565075472-15106-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH] configure: remove AUTOCONF_HOST
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

This is a left-over from commit
c12b6d70e384c769ca372e15ffd19b3e9f563662 ("pixman: drop submodule")

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/configure b/configure
index c5a5b44..ae70780 100755
--- a/configure
+++ b/configure
@@ -7346,11 +7346,6 @@ if test "$sparse" = "yes" ; then
   echo "HOST_CC      := REAL_CC=\"\$(HOST_CC)\" cgcc"  >> $config_host_mak
   echo "QEMU_CFLAGS  += -Wbitwise -Wno-transparent-union -Wno-old-initializer -Wno-non-pointer-null" >> $config_host_mak
 fi
-if test "$cross_prefix" != ""; then
-  echo "AUTOCONF_HOST := --host=${cross_prefix%-}"     >> $config_host_mak
-else
-  echo "AUTOCONF_HOST := "                             >> $config_host_mak
-fi
 echo "LDFLAGS=$LDFLAGS" >> $config_host_mak
 echo "LDFLAGS_NOPIE=$LDFLAGS_NOPIE" >> $config_host_mak
 echo "QEMU_LDFLAGS=$QEMU_LDFLAGS" >> $config_host_mak
-- 
1.8.3.1


