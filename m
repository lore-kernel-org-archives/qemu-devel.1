Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134C6C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:46:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C801B20658
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzikMDXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C801B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDx4G-0000V0-Vk
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLv-0004u3-05; Thu, 03 Sep 2020 17:01:03 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40119)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLs-0007pU-Bw; Thu, 03 Sep 2020 17:01:02 -0400
Received: by mail-oi1-x244.google.com with SMTP id t76so4500619oif.7;
 Thu, 03 Sep 2020 14:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mcURfk5W32wdNJCNi/KCDUV8DNNwwxKl3IilrVi/wvI=;
 b=CzikMDXVLKlKz+t6WqY0ApV+J4z9aQkNKVvl2qWLWG/dsu4TN3E5z6gzWCugT4G8GE
 y2a9PQN6PrAB1CTLD0ksddMJ1xofxWOW4gFNEBTONfCXdz/Al1cLEMZREnSJdHb/a0Ss
 DNqpNOE/+IhpiJWmIEEpRf+uPweWlLbBPe2HGRe8iplq6W8bfkjX4JWThEabF4LHC+F/
 craUQKzKXV4zIL3/UeM9ikFR+hXmqT6XomjxX6KgdP+vqZ+WuKfyN/HpoK811LBXsA3A
 SynCplR3iRFe1265c/IElQoqgvS0kC83NJUgloTS5P/fRdtDQryhR2PlTvFQdL6q1IPV
 D8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mcURfk5W32wdNJCNi/KCDUV8DNNwwxKl3IilrVi/wvI=;
 b=uMTXCxIvSEgQdv0H9d8m1pGpqlU3Q3KiVTk1tJtgOozBJIv6RpAUMNjo1pXSYggVGy
 1RNZ2TYg50uUSC+KFGVOr6MSKJIUfeia+Hk3QLbkyG/jrxicspWY4ey12zdBiWPThSYl
 YQAN+DPmhMDJGJjrooT9z8GyOzYbdgcK1iyzk1VJtH79fOsjCOpm8qrblVSa4qvLBKaH
 GktX8bgqbcOtXWEWK4dJzKqEo1jUPGH+xKAbpdyXRoNVCjFKqL3Wa79ZBW0IxxgGcPcq
 byzE188ER8XJF6isBj9MRys4kdg5/PNuRAgk1R+ijF3gOYrjg1vF7hf8qFGL1D5fS720
 R6rg==
X-Gm-Message-State: AOAM532nCarS1jntynEQbnuR6LyBY/nsIkiMDEYT+Naggcrl+rgf0KjP
 bF5g3QsCTi2pL/3AIFrBDWRXo3Q+VCgIxA==
X-Google-Smtp-Source: ABdhPJxkAI4+DhwXOvR1NOhvLXk3KuK5QvhSEJhe0qtC7QaI9W88quAYK3iU0t9wz4cPa/X/oBAtjg==
X-Received: by 2002:aca:c3c7:: with SMTP id t190mr3419222oif.167.1599166858651; 
 Thu, 03 Sep 2020 14:00:58 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id 187sm707041oie.42.2020.09.03.14.00.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:58 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 58/77] tests: tpm: Skip over pcrUpdateCounter byte in result
 comparison
Date: Thu,  3 Sep 2020 15:59:16 -0500
Message-Id: <20200903205935.27832-59-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Stefan Berger <stefanb@linux.ibm.com>, qemu-stable@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Berger <stefanb@linux.vnet.ibm.com>

The TPM 2 code in libtpms was fixed to handle the PCR 'TCB group' according
to the PCClient profile. The change of the PCRs belonging to the 'TCB group'
now affects the pcrUpdateCounter in the TPM2_PCRRead() responses where its
value is now different (typically lower by '1') than what it was before. To
not fail the tests, we skip the comparison of the 14th byte, which
represents the pcrUpdateCounter.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20200707201625.4177419-3-stefanb@linux.vnet.ibm.com
(cherry picked from commit df8a7568932e4c3c930fdfeb228dd72b4bb71a1f)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qtest/tpm-util.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
index 34efae8f18..58a9593745 100644
--- a/tests/qtest/tpm-util.c
+++ b/tests/qtest/tpm-util.c
@@ -139,7 +139,11 @@ void tpm_util_pcrread(QTestState *s, tx_func *tx,
 
     tx(s, tpm_pcrread, sizeof(tpm_pcrread), buffer, sizeof(buffer));
 
-    g_assert_cmpmem(buffer, exp_resp_size, exp_resp, exp_resp_size);
+    /* skip pcrUpdateCounter (14th byte) in comparison */
+    g_assert(exp_resp_size >= 15);
+    g_assert_cmpmem(buffer, 13, exp_resp, 13);
+    g_assert_cmpmem(&buffer[14], exp_resp_size - 14,
+                    &exp_resp[14], exp_resp_size - 14);
 }
 
 bool tpm_util_swtpm_has_tpm2(void)
-- 
2.17.1


