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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D28C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E30F20707
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdoECw0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E30F20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAx80-0000rH-Md
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAx6e-0007gi-Sy
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:12:57 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:35540)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAx6c-0003ye-Rh
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:12:56 -0400
Received: by mail-pj1-x1041.google.com with SMTP id g6so1008224pjl.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nHEmWVZQoKiBv31d0b1nWAUGSiNgf5i9gDUSz3OTqd8=;
 b=GdoECw0e5YKinLb4cEj/ymQxqf/zFPj/c5UIrH1q8owDrW+r6z5MLq4F3F9WSCXizg
 VTOGuBAWp9ns+tR0kntL8g+wtAebs3picSb1VZwmtmr3bPrJixaLtrw7vgBxDKJPX+/X
 /0OydXANKJXperaS5SbTfyE8pFAtc02x9PKwZZqThV2/RSIvKlkaH/XhY9H7LzOkY4y9
 0OKyyFAeaF8WHEYMz6VM/JkLcN7A6v5nY7M7tfRGueJJA2eA61BiLiIbmDz+WgA+KMJK
 /4GrFgSQIvCPzi7+99ByxA3ASJ9CVDbWfN0h/fVuDt2SvjPBLSHYJ/2ZWMNxL8Zqy21m
 FScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nHEmWVZQoKiBv31d0b1nWAUGSiNgf5i9gDUSz3OTqd8=;
 b=IiBrDwvao6TglNBXPA6B0nYJwJmuHAspZ3VsAracRacnPhkoq45DXHNsI1dbyV8ovx
 ymbKFuaPA0xfqUlH5Wh8FK4Q+YP4EeVqmcDQR72fOo/X98ltWdNvIWHDY/1qRStOfQoz
 Cd8X9WTpARqGrHZ4VAxaoihiN/Pn8gjSF35VwJkWaGv6KMe862KQoqGz96KVxWI3gOwA
 o9SM1O7Ep6pE28+u4otM8turBMbztUPXFo9vrf1WS86iLf3gb/dqZ4XLOtSQDr62yOuo
 6vAzZYhxl+4DPCgpdu39uVRv8/S3499WXU2pmMpYz1S/pwsg5YqFyPtzHimIPRDvxv+h
 9EbQ==
X-Gm-Message-State: AOAM532SwTVjKZP8LexWGrWj3uEczbiFxW07GQ1w+/8YfRAt22qctMqc
 5Bch4xt4Sw9yYEdQbKOHsYMt85hbWAd5wQNk
X-Google-Smtp-Source: ABdhPJwgto4tcYkZ5LksKK7qnwVO1X4jKzO+5Qo9STqU6NDJ/kCkPzEw9wuPn20TrVL2al08H5g8tw==
X-Received: by 2002:a17:902:8690:: with SMTP id
 g16mr10552773plo.257.1598454772839; 
 Wed, 26 Aug 2020 08:12:52 -0700 (PDT)
Received: from localhost.localdomain ([2401:c080:1c01:4fe:5400:2ff:fef1:b056])
 by smtp.googlemail.com with ESMTPSA id
 27sm2423169pgk.89.2020.08.26.08.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 08:12:51 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH v5 1/6] meson: Fixes the ninjatool issue that E$$: are
 generated in Makefile.ninja
Date: Wed, 26 Aug 2020 23:10:01 +0800
Message-Id: <20200826151006.80-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1041.google.com
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


