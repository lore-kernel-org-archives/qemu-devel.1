Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ADCC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34DEA20872
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPLfcdNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34DEA20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIARf-0005TV-AC
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9rt-0002Sy-BT; Tue, 15 Sep 2020 08:15:30 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:56027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9rm-0008N5-LR; Tue, 15 Sep 2020 08:15:28 -0400
Received: by mail-pj1-x1044.google.com with SMTP id q4so1670645pjh.5;
 Tue, 15 Sep 2020 05:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+2fNL50dgeI28TebAqSoSX6cTtGwDHyqvFUmnw67Jgc=;
 b=hPLfcdNJh2mAb1WJzhT1hAolY0afE4JC/xDRxkhejAJ707uQF/cPLW8/1Pr79T8sOx
 tqYLoC3rtqaOHUZ4UeTsataY2eSiLJdAETFmxmTMiKziLNN7zAmdrWp7zeBcLv+z0XYS
 wxj+f49My30sBK6p0YFWXZyzddNbe018csoFnJT9jRTALPabYEnZpy3olxnM2Vj5UVw1
 1A8dm8fLC0D40G64HwWIv5gDujSe5zVzQSPTHbSlZtcKXhqmFG0bmTvcoSVEdm4gKIfd
 /w/Q24Oq26fkblg2wXFWP2Ou8lPSYbgdof60OEL9wf/mI5FUDhfYDEGErFWOTqsnoOku
 ITng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+2fNL50dgeI28TebAqSoSX6cTtGwDHyqvFUmnw67Jgc=;
 b=kBTxRaXKhdgL/qYjTbt86t33Gj64pTU4ymkG0sDV6KPebu7NUHhTxFmW+lkjXSNZt2
 0VVlvKiEExi16KiQDuHDTiCVkiTEx1+07QE/aN4PXdj/XCYUbDLYYdEtb35wkT2zq63w
 9Pj9b9i4U1m9cVgLSktF5ns11Iedhz4YUA1adGl6SoaXiipitohFIWocsXAoxNuArPsF
 luwgxI0rphZUu1bgpq8bsWVIadJ/PhrUGV9BlDAHhljYFyT16JSFD+WbfA8tTxIUNak6
 bc4Pv5JG6KAYjFaY1kHmfDJrNSp+fwd5jK7BPjU0E6XmdfwQbInrZj7H+TxF8bRjHoI4
 SCcw==
X-Gm-Message-State: AOAM533gQayFEQuBQRdt4nt6QyZIwK5rrq3mjA9WlVJstl+VXGMj1887
 Qj/HWPVyjbonxGXeMI0lDROPGQwmICLqF/YkpAI=
X-Google-Smtp-Source: ABdhPJwUG0PKPwWFyT4VC2WhhJaU+ktfaYrk2uAto6ec/FOF0RrU/rwhFPo+AUfYpaj647aI2082KQ==
X-Received: by 2002:a17:902:7c90:b029:d1:e626:ef9c with SMTP id
 y16-20020a1709027c90b02900d1e626ef9cmr1081993pll.64.1600172120555; 
 Tue, 15 Sep 2020 05:15:20 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 k28sm13683061pfh.196.2020.09.15.05.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 05:15:19 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 23/26] meson: upgrade meson for execute custom ninjatool
 under msys2 properly
Date: Tue, 15 Sep 2020 20:13:15 +0800
Message-Id: <20200915121318.247-24-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915121318.247-1-luoyonggang@gmail.com>
References: <20200915121318.247-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1044.google.com
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


