Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1781AC2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 14:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8D4920692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 14:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiKP+XER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D4920692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMBuS-0003Em-Ru
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 10:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jM6gh-00031y-6P
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chenhuacai@gmail.com>) id 1jM6gg-0000my-4t
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:07:59 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:46803)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chenhuacai@gmail.com>)
 id 1jM6gf-0000lk-Tj
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:07:58 -0400
Received: by mail-pl1-x634.google.com with SMTP id s23so2277152plq.13
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2020 02:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=zWrnZumKf5bZt8iAgpjrXn5wo7mCnnfGiyN1FLjpUEg=;
 b=LiKP+XERquNt3Zb1Yv2UGWWPmzzlUNJjtBZfN6tsUAB0BGPjLcpgFq4dA44fb4mBEF
 BpExyYR04yUnH49aAltljzegKFHZZ2QvonlK+bpN9+3lLH/vo9XWyDuS6ida2Qx5+wCJ
 /PkHbIZuaLbWFtwyoFJo/RPXAqit3JkaMnazo8PfWiUlxhK8ZyRTxjGLMDZEGb1vU0SC
 Velhe+wF8kXS6ym8lnKwnqDY49+RkEJv5zDuvqwHoKPW/k7qZLgFmGC0Pg6QLwsXknJt
 kR8Lc3PW4Srm6GhbeQVmzMWDbmPy6dt991qt2JNTLHiSSHMgQlJJP3j20eZDLiiXj99s
 k51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=zWrnZumKf5bZt8iAgpjrXn5wo7mCnnfGiyN1FLjpUEg=;
 b=MQzViswrHkb0DBTbgAlZhUA8m0CxjFY1d65xmzUVY79g/0fhI7rbgZGstFcy9L1OC5
 NO4JW43SWLkX6X/GqgxCnGhqw+mOWmIVfFUVHBVlf9QwfFa3fiSll0T/yHkXHqyJByNy
 TJgoZZNA1cbMtoyIfKGuXRJkR+aTHZmR1Ms1SbtUA16XiCxeESnS1wBtCVOtJPat82CV
 1JJT5fDugRg2bi1140rE1zGmrOLXO7jMvkvWpDwPsqZMG8baHiUyl+gdt+02wr8JAMRm
 n114OQWS4ZS93x2o33fx3tQwv8T5cL5a/kb9PH9jn4fpQqstGPNE/xL9KBc8N6bSvdm3
 z5GA==
X-Gm-Message-State: AGi0Pubog2JFnhRcjCjlcLmjaE2E5zd85LRSz2wWif/oFzs1xj6stLZ2
 ACIndimsuo7jYAW/ImVzMKQ=
X-Google-Smtp-Source: APiQypLodXnlYltUi29pkVzRTrVHblJz/EStDue+QgGLHxumv4gtoknDLNgDYO36bPg//ebOxCRAZA==
X-Received: by 2002:a17:902:76ca:: with SMTP id
 j10mr6193229plt.184.1586336876151; 
 Wed, 08 Apr 2020 02:07:56 -0700 (PDT)
Received: from software.domain.org ([104.207.149.93])
 by smtp.gmail.com with ESMTPSA id o29sm16287584pfp.208.2020.04.08.02.07.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 08 Apr 2020 02:07:55 -0700 (PDT)
From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH 1/3] target/mips: Support variable page size
Date: Wed,  8 Apr 2020 17:16:18 +0800
Message-Id: <1586337380-25217-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::634
X-Mailman-Approved-At: Wed, 08 Apr 2020 10:41:29 -0400
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Traditionally, MIPS use 4KB page size, but Loongson prefer 16KB page
size in system emulator. So, let's define TARGET_PAGE_BITS_VARY and
TARGET_PAGE_BITS_MIN to support variable page size.

Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 target/mips/cpu-param.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
index 308660d..9c4a6ea 100644
--- a/target/mips/cpu-param.h
+++ b/target/mips/cpu-param.h
@@ -23,7 +23,12 @@
 #  define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 #endif
+#ifdef CONFIG_USER_ONLY
 #define TARGET_PAGE_BITS 12
+#else
+#define TARGET_PAGE_BITS_VARY
+#define TARGET_PAGE_BITS_MIN 12
+#endif
 #define NB_MMU_MODES 4
 
 #endif
-- 
2.7.0


