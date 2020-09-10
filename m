Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E552DC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6105020BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TubEjypg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6105020BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJzW-00055c-Hh
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJsX-0008H1-5t; Thu, 10 Sep 2020 06:32:33 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:32841)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJsV-0003Az-Dx; Thu, 10 Sep 2020 06:32:32 -0400
Received: by mail-pf1-x42a.google.com with SMTP id c196so4518884pfc.0;
 Thu, 10 Sep 2020 03:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ehfAiCRVE/Ke9S0rgpD+Y+SHCRLAE8fhmhSay0lCAzA=;
 b=TubEjypgVP1ZpTreKUhpalje4hQUsoLBJ9kkliJ+EvkOT7CX3ddV71IlOrtN/Z3I8G
 3KAued7/3Dlgt+P2ttc0kPUdD/GY/nr3xaCAT1LjYR+W8Ga4Si88K/o4YVIImfm56BzD
 W3mVWRrck/AS3x5HVP5tUv96tyJVs1aMI+B1R3hOzPXCpGLkFgUq9RdEXGupGoM7+Nev
 PSFCfpIuWLuV2W4yeF+63/TjN0HpmYmz3XfF2OXxG4ZyCQ2aNOSF/CWoooU1gIXsp+Ot
 FhAo2DhBgbemty/Ia5878LcvtT4VsvGD+7rN5KS5K+A4qVnjfM5Enrs5njEBglQXi13h
 YQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ehfAiCRVE/Ke9S0rgpD+Y+SHCRLAE8fhmhSay0lCAzA=;
 b=GdH+hhKNXDY8BCHXMxbf4UxJD9BP1fjx7XDk4w593sLe7HZPyKRx+ymREQtEe3WVtf
 KiRVgJ4VHBKppoL1wDNvIubUY+LbjC2GnIkPrE9A9FvhDGqS3re2ZoD1YYErT9RlaGv4
 ej5EamVx/fbjGZsMACkDsVGnLlNNosxP+RzEzaQpUJAbIjiG4AOv87WN027lnXLjSsXU
 1cvWyvZHi8R4Tz6wzsBW2Bb7HTum8DVY1kr0ihO5NaCwASRKQoIsPNlNxtrLJnc5p5p7
 b7XYofaC0iyrVKoid/DhGyJbDEHRotR42D07asq+AYn9JPKsgZokELwjOelUtnkfsfqV
 xJFg==
X-Gm-Message-State: AOAM532J/qL7j9lyI+GUXeHwqCEWskorHdFULNydYLxLcCsqI/+/6KH8
 ij6GIZedmnjDqqA8FrI2+TixwuF6KnZTzovAYzo=
X-Google-Smtp-Source: ABdhPJx5EnGH67dEhXSe62JaZYn0YUecOGkZxwJo0ZEZjwXYMLEBGLygOC0bPnU+9JBLVQrpB2sjBQ==
X-Received: by 2002:a63:3046:: with SMTP id w67mr3881909pgw.45.1599733949294; 
 Thu, 10 Sep 2020 03:32:29 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id g21sm2000203pfh.30.2020.09.10.03.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 03:32:28 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 12/25] meson: Use -b to ignore CR vs. CR-LF issues on
 Windows
Date: Thu, 10 Sep 2020 18:30:46 +0800
Message-Id: <20200910103059.987-13-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200910103059.987-1-luoyonggang@gmail.com>
References: <20200910103059.987-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x42a.google.com
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

On windows, a difference in line endings causes testsuite failures
complaining that every single line in files such as
'tests/qapi-schemadoc-good.texi' is wrong.  Fix it by adding -b to diff.

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


