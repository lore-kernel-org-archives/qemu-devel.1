Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF57C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB6E21556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9hoK7wo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB6E21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZlR-0004b6-7n
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:56:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z09-0003Tw-B3
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z08-0003Tj-Aa
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:49 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:41240)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z08-0003TA-4P
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:48 -0500
Received: by mail-wr1-x42b.google.com with SMTP id v4so1568359wrs.8
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MUTtipDJs5GuUktX0fj9AZXSq7R8/YXYGwDfm8gZ/00=;
 b=e9hoK7woL1gimDbdW4pBZnl3Yi1phoNL34n0iXyqn6XqT+HmoYX9gTDFVmia3nPYhP
 Ex91YHHENBB7D6odNiy1xYK79lw0w+it13x+b7GRnKlHk8cg7zE8tYYvCmY9G0HEZESz
 ZWdi8VydzPHRc6GBBqPw5lYVz9ZSx8XsmGkXzxoK903pj0s8hwM5X7nbrTR8zsyEnsi5
 lExfzp/vvDTmPNmKgta8hedK/XCa4VeVXvuVV/Rqz14xNWr2Es/tecLdc9BW+EDmrcwl
 TA+MUD4Jz1+7qs2zJ50+qfGWwhEmVneKLKx0JhNn7kiP9c4mCxV/5YuljBrxI1rjS9g2
 ZmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=MUTtipDJs5GuUktX0fj9AZXSq7R8/YXYGwDfm8gZ/00=;
 b=ZgBVJlpquZi61HSyIzqMKWY54fZjb2xTnhhRj4/s0L9AVmDTqoB6Q8KKKLo/ryE2Qw
 xzb8W2vTAe1ofclck0RKUIujCr1kCxeq2Aj71kDbdRsnQk7d0cB5OQ/Fb1eBuhUMw/Ag
 Kmm0ebL13WoCF9chHHEUxcH0hI3aoPh2uVkz8FJOS+SADWXMhmKVd4vTwZ67V6finWKY
 VP3Ki2oVX+a2oenL7XmirMqwfsruPXZrlJF5nlzqafglOjwOVr6Bapd3EYBPZ/EBMUpW
 0YEFNTHwjqgMMYsthm/BReEz0Jx8Pl/2hXR1xVIL63XKdCCuu8dHvbk2weTGrt+a0jFQ
 Wa4Q==
X-Gm-Message-State: APjAAAUtJ521riyPLOfHoJlfe4KXQ4mFpmcaF+c0sysQDL19TceyEJuq
 CfbQG/ULSE1mBGPlpXcxiuvKr1uW
X-Google-Smtp-Source: APXvYqxLiL8T491NkaBv0rFqk4q4Z0pHBIhAvT1hvHEFLT3xSZEf2JEY9fPzGUDWe2nsEZWiKPq4mg==
X-Received: by 2002:adf:eb48:: with SMTP id u8mr71896315wrn.283.1582632466943; 
 Tue, 25 Feb 2020 04:07:46 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.07.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:07:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 113/136] scripts/cocci: Patch to detect potential use of
 memory_region_init_rom
Date: Tue, 25 Feb 2020 13:07:11 +0100
Message-Id: <1582632454-16491-11-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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

Add a semantic patch to detect potential replacement of
memory_region_init_ram(readonly) by memory_region_init_rom().

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-16-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 scripts/coccinelle/memory-region-housekeeping.cocci | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/coccinelle/memory-region-housekeeping.cocci b/scripts/coccinelle/memory-region-housekeeping.cocci
index ee3923d..9cdde71 100644
--- a/scripts/coccinelle/memory-region-housekeeping.cocci
+++ b/scripts/coccinelle/memory-region-housekeeping.cocci
@@ -29,6 +29,25 @@ symbol true;
 )
 
 
+@possible_memory_region_init_rom@
+expression E1, E2, E3, E4, E5;
+position p;
+@@
+(
+  memory_region_init_ram@p(E1, E2, E3, E4, E5);
+  ...
+  memory_region_set_readonly(E1, true);
+|
+  memory_region_init_ram_nomigrate@p(E1, E2, E3, E4, E5);
+  ...
+  memory_region_set_readonly(E1, true);
+)
+@script:python@
+p << possible_memory_region_init_rom.p;
+@@
+cocci.print_main("potential use of memory_region_init_rom*() in ", p)
+
+
 // Replace by-hand memory_region_init_ram_nomigrate/vmstate_register_ram
 // code sequences with use of the new memory_region_init_ram function.
 // Similarly for the _rom and _rom_device functions.
-- 
1.8.3.1



