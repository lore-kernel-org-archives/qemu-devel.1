Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF357C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75AA0206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYwLDjgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75AA0206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOUe-0003Yh-5G
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyR-0003eC-P8
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyQ-0006uD-Ja
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:43 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:34216)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyQ-0006sK-At
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:42 -0500
Received: by mail-wr1-x42c.google.com with SMTP id t2so2645062wrr.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AtwMOLvxXn85AOzw7ez1xNn8Y3y0JTmxG03ZrTDH7vU=;
 b=PYwLDjgbUYegUpgA0HKTrVR7svYP7IQS/u0m9yYSEBx9wRURIxfyBz+JtdiT1GYVw7
 kaOMIGhRszTcHJlYD+rtAryf/Srk6TYeh4kXh8FgPv+gRXJMbvzvTXqCpyFcwJ497C67
 cIA/KQ+5O5aaxXCCh6hsdzcqjXkWXjceSVPWbjVTVjOcmTIY6eay35izeptQraMJdsqo
 e2ka6ZgfZbzCcrkZ67ttrwPPJtS0DVJ2I0GSR+jL/bDg6GQfFIjTeFQFZpJMpLq2Q8Wi
 T3lPzVqUQXjVyORbSgv6Bla1beJPG5UIh1IWqFqt6xCZfdf8FRKlDkyCx5sVyAQl7GUK
 eCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=AtwMOLvxXn85AOzw7ez1xNn8Y3y0JTmxG03ZrTDH7vU=;
 b=uFj45oEd4i4SGat/r3SxCfauuz2IdBYqO4EcfR6+fwjCazUD4GxbHRN6ga5O5wESEd
 jvbkfX5U34FzfOd8gTT7b0g/mHDBES/iaGqUrHuhqVIz53t6lwH5vEmJbpe6uGvkP/Du
 u6HowWeUim4+g2cMcC62/B6pE0QqZuLAhOs9j1UIgp/Ku8+4iu9MBqLkgg3y60iA8KiS
 02ET/Q4GZNar/+FqwMDm+jtDYKRXcVPWQS73clfOFOMkmJ2lGRmoUHHLgsGEhjkraLWe
 QoLcxswnYZPqebVZYssreqPu31qttvW/fbB9nBZAvo+Uf5ZcWnTxpqWfxC/BjSKEdNbh
 Ii3A==
X-Gm-Message-State: APjAAAUYV/cjkrJ6ZnNj33E4YI3Qk2EPsWi94p+Rh7iVWTNMMdL+Iyw5
 S89qNfBlfGKDTdjUCYw3z8LsU/h5
X-Google-Smtp-Source: APXvYqyveVTDWjdy4dKQPwTt+nfHPni3TPBbxFgJj8MLqO2SnHo0ESDaQxJXnYr/EaK2GfwF/LuvWA==
X-Received: by 2002:a5d:4d0e:: with SMTP id z14mr5995838wrt.208.1576155221034; 
 Thu, 12 Dec 2019 04:53:41 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 043/132] meson: qemu-{img,io,nbd}
Date: Thu, 12 Dec 2019 13:51:27 +0100
Message-Id: <1576155176-2464-44-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile    | 6 ------
 configure   | 6 ------
 meson.build | 8 +++++++-
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index cdd9d14..764981d 100644
--- a/Makefile
+++ b/Makefile
@@ -231,12 +231,6 @@ Makefile: $(version-obj-y)
 
 COMMON_LDADDS = libqemuutil.a
 
-qemu-img.o: qemu-img-cmds.h
-
-qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
-qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
-qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
-
 scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(authz-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 ifdef CONFIG_MPATH
 scsi/qemu-pr-helper$(EXESUF): LIBS += -ludev -lmultipath -lmpathpersist
diff --git a/configure b/configure
index 7be08f3..964897c 100755
--- a/configure
+++ b/configure
@@ -6043,12 +6043,6 @@ if [ "$eventfd" = "yes" ]; then
 fi
 
 tools=""
-if test "$want_tools" = "yes" ; then
-  tools="qemu-img\$(EXESUF) qemu-io\$(EXESUF) $tools"
-  if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
-    tools="qemu-nbd\$(EXESUF) $tools"
-  fi
-fi
 if test "$softmmu" = yes ; then
   if test "$linux" = yes; then
     if test "$virtfs" != no && test "$cap_ng" = yes && test "$attr" = yes ; then
diff --git a/meson.build b/meson.build
index a46b671..2b4b36d 100644
--- a/meson.build
+++ b/meson.build
@@ -280,7 +280,7 @@ if have_system
   ]
 endif
 foreach d : hx_headers
-  custom_target(d[1],
+  hxdep += custom_target(d[1],
                 input: files(d[0]),
                 output: d[1],
                 capture: true,
@@ -591,6 +591,12 @@ if 'CONFIG_GUEST_AGENT' in config_host
 endif
 
 if have_tools
+  executable('qemu-img', [files('qemu-img.c'), hxdep], dependencies: [block, qemuutil], install: true)
+  if host_machine.system() == 'linux' or host_machine.system() == 'sunos' or host_machine.system().endswith('bsd')
+    executable('qemu-nbd', files('qemu-nbd.c'), dependencies: [block, qemuutil], install: true)
+  endif
+  executable('qemu-io', files('qemu-io.c'), dependencies: [block, qemuutil], install: true)
+
   subdir('contrib/rdmacm-mux')
   subdir('contrib/elf2dmp')
 
-- 
1.8.3.1



