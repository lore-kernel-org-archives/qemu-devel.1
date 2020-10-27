Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BE3C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:22:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35D7022284
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pPYI9IL0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D7022284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNzs-000334-6P
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPX-0001Jo-0J
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:08 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPP-0004Tp-6q
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:06 -0400
Received: by mail-wr1-x443.google.com with SMTP id h5so1521089wrv.7
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+RdtttAieof9YD+RQ+f0LdfoapTUgcOeZyy/Grfs/ws=;
 b=pPYI9IL03JUC65S0+QPJwSfujorSTgEJ0inZVSTEjOjNlt5FWInVTlUdwstjgpJL/Y
 pu2g86QpxakFwQ0Y+oZlavSBaaWcZBsv+wD4XtHXtEtgHi3J6IJNS3BIyXmOJ+fKFPbw
 nOIvuKQoUbq3t4EZhxPquaNTdiSTNyZHFd4eylO9hgJnmHcZXBba5Nw1rvNgZ0+OhQtQ
 Lj+zKeVjMma1/zjy24JudRLxRYW3yhrMfLuoPPL46mu01bp0GPktjN0/RWsJbHgJHK5x
 gU6+Jk7JCvJaZQBy9ACFQ+Ybe+Lp5qVc/knX25F0Y4q1cAOjtvemvtcuf6dT3FXRkz3u
 zGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+RdtttAieof9YD+RQ+f0LdfoapTUgcOeZyy/Grfs/ws=;
 b=gV+un7XbuT5W1RIdDWgx2RDXRG19x4VRYbnbYRvWPt3Awp0FM/XFhOOyT2PcecUSkz
 Ad0Y4W0B6jxDG/I4gH25KMsxup+nrkMqHHEqFNnou9i7NnwvlaE4su5SO4rIfmhyUGPS
 6BsyuojilySrlvSsFnbkHqnJdQfqhxPAziHFcx+9fbVbIoaJ4QMTyE0VvUuCrqmD4BV0
 +GJeGBSJ37FJHHQt9pwSU+J/xx8BCadPV5zBn8fZia4GkncxwGfoOX1xOi1OjQhVRG2Z
 Bpj9UUZPyjTDCrowlSMHEca/aDoamHGt86GhJC0n/9GFzC3W3cAlV8Lu+ZtraW/FwNdq
 OVQw==
X-Gm-Message-State: AOAM533xJaFEPqQbxk9r1KjLsPU8Nrvc6P0Ta4O5cdBLGO9U3gWx6k27
 ik4SGBJAq2wJkgEzUIH9aCskywwnIdIPwQ==
X-Google-Smtp-Source: ABdhPJysMyuBRhGHchigenYWj3uyT0pUxTe7lmGZf3NftpH84RZSVKMBTf+kWGef5c2q8F7GgjzmmQ==
X-Received: by 2002:adf:ab4e:: with SMTP id r14mr2345847wrc.397.1603799097428; 
 Tue, 27 Oct 2020 04:44:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.44.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:44:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/48] hw/arm/highbank: Silence warnings about missing
 fallthrough statements
Date: Tue, 27 Oct 2020 11:44:03 +0000
Message-Id: <20201027114438.17662-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

When compiling with -Werror=implicit-fallthrough, gcc complains about
missing fallthrough annotations in this file. Looking at the code,
the fallthrough is very likely intended here, so add some comments
to silence the compiler warnings.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 20201020105938.23209-1-thuth@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/highbank.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index da0510d7cef..f71087860d0 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -92,10 +92,12 @@ static void hb_reset_secondary(ARMCPU *cpu, const struct arm_boot_info *info)
         address_space_stl_notdirty(&address_space_memory,
                                    SMP_BOOT_REG + 0x30, 0,
                                    MEMTXATTRS_UNSPECIFIED, NULL);
+        /* fallthrough */
     case 3:
         address_space_stl_notdirty(&address_space_memory,
                                    SMP_BOOT_REG + 0x20, 0,
                                    MEMTXATTRS_UNSPECIFIED, NULL);
+        /* fallthrough */
     case 2:
         address_space_stl_notdirty(&address_space_memory,
                                    SMP_BOOT_REG + 0x10, 0,
-- 
2.20.1


