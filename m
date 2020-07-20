Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69032C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35851207FC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3pQ4A21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35851207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxVQZ-0002Up-AG
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 09:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVLR-0002Vh-BU
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:56:37 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVLP-0007Ja-IQ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:56:36 -0400
Received: by mail-wr1-x443.google.com with SMTP id y3so394680wrl.4
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 05:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=9ouB9vz4LaWxmz+dvR+lSvNVqxELEdCuBWptGBdnlTg=;
 b=o3pQ4A214mdcI8Ba5WWaseQ+K10E/TyRHTdYQ5ysZNiPbBesWzlJIE4YTPJGvpivO4
 ZB9vWsExxtuBRocDFhZ35CkvfDH78gtFSoiP4EdUdqlPveoy+d4SyRSktrJSgqcfV27r
 0Ygw4WNj5/kAqeTh+fF14kQS3o7UTqgUqtoBJ/bbS8H8Eqks/OsHAcnEwRJu08vLvVAm
 vXs4kwGpNsIUMFQOcO5DpTKQ7dD7GcMWOdpTqrEutBf/UD6CeY5Fnf5RcDFQ8adadMCF
 W71vRAHrNFJCFlhAv5zdlASDUkemC3i84V+H8bDLARzZ/0p4+fNAvdA6vq+kerxoTOJL
 ezbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9ouB9vz4LaWxmz+dvR+lSvNVqxELEdCuBWptGBdnlTg=;
 b=S3FZ02ynsvKhk0ObGDsjB77IXDxTTPS0W/I4r1jIC2hmVXUGyal0l4+6gK2c19hImg
 kCUsp7K2ZDEVhHv6FgvM6qP9tRX6MSbLVa6wDGZgljzdZV3wohFtJzN3APIesoTBmnAo
 wX7got/bpIYMkGNhjuktPUcz0CNKcHPvd5Wpy790ckUVpUk0LVxvnYsS+fKUxhSUpNl+
 MWCeYDjETi7Ljhp4bUXyvCllbzqpMgFm/xh5tsH0fRjbQv6dtLNh89wN6Kw/8gnqmytH
 BFlh/wvKcR0wtgYdK6QctpN8Ci0ncx+/lU2w+U2OAy8VBX+KkSTBp5ptXYyUPiCYqjy6
 qHVw==
X-Gm-Message-State: AOAM533/NDqAj1o++EsnFtFbdR9cNRycgn7j2lYXgnumKZPToS0iyM5f
 5ENjZQKH27Y7pZpQB25bURuP3w+K9iradg==
X-Google-Smtp-Source: ABdhPJxHREDEMRdlzd6iI+H8T/fUhtrx6dC744qog7K9NaXmAG1tvjXO4lTk2ZY25dk5swlyXF/cxg==
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr12767261wrv.104.1595249793940; 
 Mon, 20 Jul 2020 05:56:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p29sm34025403wmi.43.2020.07.20.05.56.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 05:56:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/12] hw/arm/armsse: Assert info->num_cpus is in-bounds in
 armsse_realize()
Date: Mon, 20 Jul 2020 13:56:17 +0100
Message-Id: <20200720125621.13460-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200720125621.13460-1-peter.maydell@linaro.org>
References: <20200720125621.13460-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In armsse_realize() we have a loop over [0, info->num_cpus), which
indexes into various fixed-size arrays in the ARMSSE struct.  This
confuses Coverity, which warns that we might overrun those arrays
(CID 1430326, 1430337, 1430371, 1430414, 1430430).  This can't
actually happen, because the info struct is always one of the entries
in the armsse_variants[] array and num_cpus is either 1 or 2; we also
already assert in armsse_init() that num_cpus is not too large.
However, adding an assert to armsse_realize() like the one in
armsse_init() should help Coverity figure out that these code paths
aren't possible.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200713143716.9881-1-peter.maydell@linaro.org
---
 hw/arm/armsse.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 64fcab895f7..dcbff9bd8f4 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -452,6 +452,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    assert(info->num_cpus <= SSE_MAX_CPUS);
+
     /* max SRAM_ADDR_WIDTH: 24 - log2(SRAM_NUM_BANK) */
     assert(is_power_of_2(info->sram_banks));
     addr_width_max = 24 - ctz32(info->sram_banks);
-- 
2.20.1


