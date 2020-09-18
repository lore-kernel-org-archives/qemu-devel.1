Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665DCC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:45:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990BF21973
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebbki7VR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990BF21973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJHdU-0007Ks-FW
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 10:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJHch-0006lX-1g; Fri, 18 Sep 2020 10:44:27 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:35183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJHcf-0003vo-D2; Fri, 18 Sep 2020 10:44:26 -0400
Received: by mail-pl1-x62f.google.com with SMTP id bg9so3105446plb.2;
 Fri, 18 Sep 2020 07:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RxOe7eEUW06SH+dJ3JUnUQCKxr91q5VdFDVbXqBq6zw=;
 b=ebbki7VRy0c9NgvBe1q7Y3nj71y2cm6eWIMU5JrQ19XScyTovTU9p4qadKGan0GssW
 JECB4+SE/epkt5taPqogJbGV2RmwlEgNHSzS4zVsnEDp8yz+2rF3BWBz5Ee6TKHSLmKD
 OdFWB2jFN2YKz4aB5kBZQ0roTE/d0nX5ikG82alFnd3yHlCVFRQnNfmEWIzLPSwIuqew
 kPmuvJW9dtho5unJDYktbuqepWKOwz9jjRp6JqIXS35rJHnR7khRUyzvW0d/xmszAnt2
 p0Px0j+GRH5jEFlxfDovcqlqHXjomA6CNB7ZHvTIrExUnlM26af5OrgJVebqfMkapi9h
 hFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RxOe7eEUW06SH+dJ3JUnUQCKxr91q5VdFDVbXqBq6zw=;
 b=n4BXVXDCQ/iqUBoZZwLHakDOGxwDOtzO9FfavCfRPk2gLazz8Y4aJQUtiaR7VBSSfL
 c7mRJZUsxLSHwXVre9Rxo8MO3ElU+sJ1DCg44jZB4AkEI4t4c3IqEzJV60Tnff/Z2syc
 GGgC88HwribtZCkxD3C+7Ak/gZpsJ7eBFXGp41llyF+mOKNaURBfsI9MiPoo4TeSdW+F
 x96FC1NabPi4P/nw41BJQBhGrERMjUZ65w5QyGsu8BmtWYh9YroEXZHmEy3giiyS4NV3
 mwOH99AEIcUameE1Ei9h/DpZ9P+fc4RmJE/SNPovPfiGchzqSwIxTzY//O5GeTUlAdzZ
 ggdA==
X-Gm-Message-State: AOAM530uyBZBbH2cc1Ap0zrul2D+wIprUdOzZagd+t5cHzbepp9eGEiM
 IYpQC+h/PJZkUKItm1RZ6YcEc0zr0mBrDg==
X-Google-Smtp-Source: ABdhPJxH+DVU+bmeQXWoHdiII6V+W0T4IccwTOsieVJ0u/QP1EpVo0uqGYIFdhSrNUyR0DssxULzjw==
X-Received: by 2002:a17:90b:1916:: with SMTP id
 mp22mr12521523pjb.132.1600440263025; 
 Fri, 18 Sep 2020 07:44:23 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id q15sm3097603pje.29.2020.09.18.07.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 07:44:22 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: fixes indent of $meson setup
Date: Fri, 18 Sep 2020 22:44:03 +0800
Message-Id: <20200918144403.521-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x62f.google.com
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

convert these line from tab to space

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 configure | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index 3757e48b17..6acd13a436 100755
--- a/configure
+++ b/configure
@@ -7850,10 +7850,10 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
         -Dstrip=$(if test "$strip_opt" = yes; then echo true; else echo false; fi) \
         -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
-	-Dmalloc=$malloc -Dmalloc_trim=$malloc_trim \
-	-Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
-	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
-	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f\
+        -Dmalloc=$malloc -Dmalloc_trim=$malloc_trim \
+        -Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
+        -Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
+        -Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f\
         $cross_arg \
         "$PWD" "$source_path"
 
-- 
2.28.0.windows.1


