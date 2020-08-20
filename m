Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A923C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 19:45:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A1B3207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 19:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owqPY7lD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1B3207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8qUq-00087N-AU
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 15:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1k8qTV-0006vp-LB; Thu, 20 Aug 2020 15:43:49 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230]:43573)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1k8qTS-000305-Np; Thu, 20 Aug 2020 15:43:47 -0400
Received: by mail-lj1-x230.google.com with SMTP id v12so3403749ljc.10;
 Thu, 20 Aug 2020 12:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iQby6NjkdZDpj5Eu21WRa/aMPhqg4CaJZ3i36bO+0Co=;
 b=owqPY7lDARmLL4RLDhfBrtXOScYGeFP4l7YM/i57DE5gtHfGWb5S43UHn/kQo9y8RO
 /Zm90fCN8LQOX/KOgo+YTKhlpo9o5WzLlby3+Tbf4zPry3eJRxp9NFBnFkj4J02EtnYR
 tsVEv1028ZY1aL/83oZcZoFwgrso8GC0kfNCq4vdLwES2bF7XMgtwGJIFg6gAnBtD5oH
 lYast5G3USTOhfrPSncG47wC0/7433c9x9Bgq/ZaLqUc1EJjmJcmeMxmodwHSRi9r3Mh
 z/IrnLcjT6MZLIMdU10hq3Ajy8DEeqQ7n9cLmZjp7YAQhM11zfaHm/kTY9nzCsr/1Dm1
 fpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iQby6NjkdZDpj5Eu21WRa/aMPhqg4CaJZ3i36bO+0Co=;
 b=A4KelMia5m2XPYG6JFMa4VhK6WmfRtV5UBn/tzvR3P4FZH1mOHD4JT3lEvGyATq+dt
 61/b8JmRZSfuQju7KPtBXJN6RVp501ykD/egA8vjzw32rHRIIZQHA5jP1PwqAzgq0tKa
 ET3LgkN/iUipl5qCVn8PlKq0Crc7TTgMRqxV/5EkJDlthv1w8Q2ByJJLnzP2Ju1vZkHy
 1AL+hT/ewxpI1gfLzqjMm7eQAuAoh0eAHqCI42cAwH94J4HiEaB5yjjuP6LDh97e2Gs5
 Rj7+xc1pq0LBWrolGV1zlFw10EtaXfLtiR0jykrZU68gkGlJzbDFQ93APLU6s4e3VGHn
 CT6Q==
X-Gm-Message-State: AOAM531I5LOlF51rWVlRcYbrZpOkBKtUzp/aOTULP+pqSR8SXIsWhLY/
 quY5sPTdvlML6mhL3AH32RUTV3nsZJ4=
X-Google-Smtp-Source: ABdhPJyjmM0drbx02Yb2sqNV1iRNafbrYxrJra9liqaDYXyBvzeeEnLGf7W1hgfw+w+DyI9nHamoxw==
X-Received: by 2002:a2e:8717:: with SMTP id m23mr2388939lji.245.1597952623703; 
 Thu, 20 Aug 2020 12:43:43 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id h13sm618499lji.134.2020.08.20.12.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 12:43:42 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/2] pc-bios: petalogix: Re-generate DTB and add DTS files
Date: Thu, 20 Aug 2020 21:43:40 +0200
Message-Id: <20200820194342.1292611-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x230.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

This adds missing device-tree source files for the petalogix boards
with recompiled DTBs.

Cheers,
Edgar

Edgar E. Iglesias (2):
  microblaze: petalogix-ml605: Add device-tree source
  microblaze: petalogix-s3adsp1800: Add device-tree source

 pc-bios/petalogix-ml605.dtb      | Bin 9982 -> 9882 bytes
 pc-bios/petalogix-ml605.dts      | 350 +++++++++++++++++++++++++++++++
 pc-bios/petalogix-s3adsp1800.dtb | Bin 8259 -> 8161 bytes
 pc-bios/petalogix-s3adsp1800.dts | 282 +++++++++++++++++++++++++
 4 files changed, 632 insertions(+)
 create mode 100644 pc-bios/petalogix-ml605.dts
 create mode 100644 pc-bios/petalogix-s3adsp1800.dts

-- 
2.25.1


