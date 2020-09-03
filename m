Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DDBC2BD0F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E86F92065E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t3Z9QAOi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86F92065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwtf-0004SY-4z
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLt-0004qx-LY; Thu, 03 Sep 2020 17:01:01 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39459)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLr-0007p4-AV; Thu, 03 Sep 2020 17:01:01 -0400
Received: by mail-ot1-x341.google.com with SMTP id u25so4010867otq.6;
 Thu, 03 Sep 2020 14:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZGuqioQ81AJZZTMFCUZaggIBmQ2hKOBauKIF8BVgJKE=;
 b=t3Z9QAOiFV38Bvy88UMabvWB9aka5Pwguc3uO0J5C8WmqW80gF67t7YPJU2BG/LrH9
 lUzjKYN/vh8bqGQjoK+mTkmOEqbqXm2EbRCCwpw6iei5dH6vEVxYsB7UpT2i2gXYhJrC
 4ZYMCMXd3Z9eWG/90IbLbrp20bgEOFpObOJbhVyPzfzJTkcxyBljCII27wY+7tL51L7D
 NPQkNuf3drqJ2n20YHA1gigfbKN2447i7zI4gi4B5bRz67rXV6A98c/aPttVK3H7IZp2
 JCiDZKFo18bRt2Bzzw+dLo639fUho/YYZWS4cTFd1h5GbBPwM13pecNBSPqQdTg/4W0D
 jXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ZGuqioQ81AJZZTMFCUZaggIBmQ2hKOBauKIF8BVgJKE=;
 b=FPfHB3HFoABVxP6Va9/PQU6Ip6XzcKwSW/xqkL4g5Tq7AFaJbwnS+ZMMdnWSd32n5L
 Py9729vGGUXstPo4RnrANumgQKtV7gjwrm6WxHVGuD1arXa2tt91zsXt1NDDNSmNAFc9
 oUKRey0c6xgWGtUmufylw1D7JxKZxpG8jmlCQPKZFVCPEEZkQcTU1N6jqn1h6RYizzxt
 3op9PDKYT1tHjjviZWJ/KxgqbUI7fjGCvyYcSjhAjfJQQ5UkzgjtuIf7kitSlfjwci46
 tt1Jxc2Uedu7Bpddsjz60JlrVYwUfSxAWSHsGP6EMHqqNTFyecnIVEDn+wK6xvGs1biC
 TtiQ==
X-Gm-Message-State: AOAM531OJ9nWXEO3oHu7i/y4JaBmryCsk6/a651vri8zI1T/qetlcg+2
 ASNJxPBnnrEDuWx67uATPs82kjIPgo7qrw==
X-Google-Smtp-Source: ABdhPJy/v8mjZfWytj+5MDYTP3PhgJaV7wQ7wilhaIq21KHwQ+47BAM3XHGdzoDCkoPhWz7w6zwxpw==
X-Received: by 2002:a05:6830:19ee:: with SMTP id
 t14mr3084951ott.171.1599166857524; 
 Thu, 03 Sep 2020 14:00:57 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id g18sm760177otj.41.2020.09.03.14.00.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:57 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 57/77] tpm: tpm_spapr: Exit on TPM backend failures
Date: Thu,  3 Sep 2020 15:59:15 -0500
Message-Id: <20200903205935.27832-58-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x341.google.com
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

Exit on TPM backend failures in the same way as the TPM CRB and TIS device
models do. With this change we now get an error report when the backend
did not start up properly:

error: internal error: qemu unexpectedly closed the monitor:
2020-07-07T12:49:28.333928Z qemu-system-ppc64: tpm-emulator: \
  TPM result for CMD_INIT: 0x101 operation failed

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20200707201625.4177419-2-stefanb@linux.vnet.ibm.com
(cherry picked from commit f8b332a1ff107dc014a52eaf9bf547995205f18a)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/tpm/tpm_spapr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
index ce65eb2e45..b67aafb24e 100644
--- a/hw/tpm/tpm_spapr.c
+++ b/hw/tpm/tpm_spapr.c
@@ -306,7 +306,10 @@ static void tpm_spapr_reset(SpaprVioDevice *dev)
                             TPM_SPAPR_BUFFER_MAX);
 
     tpm_backend_reset(s->be_driver);
-    tpm_spapr_do_startup_tpm(s, s->be_buffer_size);
+
+    if (tpm_spapr_do_startup_tpm(s, s->be_buffer_size) < 0) {
+        exit(1);
+    }
 }
 
 static enum TPMVersion tpm_spapr_get_version(TPMIf *ti)
-- 
2.17.1


