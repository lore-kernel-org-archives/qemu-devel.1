Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F6DC433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C672072D
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUWRuRGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C672072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEfiG-0003vj-M6
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 17:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kEfhW-0003PT-6Z; Sat, 05 Sep 2020 17:26:22 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031]:56024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kEfhU-00085l-ID; Sat, 05 Sep 2020 17:26:21 -0400
Received: by mail-pj1-x1031.google.com with SMTP id 2so4792295pjx.5;
 Sat, 05 Sep 2020 14:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EgO1cmzCxGlg+P1IOmJLS549V2SlGp5yHrf5EgcbiQg=;
 b=gUWRuRGLoDvv2hncmHcGORWRWH24VVSCU7ueGapVvuN+JZo0LkAme9aLeThnQcHirN
 DASSRkg0MlU5MNVuug/POzjtQLZ+kXmvTfjWOPD28XFwlVv067tOHyXBUekDoA2qs4o6
 7WL/ZrJmXnjsC/nLvmMAzoYIah/rn0NeDvcTaZpLOuwCdzP/NmRS8zD83vkBvFhgf6Qs
 1daiz1iiiYRWGhZlY0bhWFJOCLsi3jP4MkSp4VU6/SznB+hv8N28cibVKh+eYJU6nGv0
 w61Cym7gPJzCk9fvZoLXJMeVne/YlMC5DjIp12MEMReEsFbLsZPZ0QD4zccMhO23MMDd
 Zi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EgO1cmzCxGlg+P1IOmJLS549V2SlGp5yHrf5EgcbiQg=;
 b=j2lj39GzX0LqZTtkTdeNdCUUH/4MnOpw1NNdwwRhqQ/Fb+cwQjmhNt51abXXR5XRo2
 EK/exqNOTnV11tIanJzNOAQW+4PzjmFnXjEuqkepZMYA6CKHyqHp3+amgaa4ATwIJTch
 8UuMrT4Zh5hXzmhWGjN7SVksAYG44/v8sIWLT9XeN8J+gOj6+ojCwPT/KEBFl9PMAtDZ
 c9D8nSE08/XTpCDmXsfCMHrfEEgN61/AyBvTlG/IYPGLlvVfFGibw64WUgbn4X3Gt0UR
 yP2jrJq2KvEtP9DzOMi2ZIXghLSlcH5N2afh0EnjQstkjTKi356btak/b/XbEG8hLsBU
 LrKg==
X-Gm-Message-State: AOAM531QbaM24hfzq+kW5adeLbF3q1J9ytGqAH6qcVquEu8VYX+R+gw9
 4pFo32rau+BYR3CeQHfjDXMwOys2Hny4z4/f
X-Google-Smtp-Source: ABdhPJywLAeoHVIjIlevgUvUnZVVU0saQquUW+JabCVEzFJZ7vLKD9h1oXz6DnIcuPPWoSe1y2OIhg==
X-Received: by 2002:a17:902:c3d3:: with SMTP id
 j19mr13884746plj.59.1599341178226; 
 Sat, 05 Sep 2020 14:26:18 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id x19sm10035898pfm.28.2020.09.05.14.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2020 14:26:17 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: Fixes qapi tests.
Date: Sun,  6 Sep 2020 05:26:03 +0800
Message-Id: <20200905212603.761-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1031.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use -b to ignore-space-change

The error are:
+@end table
+
+@end deftypefn
+
make: *** [Makefile.mtest:63: check-qapi-schema] Error 1

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
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


