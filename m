Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A84FC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:30:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0749B20836
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilpQS7Vg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0749B20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if30w-0004KK-1V
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 09:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1if2tv-0005Pm-CX
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:23:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1if2tt-0003D8-Tq
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:23:39 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41492)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1if2tt-0003CA-Nw; Wed, 11 Dec 2019 09:23:37 -0500
Received: by mail-wr1-x443.google.com with SMTP id c9so24247094wrw.8;
 Wed, 11 Dec 2019 06:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SnbM4HZb29FsG4J6fiW5WwWfE0ShjwYvCK5bmD3CYRU=;
 b=ilpQS7Vg1VgZDqrE/uEczkUIFtJqrxecCgvPQcP2+fNZ5Y0wDu4jdpg7IfL4WqKzB4
 w11BCNJ1sBFfapPPasdZzfqplIrJcK8lU3EDh+CSsEOp0m2BQIF+/EcocnNH9SZOFcbn
 u777YwftnULQEd18vrH5v34hGR16r+J8XZvylHWg0nC3gjuv12z1UVRGTaqokTR/4SeT
 EEmUTtG8q+GzxkR1ELvB1DhmVIaNFqA3+hxXGfdj3gQ39AlXjF1cBmrbVZ1YBtuRA8El
 WP3IDdnWkjbxuejYkljwSHjGhM42tHLpT1CDcB/76+Vdl2d1Bpnq6MENWIYGqQWh3Cbb
 oKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=SnbM4HZb29FsG4J6fiW5WwWfE0ShjwYvCK5bmD3CYRU=;
 b=kHOP9PtpwAuv2Fqb37kttZzt4kFMKazhqyu+8AvwrmkCelj3J+D6WBFInUIU9SCvOO
 O/Oqu1G363dotmp/H6LYwRRtGzZ2WGF2FcvJRWHrDP0ys23tME7fBwgQ3abUr2GLF8Nu
 zJE2k5WXA0h6bhT6JJgHuNhhG7uHMua9/cDNifhTYT9vwe4Ce6GXkwmluBbyjpirIVcd
 FXHshE1sutVhKxd36bbj+GPor0aQcIwm7yNtrEYYpMje0WKLwDV1XZ2h/iJpToJ72FpA
 vNlrlt1zvq7DiRRAfWW0EjH7dnZDmww+Qs3olkRCLNFLzfHpVyslDXT5P3SwPawQbBKV
 AIVQ==
X-Gm-Message-State: APjAAAUObBYvx5t8byiTHDud2aeoMnhBYzXV0SBFBSsEAj8xUuLkIjO4
 CsL1z/9+QX/SUxppXZoBQs4H2Drm
X-Google-Smtp-Source: APXvYqyezu+o4TaFOOsMQboqUbLhkRRiaWSUS1F+/DK+51nKA+uRVWg+uUeo2CzNKamq6QxK7V1x7Q==
X-Received: by 2002:a05:6000:cb:: with SMTP id q11mr92237wrx.14.1576074216464; 
 Wed, 11 Dec 2019 06:23:36 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g23sm2503783wmk.14.2019.12.11.06.23.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Dec 2019 06:23:35 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] monitor: fix maybe-uninitialized
Date: Wed, 11 Dec 2019 15:23:26 +0100
Message-Id: <1576074210-52834-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
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


