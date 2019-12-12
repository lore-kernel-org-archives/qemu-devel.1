Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C05DC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:21:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358C121655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p28New7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358C121655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOOq-0002qv-Qx
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:21:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNy9-0003A6-Vw
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNy8-0006JE-Pc
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:25 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:39013)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNy8-0006HZ-Ib
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:24 -0500
Received: by mail-wm1-x330.google.com with SMTP id d5so2374822wmb.4
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s/XxOv3v8yWIEINkNyhklSprKPX+gu5M/S5mfVQYviU=;
 b=p28New7zU64hcnMnqpVn1jvz1Ag1iuA9FnWsTEnYaN3NdeaM2+ZfdYoUaicJ2YcXhS
 B9tYIBkqnnYEBG1olqgPQHRhb0gAAmbe43gf5KOiHK1Peh/mQmXa57FVC2tjw0Iun0rM
 Tdb3NUBo4kvNKlnVhBrT6At3UZrA9LCOTjECYodXzSQCauYOdfllVggGj9/Z4K5fqr8P
 ERSyMtdv1MtGmgy/Ox4iEWPm+ISoIKnx1o3WU1LJTKupqMWK400UivmdTlnv4IEA9RG2
 FMOByAuPtb8gg4JO6cldvsAChY4duSUqCj+66p2ds4P2kMz/KFb62zeK6XX0NjANYp7w
 QWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=s/XxOv3v8yWIEINkNyhklSprKPX+gu5M/S5mfVQYviU=;
 b=Rua9oUiazKAMR9/UHDz9pWQqASmqCPJPY87/HJ543M93YICc+/tbapQXh0sFwGRSsI
 L6qE6ZvP7cPyXg9ttxuUVg0v5bAhOSwl1n+vgmK/FZ8rObJi/gK9ggf/VVxZeXJebx/T
 L1irem8qfTxCcS8ng8oPmsc1BbEom4zukvfPfhEEN4H4aYd2h2oq+Y5RAnziT7D/Hn9W
 dZPjPlT/3GgGKRRhYmcyOD9ySLJgN9s3qjPAlV8DWnSPyMx7Mp/Vd/R87NC7mixWTFNf
 8gqEfTetCjbg1+fvsv+zyZSZs1YsiPT9Yt44YLcXxl+chvQuLtLZKnGPIdfo3LYk+8w6
 txhA==
X-Gm-Message-State: APjAAAUJWZN+anwRRgN7mLbvEA13XHBB8KLExxcOpA5Uyq5OgejUZnFf
 tnuEKGeRnNH4ZP0yHR8Aea0HYbgm
X-Google-Smtp-Source: APXvYqzxu9sKAou26SXbhfTWJZ3eFaqHnZSdMXFSTWjKCRMt+twbaxu4bBBF0DA4MgpyWmGIxsSwnw==
X-Received: by 2002:a1c:e909:: with SMTP id q9mr6758500wmc.30.1576155203343;
 Thu, 12 Dec 2019 04:53:23 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 025/132] meson: add qemu-edid
Date: Thu, 12 Dec 2019 13:51:09 +0100
Message-Id: <1576155176-2464-26-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
 Makefile    | 2 --
 configure   | 2 +-
 meson.build | 3 +++
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index fe4df0d..6a888b0 100644
--- a/Makefile
+++ b/Makefile
@@ -372,8 +372,6 @@ qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io
 qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 
-qemu-edid$(EXESUF): qemu-edid.o hw/display/edid-generate.o $(COMMON_LDADDS)
-
 fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p-marshal.o fsdev/9p-iov-marshal.o $(COMMON_LDADDS)
 fsdev/virtfs-proxy-helper$(EXESUF): LIBS += -lcap
 
diff --git a/configure b/configure
index d05c0de..0b294bb 100755
--- a/configure
+++ b/configure
@@ -6041,7 +6041,7 @@ fi
 
 tools=""
 if test "$want_tools" = "yes" ; then
-  tools="qemu-img\$(EXESUF) qemu-io\$(EXESUF) qemu-edid\$(EXESUF) $tools"
+  tools="qemu-img\$(EXESUF) qemu-io\$(EXESUF) $tools"
   if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
     tools="qemu-nbd\$(EXESUF) $tools"
   fi
diff --git a/meson.build b/meson.build
index 14a8a9a..e5b0e31 100644
--- a/meson.build
+++ b/meson.build
@@ -234,6 +234,9 @@ if have_tools
                dependencies: [qemuutil, xkbcommon], install: true)
   endif
 
+  executable('qemu-edid', files('qemu-edid.c', 'hw/display/edid-generate.c'),
+             dependencies: qemuutil)
+
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
     subdir('contrib/vhost-user-blk')
-- 
1.8.3.1



