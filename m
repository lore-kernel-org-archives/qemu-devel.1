Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2790C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:02:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC372071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pziHfGYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC372071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA9Ii-0005sz-TY
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 06:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kA9HY-0004AX-TT
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 06:00:52 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233]:36886)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kA9HW-0006VN-MF
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 06:00:52 -0400
Received: by mail-lj1-x233.google.com with SMTP id w14so8914852ljj.4
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 03:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Dd0EJqBzQHROoOB+Rn94QdMh9XLX7GYS6cokwONIqVU=;
 b=pziHfGYhMC/iWsOnUi2CgZkNDxcuFp2meX13mNkMLtXH6J3OT8jTyeWd6sudEaMI61
 RyUc0pUt4PIaPGD7HM8/iG9yoAHAB4oRDAuhZNNPMyzw9Wje31Mrr7cmTut6HSL8q4vP
 /Wbnul9O9lX6cwJSIWiw/y5sHoKmFq/VmcH2I+DtygW7y+ttXrmITxEe/fbRSGv5dwUl
 jaF2Je6cO3Or8DeIiViSReVqv8IkYKBi08r7FuVF7vGtp2vfNCfr5dLSIAtcYo6xFU7I
 qlCadpqkvWDvVZpkyP8kfVdBBXDEWiGIUosqKbp6eKggx5JLrTieL47lxn30pxN1/9Yu
 OLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Dd0EJqBzQHROoOB+Rn94QdMh9XLX7GYS6cokwONIqVU=;
 b=DlElGDt9R/Q6qECyNrI4s5bxcPnHBuE+20LqjrB3VVbfmLsbuKS52Voa/a+0jNKTdN
 iDxlt2E1ng6yKUsKaqpADd4p3ayEws0Ri/i3m1yao3QcBHyRRpdWcQoTIXsdCdYdKyUN
 y+pZxwBDFpqasRmXtrpXfafGn4N2kof+xtiw6uWNyfoWy4Skch10fDeM0K10WbA5kko7
 kt7tBIsgpN9j/2hjOHhpyOXCDgmhCvEJlWxLG9YgWX8K9hKEHitJB52S5fIESi3YbHOg
 LuhEca7AR7ipW9rPRbQm7KP3D4hTqUNwA2GTntltpEX44pcRXZBaafW7V+mtCsD+WcuF
 uiMg==
X-Gm-Message-State: AOAM532FzdyVL5Np2luIVWn4evBCD7+1tZEu/dzWfR/XoOGBHlUXEsV1
 bzxS1Nla0nUq7WAGhCr9ey33wXiOHhQ=
X-Google-Smtp-Source: ABdhPJzUx//VV7Z8T+ypJUtu3bWSrAezzxKizV3qVivqXg/ycTKXcpSoVDnvCEoGS9C2/UCW5z8y7g==
X-Received: by 2002:a2e:2c0e:: with SMTP id s14mr2424491ljs.28.1598263248682; 
 Mon, 24 Aug 2020 03:00:48 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id h13sm2080703lji.134.2020.08.24.03.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 03:00:48 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 5/8] configure: microblaze: Enable mttcg
Date: Mon, 24 Aug 2020 12:00:38 +0200
Message-Id: <20200824100041.1864420-6-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824100041.1864420-1-edgar.iglesias@gmail.com>
References: <20200824100041.1864420-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x233.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 16
X-Spam_score: 1.6
X-Spam_bar: +
X-Spam_report: (1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.724, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 67832e3bab..b8f5b81a67 100755
--- a/configure
+++ b/configure
@@ -7782,6 +7782,7 @@ case "$target_name" in
   microblaze|microblazeel)
     TARGET_ARCH=microblaze
     TARGET_SYSTBL_ABI=common
+    mttcg="yes"
     bflt="yes"
     echo "TARGET_ABI32=y" >> $config_target_mak
   ;;
-- 
2.25.1


