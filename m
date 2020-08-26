Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EB4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7CA520897
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWPL1RMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7CA520897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtfK-0000N5-4c
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAtdx-0007MD-HT
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:31:05 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAtdv-0006Vu-FZ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:31:05 -0400
Received: by mail-pf1-x443.google.com with SMTP id p11so814670pfn.11
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 04:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nHEmWVZQoKiBv31d0b1nWAUGSiNgf5i9gDUSz3OTqd8=;
 b=iWPL1RMMiji9Pu2GauffyWtNEFr0Vbmqegdgduke4Yt7h+lEGH/cHhJM1E89JFj4Qb
 ruPyJziqc15iKsRlQfsVdPB2IP05GuRXUJc3cDeom+7otpiTGt1XmxT3wqahAWLG2C2T
 nwK6kGVcyg9sDj3pimRIr6YckyyUWWO0UEHzPUFRo95l6sMj1/0ffY9lMCgp0uYkVAU1
 E+JWmgQEXem16bsS0jEPBpJxh0YC8MIcvF/WevSYYbZJ7950jS08kw0xbNKxjuKDAZKF
 MsQV6zidVYuvNazxxSxjPzIl1Ix2/aMnDFdlz1ZPOhMiuIj71VWiolDbetd222FyX9F6
 qocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nHEmWVZQoKiBv31d0b1nWAUGSiNgf5i9gDUSz3OTqd8=;
 b=e8/miZ9dKYzt8HTJtxMerD3znoMLuUu9cGO2nMsFp5mcjpXjgVzPLQoe/aYzNBK7FP
 JIh6k5Cs1E4rAkY0dzghAapX8dkKIbnr/FFwenjbmCbA2+kbPlX57hJMVyQB2s0fgwnL
 poQjKZ4SxoMO4rl9xsCea4l8lRUswWN/2W52hJelQY+DOIp1DXt+SfnBAnLm7Yh7UvAP
 K0v6oKU63z+oVNACFB/0/j/InM787WGFcR5unRy30BZdqjXdOdLuCZU8MwahLPNRRE2j
 mdLN4djunda3WcwLA9VcXYiw/BT5UzIJVUVC37IeCfqHAh9d6DhH4JrwvtMZ/KjhGpiu
 jUfA==
X-Gm-Message-State: AOAM531zZzJ8y3JFb3l5mVBhV5lA3oBxuz0aXccnJusNR4BnY9efnAjc
 WtLwDGW7/sL5T1OnEbL7V5iEl2zrT5dvZcFz
X-Google-Smtp-Source: ABdhPJxeNBu2Fj/5TngcbaDsEcAoYod+ZzjKxR2ZTS3GRX24NF1AjGOJ0NCptlNrT6alqr6B/IHTAg==
X-Received: by 2002:a05:6a00:798:: with SMTP id
 g24mr8062765pfu.196.1598441461042; 
 Wed, 26 Aug 2020 04:31:01 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id v8sm2310878pju.1.2020.08.26.04.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 04:31:00 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [[PATCH v3] 1/5] meson: Fixes the ninjatool issue that E$$: are
 generated in Makefile.ninja
Date: Wed, 26 Aug 2020 19:30:31 +0800
Message-Id: <20200826113035.1564-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

SIMPLE_PATH_RE should match the full path token.
Or the $ and : contained in path would not matched if the path are start with C:/ and E:/

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 scripts/ninjatool.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/ninjatool.py b/scripts/ninjatool.py
index cc77d51aa8..6ca8be6f10 100755
--- a/scripts/ninjatool.py
+++ b/scripts/ninjatool.py
@@ -55,7 +55,7 @@ else:
 
 PATH_RE = r"[^$\s:|]+|\$[$ :]|\$[a-zA-Z0-9_-]+|\$\{[a-zA-Z0-9_.-]+\}"
 
-SIMPLE_PATH_RE = re.compile(r"[^$\s:|]+")
+SIMPLE_PATH_RE = re.compile(r"^[^$\s:|]+$")
 IDENT_RE = re.compile(r"[a-zA-Z0-9_.-]+$")
 STRING_RE = re.compile(r"(" + PATH_RE + r"|[\s:|])(?:\r?\n)?|.")
 TOPLEVEL_RE = re.compile(r"([=:#]|\|\|?|^ +|(?:" + PATH_RE + r")+)\s*|.")
-- 
2.27.0.windows.1


