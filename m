Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D432C47247
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BEAE206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bqq0lQ1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BEAE206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaIY-0001Xz-4u
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHd-0008Fb-PI
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:17 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45997)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHc-0000j9-Uh
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:17 -0400
Received: by mail-wr1-x430.google.com with SMTP id k1so1830269wro.12
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=xmwQJ59ebHjR9ouwlTnSfL4Ky/fRkTGEraev7ufNxkA=;
 b=bqq0lQ1mpxvsAss8rbAXbX8FeEcQpXvVe3PMKyD2nWCO4AJtCOgTUv/wSDbCkrXf9w
 QbkkxcdIpHt8uPHYvl3clIBMdRHi94tODCvqMD2/A1Szi1MJXjsls7Px4W7LkESp13Wt
 WSZdB1iOxKns0tAzo3P3H2VELiL2AVGmUc3PF82eggJM5Iv2cOSZ4AwSPmrQi6nHUvy8
 AofDml1U10p7BPwOP4zgkJC73RjNXHNKwGD49TzPO/QyWCN/i/8/TMmS/MKo6PS7iHFR
 Ws9ZBQFCeyOJtwk8qXZRZEy/iZTN4Kb6CRLVtpwBC4jviEWQF2yCV1t3rP3ySZ4V8j+f
 c4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xmwQJ59ebHjR9ouwlTnSfL4Ky/fRkTGEraev7ufNxkA=;
 b=sC8i7JHrCRCT2VK/8OVWcPSrAktHQ4kflnf/Eg9O0aYQRA2PdnSFVD4OzpOuXKP4VK
 /NSowIbXQ2IfH1IN89UAE9aX5hB+84EBLOOyZff7PJPzIw5dN5k5uO6AWuvuZ/IR0a55
 vH+nmzB5o3OJw9MuMjCvK/4FSj9BZz+jbzgijC38N9vvg7Wx9gcb9cXagXbRzitlxxKW
 zxt63y8D04a3H5HsKUi+0ZSiiDahNwEoJmkCZxwdocalHsLgRT24FmmnBhdWHoJ5kvY0
 WkjD26iHG0ihwbweyQJRropSfyA86sp1J+aw+C8McrmT5Yq5vqLtdg3ezGEykXjWtklQ
 nl7Q==
X-Gm-Message-State: AGi0PuYo/nkcbCV9ZAtwH2XnQHzXibJyb4DH6ibVk3UJcni/XZcTmi45
 zwpzDWxp3EpsbSTC1vG2SqkMQtrT6FIJKQ==
X-Google-Smtp-Source: APiQypJXLgCp8D34gCB1ADz+2Pz+OnKYSOb3Y27CEEQR36qEs+CfGyUUHJc3coMteXhQBUtCWZL7yg==
X-Received: by 2002:a05:6000:1146:: with SMTP id
 d6mr7078593wrx.289.1588595594518; 
 Mon, 04 May 2020 05:33:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/39] hw/arm/mps2-tz: Use TYPE_IOTKIT instead of hardcoded
 string
Date: Mon,  4 May 2020 13:32:32 +0100
Message-Id: <20200504123309.3808-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

By using the TYPE_* definitions for devices, we can:
 - quickly find where devices are used with 'git-grep'
 - easily rename a device (one-line change).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200428154650.21991-1-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mps2-tz.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index a8dea7dde1c..2c43041564c 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -395,7 +395,7 @@ static void mps2tz_common_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
 
-    sysbus_init_child_obj(OBJECT(machine), "iotkit", &mms->iotkit,
+    sysbus_init_child_obj(OBJECT(machine), TYPE_IOTKIT, &mms->iotkit,
                           sizeof(mms->iotkit), mmc->armsse_type);
     iotkitdev = DEVICE(&mms->iotkit);
     object_property_set_link(OBJECT(&mms->iotkit), OBJECT(system_memory),
-- 
2.20.1


