Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D991BC4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73678206B6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRdkO7K8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73678206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP8UD-0003HX-Il
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 14:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8Ne-0002QT-Hk
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:06 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37408)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8Nc-0008K0-PD
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:06 -0400
Received: by mail-wm1-x344.google.com with SMTP id j136so6555560wmj.2
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 11:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cOMsVR/bsvHdway04jDltRgllwzQmPMEyrlXW5r0zlw=;
 b=lRdkO7K8Fu3h2bVNhvGVYCDCKCIm3UsTh9Q6gVzkJl+ReCYioBSXG23TEgwBHsVj4k
 XC1X/M55Ky4yFCIFzsCoXzvd/Xr93lz7rYfP3dCXkEDfE3iVtQ5nmTwQlY0DEVgyGO7x
 5lcGjUnVu7Nymn6wqvM/+x7nC9nYQu7uEM3IKLA+L3MCilWmEswtXJsPVlMXNUL5epM0
 aQrUhE0nHyjqIkWcNzYWzvCTDLCXu2bEG84zz6rozqIc3sB3saE8IwZFZOelm06ILlXC
 yFo1atH0/sInse379wcwW81rnmXFEAU1StBn7VIcrsgh2EZdx3QykPcPD1H2l+PFivbM
 /NGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cOMsVR/bsvHdway04jDltRgllwzQmPMEyrlXW5r0zlw=;
 b=fmGi5Mg99Y8ZLFuTqbnycEi3BttReuTtWVZA8Q2k1Vk4iIDPOiJneqxAV0m8uynMQK
 VvXdkCekUTI+IBsE83x123rAmon1xu7mcmlitH84I2DzXYf4i3eL2vnmnf+qswhDgWdO
 OQSBrslOujysZV+C1ZqVy69Jew6Afst2psxc9j6qiWbKf21IJ+pkskL79JexfXutk5b7
 iID2w089fcLa7+DpR/dFJl3ipnofT9IDB7cBlj7oGLjcPGOUekyG2wMe0Ymr3qp6vnfi
 jV32b4QOWkN7zQh9KW+8u3sZKK8y0UBq1v8Sejtb0wHo2L/u5nt3NhnSUu+SFD2PDIba
 u3Bg==
X-Gm-Message-State: AOAM533LrUqDORIFpP30j09gM4bFl+IYEJ8aTEnf4Vp6+T0ZsJjDpdJ6
 4FHZUAwi6cvEz6dyMckGhCb3DHDsAeu2nQ==
X-Google-Smtp-Source: ABdhPJxCLt7fxTsj6OGEMBRJLGDJJ+OXYsMePKBY86LqYQjyokm5yrfq/YNUazUqpPScJdgfTvsACg==
X-Received: by 2002:a1c:1f87:: with SMTP id
 f129mr13417484wmf.182.1601834703232; 
 Sun, 04 Oct 2020 11:05:03 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j10sm9593202wrn.2.2020.10.04.11.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 11:05:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 12/21] contrib/gitdm: Add Qualcomm to the domain map
Date: Sun,  4 Oct 2020 20:04:34 +0200
Message-Id: <20201004180443.2035359-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004180443.2035359-1-f4bug@amsat.org>
References: <20201004180443.2035359-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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
Cc: Taylor Simpson <tsimpson@quicinc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a number of contributions from this domain,
add its own entry to the gitdm domain map.

Cc: Stephen Long <steplong@quicinc.com>
Cc: Taylor Simpson <tsimpson@quicinc.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
One Reviewed-by/Ack-by from someone from this domain
should be sufficient to get this patch merged.
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index d7dca5efd4..47522dff02 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -28,6 +28,7 @@ nutanix.com     Nutanix
 nuviainc.com    NUVIA
 oracle.com      Oracle
 proxmox.com     Proxmox
+quicinc.com     Qualcomm
 redhat.com      Red Hat
 rt-rk.com       RT-RK
 siemens.com     Siemens
-- 
2.26.2


