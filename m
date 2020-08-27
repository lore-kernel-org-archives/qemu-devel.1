Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AB8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 05:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC8F2177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 05:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsLcjvRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC8F2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBA7q-0004VO-Q1
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 01:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBA6x-0002vv-Eo
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 01:06:07 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBA6t-0005e7-O0
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 01:06:07 -0400
Received: by mail-pg1-x542.google.com with SMTP id d19so2483370pgl.10
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 22:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nHEmWVZQoKiBv31d0b1nWAUGSiNgf5i9gDUSz3OTqd8=;
 b=YsLcjvRX+WcK6eYyQRSaanX+IZhHcI5T0+N+EkuDFA/XgBL1wUT0v2qtab52rcEz32
 BluOivHgKqkFGzVstEKM1sFXCyeHoKR+XqA0CVU87AUitr+ZbIuyGXx4EREpI34uv35E
 mj3TxbEprXtZlZb5qehgDVzyR9AGp2FxH/Zd6YzztNcr8iNKUq3jEdeyW4uRDsefwfVu
 emHPoyyzdMDQKh3+V7PtWYJ/dgh2NROrvdjzhL1K1gSX+9/dNbBai7EZo+vibRdDWnTa
 BGptbtcKpxkD+qVBfcGCJ0RR9LWkUZHZZghnGlXokjRszq+4Ef+MKnD1lOR/uzaTJr15
 zAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nHEmWVZQoKiBv31d0b1nWAUGSiNgf5i9gDUSz3OTqd8=;
 b=Uk83Z7rGD2clMaXGir3XQWichT9WZMS39bojcIcUbku9fQhjzWp5JgFnUsz0PGjMyv
 jkQsO3QV705tSKwEJ1LxbfyQGFTLYj18AVJY3y9z6ycRnAO9hJC3hxZSQP72/c7eO1nY
 x6aYevCPxDsxVqKNvMNMm3pwl2wZkeSLOWGUR/i4/SMFGG4fXNI7T/wRwsv9vhd459gX
 z4o/jsmj54hLL5A3iZoXR/XGKJkMXWZtAy0lnuCy2D+TEgRIfLtG2uKA0g5iTrp3oy4K
 Ffk4tBBgMXaheapcNKIzSnEgZln7U+9b5jPtIBExSuFP7dyAmWv4gxuDAGTPa+nvTDac
 yi6w==
X-Gm-Message-State: AOAM532R4NBS1bwnB0WiI092PhG8eq/v4W77XMBMfu03wx5eXQqlmiKJ
 jqCHWXTWPqTAFx6ZUKe/vDp26K1Ez6JAXm9CMUE=
X-Google-Smtp-Source: ABdhPJyyOwff+ERLih2sCkkfjAaEHr8X/PeBp3LipdcXvTxUVItcCl4i8F9hQbAlzVb8OwASse6MPg==
X-Received: by 2002:a63:ca4e:: with SMTP id o14mr13594865pgi.213.1598504761754; 
 Wed, 26 Aug 2020 22:06:01 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id u3sm724213pjn.29.2020.08.26.22.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 22:06:00 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/6] meson: Fixes the ninjatool issue that E$$: are
 generated in Makefile.ninja
Date: Thu, 27 Aug 2020 13:05:38 +0800
Message-Id: <20200827050543.44-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200827050543.44-1-luoyonggang@gmail.com>
References: <20200827050543.44-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x542.google.com
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
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=E8=8C=85?= <berrange@redhat.com>
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


