Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0E5C3F2CD
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 16:36:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70765222C4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 16:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4Z145Ud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70765222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8RZm-0004Ns-LR
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 11:36:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcfaracco@gmail.com>) id 1j8RYw-0003rt-R6
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 11:35:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcfaracco@gmail.com>) id 1j8RYv-0008Uo-PK
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 11:35:30 -0500
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:34835)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcfaracco@gmail.com>) id 1j8RYv-0008UY-Je
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 11:35:29 -0500
Received: by mail-qt1-x843.google.com with SMTP id 88so5791591qtc.2
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2020 08:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VXJc2C2zW9dt8LfAK07yfI5Ta+8Bpw27jkjvWF6BEok=;
 b=e4Z145Ud/MI7IvwBNSzaMJYcpUDywiQ5w0884lAJqJPX5UOqqu2YZlTo3vVUZBzyDj
 I0d3mBrzFnTYbBtO8RfCD6wjy3sXDquvQucS2F04TTwXxFldCVk2xRwaPgHPZvCPt/bB
 +ACtMXNBG2B4zsdZtjqDXE8qsHEz09dhdgggQaUpemvMCCaztygcTnjrWyM8CFI1K+Nr
 Zqq0XOhRhjiRwVmw81JQjCAq1biLFcxJxdg99kR0w2OfxHqUpj5y+SRa2tvYG9ZOjTYp
 YdahPapNttI7ZS7QwtFMCB5/DGN6L8XkWUs5Uk0r0F++CMnMFkrDNP2ZAwOxbb8H7OQ1
 yHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VXJc2C2zW9dt8LfAK07yfI5Ta+8Bpw27jkjvWF6BEok=;
 b=fE2TBAtSODMmCoQ8NZyUqXM1zzY10gtPGYeUYmJhdYAYoI0cadGwTyT/gmLI3+SLVU
 CI10JhIEQBmrj0PIEgQMhzt7NgHKJxk0bGsh7Jc0goimgoG3/CEemaK7rkf9f2UjuWx1
 1IHyQ7V87Js+1ioI1o0rvYCcVVSF4vVf3QojiCh5Ht7Q5ED7igfgA8t6ycZ6GROtxw3p
 wM5ejdJu+N9FB6DjAixsCga14qOz8s6wMf9QL8CUjDua+0+6jMEncsj6abXp0bqb80U5
 5CgIk/VOn4ynltFyz0gJZPG7krKe9ZMg5USRMH0WfsFURRHeK7kodnOUmygKZYxcvEJo
 f8Wg==
X-Gm-Message-State: APjAAAU91ibMUKkMoJCjTWPu4KBkhZ3wTo7pTaUBxOmLhk6CzLo4IcxZ
 tluo0inMajFd7BxcPge/Z3EtbIUy
X-Google-Smtp-Source: APXvYqwRygefR5CTV1jCjLCXB185/pU9vzNvtREnaDUd+S6EWTjiPstcVdvE/yX79RrIrYVKoyWSyw==
X-Received: by 2002:aed:218f:: with SMTP id l15mr12090571qtc.247.1583080528086; 
 Sun, 01 Mar 2020 08:35:28 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7cb:f65:3196:5ed7:3478:df97])
 by smtp.gmail.com with ESMTPSA id
 v6sm7720320qtc.76.2020.03.01.08.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2020 08:35:27 -0800 (PST)
From: Julio Faracco <jcfaracco@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] i386: Fix GCC warning with snprintf when HAX is enabled
Date: Sun,  1 Mar 2020 13:35:23 -0300
Message-Id: <20200301163523.13581-1-jcfaracco@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When HAX is enabled (--enable-hax), GCC 9.2.1 reports issues with
snprintf(). This commit is checking if snprintf returns an error. This
is a simple way to avoid this warnings.

For more details, one example of warning:
  CC      i386-softmmu/target/i386/hax-posix.o
qemu/target/i386/hax-posix.c: In function ‘hax_host_open_vm’:
qemu/target/i386/hax-posix.c:124:56: error: ‘%02d’ directive output may be
truncated writing between 2 and 11 bytes into a region of size 3
[-Werror=format-truncation=]
  124 |     snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id);
      |                                                        ^~~~
qemu/target/i386/hax-posix.c:124:41: note: directive argument in the range
[-2147483648, 64]
  124 |     snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id);
      |                                         ^~~~~~~~~~~~~~~~~~~~
In file included from /usr/include/stdio.h:867,
                 from qemu/include/qemu/osdep.h:99,
                 from qemu/target/i386/hax-posix.c:14:
/usr/include/bits/stdio2.h:67:10: note: ‘__builtin___snprintf_chk’ output
between 17 and 26 bytes into a destination of size 17
   67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   68 |        __bos (__s), __fmt, __va_arg_pack ());
      |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
---
 target/i386/hax-posix.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/i386/hax-posix.c b/target/i386/hax-posix.c
index a5426a6dac..7437d54b44 100644
--- a/target/i386/hax-posix.c
+++ b/target/i386/hax-posix.c
@@ -121,7 +121,11 @@ static char *hax_vm_devfs_string(int vm_id)
         return NULL;
     }
 
-    snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id);
+    if (snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d",
+                 vm_id) < 0) {
+        return NULL;
+    }
+
     return name;
 }
 
@@ -140,8 +144,11 @@ static char *hax_vcpu_devfs_string(int vm_id, int vcpu_id)
         return NULL;
     }
 
-    snprintf(name, sizeof HAX_VCPU_DEVFS, "/dev/hax_vm%02d/vcpu%02d",
-             vm_id, vcpu_id);
+    if (snprintf(name, sizeof HAX_VCPU_DEVFS, "/dev/hax_vm%02d/vcpu%02d",
+                 vm_id, vcpu_id) < 0) {
+        return NULL;
+    }
+
     return name;
 }
 
-- 
2.24.1


