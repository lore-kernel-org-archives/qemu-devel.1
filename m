Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE90C47095
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 445EB206BE
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aZpK79nU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445EB206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCMv-0004Tb-6n
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQC0r-0004SP-3F
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:09:57 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:46864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQC0p-0003Ep-6D
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:09:56 -0400
Received: by mail-wr1-x42c.google.com with SMTP id n6so2554583wrm.13
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 09:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=05jC61y8B+Ibr2TYdyvTz5KnsGregGooUhgasKNJco8=;
 b=aZpK79nUdbYSSlpy2/YzAZz/IvlW/u1jUAk0DbEBdMEG6sjVwn/qllmW6GYjRfkO/i
 AcjlQ6f9/UJ8BA7vbbvPG2VrQPhyfEux44lWak1/fU05V2iACkF0H99TSaWQtxXd5sKr
 pVtiS079CEqDCqbjvak8cOILJ3qxUC4je+D2YebhB8b+iEQkqBP82X7f1BAwauqeFtgn
 f5yX7TJl+t9Xkpg45YUyVj5stdn8JJoa62Y7/pb+QEnjh/CmKxEcJIhEdMGuZIBBuWKH
 ayPN7c2xKH/NE4C7jVVJ8sXa0FAzig3G72uk+gDrBX3Xmi5x24WEozeY1U8OPVLQHzIr
 EeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=05jC61y8B+Ibr2TYdyvTz5KnsGregGooUhgasKNJco8=;
 b=S5M3FzjGOGePyp8ZqLoiR5zthskUNtYsm6Q+7xzZ/GW4WIvti88cn0vNfSyIELzWge
 SyCyksYb28CO1foVgEnzN4ZVkFz3dDZ8lWl/xJDuTAGP6DJmduL+rV7YNQEQNAxT6/j9
 g8lk95f47rarCQV+VBUo+JhrS3xyoHKg6jdb4Nl8BY2wM7Q+BjTzIxzUgnvjYUCvxNrG
 dfzqzED990/ybjFgKKII0Yl0HsKW9OrF/ECBU/jPIYGgvaZKkEJKfLJt0iHDXe2J1iGh
 0RfbUZD9D0CcpyLjeV7/ofkKNmSv7pygIwR1JCH3vu27KD8UQnOHVWD3DtCKJBrQwW0W
 lS+w==
X-Gm-Message-State: AOAM5319RN4qkve3VQnj+SiPamRnE7FzryHOsNzIFO9qU4se1sC1kk/g
 hgQS0mxn8CUMlgRtNcB878BnEQ==
X-Google-Smtp-Source: ABdhPJx9M7unxUWWHvLMpgAbZ+3pKxyHfXshVRmYl+pM2rC1JghDm86XZ3qyt10GNQaX8TkiiQN/zw==
X-Received: by 2002:adf:bbc6:: with SMTP id z6mr4378064wrg.298.1602086993867; 
 Wed, 07 Oct 2020 09:09:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h16sm3549444wre.87.2020.10.07.09.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:09:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4F5261FF9C;
 Wed,  7 Oct 2020 17:00:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 13/22] contrib/gitdm: Add Qualcomm to the domain map
Date: Wed,  7 Oct 2020 17:00:29 +0100
Message-Id: <20201007160038.26953-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007160038.26953-1-alex.bennee@linaro.org>
References: <20201007160038.26953-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
Cc: Taylor Simpson <tsimpson@quicinc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

There is a number of contributions from this domain,
add its own entry to the gitdm domain map.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
Message-Id: <20201006160653.2391972-8-f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 14c0582060..6c5c92260d 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -22,6 +22,7 @@ nokia.com       Nokia
 nuviainc.com    NUVIA
 oracle.com      Oracle
 proxmox.com     Proxmox
+quicinc.com     Qualcomm Innovation Center
 redhat.com      Red Hat
 rt-rk.com       RT-RK
 siemens.com     Siemens
-- 
2.20.1


