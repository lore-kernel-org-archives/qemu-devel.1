Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E82EC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:40:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB62F21556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwhNiLbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB62F21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZVG-000645-W7
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:39:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0H-0003fa-4C
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0G-0003Xt-5v
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:57 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:32942)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z0F-0003Wb-Vf
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:56 -0500
Received: by mail-wm1-x330.google.com with SMTP id m10so2082973wmc.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zDrIK5sum9/1gKaKgP2rH/ZOPM4JlQBwHDLBWHfuqUg=;
 b=XwhNiLbRM60iqYGQKquaWXZ+jW01R01e5eAdIirJgmn/48p75UuSmAk05a4LYIEGsn
 xWsrjJ2Cze1PT6ux6ZkucvS0S8h0s7TNnEDy+YjYow6bSmEUZA4CSYKE09DBliE9MpL+
 vAgVYewueceg6gzEOGJ7Z8ulvTm+C/wgniOeR9SKLIKgSVvceCisnJsA075CjATfmnOk
 3s/uh/3q+y2tSXt5t4E8Q2KlfQp3tEQ11Sb9OFQ3O3w6QnWCty6vNw+rg8o/zUTRx+Zn
 thF/9QEM7dJpwfSUuXwv7KwTcIovQjE/2HxDlJjFaFjuJ5wLncyoc2cQIOxkXwseap1Q
 FWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zDrIK5sum9/1gKaKgP2rH/ZOPM4JlQBwHDLBWHfuqUg=;
 b=E0D30SkW65p2kMvr2bW4S2Aw9xR/RhIPPG6OHk9bgjatM3DiH/vz/yLeXD3rMpfQei
 ZdyL2xEmEdLyA13MMCINVMthpEoG8RPrP/cWPLCyb3YSb9ioXfWprXBfomSSEDPKzz05
 ufyYcaNcPlKoK6j9eqb8KWVM7wjB5M8JsODnuQmKCFav0QVure+aomEd/SiTWYFTpDRi
 Ka9LPltBJGgLyRfsCFFVO6aBwx19R6qNL3HYfiGZ1CYm+QIB8Z6oa/QUdegp8kI1Gq9b
 WuRC2oIMxfUIrPezLmW+/BRiS0xv+J7YzZ1kuOacZ5+09+Sv1f0sufbbiz7fEjybVAYG
 9hBg==
X-Gm-Message-State: APjAAAWw0CUPPrK4ua4IUm1NjP2cNC0rsOtjJBVhn1gQBERY+XD904hc
 cRbuqxRJBFvsjyI2/dtRQ2V0aHvC
X-Google-Smtp-Source: APXvYqzBBulVLl94WnbeMtRWUVRXrQsNTAD2RzxUp0VVn2SQf0VbwBbrNEewP5q3KADsKejCopgqsA==
X-Received: by 2002:a7b:cd1a:: with SMTP id f26mr4737518wmj.184.1582632471532; 
 Tue, 25 Feb 2020 04:07:51 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.07.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:07:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 118/136] scripts/cocci: Patch to remove unnecessary
 memory_region_set_readonly()
Date: Tue, 25 Feb 2020 13:07:16 +0100
Message-Id: <1582632454-16491-16-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Add a semantic patch to remove memory_region_set_readonly() calls
on ROM memory regions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-21-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 scripts/coccinelle/memory-region-housekeeping.cocci | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/scripts/coccinelle/memory-region-housekeeping.cocci b/scripts/coccinelle/memory-region-housekeeping.cocci
index 9cdde71..5e6b31d 100644
--- a/scripts/coccinelle/memory-region-housekeeping.cocci
+++ b/scripts/coccinelle/memory-region-housekeeping.cocci
@@ -48,6 +48,21 @@ p << possible_memory_region_init_rom.p;
 cocci.print_main("potential use of memory_region_init_rom*() in ", p)
 
 
+// Do not call memory_region_set_readonly() on ROM alias
+@@
+expression ROM, E1, E2, E3, E4;
+expression ALIAS, E5, E6, E7, E8;
+@@
+(
+  memory_region_init_rom(ROM, E1, E2, E3, E4);
+|
+  memory_region_init_rom_nomigrate(ROM, E1, E2, E3, E4);
+)
+  ...
+   memory_region_init_alias(ALIAS, E5, E6, ROM, E7, E8);
+-  memory_region_set_readonly(ALIAS, true);
+
+
 // Replace by-hand memory_region_init_ram_nomigrate/vmstate_register_ram
 // code sequences with use of the new memory_region_init_ram function.
 // Similarly for the _rom and _rom_device functions.
-- 
1.8.3.1



