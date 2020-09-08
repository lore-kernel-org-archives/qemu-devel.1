Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B03C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B2C220768
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+p85ef8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2C220768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFjh7-0008UE-6f
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 15:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFjcQ-0006bV-OE; Tue, 08 Sep 2020 15:49:30 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:42794)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFjcP-0002Y0-40; Tue, 08 Sep 2020 15:49:30 -0400
Received: by mail-pf1-x42e.google.com with SMTP id d6so27356pfn.9;
 Tue, 08 Sep 2020 12:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=30KkRCFEtXNka1aga0YHq3EqESHJABavOs610tDas18=;
 b=q+p85ef8a3EKzgpllK8bF6DDmoTMT3WWdcPtbx5xDANt1wZ4ydgna8jRjINQtGKxtN
 RALOjee9svUEpcKlEvwoprqPAxrLvfIN+ptIHCj6UEmGZJ4rPlovYLN8JEIjDfWcdGiV
 mLnvKcjy9Gn7pY9en7fBvDh1pwEXXrvE+TI/07JFugE3DXHd/pPZc4vWwAtPclGbzLjZ
 D2+KJym71ZA+Z5nV+gmPFwhJN9mx7ytJt+otdq4REVYAaKycHsFSkqAmSImE56r+Pgw4
 c3gcwaNPSlV2sFOqv0z0re2SjgQ/8P243QkjH30i/Xk9EhmhQcT/l00yXAxOUXKPMtS6
 TTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=30KkRCFEtXNka1aga0YHq3EqESHJABavOs610tDas18=;
 b=cvic1TnsDIOuudt5JOgAA0rVsbeuNPcuo8ld1TzkAG0xAra+0vATqPGkx1CNhf5Cf0
 iAXxtBHL/J+R1LzLT8WPxHexFnYRBH3zexK+f3I7/Ki2MqHGsH+17UQvaBjJAHFGa0Yu
 Q5x72B3JN0NoeygYnIDnXq7+J/0Hhqs/BhaYQz00hkukq2wuDkcZF6epDE0V5oe3WoU8
 PkOK0O1I9irTuuo//9pVZ4SxLVaiRhCUnRqP69DekgdxhvJ0LG//UvEodZVeeUW7Gx9i
 +n5RCNtLCa2/lRQhMsx+EnWXeqbdl6dtwNNCtpDfM4y/e6AWTd+vxD137qRX0FkAHUX0
 4aLA==
X-Gm-Message-State: AOAM532oYLvg6DZiAfGOqPjfUKiDePj/5J10nHxLB8U8S5/bMvtN5ueh
 swdTNnMwAkEtRCQR4FL57YWmd/j8zF0nhBjT
X-Google-Smtp-Source: ABdhPJykW8UuNSMZAZRXw7m1Asu0y7vFxSy05CIZz/DrPpBfErJPgb/XlGJAn3SKc2VbbCOKv1hOmg==
X-Received: by 2002:a63:5160:: with SMTP id r32mr301050pgl.112.1599594567064; 
 Tue, 08 Sep 2020 12:49:27 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id n127sm216922pfn.155.2020.09.08.12.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 12:49:26 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/16] meson: remove empty else and duplicated gio deps
Date: Wed,  9 Sep 2020 03:48:16 +0800
Message-Id: <20200908194820.702-13-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908194820.702-1-luoyonggang@gmail.com>
References: <20200908194820.702-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x42e.google.com
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
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/meson.build b/meson.build
index 5421eca66a..0b1741557d 100644
--- a/meson.build
+++ b/meson.build
@@ -317,7 +317,6 @@ opengl = not_found
 if 'CONFIG_OPENGL' in config_host
   opengl = declare_dependency(compile_args: config_host['OPENGL_CFLAGS'].split(),
                               link_args: config_host['OPENGL_LIBS'].split())
-else
 endif
 gtk = not_found
 if 'CONFIG_GTK' in config_host
@@ -344,11 +343,6 @@ if 'CONFIG_ICONV' in config_host
   iconv = declare_dependency(compile_args: config_host['ICONV_CFLAGS'].split(),
                              link_args: config_host['ICONV_LIBS'].split())
 endif
-gio = not_found
-if 'CONFIG_GIO' in config_host
-  gio = declare_dependency(compile_args: config_host['GIO_CFLAGS'].split(),
-                           link_args: config_host['GIO_LIBS'].split())
-endif
 vnc = not_found
 png = not_found
 jpeg = not_found
-- 
2.28.0.windows.1


