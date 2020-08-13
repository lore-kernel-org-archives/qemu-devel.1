Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE190C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0D420675
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rzo7tTcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0D420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6JXE-00037S-Oy
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 16:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6JWQ-0002MW-0C
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 16:08:22 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:32879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6JWO-0003cN-FJ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 16:08:21 -0400
Received: by mail-pf1-x442.google.com with SMTP id u20so3382843pfn.0
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 13:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=q8BMy77L7yRRc+dkxt7BhLbozbyveZleog+97Dhxu9s=;
 b=Rzo7tTcpfXUOaMs/dQyNhv2gUqMyPe2BiPffJuqZ9W8TWmuX5767O3wD8fa9B4Lavt
 jGKfEUTquco0t+NK7AXRSXD6SC3+4UOEk4/New1S/rIgHGJ4TVOkI536l2mY60WpkmpY
 eOPVZ/z0wnsZIpbzes+z4LaSq/+IrKyMEY7bEOHAS3LRaueRvxicL6wlER1G7Prt2wMj
 hQ8h3sX5tX76Bt07h5A2CY7dzwQuQHKmEYJZM6lPmY1+wk4FxbqApcaNU2GDDJNSgHcL
 H2IxvAOID2mylcW4wqb59qlGUmGn8uwzoLyFASuS9kd8t3hYwCmpNGgtkG0De1w15x5F
 Z2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=q8BMy77L7yRRc+dkxt7BhLbozbyveZleog+97Dhxu9s=;
 b=UrSlnEDDOnregjuCoTDUlEY8+OL/bGPjaW2Zuz6oZF0l/5PWVYkxnq1Tswe0VsKM0b
 9kqP07FbydYQ75Q23sWrH5lKQo83GYDeZa5bd9mHTQbRQCKY7fvyKAI6v0/CF/+TOSGg
 tSi1RD8ap2OqhKLBCb4w1woE4jixHK1qTng4LwP57WOkytr2wcfP0D0wFrFsUg6yDXPD
 sfsrJQ9JganNzBK82kRchmNgjb2kBYAiqvmt7/UeMphaLXnVJyLCjD2wF/GrDoMHHxq9
 ze5xMatao5d7bAzctBcAUi8RHoHlO81izTtpeO70wQASvtBoPm3lv4nJayg/wTswa1sw
 /usQ==
X-Gm-Message-State: AOAM531yFwNnb0tfY/qCwMz4wBLCOQ75HuI/G9EfTFQldjJcMO+mrknD
 Hum/wIfKxn/P62HBrJSVRFDipCNC+Fc=
X-Google-Smtp-Source: ABdhPJyPx/DHDKdlfuNSIx87JxLCWr4ngoVEkagH1XlLl0M1ivoUdxekthdXX5X6qwKT8l6DkJBnsw==
X-Received: by 2002:aa7:9585:: with SMTP id z5mr5633628pfj.11.1597349298422;
 Thu, 13 Aug 2020 13:08:18 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y196sm6811642pfc.202.2020.08.13.13.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 13:08:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] target/arm: Fix syndrome for MTE tag check fail
Date: Thu, 13 Aug 2020 13:08:14 -0700
Message-Id: <20200813200816.3037186-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: andreyknvl@google.com, vincenzo.frascino@arm.com, alex.bennee@linaro.org,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Supercedes: <20200812171946.2044791-1-richard.henderson@linaro.org>

We missed filling in the WnR bit for the syndrome reported
into ESR_ELx for the Tag Check Fail Data Abort.


r~


Richard Henderson (2):
  target/arm: Pass the entire mte descriptor to mte_check_fail
  target/arm: Fill in the WnR syndrome bit in mte_check_fail

 target/arm/mte_helper.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

-- 
2.25.1


