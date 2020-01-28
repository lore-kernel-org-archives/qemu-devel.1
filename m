Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AEBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D798E20716
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n36Lbzq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D798E20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVYL-0006C7-VC
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:25:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4r-0007cl-5c
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4q-0001Bl-1E
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:05 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:35700)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV4o-00017H-PI
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:03 -0500
Received: by mail-wm1-x32f.google.com with SMTP id b2so3591819wma.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qQw8zzE7AoNvqb9tGGr9+L52Yo+xg0N0SwkldFPS5Hw=;
 b=n36Lbzq0qqKC0LmQmbWl8TEuxXPYUbztz7zVjX2qAHuOtlO+PCnlB+v+6bbU3Rrnqs
 0KEtqJdaf7Db6Mr7eOvh2lZ+1nB2p+RurUuguFrCqVbJll5LrOOTs1iLmjWqqJ6nkQtP
 DtcJ/s9UJ9i/ALr3/icUmIvr6sp54KUD3lHXyjRvB1lFvM5OByxwwyzoLliyMK0n90xz
 P9R8c31oU1EYNXOuV+tdYJu7DpwSsbSSwKbl9cLuhbTls1lZZNkbWN71CcNxEOyQeFFO
 9b06QfvqwS+VyAY5UhMogwjU0RiTfDe91nIVAxb0aiGvM46kbfBWJEoLoD1rqM8SGtcb
 Gc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=qQw8zzE7AoNvqb9tGGr9+L52Yo+xg0N0SwkldFPS5Hw=;
 b=eiDItYVyAETgkKuHKl3ARZMojlo/sji9TyUG8IeglYV4P9kI3Hqh0kCufFZ47eAFpe
 isKIMfYYT/Yth7vACBHr/35sUAl9SVNz+jQd7KBRsMCsUf9okkZvBNT+tf77FSqxhfra
 gRip7LFhx54iemoDPeCKG+i6vzB1zmoxl39Y3a+rrxCXvnSMV4FKzcFU6YBzn5MFJNyp
 +MyU+Ye1QW07b02EVghVd+L422bOqebWfq/rZzfx5pMD7tcVJA2He1DEeYcGyHf3nkdz
 DcjeaXh4q0weDkQKx+bNrcM/+iFa2wxnHW+oFs+hMtTy0g/cTtgDsuyWpfrksR583JFg
 aPpg==
X-Gm-Message-State: APjAAAX2670ny1Ok7QVp5ecCxScrxgJBj/3rrG3+pL8xYozEmOJs1jWr
 qVkkohmzxrPKHJQunLIL6gST2v+x
X-Google-Smtp-Source: APXvYqzWOpoHPhoS/dmYDlgtLgTTt+t47/TFGV04y5tf/UPjT1gW0gsoV04C3MqTCj2YcD0Gd5/g+Q==
X-Received: by 2002:a7b:c152:: with SMTP id z18mr6235208wmi.70.1580234101512; 
 Tue, 28 Jan 2020 09:55:01 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:55:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 030/142] meson: add qemu-edid
Date: Tue, 28 Jan 2020 18:51:50 +0100
Message-Id: <20200128175342.9066-31-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
 Makefile    | 2 --
 configure   | 2 +-
 meson.build | 3 +++
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index ae9f1157d8..f4965823c6 100644
--- a/Makefile
+++ b/Makefile
@@ -401,8 +401,6 @@ qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io
 qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 
-qemu-edid$(EXESUF): qemu-edid.o hw/display/edid-generate.o $(COMMON_LDADDS)
-
 fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p-marshal.o fsdev/9p-iov-marshal.o $(COMMON_LDADDS)
 
 scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(authz-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
diff --git a/configure b/configure
index 0b8b31aedb..6d0d0b5b72 100755
--- a/configure
+++ b/configure
@@ -6202,7 +6202,7 @@ fi
 
 tools=""
 if test "$want_tools" = "yes" ; then
-  tools="qemu-img\$(EXESUF) qemu-io\$(EXESUF) qemu-edid\$(EXESUF) $tools"
+  tools="qemu-img\$(EXESUF) qemu-io\$(EXESUF) $tools"
   if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
     tools="qemu-nbd\$(EXESUF) $tools"
   fi
diff --git a/meson.build b/meson.build
index b8707f25d2..229d625bb4 100644
--- a/meson.build
+++ b/meson.build
@@ -250,6 +250,9 @@ if have_tools
                dependencies: [qemuutil, xkbcommon], install: true)
   endif
 
+  executable('qemu-edid', files('qemu-edid.c', 'hw/display/edid-generate.c'),
+             dependencies: qemuutil)
+
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
     subdir('contrib/vhost-user-blk')
-- 
2.21.0



