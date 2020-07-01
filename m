Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4B5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:12:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 780B720702
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ne7BbYYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780B720702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdTV-0004Cs-Kk
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdKr-0004nU-H5
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:37 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37851)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdKl-0006om-Sz
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:37 -0400
Received: by mail-wm1-x341.google.com with SMTP id o2so23396855wmh.2
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 07:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pcMZ/obXnz3i4V6AJOF1d+E1lr/wSxwpDkghVxLQofU=;
 b=ne7BbYYUPGqQ4gOO2pqVyltzSPxSk5g3bbKAs0ix0pW/vg9x0GoLC775o5s61wPYCm
 3FnADJ4CIg265fOYvP5XBHO8e1Gp3jh8o59WnhRD5cdatWhd4DOkVuLiL/r+7XuTz00N
 OVqG2acLbGWq2N9EqTCfkG3Cffr/YcnZHhLZLvrdOSSUWRkG0AsNiQlepRWVhQupEKLs
 Xf2jwOprYTAyrwF8VTM/+NPmRIiQbliz8wfyjIS5fQn7GeiryTmBt7RxEHOFuJv5Hi+J
 +PGfnnxQTIsCkqJZdBX2zbWpfi1ySxk01UyjXXSTu6SDtBey5H9BV0FwrdjHR66kACiN
 Y3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pcMZ/obXnz3i4V6AJOF1d+E1lr/wSxwpDkghVxLQofU=;
 b=MTLKXQn9ZioXiHPTWao8j3FdFmhQID1hZmfNBbvb9Qc7eQN+7kE5Xq6S/Vg2s6TPfv
 o/5aEN3GGGic138ZjgSzSHfKc2Wd/FFSfqvaIP+VrQeeU6qtH9wy45V5BD/+6HAbzF9d
 hJYVqInCEx9ZniU+uK1xfgANmi0CVJBWJsni5SQTtrO/qIu5of7v1gSjpSm7k4Qfco5l
 fOiAFmds2qJ5hOD3xxD0imx9Hu7OOZFkIpHcmBfx3OIcRcTB1DI5UhyohXPOOAi/dmCD
 b20EF0NhhTGMWVidQRRwKFz3bEDiwZ2lAxK4Tpo2bWAilVgHR+HVROg2XojHPd7rVgNf
 QOgw==
X-Gm-Message-State: AOAM533k/4tJeSB14vn399P3Wf/Xwh119nuyu2pwgrrZCySwSMNcu1Ed
 /L9NK/pm4CAPEF/4xp7R8wASWQ==
X-Google-Smtp-Source: ABdhPJx4K/Xk1QxnzMQQ9ReB8d4wistJ4M5aLjQjBNtZgI0VgVK+Uj/YJ4xB2J8Ob6QKQbUBP/kC7Q==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr28001926wmb.92.1593612210468; 
 Wed, 01 Jul 2020 07:03:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u2sm6878069wml.16.2020.07.01.07.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 07:03:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9FF731FFB3;
 Wed,  1 Jul 2020 14:56:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 27/40] tests/acceptance: fix dtb path for machine_rx_gdbsim
Date: Wed,  1 Jul 2020 14:56:39 +0100
Message-Id: <20200701135652.1366-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701135652.1366-1-alex.bennee@linaro.org>
References: <20200701135652.1366-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 Cleber Rosa <crosa@redhat.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The old path doesn't exist but the rx-virt.dtb file has the same
checksum so lets use that.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/acceptance/machine_rx_gdbsim.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/acceptance/machine_rx_gdbsim.py b/tests/acceptance/machine_rx_gdbsim.py
index a44f2c87da0..bff63e421d5 100644
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


