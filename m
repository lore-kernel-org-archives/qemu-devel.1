Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B878C2BA16
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 14:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6615C20692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 14:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5Q6oq6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6615C20692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMBuT-0003F3-FF
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 10:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jM6gv-0003BP-Ps
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:08:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chenhuacai@gmail.com>) id 1jM6gu-0000xK-SF
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:08:13 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:36262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chenhuacai@gmail.com>)
 id 1jM6gu-0000vz-NN
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 05:08:12 -0400
Received: by mail-pl1-x62c.google.com with SMTP id g2so2302361plo.3
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2020 02:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=SOR40jzBSUpqPa3YKI4axKYoQpchXwTjuvvVPeOFCJw=;
 b=W5Q6oq6r4aK7U24MT+TDejb6V6NAgN+IMlJKuL1gCrT2dN1wv/kVF4BMtFBz88l7hd
 d9ZqKUmOlWk+gKSD96ZMttNCgpWU34f0nUpa2jLRsuwGkpucDF4sPF0nmFhgfGyvJ2aB
 Yxpb1idW6m73Gtj08TUt8TlVZEYd7f4C9MjfoekPpetp8SDh5RFJPOJfr4yVSxNrsyKc
 SraFnuptx3s9e+/QfKwPWg/XPrkNYk7y6yApLlx1DHBEYTUL7CbtFKZKcmPdxZ2iGEdD
 OyfzI/v+OGB18axfPhRLyXIyotUHXt/M1P2aK2zYvzsssThdqxk5btlfJ0A1Q+QQG70t
 uAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=SOR40jzBSUpqPa3YKI4axKYoQpchXwTjuvvVPeOFCJw=;
 b=EMQjKdeICgRca8hHeVOyoCA1eXfEgm4a/zWZFHlZACL1DZ/xxOQFErtEVSDruDM2P9
 kA4/wBeXic17vBzFXgWnDs17zYLXGmYmZQovpz/t4hRmwOCJESyolD/DUqT+feXIZ8Ze
 JvkvxxMUQ6Ds1JYGjSPv7qlxDactYswtelV6IAGzodBcmYkuO/aRDqEYlf+sFp0d2D9k
 gKgMQoz63BK7Kcewp6ho+6p2hsh2WS5UVe8C5v6CO4hEquyG+pRVFSMpw6p+hN0cLHl4
 hjKxzXl7lFf2J5U3BJ2NkKdH1a+IpeCuS3X51X5c17kg3XNwGM8yCRe0osLKlQYVm5O3
 M3bA==
X-Gm-Message-State: AGi0Pub2JzT4Q1aZZ0yLJ9BRTFHEked6cF89Fxr7WKoxJcQOLh1j0wPU
 pvskZ3HdniBIrJrWlgyCf0Q=
X-Google-Smtp-Source: APiQypJMJ9JaueUrsn8VikzmqIYqZ1XP/evRhlBjKv09TRDafyfcZz+b+PbxLORUT67JERd9yrDT7w==
X-Received: by 2002:a17:90a:a40b:: with SMTP id
 y11mr4356052pjp.130.1586336891515; 
 Wed, 08 Apr 2020 02:08:11 -0700 (PDT)
Received: from software.domain.org ([104.207.149.93])
 by smtp.gmail.com with ESMTPSA id o29sm16287584pfp.208.2020.04.08.02.08.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 08 Apr 2020 02:08:11 -0700 (PDT)
From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH 2/3] mips/mips_fulong2e: Set preferred page size to 16KB
Date: Wed,  8 Apr 2020 17:16:19 +0800
Message-Id: <1586337380-25217-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1586337380-25217-1-git-send-email-chenhc@lemote.com>
References: <1586337380-25217-1-git-send-email-chenhc@lemote.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62c
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

Loongson processor prefers 16KB page size in system emulator, so let's
define mc->minimum_page_bits to 14.

Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 hw/mips/mips_fulong2e.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 5040afd..23897d7 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -399,6 +399,7 @@ static void mips_fulong2e_machine_init(MachineClass *mc)
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("Loongson-2E");
     mc->default_ram_size = 256 * MiB;
     mc->default_ram_id = "fulong2e.ram";
+    mc->minimum_page_bits = 14;
 }
 
 DEFINE_MACHINE("fulong2e", mips_fulong2e_machine_init)
-- 
2.7.0


