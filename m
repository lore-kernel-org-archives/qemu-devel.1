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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B49BC3F2CD
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 19:23:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD31D24699
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 19:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TocZwJ2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD31D24699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8UB2-00077B-UX
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 14:23:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcfaracco@gmail.com>) id 1j8UA8-0006gr-GO
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 14:22:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcfaracco@gmail.com>) id 1j8UA6-00074q-Ih
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 14:22:03 -0500
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:35089)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcfaracco@gmail.com>) id 1j8UA5-00074S-Ti
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 14:22:02 -0500
Received: by mail-qt1-x841.google.com with SMTP id 88so5995524qtc.2
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2020 11:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RUBCpEoaOsnBdTu6/lHguw83X8XCmYmpQ2ki8zPmxz8=;
 b=TocZwJ2U9RfZZFTFqJKHZSYOXaKJ/C6IRsZ9KvzBTeOB4ZOvM4c/3iUlodg6NFb4Fj
 kTzXdxv18VdaiSkNZrSmQs/jk7zNKp7iDnz7QrTYxqRmyX0MQMSYSh3HqyjzDzz/3+rX
 wQv8f+Vo/HOBckK6p1hJezthsU826sNHkpBjC7VKtn9oyqoroGiL+cj+sCZSMRKm2iHg
 TyUcLje5lnXpeYy3yAUnbRu9JHrFeHss/thKMIJA3kRcpABWaQmLacyCqrrDK/EqJ6id
 gBnwDoCBEhzKANMrhf2HHPtEyDKIlNrB8GTto6hIY4QzrIzy8JjyLFicTOfS7VwmM94K
 BSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RUBCpEoaOsnBdTu6/lHguw83X8XCmYmpQ2ki8zPmxz8=;
 b=BvqqBKWkFw76q1p+O0mloWR4SY7IPhTZPFK8JQFtuZEaWuFAPUf/l0js087n7X3v0B
 lfOGqrSGTsKJBbxshhVdImZzLPSG4zvJZC5q6qyJUm1gJ2+HpNADx9XDWfhwdEJW99+I
 FTpo8TRJIrjt54t82uBiqlPh2BRR8PO39kvwprTO1wcw5mjVBdtlklVEXa+fd1FWZe3l
 5MB9rTd3NG7qposXOdjn/x8h6VqWtzovRAiH8PRxPAyWI12v8acqd3+Lyu8fLtkUp+wc
 Y/uq96j6l/zInhXuFXJA1oCLTgzy1ljxg+o4+VDLmqwSHseg07wBR8hykJw9haLwOMNc
 Uwsg==
X-Gm-Message-State: APjAAAXjrGORlR8qr21Nt+eCw4ORmr+7tUfSf18Eu+NcDNyv+VO/LSDB
 GNcJRI4oUIBXHZU4xLsvBCpdDaYP
X-Google-Smtp-Source: APXvYqxr49Al5tk/bLErP4hPscXhxzhuL2egiE1YREJ8M2+Idbx54UCS1XmSxVhURS19zpZZI/Hv6g==
X-Received: by 2002:ac8:65d1:: with SMTP id t17mr10918067qto.302.1583090520184; 
 Sun, 01 Mar 2020 11:22:00 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7cb:f65:3196:5ed7:3478:df97])
 by smtp.gmail.com with ESMTPSA id
 i16sm8685071qkh.120.2020.03.01.11.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2020 11:21:59 -0800 (PST)
From: Julio Faracco <jcfaracco@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] i386: Fix GCC warning with snprintf when HAX is enabled
Date: Sun,  1 Mar 2020 16:21:56 -0300
Message-Id: <20200301192156.19357-1-jcfaracco@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
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
is a simple way to avoid this warnings. An `assert()` boundary checks
were added before snprintf too.

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
v1-v2: Add assert() as Richard Henderson suggested.
v2-v3: Fix code syntax alignment with vm_id and snprintf() function.
---
 target/i386/hax-posix.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/i386/hax-posix.c b/target/i386/hax-posix.c
index a5426a6dac..2151c9ed45 100644
--- a/target/i386/hax-posix.c
+++ b/target/i386/hax-posix.c
@@ -121,7 +121,12 @@ static char *hax_vm_devfs_string(int vm_id)
         return NULL;
     }
 
-    snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id);
+    assert(vm_id < 0);
+
+    if (snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d",
+                 vm_id) < 0)
+        return NULL;
+
     return name;
 }
 
@@ -140,8 +145,12 @@ static char *hax_vcpu_devfs_string(int vm_id, int vcpu_id)
         return NULL;
     }
 
-    snprintf(name, sizeof HAX_VCPU_DEVFS, "/dev/hax_vm%02d/vcpu%02d",
-             vm_id, vcpu_id);
+    assert(vm_id < 0 || vcpu_id < 0);
+
+    if (snprintf(name, sizeof HAX_VCPU_DEVFS, "/dev/hax_vm%02d/vcpu%02d",
+                 vm_id, vcpu_id) < 0)
+        return NULL;
+
     return name;
 }
 
-- 
2.24.1


