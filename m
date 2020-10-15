Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDADC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 04:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26E7D22247
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 04:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zq+6G8JG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E7D22247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSvGP-0007yS-VZ
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 00:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSvFP-0006iP-3B
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 00:52:15 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:36959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSvFN-0003OO-IE
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 00:52:14 -0400
Received: by mail-pj1-x1041.google.com with SMTP id hk7so1178794pjb.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 21:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k/KMHbcBe/psiXc0RgwR1e2SMDbT/ILF/e2Crf7DpqM=;
 b=zq+6G8JGRHXuQrlbN4d5anSsFlntJplRrBnJupX1xsZMQvZyjVx3tQ6m/RRhi69sGO
 dNcIqakSWvlkdAh6ibFZ9hvXdUBPexBqFTMcgnmvhIA7LdXY2EB5OZ8lUbQ9CQ6ZImQO
 pkTDopYxVGyecVDHlT8Bb3x3YbW3e2YaS1fCfv1wWGcelL9YH+xBFJ8UsXCccaPjoS8V
 Lb8TBjXK21hwa5Zoo5hdcfNsLx/93pz4R52l5RTH9hzVvMe3wXtszCWPP5UyTnuBd/hx
 60N1veKE95VFtyL4v19it0fmz9Sf3MhSEUPy5wtbP8Pl410V9TD1mqEQw59yF3DjYVtP
 5Lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k/KMHbcBe/psiXc0RgwR1e2SMDbT/ILF/e2Crf7DpqM=;
 b=dnRLPMsZOo8vuB1uOSbobXuEQcT5Us1XmNJp+hknnxcwOZVIyjNIeNoR+VtyG9lMwx
 qVG184D/b/9XpQ/a0pH1Rj9ckycNjz7GHgwsIV9KzV8lx0XMLqQVo6dyfBNPt7tyvFFj
 MmNm1fptat3DnIRLFf7LaGaRp8l6pheGnh+07DIHxztd9ZNLm3GVKg2GJOb6VzI/Qc2l
 tqPUCg08b9u1gNOiviQmVzGlbpDU1M8dIB5/o+GtO99mDQkVv0d2gVdIwJyN4gkxe7tp
 rOS5jUNGIj/u5czOhLvLD1zoIO8KiThmoAu9YTjVltXGpn0xg+/1d9sWJmClJy/aVzEo
 oS8Q==
X-Gm-Message-State: AOAM531TnX9t2G/6wB/83CY4mPCK4BZ7m+w9vFvehZi7+FQxUacdvbLX
 FNddduZJgI4tJIFCCUFbAoJKKFnjHwYATA==
X-Google-Smtp-Source: ABdhPJweGC9G+yAmjQuOOcMMj/xDyZ6dqJ5ZCSdLm6gGjx8cv8v23Z9CIq+L5BmXYyXAM0XZS7Y8XQ==
X-Received: by 2002:a17:902:7c01:b029:d5:aad0:b7b1 with SMTP id
 x1-20020a1709027c01b02900d5aad0b7b1mr2546163pll.53.1602737531626; 
 Wed, 14 Oct 2020 21:52:11 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q66sm1407493pfc.109.2020.10.14.21.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 21:52:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] tests/tcg/linux-test: Adjust getsockname for musl
Date: Wed, 14 Oct 2020 21:52:06 -0700
Message-Id: <20201015045208.595044-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201015045208.595044-1-richard.henderson@linaro.org>
References: <20201015045208.595044-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Unlike glibc, musl does not use transparent unions to hide
the different structures that overlap struct sockaddr.

Add an explicit cast to work around this.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/multiarch/linux-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux-test.c
index 8a7c15cd31..96bbad5823 100644
--- a/tests/tcg/multiarch/linux-test.c
+++ b/tests/tcg/multiarch/linux-test.c
@@ -296,7 +296,7 @@ static void test_socket(void)
     server_fd = server_socket();
     /* find out what port we got */
     socklen = sizeof(server_addr);
-    ret = getsockname(server_fd, &server_addr, &socklen);
+    ret = getsockname(server_fd, (struct sockaddr *)&server_addr, &socklen);
     chk_error(ret);
     server_port = ntohs(server_addr.sin_port);
 
-- 
2.25.1


