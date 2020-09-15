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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A02C2D0E0
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:20:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78FB321974
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z06O4jcs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FB321974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEd6-0005Xt-BM
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEWq-0008Og-9r; Tue, 15 Sep 2020 13:14:04 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEWk-0002hu-5o; Tue, 15 Sep 2020 13:13:59 -0400
Received: by mail-pf1-x442.google.com with SMTP id o20so2298162pfp.11;
 Tue, 15 Sep 2020 10:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cB+r+dkpxaxYLpmfHgr9Ib2dc/r134/ZQOU509IQ9fY=;
 b=Z06O4jcs7TnjWam6CQiD+oDN+H3jK8W6P9MnTQ/On7fM/A+0qSvnApVR1Chpggtpdf
 3DsjvPOBG0HVDMTZ4oTSh/hZqEdpX4BS/B6Z/76rnjkvDroXxfOAJi721f60hcI2Fch8
 1bM6KY5BTBylQCiFjBIrzkcbDzYPu+eF2VX7iaXyQXRShF3daq+KtuKaFGvP6f7v63jl
 UoIJ6yVr/wpb09ndXnQtiTpIbHisCewzFc2R0Q1fMD9mR4V65K9JD7ChiZ+WJSDal7u9
 CEw/9+4s3mqk3A+jlS8Aw4IXb7uIoBgWRqRVlZUW60Tt0xYSFmrb1d368GKi21IuWcui
 K6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cB+r+dkpxaxYLpmfHgr9Ib2dc/r134/ZQOU509IQ9fY=;
 b=TEBuhQCBv0ryCHWijzbaodqryektbRGmeDW+7hsScBcgp9I/ghBKZVdWL+RZAEBlUr
 cVem2DCTcHZZfnUo1K7wq3HGkBIfsnCNzl0EHXC8X9YDnNsE6vkHHdX/7yYAbWwQRR97
 nCTAHpgmPv+RFn6dCu8Mzq4JrG76iA4czgjUO6CZqODffC5Zl7Hl/q9WQvgmW1Tb46WD
 rU8MKAS4vWDASxHYM3wfkw/aUxGU0XuaW3Jeq6tCralXLDZNQCe6/q1rMRqz/elt54zn
 auv3/p4yiHZ4ZR4BSddhL8TaLFXlfL03Ftme5cZZ5N98VgcXFchPIrzzuGonb2VU+5tJ
 YmHg==
X-Gm-Message-State: AOAM531ekM6OPFKrA3h6+QUHY4XOQIXA7eOqF3KbA6Rs7bQhTKhA+UBH
 HdwlukcgEs+DFaDNXfieWHWbxSIdaDbOcLLVVtY=
X-Google-Smtp-Source: ABdhPJy0tAx8M5sj0/vlD968nR/+m+ZXUUX7TAFatmRqO0sf6cAVdgj+oPyUnDcTxB2BiWIKc6aivQ==
X-Received: by 2002:a63:3441:: with SMTP id b62mr15272736pga.191.1600190035704; 
 Tue, 15 Sep 2020 10:13:55 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id j14sm124046pjz.21.2020.09.15.10.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 10:13:54 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 14/26] vmstate: Fixes test-vmstate.c on msys2/mingw
Date: Wed, 16 Sep 2020 01:12:22 +0800
Message-Id: <20200915171234.236-15-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915171234.236-1-luoyonggang@gmail.com>
References: <20200915171234.236-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x442.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The vmstate are valid on win32, just need generate tmp path properly

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/test-vmstate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index 1c763015d0..ac38bfcfe8 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -34,7 +34,6 @@
 #include "qemu/module.h"
 #include "io/channel-file.h"
 
-static char temp_file[] = "/tmp/vmst.test.XXXXXX";
 static int temp_fd;
 
 
@@ -1484,6 +1483,8 @@ static void test_tmp_struct(void)
 
 int main(int argc, char **argv)
 {
+    g_autofree char *temp_file = g_strdup_printf(
+        "%s/vmst.test.XXXXXX", g_get_tmp_dir());
     temp_fd = mkstemp(temp_file);
 
     module_call_init(MODULE_INIT_QOM);
-- 
2.28.0.windows.1


