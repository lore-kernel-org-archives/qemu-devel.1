Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CC5C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:47:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E88A21D7D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMIzdWzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E88A21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG4CA-0004DB-Ib
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 13:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kG4BI-0002zb-NE; Wed, 09 Sep 2020 13:46:52 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:39426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kG4BH-000820-4l; Wed, 09 Sep 2020 13:46:52 -0400
Received: by mail-lj1-x242.google.com with SMTP id u21so4678678ljl.6;
 Wed, 09 Sep 2020 10:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ResYvHVsixTY2DnmgFATFOdSIPiM9sAszbffp91IaMo=;
 b=lMIzdWzJqPy4S3oEti8lj7lqTWvS5vZURTIjg8eStBiLIeiq5l2PKu/4zKA82id4pH
 4+5ZhRpku0tktuMoAQcf0CqUkw4DVGCwGhdOxtQ11Ewq/ulBEtY3v/u+kEzCVpQtoyCS
 f0SGlhq0u5Bg+U8OepJ4VCtfAurkm9PWfeEEU+tyb0H214EaupsDo+PPd/F+A+51VnGj
 4QC7nsQt4fBzwEGg/R5CHli9NB4bpmRv9ANvhvoCXH3mKTEjkShKWCmXYsgO4bnOT3pQ
 zwEtn+9ILvwGHBfabva0WSb+zmSC0FwS3GFAncChYQ46l7kylqZ7RdkPrxp3q4G9R+pU
 eNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ResYvHVsixTY2DnmgFATFOdSIPiM9sAszbffp91IaMo=;
 b=BvmdAQz+HXCxcVZ+Zzzuj3h9UMjyNIL5/lKc/bnRaZlOMff7c4iCAFK0iwWXr6CgIU
 Wa21V9R02aNCijEPYRyKIuKW7tLFFE6IVqwvPYQcAXv61aI4Cd1SFcpeOGkp6t21shBr
 a8zPM0c+UZF8pFqL8R1NJLAQVIbMF9T4NDa/fbjI4UP7WRbTUbh5y7eh1rR8jUWjn6Wi
 i3a7xUBbU45JDTyR9yxVb5kRMTgZjx1Q1WNrom7YUqbSHGvXYcuWF+wqq2/GZGW6lStY
 tc1P86mzv5/EDHUnHv0rwIw7tk42A20Fv4VO7dYGy8WLvq08w5c7F2VVLI9497UCtQCf
 SFBg==
X-Gm-Message-State: AOAM532s4gd482LOmLxBa/82Fc6/NVdy74sgXSHUvY0WcqjEis/VXuRz
 ELTdae8X90etJAFTHGchLKJZKiSu3BY=
X-Google-Smtp-Source: ABdhPJx83oD15eVNklv74Si0OB9Z/EbTV9oHhYjvUmE0r463FGT1nt121GuOftlE6bZw/f801lYM5Q==
X-Received: by 2002:a2e:5054:: with SMTP id v20mr2633841ljd.345.1599673609051; 
 Wed, 09 Sep 2020 10:46:49 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id s11sm904637ljh.56.2020.09.09.10.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 10:46:48 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/1] hw/arm: versal-virt: Correct the tx/rx GEM clocks
Date: Wed,  9 Sep 2020 19:46:46 +0200
Message-Id: <20200909174647.662864-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=1.8, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
 frasse.iglesias@gmail.com, alistair@alistair23.me, frederic.konrad@adacore.com,
 qemu-arm@nongnu.org, philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

This corrects the Ethernet tx/rx clocks in the generated DTB.
Avoids a Linux kernel warning.

Cheers,
Edgar

ChangeLog:

v1 -> v2:
* Fix commit message typo, I -> It

Edgar E. Iglesias (1):
  hw/arm: versal-virt: Correct the tx/rx GEM clocks

 hw/arm/xlnx-versal-virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.25.1


