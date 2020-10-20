Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFE2C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:05:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 421DD22247
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QZrlTwjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421DD22247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUu8P-0005um-41
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0y-00050E-Jh
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:32 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:40611)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0w-0003uu-Oj
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:32 -0400
Received: by mail-wr1-x42f.google.com with SMTP id h5so2782044wrv.7
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+9ZaCuqJ8zy5+WF6Ipq45D8XTLEwaZjQqev+UaIXemI=;
 b=QZrlTwjEkBaMCIC1d/uvrI3vrqCVEHp7+92sHuyrYVaZxMTX72RivHo5WM7t9qV8hZ
 iUQNRR+ybj+680OQjeCcIN6Ll6Jlu6C9ZGSsnctXevi6XOpgIB4W3sefhHwyZv50/iii
 3eJiArHg439X37qBet2fK9OJFjaAxaq5xmTq/DhR+c86UJtR7xashc3IvUKzuBDW3kH5
 rPvgVkpekLUXB/GBI2PQfrTNjsEq8m2++I+dHu3U7Uyr6yzS4IdevlcSAB+clc+K+Dgr
 xuCFbNCuFjcAEf5v3IKvufxYTQ+63S2as8UF46j8l+o+036THgWaeg6tHiFqdUdByye+
 f1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+9ZaCuqJ8zy5+WF6Ipq45D8XTLEwaZjQqev+UaIXemI=;
 b=EbUgfN+3hDLVBrSBTrsPRUzlLGoZFzBSgYr+S4YFr2qYLL62b5hFnA4PhKWcTfDtsU
 4IbqOiw0d9i2ME4LkXUvO/lwpmX4zWPHYN5mriYBc9rc0UMDAwd/yLKmL2M6uHALDSej
 A4zWil6Vhn+o+Sm2PyG3gN0+no+Msn0GMaBp/is+ogkBY0JGLqdJFPHiPe6jKFkKR+G/
 Edzs+GhHjk2bef5eyn9v/XuJxWcrItg7v0SCSgP1zFFiX0g+EoL/M//kS18g4EwcGjwS
 VIfZ/noDip6MRCpl6BtWlsaBv5l1UsFD8oS63O+X+yPrXctlCB3LnWIUWGxJKEGfeq5D
 fIpA==
X-Gm-Message-State: AOAM532XIhW5x6UZezSqrDXHe4yX4qH2J+mFNFoQTeTjKHq2R7486KD0
 Gn/7fSxpdbHbWLfypajordhxzwAfEc+j7Q==
X-Google-Smtp-Source: ABdhPJxq7gh9PEd6vbWOE9fr9pBr46y0RZ69WtV1ie28M7HbLr/vAH66VJGbsxNFfMR8g6HW/TdWZg==
X-Received: by 2002:a5d:5604:: with SMTP id l4mr4150749wrv.140.1603209449025; 
 Tue, 20 Oct 2020 08:57:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/41] microbit_i2c: Fix coredump when dump-vmstate
Date: Tue, 20 Oct 2020 16:56:33 +0100
Message-Id: <20201020155656.8045-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Peng Liang <liangpeng10@huawei.com>

VMStateDescription.fields should be end with VMSTATE_END_OF_LIST().
However, microbit_i2c_vmstate doesn't follow it.  Let's change it.

Fixes: 9d68bf564e ("arm: Stub out NRF51 TWI magnetometer/accelerometer detection")
Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Peng Liang <liangpeng10@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20201019093401.2993833-1-liangpeng10@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i2c/microbit_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i2c/microbit_i2c.c b/hw/i2c/microbit_i2c.c
index 80247398208..e92f9f84ea8 100644
--- a/hw/i2c/microbit_i2c.c
+++ b/hw/i2c/microbit_i2c.c
@@ -83,6 +83,7 @@ static const VMStateDescription microbit_i2c_vmstate = {
     .fields = (VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, MicrobitI2CState, MICROBIT_I2C_NREGS),
         VMSTATE_UINT32(read_idx, MicrobitI2CState),
+        VMSTATE_END_OF_LIST()
     },
 };
 
-- 
2.20.1


