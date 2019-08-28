Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82747C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:22:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DAC42189D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H9s7mKta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAC42189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2wxy-0002r0-EF
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 08:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i2wlV-0002K8-7J
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i2wlT-0004E3-Bi
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:09:29 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:38326)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i2wlT-0004Df-68
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:09:27 -0400
Received: by mail-wr1-x431.google.com with SMTP id e16so2249700wro.5
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 05:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZPlBiunhfKpTczKApGa0BHboWJTJ/S0U2B+sG6MNmqU=;
 b=H9s7mKtaUqlA4NE6VRWAV3aAXOQmGnzggq5Qlfgh3qAe+LDz1CJE15bvVCxGLS+BzG
 4ERDvdnKa6mwRPovOsEnweYcz8VhDlz3r06PL8TX0l5SsUDDirNnIAsZH20FwuGEoi05
 KF/p/zGQuSyw34K58NxTBp7EVglEbXPWwTgpz+bMCZntrLsScbrC06DUXdlxNyRJ8P0v
 /g5r9XrRsmS4QCf9nWxYw/SGFRWRfhVPwkfg27JHsofp2CRIrZ3rbXzd/1W+lrdaTSri
 ypw2pnXdkfj5VEEXwIdeejed6oxRK/91AljFITtRI8xC2Ugd9dCo0P+mRcYVFhd0DFuK
 w0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZPlBiunhfKpTczKApGa0BHboWJTJ/S0U2B+sG6MNmqU=;
 b=TVp3NtjeEtv2pURVnom0+8byYGS95NR56Zbg/vsuqqsbcmUPW81VhtHCbBKbUyFudw
 odoRq9sJqdbwgOIDbv99EOWAII+k+jKLN4io82RWvhSS+jbvFxvtySvttNoVEayTv9tD
 6SAr2E58zU5/zGSjknnc8IU6hXHj3pwj+uyL0r6S1cHDyiRhWsHrAldeGR8hxTggglXe
 oyVM3wsNpd5DP1dqaHk0oH4ZjoZ+c2PNT8zUM2qFG6QIcZY0E9DDUiYtEY8ZECvknrW9
 VY0bWzoV47aXU6fH1KgNhP4TecNz3wcuF9PCADWlThFxSdEvk4z4IunIvf+MMy5nKFIK
 4aYw==
X-Gm-Message-State: APjAAAU5JLjti2N47vuSkECWoLT8BDssdPiyLyvyTUUVHurnpHdmJcG2
 wCYFOShF6YIdZIKFYJTMVdqOHw==
X-Google-Smtp-Source: APXvYqxhdfntArWRUpC//M/W990Ugknj0QBPTOAiJ3GD2jq+pDzcbK8CFswk2EoiEwjZZ6Yh9E1hVA==
X-Received: by 2002:adf:8444:: with SMTP id 62mr1061710wrf.202.1566994166189; 
 Wed, 28 Aug 2019 05:09:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i5sm2902577wrn.48.2019.08.28.05.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 05:09:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 239961FF90;
 Wed, 28 Aug 2019 13:09:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 13:09:16 +0100
Message-Id: <20190828120921.9586-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828120921.9586-1-alex.bennee@linaro.org>
References: <20190828120921.9586-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: [Qemu-devel] [PATCH  v1 3/8] mailmap: Reorder by sections
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Our mailmap currently has 4 sections somehow documented.
Reorder few entries not related to "addresses from the original
git import" into the 3rd section, and add a comment to describe
it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20190822230916.576-2-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .mailmap | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/.mailmap b/.mailmap
index b8e08297c90..e1fdc88d25d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -4,20 +4,12 @@
 # into proper addresses so that they are counted properly by git shortlog.
 Andrzej Zaborowski <balrogg@gmail.com> balrog <balrog@c046a42c-6fe2-441c-8c8c-71466251a162>
 Anthony Liguori <anthony@codemonkey.ws> aliguori <aliguori@c046a42c-6fe2-441c-8c8c-71466251a162>
-Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
 Aurelien Jarno <aurelien@aurel32.net> aurel32 <aurel32@c046a42c-6fe2-441c-8c8c-71466251a162>
 Blue Swirl <blauwirbel@gmail.com> blueswir1 <blueswir1@c046a42c-6fe2-441c-8c8c-71466251a162>
 Edgar E. Iglesias <edgar.iglesias@gmail.com> edgar_igl <edgar_igl@c046a42c-6fe2-441c-8c8c-71466251a162>
 Fabrice Bellard <fabrice@bellard.org> bellard <bellard@c046a42c-6fe2-441c-8c8c-71466251a162>
-James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 Jocelyn Mayer <l_indien@magic.fr> j_mayer <j_mayer@c046a42c-6fe2-441c-8c8c-71466251a162>
 Paul Brook <paul@codesourcery.com> pbrook <pbrook@c046a42c-6fe2-441c-8c8c-71466251a162>
-Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
-Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@mips.com>
-Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@imgtec.com>
-Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
-Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
-Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
 Thiemo Seufer <ths@networkno.de> ths <ths@c046a42c-6fe2-441c-8c8c-71466251a162>
 malc <av1474@comtv.ru> malc <malc@c046a42c-6fe2-441c-8c8c-71466251a162>
 
@@ -32,6 +24,15 @@ Ian McKellar <ianloic@google.com> Ian McKellar via Qemu-devel <qemu-devel@nongnu
 Julia Suvorova <jusual@mail.ru> Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>
 Justin Terry (VM) <juterry@microsoft.com> Justin Terry (VM) via Qemu-devel <qemu-devel@nongnu.org>
 
+# Next, replace old addresses by a more recent one.
+Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
+James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
+Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@mips.com>
+Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@imgtec.com>
+Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
+Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
+Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
+Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
 
 # Also list preferred name forms where people have changed their
 # git author config, or had utf8/latin1 encoding issues.
-- 
2.20.1


