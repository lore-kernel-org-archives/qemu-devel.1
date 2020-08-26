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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DB3C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB482083B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UD9cOa/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB482083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtiD-0005EF-9S
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAtgr-0002tY-Bx
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:34:05 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAtgp-0006hJ-M9
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:34:05 -0400
Received: by mail-pg1-x544.google.com with SMTP id o5so903039pgb.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 04:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nHEmWVZQoKiBv31d0b1nWAUGSiNgf5i9gDUSz3OTqd8=;
 b=UD9cOa/a47vPa6dJ1ilncNdjvMU112NkxIte03WY+6qrSWCP+ysQaBLpsUbtEITezO
 GooWbTavYASJP/x8QSp2uJh3bIMn4DifApS3o1sIx3QylRgXZyoW94GJ/QDyIo4dukrr
 kCim66fs6/oqMuTsTZtFlJJA6DXh12WLEGl4g+8qCwqFH5AHJhNSnW68BVyATZ5CO5Gt
 dl7QVf9T9wq7TVARFJsKgXI7hAWaCm1lLHy4ZeAvLNK2bilR/rD4AoaL2G6oUbfb/yJo
 hIkV85g0YtdLXpj/x7hzvhXp2XmRBQNc+gFQZx1k2jeXlMbUlBB/wGX14x+WvQlkwg2Q
 jEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nHEmWVZQoKiBv31d0b1nWAUGSiNgf5i9gDUSz3OTqd8=;
 b=baixsrNYR4jIi+DSxgMwUNSX8T58/uXA071+DfNUOGs+0AEpvY/y9d9rzw7xbsD+rS
 IjXdW96YEAd28zWNN+hg/fE3Mam54P92m/ZXVWllgOanvNjaNTKlUwh7m9ZLH2pEwiS5
 h2bbgniw35PoWeiOgelFoL8ok7Ui1fLHjKO6yHI0VZ51G3GY9oq2DK7Y0SvRI8vz0+P5
 NmuXNfs1ot0XF3M5SW0ZrCJDZ+reg1gQUu3/zyTMv2mSHYi03gRcLBRxMrptZHQiTP8s
 tZ9RS/IktUOkVX+aXbBcpqxeSAQHr6Ej2+KOdUzvVWPB5O8YXGH+52zizfHNLDYFDDyT
 MUpw==
X-Gm-Message-State: AOAM5300FuQ4RWDklxFL8KubwJfOs590SMSJa3+/TUzs/khXdRqRGGdB
 90p2OJ6c93his41BLrsOIILaffeGzN8kmeQy
X-Google-Smtp-Source: ABdhPJyYo7308n1g7FMHCagGy2xTCPEiZc2hnY40vH2WXOVo9fniG0ZeWKl1IfVrSNfDSZOzP379Nw==
X-Received: by 2002:a63:1704:: with SMTP id x4mr9761293pgl.186.1598441641561; 
 Wed, 26 Aug 2020 04:34:01 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id p20sm1915914pjz.49.2020.08.26.04.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 04:34:00 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/5] meson: Fixes the ninjatool issue that E$$: are
 generated in Makefile.ninja
Date: Wed, 26 Aug 2020 19:33:22 +0800
Message-Id: <20200826113326.491-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x544.google.com
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


