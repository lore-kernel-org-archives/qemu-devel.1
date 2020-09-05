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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D296C43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B800520797
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuONuXGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B800520797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kERlv-0002Na-Nj
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 02:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kERca-0007DR-D0; Sat, 05 Sep 2020 02:24:20 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:36673)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kERcY-0003YR-4Y; Sat, 05 Sep 2020 02:24:19 -0400
Received: by mail-pf1-x42e.google.com with SMTP id m8so5790838pfh.3;
 Fri, 04 Sep 2020 23:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Bq1eYS85B3lVfUWOPYt+//P+vJhXogDV3XY3bX1W5SI=;
 b=HuONuXGpUAzuMPwrSAueD74wQQy5qHeVO/lPP+88LwzK0pVBVSxlVz8RMRJSc9nb+h
 PG2Ud3cB+oNtjoFNjIruwZU0ZkMHdwS0a1wBbQ2IZk9zVM0+crRwtVaXdTKyj6m8Hzux
 EwuQcaxhVadS8KUje58zphiKjUuhQAgzJtFNS099nwh2upG7cf878jxTdwkD8/9L5I/r
 MC0zFLWvBpUvtyEKX4te5C7/Z322iK7oOdldVWKgWfGKdyUexLU5ycGK67jSQNax45u3
 pBqIbdjeuzkGakV/Smqj/bxY1sVasJROE4x8XnZnpy6k0l7MmbFySlHwtSSuIRXP1iV9
 Lrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Bq1eYS85B3lVfUWOPYt+//P+vJhXogDV3XY3bX1W5SI=;
 b=EB2Pu1YAKI/fgQRLAqaPYP74f+EJlzKAsrFUMXNV1I4qUHCtHj8ihkHY43P+E5XmIG
 mYYmZyX1A4VhNF3SBcWAdwJ30P1sVpU3exDdM+hxtBNvT+sTFGLTwA3YtG9syNC6vbC8
 tUHyi5MU1OxrHEdLfU2PR+Q1CX8JOJA/hmwrFSowrs/VVAbCDxS11f46UNbwnDvXrP9P
 2mljAJRFjEv4DhgQ66WyrZKQPFIFdQZtbXgba7wMybUhUFRlKZZVW0oZDxPFKDN4NodK
 jj6MeLdB+nJJY0Ncg0aDha6qwLx1piIPfA20aNtKuNCnGxyGCyEthXqi57jTLXqXr4zP
 irSQ==
X-Gm-Message-State: AOAM530WeCTk5dm4KUsLCxqVlOl73Bjm/Qq2EibS4HYVQMeXxvMaiZb+
 fmbe16io/ki7go3V6JAHkkFMdvjXBLlpTL27
X-Google-Smtp-Source: ABdhPJykUqv8G5QXcVj/KLG8WPZwAhiVCO95ZimWMbyZkZ7AGnUVrNLBJyiUIAkaP21CGZ0rFnMrIA==
X-Received: by 2002:a63:4c:: with SMTP id 73mr10121113pga.286.1599287055936;
 Fri, 04 Sep 2020 23:24:15 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id v8sm21436381pju.1.2020.09.04.23.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 23:24:15 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 09/11] meson: Fixes qapi tests.
Date: Sat,  5 Sep 2020 14:23:31 +0800
Message-Id: <20200905062333.1087-10-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200905062333.1087-1-luoyonggang@gmail.com>
References: <20200905062333.1087-1-luoyonggang@gmail.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The error are:
+@end table
+
+@end deftypefn
+
make: *** [Makefile.mtest:63: check-qapi-schema] Error 1

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/qapi-schema/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index c87d141417..67ba0a5ebd 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -220,6 +220,7 @@ qapi_doc = custom_target('QAPI doc',
 
 # "full_path()" needed here to work around
 # https://github.com/mesonbuild/meson/issues/7585
-test('QAPI doc', diff, args: ['-u', files('doc-good.texi'), qapi_doc[0].full_path()],
+test('QAPI doc', diff, args: ['--strip-trailing-cr',
+                              '-u', files('doc-good.texi'), qapi_doc[0].full_path()],
      depends: qapi_doc,
      suite: ['qapi-schema', 'qapi-doc'])
-- 
2.28.0.windows.1


