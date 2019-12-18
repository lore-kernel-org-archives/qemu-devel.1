Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81517C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:17:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7812146E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k74tXKop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7812146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYGg-0000Nc-Sd
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:17:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3B-0006NX-H5
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3A-0000kh-9p
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:33 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:46592)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3A-0000hB-1i
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:32 -0500
Received: by mail-wr1-x434.google.com with SMTP id z7so1963174wrl.13
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SnbM4HZb29FsG4J6fiW5WwWfE0ShjwYvCK5bmD3CYRU=;
 b=k74tXKopfKzRPy/wQkZEPWyGWwStkA7fEXXEmn2NxdV+grs0EapWmEJ2Afonm/eJjG
 GkX8+L6pr4Qc4wm3C06iM8VDGpyTTNIiF9J+qDZRcAkcpbJZbBs/OK/ta/szGZprBnLH
 nqksaUXuMKIxwElnc41+AiJ2zodKk3LfArk2WRzZ019vMN+nC/3WOavUwqdRGP6BUoat
 2OYZQ1ErBOtXnpakoXJkddVW82XjuobCy/E4DSxayZDR14Qxc2LS/MAKFKG/wczXLaSF
 6cyDX+EmSmR4tP2f+gkkbNgwQLVHp6s9Q2HSWBpdJT9ZVfFoBle/iFH4hku1VtEEGYaw
 l0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SnbM4HZb29FsG4J6fiW5WwWfE0ShjwYvCK5bmD3CYRU=;
 b=iNzep+bK90HrmKgTDTbnrX0+E+tGSAFJK84lMBvL42rZAx19g8aQzYBhjutIfraTD+
 0CFtX39tg+I3YHPYrBqiLvyAwu4+DEcC2UFGOCeug4x/qiXYGdsigj5q9agayp+16h1D
 xxwMA3G05t6Ii9kU+vkmXUjyO0ph0WQ076zFBDeKQ4pxY803E/Q5NmJckHJ7DgU1Ajg/
 C6xaJt4BpOuKYc5z44UdhGvo3hnERMmCrC/n4yr07BFw0ROXA467seiwHhBw0o+TDyT7
 GLA6oriwq2bUFDec05wMU5Tdx5UTkav7U0o+u2xTvoF84sDHe3X6+hAxkH02IkjBLJt8
 iBhw==
X-Gm-Message-State: APjAAAVd+lSMSEDTu7UC3URWQ1yHF+ustkCbKTLzWz3e9aqsB1G45NCo
 1UXgp4MiGMZgPjvUGFrfTBg4ehT7
X-Google-Smtp-Source: APXvYqwE3r6OKAQOed6N+x8WWR8x6cTahbcHKP9KJJXfsw2dJMOzZ5XKEkY0k4YyE6MjKJSoGZ6F9A==
X-Received: by 2002:a5d:6a8e:: with SMTP id s14mr2543802wru.150.1576670610728; 
 Wed, 18 Dec 2019 04:03:30 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 35/87] monitor: fix maybe-uninitialized
Date: Wed, 18 Dec 2019 13:02:01 +0100
Message-Id: <1576670573-48048-36-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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

../monitor/misc.c: In function ‘mon_get_cpu_sync’:
/home/elmarco/src/qq/include/sysemu/hw_accel.h:22:9: error: ‘cpu’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
   22 |         kvm_cpu_synchronize_state(cpu);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../monitor/misc.c:397:15: note: ‘cpu’ was declared here
  397 |     CPUState *cpu;
      |               ^~~

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 monitor/misc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor/misc.c b/monitor/misc.c
index 3baa15f..a74cff3 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -394,7 +394,7 @@ int monitor_set_cpu(int cpu_index)
 /* Callers must hold BQL. */
 static CPUState *mon_get_cpu_sync(bool synchronize)
 {
-    CPUState *cpu;
+    CPUState *cpu = NULL;
 
     if (cur_mon->mon_cpu_path) {
         cpu = (CPUState *) object_resolve_path_type(cur_mon->mon_cpu_path,
@@ -411,6 +411,7 @@ static CPUState *mon_get_cpu_sync(bool synchronize)
         monitor_set_cpu(first_cpu->cpu_index);
         cpu = first_cpu;
     }
+    assert(cpu != NULL);
     if (synchronize) {
         cpu_synchronize_state(cpu);
     }
-- 
1.8.3.1



