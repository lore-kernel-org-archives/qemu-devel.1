Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B47C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F32A922251
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ObR/Cce7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32A922251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQveu-0005Kk-3o
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvRG-0003Bz-W9
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:40:15 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:51748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvRF-0006IG-64
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:40:14 -0400
Received: by mail-wm1-x32c.google.com with SMTP id d81so10449691wmc.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5SSb91lE5qyANttReMxR3EV3dROMQzH23SGqYPpptZI=;
 b=ObR/Cce79MlUvFwVuynnNMcuz/uwPTrnyhtepw5nzaUcTnEtEwtvS23DqUR80RN0GI
 LL09g23icvt6rtp4UhgQwVIjxa5xOF2cjfpFBkSQiLA5zdQOd+p5VKCky57wOezVkDSv
 DWjixVnlHOyheSxJmcpXDsTLZfHlf9f2a9hmH3dv3uwQTGeCPpv0uuTvRLJmfX6MrzxV
 2dTpLn55Xl2yhFDNEu1TxN2GLwSXppjZiUbjt5iszkBUnhwyK6OdlxA/AoNqlr7qLZpp
 QuFLJ2UbtVFVFx6D3pAI09sOmhHi6BxbFOfdeGi+6/8prcMnegOtYZ2vEsjmmmNN9S2d
 JY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5SSb91lE5qyANttReMxR3EV3dROMQzH23SGqYPpptZI=;
 b=I7EeqQhd24+mCof2zYXcRjZxCG23+gnEv1ZCp0D7gYTmauhfJwX1v8g0OsQOS4N3Dx
 XTejzdKO9D9igb9y6lTNVu2noZClKMqYnEdpGsaiZiwpo127TAdz40i5cOFoxbfBRssk
 6C1nEX+Xg0CiCoteyRR/EMt2isTHczPXTeSQFmjRtM6ktJtY49CrEkp+hHtwtIAPzyFG
 8rrI/oVVeb8BrtPXlhOFS+ZVK05s743REUxm+zyGr93/J0q0ZWfuVnIaFfykv4A4T4IY
 MQeu0iswnvPmTCeEUo+ELj38tTgxGn4RGs8SSfsaAJUNsVyz7Fn/v1eXPpi05LU7g05v
 ntdg==
X-Gm-Message-State: AOAM530V9QTEZtQ0aNB06YFhzLQxYsA2jZhio/QV127m0GjpXhN4DErl
 W7MwMw9kr6tSIe/QJcRLizvHbg==
X-Google-Smtp-Source: ABdhPJwcpqGOpK9idu++GR+oNfaHujSRqgRK4nlHXFM40iR7KNWA78H3IuMY6L+giYXITPQ96OoIwA==
X-Received: by 2002:a1c:b657:: with SMTP id g84mr15107101wmf.0.1602261611751; 
 Fri, 09 Oct 2020 09:40:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z13sm12469291wro.97.2020.10.09.09.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:40:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C3DA61FFA9;
 Fri,  9 Oct 2020 17:31:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 19/22] plugins: Fixes a issue when dlsym failed,
 the handle not closed
Date: Fri,  9 Oct 2020 17:31:44 +0100
Message-Id: <20201009163147.28512-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201009163147.28512-1-alex.bennee@linaro.org>
References: <20201009163147.28512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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
Cc: Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201001163429.1348-2-luoyonggang@gmail.com>
Message-Id: <20201007160038.26953-20-alex.bennee@linaro.org>

diff --git a/plugins/loader.c b/plugins/loader.c
index 685d334e1a..8ac5dbc20f 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -235,6 +235,7 @@ static int plugin_load(struct qemu_plugin_desc *desc, const qemu_info_t *info)
     return rc;
 
  err_symbol:
+    g_module_close(ctx->handle);
  err_dlopen:
     qemu_vfree(ctx);
     return 1;
-- 
2.20.1


