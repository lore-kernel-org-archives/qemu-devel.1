Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB0BC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:22:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B29BE2193E
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPkKBwve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29BE2193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEf2-0000cG-L5
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEWr-0008Og-8R; Tue, 15 Sep 2020 13:14:09 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:33077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEWZ-0002h9-38; Tue, 15 Sep 2020 13:13:48 -0400
Received: by mail-pl1-x641.google.com with SMTP id d19so1682789pld.0;
 Tue, 15 Sep 2020 10:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lgTEIoGQTMBZd1KdzUKViOu+UKgD2OOzWkZKgsEYCHM=;
 b=RPkKBwve+pqiSsH9ak06sYW2tgWckUqL/pefncMjn2P2aXLB9tQYBULN+cUtHA/qJJ
 jXLh2tx8Uwroc+ddkuhT23ypU8vR21JqXkZ50ZDszDKvU8zXam3RLXn+B5G4Pv9YQjUr
 euaCW30R5UObaME3/TAVkJcqXFNh718Zap72PEzGerKYNGDPGxTO4kfpjYSXH05HjTgN
 dzCJOe5f/12sb5EMXIo/v0uxytXOlLs5NV/aqJHyoH2SviI1DiEuQnbmbax1wNS9/XeP
 PV2S8TcEom24O0jgSm+03Q5d0OErozbWLMp3sqj3nM/y+st0mIYRnnuNhv9aDIgJZ5Dk
 ILsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lgTEIoGQTMBZd1KdzUKViOu+UKgD2OOzWkZKgsEYCHM=;
 b=dcRpnoSzfEBTvDT+THvAW7lfnSkNC7x9cey1yBVVAZTCCcruyWRouynx1eBwh1uR2P
 E1Dki0cDFtzifrcm5Kinetj2SURtQI2fjdIh4p9gSyNkkx512KRu+4yBOJ463HR2hT5h
 3fejkwjQAzuEm47fViWLmnxy4bH7cKaO9u/Q/HMsEJvSRuOeaXt9VckeuzPSGl0Vib6W
 m9poaYqWU9AXZVRaKntsz30Vcc6l5lBhiFY5UpVVHzKlc1CKgDix62SdqRTah9z+8pQq
 hBojV6j4gU8THFZ4+JOY+LHeGiQ6meouilxocwbJ7APr9LYfwACM30PSjmUQ4LLBitNu
 KBag==
X-Gm-Message-State: AOAM530moYBR1G/DXKZgzr9Jm/e1FWFjmKuQ5gl93yXgxjUgKwq4HpYf
 7L/uXmfRj8O/MCSv9owVB1SOqx+PtAVr6xOXPBE=
X-Google-Smtp-Source: ABdhPJyOGBqh+wkNDSnf/uoel5ravMK4J6Hi9Vp5rGMl4c+zV/6NiqxgHhjTBiap5io+Mpt27hAxlw==
X-Received: by 2002:a17:90a:d702:: with SMTP id
 y2mr344895pju.216.1600190022029; 
 Tue, 15 Sep 2020 10:13:42 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id j14sm124046pjz.21.2020.09.15.10.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 10:13:41 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 11/26] gcrypt: test_tls_psk_init should write binary file
 instead text file.
Date: Wed, 16 Sep 2020 01:12:19 +0800
Message-Id: <20200915171234.236-12-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915171234.236-1-luoyonggang@gmail.com>
References: <20200915171234.236-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On windows, if open file with "w", it's will automatically convert
"\n" to "\r\n" when writing to file.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/crypto-tls-psk-helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/crypto-tls-psk-helpers.c b/tests/crypto-tls-psk-helpers.c
index a8395477c3..11ae26368c 100644
--- a/tests/crypto-tls-psk-helpers.c
+++ b/tests/crypto-tls-psk-helpers.c
@@ -32,7 +32,7 @@ void test_tls_psk_init(const char *pskfile)
 {
     FILE *fp;
 
-    fp = fopen(pskfile, "w");
+    fp = fopen(pskfile, "wb");
     if (fp == NULL) {
         g_critical("Failed to create pskfile %s", pskfile);
         abort();
-- 
2.28.0.windows.1


