Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D59C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FDF520CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze0JH70v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDF520CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZwM-0004kl-8u
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:07:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlW-0002SN-Vf
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlW-0002Qk-0N
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:42 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:35861)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YlV-0002NC-QA
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:41 -0500
Received: by mail-wm1-x331.google.com with SMTP id p17so2862335wma.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1tKsxoYp7GhUyN36SIdtT+qkYcQ6Z8f09kM0pNR69JI=;
 b=Ze0JH70vh5meLEkBVmd1CPKCXufMGjWXbJT5q+A15zsbEGuRWeFUVkgbgKWxp8oswl
 kOzRvu3IljCTnQMOpjqOO1trPui8cgeYf55BeCsBICJhWwtsX1isZB6KArQpx+FxDvTV
 V0M65kyuTERlUJU2cYag/BSfAyilBWVBL9O8pTD5c4nPdYhHj2BtXIo1dVdV9Q4eW0ST
 YCLUBPBzBftnuPFf6J3aUINM9dOIf1xlv0r+Bfffzb/Thb3cr30fvbdsu56ZrGCx4bp/
 GRDo6uIk+9kWWnXxaSgY9G9I9jDq30zWb2NlWzpWzm0BveUdXIgOKciZW7lhgdzCAFwg
 Gq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=1tKsxoYp7GhUyN36SIdtT+qkYcQ6Z8f09kM0pNR69JI=;
 b=egYH9XI6rM778UZk9XUVCAd44qbPZtJxhYUZ829SRGRD/WwFX7wgIgJDsI0a9rzEzL
 U1i7hxHtcUSEWXLWjANA3qgxwSwQg0zrKxSvWZ9fl+xj3XYhOSwVNvWNdGyrqUo0UJnp
 en3Tf3zvsRjIySk1W5lcDdiTxnsOFJogG1cir1VY/ppPlGW6/3DrJCrytZfrfOIHQ/Gz
 VTxQxmIgENhfLUNi3HA8utfeIq1w135tT1TPxEzlzpK2orb+CbscvSgoHPMZ42H5OY/W
 y8wBQ7KSM010b3uFgq0TQjC7PBUO2n+btFkcR7Ank1ChjkmWyMyP1Y2vWiaCy9OW4+S/
 geOw==
X-Gm-Message-State: APjAAAVg2H3BhpVYxK3dpt75cdRhFm7408N5/3WzwpT94U6jxiBR3JVe
 g3d3Kg1r6t0MtZWxTWUZYPYTFA+e
X-Google-Smtp-Source: APXvYqzoA9CWfZmKS0vDptNiCJ1jRh/wjlrdtEcVSrl7oj24vbi0SHW/mEgkAq3/ETKgY+t4Q8WD1A==
X-Received: by 2002:a1c:1f56:: with SMTP id f83mr2674177wmf.101.1582631560569; 
 Tue, 25 Feb 2020 03:52:40 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 102/136] scripts/cocci: Patch to replace
 memory_region_init_{ram, readonly -> rom}
Date: Tue, 25 Feb 2020 12:50:32 +0100
Message-Id: <1582631466-13880-102-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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

Add a semantic patch to replace memory_region_init_ram(readonly)
by memory_region_init_rom().

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-5-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 scripts/coccinelle/memory-region-housekeeping.cocci | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/scripts/coccinelle/memory-region-housekeeping.cocci b/scripts/coccinelle/memory-region-housekeeping.cocci
index 3699c10..ee3923d 100644
--- a/scripts/coccinelle/memory-region-housekeeping.cocci
+++ b/scripts/coccinelle/memory-region-housekeeping.cocci
@@ -11,6 +11,24 @@
 */
 
 
+// Replace memory_region_init_ram(readonly) by memory_region_init_rom()
+@@
+expression E1, E2, E3, E4, E5;
+symbol true;
+@@
+(
+- memory_region_init_ram(E1, E2, E3, E4, E5);
++ memory_region_init_rom(E1, E2, E3, E4, E5);
+  ... WHEN != E1
+- memory_region_set_readonly(E1, true);
+|
+- memory_region_init_ram_nomigrate(E1, E2, E3, E4, E5);
++ memory_region_init_rom_nomigrate(E1, E2, E3, E4, E5);
+  ... WHEN != E1
+- memory_region_set_readonly(E1, true);
+)
+
+
 // Replace by-hand memory_region_init_ram_nomigrate/vmstate_register_ram
 // code sequences with use of the new memory_region_init_ram function.
 // Similarly for the _rom and _rom_device functions.
-- 
1.8.3.1



