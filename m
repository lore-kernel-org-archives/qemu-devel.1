Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A58C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5FB0206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bz19ocSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5FB0206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRxPH-00054G-QJ
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 08:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRxHI-0002Zn-KV; Mon, 12 Oct 2020 08:50:12 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:56263)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRxHG-0000k0-L0; Mon, 12 Oct 2020 08:50:12 -0400
Received: by mail-wm1-x342.google.com with SMTP id a72so6482774wme.5;
 Mon, 12 Oct 2020 05:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3/Yc3WohY6Xtn0FpFPx5SHsA/mZ/UF7uI6UU+43HITI=;
 b=Bz19ocSekFRSjlJpsko0m7P6WJCseNwQ5DLsh5GuV0j3zo3yz2ZRE8I5KWhjJ0uD7m
 7Y3UjRlLdMRyo9DS+0vij3o+L+vYTyMyy0tHtWnCfS/r28i40j4Gx1koDWtgZfc8R5w8
 254azKNi7mfDLLTx4zHGE6ApOg0xq7wzlKNywwkag5o2EQ9Lu8v7wpmNlBWFkEFD/6aD
 4O28ZhUGANcvS3DNdosMewdKfOlE3yvPZo6J2ePtstGegCNDHL7siTjk7Va7Oh25YZ2w
 In9/oVACncN74EWK+t0tdxJ3TuiXFMKn1NzcL/jRa8S7f389ESFPh2BOs50VmPKn90a0
 hdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3/Yc3WohY6Xtn0FpFPx5SHsA/mZ/UF7uI6UU+43HITI=;
 b=RsUz9It4FlYam8G6gX50NFz0OyrVuzz226DRferC8w3RvG0aNZv5EkSAKRoC1us0TF
 aaBBeX000g+y8XbSH2oeUqROc5AVMIwcbs4ix27z1UDnPj/LDpSP/ZxOKPz0CUQt/oUM
 4zfnaMr0AxjIc5Vb+V+0L7Hz27xnpz/mPWQyLQgW+RmrzFsA4uvbbmOjpvm44DjwcRIV
 A82tsGqcxUiS4qMH+5+QC2cZCw7VnTbqMbIx/zksrihr7mpLfLxSTgTdl6tQo/oEyAfO
 EM9YNLSkAnSeUhSdWM/pbxhYkQ8/jKwmCS9oDEpNqVVTUK5r6t1AvtHrZPx97rpnWD1/
 /xdA==
X-Gm-Message-State: AOAM533OYRoqWeT4yyA0swo6ENTPTC+OrVzOMInkAye1oMsJEV4BRvmO
 eGnMVhx+X1ED7BTpQpY2iSx30K97viA=
X-Google-Smtp-Source: ABdhPJwMJyQLLQfQknIZjn7/Gu89gRPnraJzLY3/Zs22AP76L4GyKwaLPFD664vQIFiX8Jn4kpgi+Q==
X-Received: by 2002:a1c:7708:: with SMTP id t8mr10504313wmi.6.1602507007512;
 Mon, 12 Oct 2020 05:50:07 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id d7sm21679136wmd.48.2020.10.12.05.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 05:50:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 2/3] hw/ssi: Update coding style to make checkpatch.pl happy
Date: Mon, 12 Oct 2020 14:49:54 +0200
Message-Id: <20201012124955.3409127-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012124955.3409127-1-f4bug@amsat.org>
References: <20201012124955.3409127-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>, qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To make the next commit easier to review, clean this code first.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/ssi/ssi.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
index fe3028c39dc..c15548425a3 100644
--- a/include/hw/ssi/ssi.h
+++ b/include/hw/ssi/ssi.h
@@ -1,12 +1,14 @@
 /* QEMU Synchronous Serial Interface support.  */
 
-/* In principle SSI is a point-point interface.  As such the qemu
-   implementation has a single slave device on a "bus".
-   However it is fairly common for boards to have multiple slaves
-   connected to a single master, and select devices with an external
-   chip select.  This is implemented in qemu by having an explicit mux device.
-   It is assumed that master and slave are both using the same transfer width.
-   */
+/*
+ * In principle SSI is a point-point interface.  As such the qemu
+ * implementation has a single slave device on a "bus".
+ * However it is fairly common for boards to have multiple slaves
+ * connected to a single master, and select devices with an external
+ * chip select.  This is implemented in qemu by having an explicit mux device.
+ * It is assumed that master and slave are both using the same transfer
+ * width.
+ */
 
 #ifndef QEMU_SSI_H
 #define QEMU_SSI_H
-- 
2.26.2


