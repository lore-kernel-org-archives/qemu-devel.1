Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B24C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55BE620936
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ublds1wZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55BE620936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIAJQ-0004xf-BH
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9qv-0000zU-No; Tue, 15 Sep 2020 08:14:29 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:44209)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9qs-0008DD-Ev; Tue, 15 Sep 2020 08:14:29 -0400
Received: by mail-pf1-x429.google.com with SMTP id o20so1800659pfp.11;
 Tue, 15 Sep 2020 05:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/tGNcDT+soty377wKryHTaQKgDiEnZiZY12oC2sg7jk=;
 b=Ublds1wZL7FnLdSB0HV8YmB+djhFL+5FNY5UWiZGG7Id6B8IRr7VmO9te+cDnXR7ML
 MtVfEWrRoW2aAr9kQDVxbVNBvFq0WZ1O3Ex3SVbmvzzJf2GVy/BfjCx/rS3QwHAQOKVE
 sGH64MXVhnk+F1EkyfQLqVEoLqN40oj0yjdu+vUC+q91FQCcCCk3V+6b0yz2xGHVt+P+
 S+ZLclwHVXejV2c+SlE/ZwYrGpGujbaIVly6/JSLPrfWkH82eD2ZVaEL0EdYNPNApsJz
 zNPDlcb4lzmZVZH0GqgiVNLN0kn+2G3BRgOInKjT2MWccKjYMs8/JpXMcrRZz7BnFDiq
 Zq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/tGNcDT+soty377wKryHTaQKgDiEnZiZY12oC2sg7jk=;
 b=MVoMrFSuHRCvOTozAQXfQ/MTrne0YdICqRwDQ7GJS+gxtah2LkT51/s4STUgs4we6C
 9j1eph5EvMDcyHsSsIKHF82n2bL3zy7AwhpuKGjXmIkfoV76qlX2O45sOT0yHFaraS0W
 ui381ccd0Ex4+W+fuf+I9/HFBr3PSTgRi/nCdLHFRzZGC4ubywk5/AzN70i/EMH7ysz5
 sFMTlJaUGtY+iCEPPBJ4ZEkAQVfEcPf0n19x3C4cZTrquX+aL8c7kqeHY1djeDYOh4Fk
 4f/LSf6wSAjeOdTHcsM23+/MWe9kxnzrew2QSGBZ2vBJa+Q68Fy09FTewxaqbcbCmkBF
 LsGA==
X-Gm-Message-State: AOAM5315oXG2B2QkyhOrFJI3IMAFGas8MhpgNwHB9uYMTrSTGc7P1Js1
 9TdPdfOQSO+dSeYhLd/i+m8b1iPanI93tkyUs+w=
X-Google-Smtp-Source: ABdhPJyIR68ALKdgN/MzGwe3TRAKxwg2b36GkFje7CpkacDYwOJLOCBnh98ByxA5qe2t7+eP95bZ3w==
X-Received: by 2002:a62:1557:0:b029:13e:d13d:a060 with SMTP id
 84-20020a6215570000b029013ed13da060mr17699900pfv.38.1600172063327; 
 Tue, 15 Sep 2020 05:14:23 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 k28sm13683061pfh.196.2020.09.15.05.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 05:14:22 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 10/26] meson: Use -b to ignore CR vs. CR-LF issues on
 Windows
Date: Tue, 15 Sep 2020 20:13:02 +0800
Message-Id: <20200915121318.247-11-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915121318.247-1-luoyonggang@gmail.com>
References: <20200915121318.247-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x429.google.com
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
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ideally we would use the '--strip-trailing-cr' option, but not
being POSIX is a portability problem (i.e. BSDs and Solaris
based OSes). Instead use the '-b' option which, although doing
slightly more, produce the expected result on Windows."

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qapi-schema/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index c87d141417..f1449298b0 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -220,6 +220,6 @@ qapi_doc = custom_target('QAPI doc',
 
 # "full_path()" needed here to work around
 # https://github.com/mesonbuild/meson/issues/7585
-test('QAPI doc', diff, args: ['-u', files('doc-good.texi'), qapi_doc[0].full_path()],
+test('QAPI doc', diff, args: ['-b', '-u', files('doc-good.texi'), qapi_doc[0].full_path()],
      depends: qapi_doc,
      suite: ['qapi-schema', 'qapi-doc'])
-- 
2.28.0.windows.1


