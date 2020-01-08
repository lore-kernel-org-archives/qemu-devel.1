Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA883C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A162077B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G209Vhfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A162077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2UV-0004yz-DR
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 22:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2J2-0004u4-I9
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2J1-0003iG-FA
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:52 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:37851)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2J1-0003gh-9J
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:51 -0500
Received: by mail-pf1-x429.google.com with SMTP id p14so910975pfn.4
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z0FD/atDVuTouuMhumTq1HgV7wZSwz0LnpdmbMaMHY8=;
 b=G209Vhfz8zzAREVP5+X7jMQiXeCx3KZzA/2WzIojkRRHAQgf9wD5fqvj1IhkX6pi0b
 X5XfccDwhCcmXQ6tIHwhL3ryz8GvWkVmSnBoRK7cWsni8LW8cupJKusWqJY8ksRocmKU
 J07UuekoghlmMkxYbPasbAqtdCRYF5XNJq1tYq5RKvHvoKdHlJF+g039lXNdsvG9zzc+
 g/Q6HlvKnHFOgFggvW9dBjp2GQlu07nK5f22gbnUVPNj1cVD2mlvWB9ETGrkcrPJHglG
 jhiXwmBbZlQoEHA5H5MplHP7oDw+OY+rf1k7kSwhIMBESOa2UoH86Yjq2NmGeRatARi8
 lSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z0FD/atDVuTouuMhumTq1HgV7wZSwz0LnpdmbMaMHY8=;
 b=YeyuyYhxKBmEooKXMmFHMcSKC/sTFePY4KupDb7b+8boVKU+y2fJtevspzFcA8x+uu
 nEuRWO1SEepVV/uQvXMde+9DP+BaGplQr1NE2JXTHVHO4hSZX4HJ/lpaCkcmhnXq89ML
 ufnlSKToPopKBl1rtT8e4E9L3zHi0K3k1Sw89x50UDIrfKd5R4XIC4rg88YC2moi5H7H
 1QpFaZOQbEAZeLRmFo+WdH9ZhSqb/gmTUT16acnUO4YlSgjWYhRINNB2rF1r41Y/M5wC
 vUIlRAkFypVoDaCPVuEH9DRLei9smpd6gvSPCirS0Wwku6Zbeqr7f6Oc5GPa6msd12sW
 5svA==
X-Gm-Message-State: APjAAAUTvHaCIAqrAeX6ATZBbni/7RHig66mvKZrcj/QXr9RbTCutJjV
 njNEdY5ndr/he62YhYeJf69a/u+2rG/l2g==
X-Google-Smtp-Source: APXvYqxmElP35/a0OCHvHg4o1914tNk1P0ZStzgWPC4zO9MmPD8fuNX/9B8DwCTHEX8a8iXWYXgYcA==
X-Received: by 2002:a63:d14:: with SMTP id c20mr3028319pgl.77.1578455209870;
 Tue, 07 Jan 2020 19:46:49 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:46:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/41] target/i386: Remove MMU_MODE{0,1,2}_SUFFIX
Date: Wed,  8 Jan 2020 14:45:08 +1100
Message-Id: <20200108034523.17349-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::429
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index af282936a7..1b4b90556c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1952,9 +1952,6 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 #define cpu_list x86_cpu_list
 
 /* MMU modes definitions */
-#define MMU_MODE0_SUFFIX _ksmap
-#define MMU_MODE1_SUFFIX _user
-#define MMU_MODE2_SUFFIX _knosmap /* SMAP disabled or CPL<3 && AC=1 */
 #define MMU_KSMAP_IDX   0
 #define MMU_USER_IDX    1
 #define MMU_KNOSMAP_IDX 2
-- 
2.20.1


