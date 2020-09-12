Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF42BC43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 22:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F47320731
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 22:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4uq7D28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F47320731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHEUO-0004OI-Bw
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 18:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHEI5-0004m7-Ho; Sat, 12 Sep 2020 18:46:41 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:51524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHEI3-0004ZX-Oe; Sat, 12 Sep 2020 18:46:41 -0400
Received: by mail-pj1-x1042.google.com with SMTP id a9so3490473pjg.1;
 Sat, 12 Sep 2020 15:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+2fNL50dgeI28TebAqSoSX6cTtGwDHyqvFUmnw67Jgc=;
 b=E4uq7D28dfTOX5/gvHL+hq791U10duAWVygqmFHbJXP1kyAJfU/A4JM6A7Yihs51AR
 YM3hNEckgZdINT9+aga1dZdQUiVdGBnJc3ZAdVhmmHhQCm2ihqIJp7kcQKXtX2R5I0Yl
 HfMVnkZvxTbPlKNU1Xkh4/JmU/I8tgJ2sJHs7TjZ8CcGB7giYAVCTl/+O9j7cEl4k4Im
 6ZlsxNtGHW0gKNFcHIBSdqz0LmGTYf1NSddFC/QlzTGoC9p9wF15uVhOoHcpwgrGzAdZ
 ZYg+sG3yz9hRwgkULfCyiSQDHb5faRkBOJzfnLfcjyx1sFeXcMSAUwnHTjAwgHKW1dm8
 SoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+2fNL50dgeI28TebAqSoSX6cTtGwDHyqvFUmnw67Jgc=;
 b=WW6eAlSZ7q6/4p+GxMdhL6yMi2uhL3g6GX7Krv5fdNigLP0PRYdPOxNI7GEDfAFCT/
 ubbjWGflvGGvVOSx4AzAIoO/Od9JWvB2jK9Qj8GJZCjllnHbzN0iKj1iANNRS2UnTeUT
 /HHFPvCHPOuO/pmnH6Ml3MqZf/ILhxrRTGhmctDAcm7K51HIw0tIvs+Zg+r7MnRkP/vU
 j9MIcoWmqYtwm2+2P1nGt07AHIhQlMVojC2ClmKeOWilP+VgDLeYRq/Uto2Pr5OLUjXs
 StVScD4zrTMoqifagqRGIniPJJRU/zf7If4bQymAM5wdLxxe2PAevlviEXsT3tZ8AB3M
 Q2Vw==
X-Gm-Message-State: AOAM531y+rV45MEh8/PL797LiTKkB/QUKgXPEihwf3UsMKK7kBMuLXc7
 M6GRygYQKmg7Kj9iGe26DkFbOGF6MR9tdzJDfL0=
X-Google-Smtp-Source: ABdhPJx/H3P0sfr6YkPmfOlNTAviWmJZNXbpsI9XVn3MO0NpccJVaeSJCxzfaP8TCxZ91gc7uXTHvg==
X-Received: by 2002:a17:90a:fb52:: with SMTP id
 iq18mr7753111pjb.207.1599950797727; 
 Sat, 12 Sep 2020 15:46:37 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id t10sm4639266pgp.15.2020.09.12.15.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 15:46:37 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 25/27] meson: upgrade meson for execute custom ninjatool
 under msys2 properly
Date: Sun, 13 Sep 2020 06:44:29 +0800
Message-Id: <20200912224431.1428-26-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200912224431.1428-1-luoyonggang@gmail.com>
References: <20200912224431.1428-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1042.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Bump versions to 0.55.2 for release

* Tag Info:
object 008d13038f95e7c7d8ad553f14e408da5b94c360
type commit
tag 0.55.2
tagger Jussi Pakkanen <jpakkane@gmail.com> 2020/9/11 1:24:47

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson b/meson
index 68ed748f84..008d13038f 160000
--- a/meson
+++ b/meson
@@ -1 +1 @@
-Subproject commit 68ed748f84f14c2d4e62dcbd123816e5898eb04c
+Subproject commit 008d13038f95e7c7d8ad553f14e408da5b94c360
-- 
2.28.0.windows.1


