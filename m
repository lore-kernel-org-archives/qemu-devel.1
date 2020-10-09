Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19BEC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B6D82227F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HS9NpanX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B6D82227F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvT0-0005PD-CZ
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJi-0000XQ-6t
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:32:27 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:52352)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJV-0005Cn-EU
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:32:21 -0400
Received: by mail-wm1-x330.google.com with SMTP id e23so3398402wme.2
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T/QXVcD42XV9jmfLUYgXtYum/lWz3NFepBqKlWUoqZo=;
 b=HS9NpanXJktf2EGI2LeJrDnQ6p1c5m4O+k9hSundHryb+5Tvzq+AE28pYVZJDl9hLu
 9IiKKUcjvszZZUwgLAbmXsTGZwg37y4rZURV3r03Jk+TQogj5u8+aBFeIBeLlE9td+W6
 rGrFvGvbJfZ73sPuKf78KkJPjL4tuM5HUXntndNXVUFdq+tpJaWd1GJyawzANFUNRo8+
 57NhlTnnhaZGXFcLt2WrcoKZZ4ZA2BxxkvOwCWgyoub5HAsS51jj4WisCw/MEvt/NmlF
 GUpP/WxRz6uULcGq21FeA8Vl938q19vWnbGmbisI6aDedlfGrv92VkGqSQAbbDSQKvE3
 OScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T/QXVcD42XV9jmfLUYgXtYum/lWz3NFepBqKlWUoqZo=;
 b=fLA+CqMIkMO7xxCObiNdSvwweBlqtOzHW+dX7AQJWctNJDkPkkMaeLuowdoDTGo1x4
 AkdwnsMhcFZtdH1HDEGHAWk4+HRV7GZnLtpEiEF+sQySLfhLIeULxlrnQdUg0gHnqRh1
 YSJaaH0xmDyUPLlBoTrOOIRcq9S7n9XEMR0iIxDSourb0AII9pE383ctLaqtEh4qPxF3
 XrmfAhzb/wr6NEnan0CvNOViYPXpBaoeDQA3gaTpz4ZVl32Cp3uTOze63htGL4fPpfW+
 rtNgb2uweo+9sED+NbZvfdh5wi54XBC73LB/DklVpuMq15Wqutmp5GCp+berp72zw8PA
 AOXQ==
X-Gm-Message-State: AOAM531plIIeZ3oBjBNgdic2N28iq2U1T/uqPbOj1/jgbccwGHJ8Nqqk
 ZS2hICOnbRkMD73A5gIWH6jY/g==
X-Google-Smtp-Source: ABdhPJxTNBE7vOQrjBDrW9em7FtrMYKjpLiFAXRTn0EvwI+7bOExzb2YP7kxIGEL47o0HFPu/D5Vwg==
X-Received: by 2002:a1c:9912:: with SMTP id b18mr8232369wme.162.1602261132248; 
 Fri, 09 Oct 2020 09:32:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n66sm12373719wmb.35.2020.10.09.09.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:32:06 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 287631FF9B;
 Fri,  9 Oct 2020 17:31:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 12/22] contrib/gitdm: Add Nuvia to the domain map
Date: Fri,  9 Oct 2020 17:31:37 +0100
Message-Id: <20201009163147.28512-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201009163147.28512-1-alex.bennee@linaro.org>
References: <20201009163147.28512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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
Cc: Graeme Gregory <graeme@nuviainc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

There is a number of contributions from this domain,
add its own entry to the gitdm domain map.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Graeme Gregory <graeme@nuviainc.com>
Message-Id: <20201006160653.2391972-7-f4bug@amsat.org>
Message-Id: <20201007160038.26953-13-alex.bennee@linaro.org>

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 72dc65f2b5..14c0582060 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -19,6 +19,7 @@ intel.com       Intel
 linaro.org      Linaro
 microsoft.com   Microsoft
 nokia.com       Nokia
+nuviainc.com    NUVIA
 oracle.com      Oracle
 proxmox.com     Proxmox
 redhat.com      Red Hat
-- 
2.20.1


