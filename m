Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDB8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:06:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CA3B20760
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cB1QV/RY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA3B20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrP8X-0006dS-EN
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxS-0005Q3-RI
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:38 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:36657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxR-0005ja-5x
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:38 -0400
Received: by mail-wr1-x436.google.com with SMTP id k6so33437882wrn.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=N/Piq7VUujhGlA1t1Zo+1vhhxB5erHw4tA6+anvZITQ=;
 b=cB1QV/RYnMHCz3vyYQO44PtoTVfvt8N9Be1jvedQ6B7BRg8iEOchpandVaUQI0Pa2v
 x6jWguYmqGxoaUSRQ33Fho1PQbsKGoMtKLnDXXkEvMEiFa+TSCKOwcrwhYfIWkVxcQO6
 loh8El8GCKPkpGr3UjxAVPBrsc/6qQsyPbAx3RTFy8QDQqlasuR3aAOink5fg13Jt7L6
 Vr0GHCpeYR5p/diHLDqtej3kpceWYBEz7DqdQOS1Y0ND7UlhxNEeexbul/H1wgQEjnUr
 0XiP+8sVtTd58bGI4/PAlTjJW5tgJHH6TJlZRodx1Nht9A5qygoyo4Czbv/t2LnnqLP9
 MdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N/Piq7VUujhGlA1t1Zo+1vhhxB5erHw4tA6+anvZITQ=;
 b=fE5FJ7hbxO9GWhRx7oLaWRBAJ8BHCS1tI2RUYat51mYQlSCyXGY7uqueuDzn3L0SJU
 VyNI5C/velhqGHCb/F8g0jyuWOtgBWNqKH0OjtBWMyy2gaH7TbsKFnWLsaRUZR16QXjW
 8QV4UMtaB3M9c6wCq7jqLZelCSmTMlC/5cCW8Bsj6G+qZ2craXCE7M6dcg9339Z/63od
 p0/cZTOqDDgjkLwGps4WsEIiZ2mU/Zg2yEi4QYj0hi/9p5XHLTmDDFx04iC+oXJCkxRl
 Jgib10/9vzskfIVsjKonnBNFMv8aSDcuE1IBxqsHXKZ3Nb2RladX3BB8Hl3+0oVvMYC7
 385A==
X-Gm-Message-State: AOAM5317MXuafGPP/vTLn5xiumS5Iv/3RFqx77/NbmE12hYKEoFWaCyZ
 E6+4waB2FCmnLe6FlwVMdqgKBcbEE/OyNw==
X-Google-Smtp-Source: ABdhPJzeL5mIY8Km8tEmolF/aiggQyT61TcBsHDW+tl6QTSYaEDQTX7YkX+MZkH6Qbksa9do1TAPxg==
X-Received: by 2002:adf:f3cd:: with SMTP id g13mr35950993wrp.45.1593795275627; 
 Fri, 03 Jul 2020 09:54:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/34] hw/arm/spitz: Use max111x properties to set initial
 values
Date: Fri,  3 Jul 2020 17:53:56 +0100
Message-Id: <20200703165405.17672-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Use the new max111x qdev properties to set the initial input
values rather than calling max111x_set_input(); this means that
on system reset the inputs will correctly return to their initial
values.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200628142429.17111-10-peter.maydell@linaro.org
---
 hw/arm/spitz.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 11e413723f4..93a25edcb5b 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -731,11 +731,14 @@ static void spitz_ssp_attach(SpitzMachineState *sms)
                           qdev_get_gpio_in(sms->mpu->gpio, SPITZ_GPIO_TP_INT));
 
     bus = qdev_get_child_bus(sms->mux, "ssi2");
-    sms->max1111 = ssi_create_slave(bus, "max1111");
+    sms->max1111 = qdev_new("max1111");
     max1111 = sms->max1111;
-    max111x_set_input(sms->max1111, MAX1111_BATT_VOLT, SPITZ_BATTERY_VOLT);
-    max111x_set_input(sms->max1111, MAX1111_BATT_TEMP, 0);
-    max111x_set_input(sms->max1111, MAX1111_ACIN_VOLT, SPITZ_CHARGEON_ACIN);
+    qdev_prop_set_uint8(sms->max1111, "input1" /* BATT_VOLT */,
+                        SPITZ_BATTERY_VOLT);
+    qdev_prop_set_uint8(sms->max1111, "input2" /* BATT_TEMP */, 0);
+    qdev_prop_set_uint8(sms->max1111, "input3" /* ACIN_VOLT */,
+                        SPITZ_CHARGEON_ACIN);
+    ssi_realize_and_unref(sms->max1111, bus, &error_fatal);
 
     qdev_connect_gpio_out(sms->mpu->gpio, SPITZ_GPIO_LCDCON_CS,
                         qdev_get_gpio_in(sms->mux, 0));
-- 
2.20.1


