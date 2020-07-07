Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053ACC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:21:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C40422065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="de0voltZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40422065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshv0-0003X4-2F
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoL-0006pd-7Y
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:37 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:34608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoJ-0004rs-9h
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:36 -0400
Received: by mail-wr1-x436.google.com with SMTP id f7so40975410wrw.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FLGnmkqna9y24iYAUhuJaK9vct+iWHSTDBHb/dvLTOU=;
 b=de0voltZRNqo+/KwkqE0gF6XrAgKXXQ4dQzW/I4fqtqgnYUSkT6IaolsEJTunn70aT
 Q8E1l17oYFOIcm/hshkkCrxu7cRrZVLhjucFhs0Z9FjR1FdAXBYgXW5ClM7YQ9jMvXyz
 YPmPZk7PowMtdgQCpjye/7rPJ0YPdJHAoF3/xKDZay8MSNLBOnDkl0T/2JmtYjmcpi+a
 u9xY9N6aFk3JKhWHfF1kE3LxHuk2uxXb/HxnuKM6J5fB06jkCqSSRNS1zouFgYw0nCcB
 Kz8KrCk4hYQVEbdHSKsHhRkQBQb2sHEMrfjBg32Abi/NCJbcCGRdLsu9YUXa6y4mnhZd
 4Dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FLGnmkqna9y24iYAUhuJaK9vct+iWHSTDBHb/dvLTOU=;
 b=SIImd8niiD5UEp2SRmJa7CYcdnA1y938A5RAe4qWq+pGC38VqM4AYS612fSwjNLk+R
 2RX4zPvCv1e+2bbkX+MboTdRFHf4X7gIP6BBCEH0DMYQ7jEINjDygyiMvdk6Btd7Fggh
 7IMC3sgCZOUojt2wZsURT9bXLi3h5tcGk3mLaw+wU4QJ16uWuvKDVdeX2/pXXPpxp2Ir
 bcMsK+dkAEgl0QCUA3xrRaiRvQqeE/APEzO3M1C3pQnapklryOkQ/o9Xr82dhNaY16na
 7GXHEAnVMpXe5++iFF4900pM/UPUlaNcKTJWlJOUa3eUvvxU9ThMG1R59HeV5E0OGYJL
 mP6A==
X-Gm-Message-State: AOAM532a+xLglPXEHTyFgq0DTpXfbWIpAHQizWpaRbareRq0k7WzciWo
 n2674er8xVjnbgRVUMONibSKdQ==
X-Google-Smtp-Source: ABdhPJxmD+ozpcoZI2Nf0BhuxiRksVXXsn3A5ntnTnfVc6zUrK6K4G4Dt/eS2yUuLNvLMKFwt8LhnA==
X-Received: by 2002:a5d:51ce:: with SMTP id n14mr52727488wrv.155.1594106073964; 
 Tue, 07 Jul 2020 00:14:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 2sm2145190wmo.44.2020.07.07.00.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:14:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 123621FFAF;
 Tue,  7 Jul 2020 08:09:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 25/41] tests/acceptance: fix dtb path for machine_rx_gdbsim
Date: Tue,  7 Jul 2020 08:08:42 +0100
Message-Id: <20200707070858.6622-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The old path doesn't exist but the rx-virt.dtb file has the same
checksum so lets use that.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200701135652.1366-28-alex.bennee@linaro.org>

diff --git a/tests/acceptance/machine_rx_gdbsim.py b/tests/acceptance/machine_rx_gdbsim.py
index a44f2c87da0c..bff63e421d54 100644
--- a/tests/acceptance/machine_rx_gdbsim.py
+++ b/tests/acceptance/machine_rx_gdbsim.py
@@ -50,7 +50,7 @@ class RxGdbSimMachine(Test):
         :avocado: tags=machine:gdbsim-r5f562n7
         :avocado: tags=endian:little
         """
-        dtb_url = ('https://acc.dl.osdn.jp/users/23/23887/rx-qemu.dtb')
+        dtb_url = ('https://acc.dl.osdn.jp/users/23/23887/rx-virt.dtb')
         dtb_hash = '7b4e4e2c71905da44e86ce47adee2210b026ac18'
         dtb_path = self.fetch_asset(dtb_url, asset_hash=dtb_hash)
         kernel_url = ('http://acc.dl.osdn.jp/users/23/23845/zImage')
-- 
2.20.1


