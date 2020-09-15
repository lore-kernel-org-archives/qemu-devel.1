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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D164EC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BB1D20809
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9EE2F0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB1D20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEZ9-00024n-7Y
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEWq-0008Og-Jd; Tue, 15 Sep 2020 13:14:04 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:46099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEWe-0002he-Vl; Tue, 15 Sep 2020 13:13:57 -0400
Received: by mail-pf1-x42c.google.com with SMTP id b124so2287957pfg.13;
 Tue, 15 Sep 2020 10:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rY6yNgCy25oDmt+nU7EZEt8FaOeANESnxbsMxWp5WF0=;
 b=I9EE2F0F8I9O7/i3HuRMJx+r20C8zSqL3qiMbhqP6oSav96x4Z89VvUvTR5M2f9eu2
 m1Vjad7WWDkjLFhs+4XF/3ZzrckQnQBYNUBto8zbp6ESMLDGraTWx6f3IiOBbPsbpkWI
 +d/6Zw2gaZ1V/Tb5dIxMzFfp9GyKukEhWLklHKh4twQgO/HHtUdlEd8dhs2xiAhT+BHp
 2fGXLpGDuTz2vdmXPqdXyxPL/qQ3DrCGhlWiAexvr7DqrXBY29axUD7ujFujcldp/qTj
 AFI6eAf3AdM4pymyi6L1RxjmrlIRmvK3C/W1ocXFy2feSx58kr/NsrVCD9oN5uXWMFgC
 BRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rY6yNgCy25oDmt+nU7EZEt8FaOeANESnxbsMxWp5WF0=;
 b=tUsLc7Oejge8Z4UTOOdmgF83mPVXwd57tmhl5vVJB0BI7tCBPi7bHQFNd6BZj2G4b6
 5KJShbHbBavTnE+6YNTyicwyk32p3KEl1VQLz2FWEk4KoXsffOGArt89N9P5ay2RIJ/W
 /ZO5Ihk5Eu//NCbTlmbli452Vka+ecpEusxUtDlKAvZaBXM1chD2sAb8U4iidqvsoqzu
 926nXYXXPPaDYsmT5R0N7cfTn/aE6+3OVP3Mux64rdAKHmXSAG+lqqdL9c26TBeqKkDr
 mZFSPLm/g2s29rkrHxI6mdxttDvaEaYLp+bCNYpUtZhkik+l6ErSPTPstqKz0ZcdffW7
 JwDw==
X-Gm-Message-State: AOAM5310Y9lZjOCSOZEn19BT3O6hbDqC8ACtUeU0aLZCFcUJKqrKEv/8
 RUsImmiR6MSm0m1PXn+ewt4hZ+H4BMhiv0edYps=
X-Google-Smtp-Source: ABdhPJzEtNRduQmGwI4ajbu/PGg6XRFf39ze0bYHCtD2ZDXy++mzgxZMu7FZ2fxaGbdSTBKZVGNfQg==
X-Received: by 2002:a63:500e:: with SMTP id e14mr15326207pgb.36.1600190031007; 
 Tue, 15 Sep 2020 10:13:51 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id j14sm124046pjz.21.2020.09.15.10.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 10:13:50 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 13/26] meson: remove empty else and duplicated gio deps
Date: Wed, 16 Sep 2020 01:12:21 +0800
Message-Id: <20200915171234.236-14-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915171234.236-1-luoyonggang@gmail.com>
References: <20200915171234.236-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x42c.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/meson.build b/meson.build
index 690723b470..23cb1b8742 100644
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


