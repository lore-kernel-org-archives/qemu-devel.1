Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C4DC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A2702077B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TrypOgag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2702077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2SE-0001Hn-2R
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 22:56:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2It-0004i7-MS
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Ir-0003Wk-Gm
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:43 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:33706)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2Ir-0003W0-BJ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:41 -0500
Received: by mail-pl1-x62d.google.com with SMTP id ay11so524348plb.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2F9qWviD9JHiCQKLhGkXywwQFXF+bVbb46hoHf6Ex9Q=;
 b=TrypOgagiXmNiSYHH7ONrO5G6z/YAdXFPbOKOVlv0hvccjJ7Ev/nr+Rdnsb8rZWSrt
 7CGRxXv4xi/+1vvTvzIupIH6LMHdpPmC5qm3A/XLeggg/XR2tHpcr63mEvhEN15julw7
 JWqx4RKOntbp2PUIp+QvLM8+jyMb6OZjzoF2m/AgFwvUhwXQALck4VgLXv/dn3I5vqJg
 iyPQMXbKwMXLjy4SGYZ2lZfssxSDiO+VLkCsUHboRfl7DmWAmD1VuRUOihQvm5reWhZj
 FrCJouqo7+l+v63weFkq5HwFVfPmMpxg+Ujk/ekiKS4gcQEV6n69BZgRxuvrxhCFRsuW
 pPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2F9qWviD9JHiCQKLhGkXywwQFXF+bVbb46hoHf6Ex9Q=;
 b=NsSkoKjw/5CHxiy7sY2OAGZupG4d3MpPCLffFGkXT4jSZBBKi5fhXX/jA3k4n9bBJq
 1fFHCfwNFmy4+qs20HV86OwB/XwUmcoRl4i+Gfxguvr0FWTe+s1NlHvJEEOzCnZMWSyy
 0+jGO8voxlojCIGcHGyE5Tx39tfLhAeF0XMnUFkFMLvMdzOtA2IWJXroGI9fp0GOUsxc
 ODIwCim6EdJHjTLMiR8pmq9LuzfSMrwWNVd2SFe26iQ+XgoIgMhaHxM1DV01hfUHo7cV
 xsm7J/Yf2DspclyJuBGL1p4EiNL1QL9ot5ISnB/8EijahHHX2QOHFmIxhXjpvylDTxix
 N3QQ==
X-Gm-Message-State: APjAAAWDbZTZQurkOyvlbq5Wda1e8QNXmqc1YAJojfPmlou1ZqnPVVFM
 GdWIY0y9VyjIox2yumfOeBih53DDml9GmA==
X-Google-Smtp-Source: APXvYqx2SuMRVLF39DQi/VatkOWh1oMxfRvuQCDmIFA0210i8bj0vP5XLv5AFw/2AgCE4R61cz0GSA==
X-Received: by 2002:a17:902:d902:: with SMTP id
 c2mr3060438plz.298.1578455200084; 
 Tue, 07 Jan 2020 19:46:40 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:46:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/41] target/nios2: Remove MMU_MODE{0,1}_SUFFIX
Date: Wed,  8 Jan 2020 14:45:05 +1100
Message-Id: <20200108034523.17349-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62d
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
Cc: Marek Vasut <marex@denx.de>, peter.maydell@linaro.org,
 Chris Wulff <crwulff@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Cc: Chris Wulff <crwulff@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/nios2/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 361b06ffeb..78f633f970 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -217,8 +217,6 @@ void do_nios2_semihosting(CPUNios2State *env);
 #define CPU_SAVE_VERSION 1
 
 /* MMU modes definitions */
-#define MMU_MODE0_SUFFIX _kernel
-#define MMU_MODE1_SUFFIX _user
 #define MMU_SUPERVISOR_IDX  0
 #define MMU_USER_IDX        1
 
-- 
2.20.1


