Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C424AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:42:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92337207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ng6BJikd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92337207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorQZ-00022O-Qs
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorOz-000095-Cs; Fri, 26 Jun 2020 12:40:34 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorOx-00060C-UR; Fri, 26 Jun 2020 12:40:33 -0400
Received: by mail-wm1-x341.google.com with SMTP id f139so9955636wmf.5;
 Fri, 26 Jun 2020 09:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VaBeUAKeU/Fm4s8wzR3hU4H0t6OdWhihwFpjUJ3q1zc=;
 b=Ng6BJikdvB8LzBCPa9mn2RSe91/E/ECsqj6YtFgVSJwrzTDvBExtg/Et/ltGexKDPw
 CFjE4ZUQsmwI72nawN/h5CBvLQLvF7lJagP9uj7X1ekv/D81LDZPL23Ug3xpxOhQ+By2
 aIF9yTjoP5cREs8OAsunsKES79Hihen1yg+x48jtQ3BM5X+dieliKDcNMMY9kPcRv1Uu
 rVkGTFIu0NwJk39Tip6fSFuKpt3csMxEwTjuWAD08ebXEolMoDT62ffEFZAdxD9UAtbr
 7fYW4pL7a9JQShVba6V3/p9YPSSwNOj08X0JRueT1ZHdL52qP8pA+87gCVAVUK/2cImU
 9FUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=VaBeUAKeU/Fm4s8wzR3hU4H0t6OdWhihwFpjUJ3q1zc=;
 b=r4/+GXduHQJqrfwg/Q2b+Ka+pfxR9gjFt5zD8LcUtyrhpcjEIDGJg0Fwg4Qum8GnPN
 xOaVF+wwJs9h1baHPTLlbLsHj0beeT1ddvehby63ALoz2jtNarE/LjJVJjDr2muRAD4a
 HmW7yPBmPmZYyrX/agfqQczRuGnpy/pgEfqT1NxY9LmWqOJ/13IIowglR54PW1Ky9Mrx
 YIUsqjD2/cnp24pCu09i7lAxi6T6AcJrLm9H2vkWolRSdAPYSL1RYETKxXj0LdPFFg6K
 GozuHecMM9+KKKbKmNvn8EAOns/RA91s7eRFFd7tc3EJK227MqPE00ApgpRQw0Vgg1Uu
 IcYA==
X-Gm-Message-State: AOAM531Jr0ARMjQrxsfB8wS8frAZI/LwJ5wnP/GhoHTep3hzmdhA87H2
 ogudXBqR7EojfBNoO9O1dStam4sB
X-Google-Smtp-Source: ABdhPJxO/UWo/gr1Bm+nEy+GofiC17JewdT32AAcMdA4ann0CEoqV9SmYQRD9Q34u2fOiJP9Q957Uw==
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr4323087wmh.130.1593189629946; 
 Fri, 26 Jun 2020 09:40:29 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f12sm24623646wrw.53.2020.06.26.09.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 09:40:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 01/15] MAINTAINERS: Cc qemu-block mailing list
Date: Fri, 26 Jun 2020 18:40:12 +0200
Message-Id: <20200626164026.766-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200626164026.766-1-f4bug@amsat.org>
References: <20200626164026.766-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We forgot to include the qemu-block mailing list while adding
this section in commit 076a0fc32a7. Fix this.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b40446c73..d9695a2cb3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1622,6 +1622,7 @@ F: hw/ssi/xilinx_*
 
 SD (Secure Card)
 M: Philippe Mathieu-Daudé <f4bug@amsat.org>
+L: qemu-block@nongnu.org
 S: Odd Fixes
 F: include/hw/sd/sd*
 F: hw/sd/core.c
-- 
2.21.3


