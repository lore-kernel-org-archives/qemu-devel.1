Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE26C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:12:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3BB21841
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w8fUhqA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3BB21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfMU-0002au-Po
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfE0-0003Df-DS
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:00 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:37823)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDp-0008UK-0A
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:59 -0400
Received: by mail-qt1-x841.google.com with SMTP id d27so2765730qtg.4
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9s3zaT975n7OFyLauiO739G/mW0fqcwhecj+9+iav3g=;
 b=w8fUhqA+iRJtmFSwrzoP1e2deJUjj6dpEpCzDxImxM7DOAErFKp9C4t4h7+MJD7ZXg
 /1nZx1qIC7Xnsev0Hd5GBo4j3Sp9h87u+6NgEnVxvkmRGc6Js30MhaGBJgHCmzHW3Ww9
 JDs6miaZR/7uJYi+xPZb2XSODrRIAF1vHF9INTBsiT14DkoAhEmb1LzK/+OW52WjNhub
 qu8y9sPgHf/ijlQFPZ5GJ3D6I49IQ5V6Drku+Lgwt0+qwzrjrqQmHdwg29SePL+bH9Cq
 TOweATc9wxeX50YvwnyXF4CjT3ldL32OXqve0W22LSw7Bvrz4kPDEELvQrUCQWmmj9Cs
 avdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9s3zaT975n7OFyLauiO739G/mW0fqcwhecj+9+iav3g=;
 b=OJi9y6iLXsdaEXJcFlVXwscO/9yEWTX/O6ckGMpMgWxV4atqUz7Ieq2ZKTKroTdHXD
 8wf2g4NOD52sa3+66kBJ/6GKdGb1NZ0VKmV3yjuk1PuBm5I+WRZ2Fb8MHh3g+F3G9D5a
 7RDOBXTy+cXwQfZj1f4lxRDYKhHtzKmNlMVS78nnc2mxZ+zZ+/OuxHlzQR/1rLwClMWr
 7mtSWxgOHxClbLkvhZjDDQsYvAj8nZ438fh30ltyyr4WEFc5jRtLG0TOflptQOT4jW8T
 Oh0eZPf1YhA88XhsnNFk99eoS5I52SG85Enqw0OE31jbqHKC9zxUDG05owr0400UDhlt
 /zrw==
X-Gm-Message-State: AOAM532uZ1EGYrStnC1EmoghDVwwz2ay9jGBDoPQKqQ6YjTCAAGk6OrL
 Z+u5mPiOSKjHTtAGYqEjuJQ3SD2baxiHhA==
X-Google-Smtp-Source: ABdhPJxS5EieiKEJ1xUjSQd7F/SrsFWqMGv7Cg/BVsrStelJWI9uxu1Z5zAcdJGSi4eBVkWjd6QZ4A==
X-Received: by 2002:ac8:7a90:: with SMTP id x16mr1080458qtr.233.1592427827917; 
 Wed, 17 Jun 2020 14:03:47 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:47 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 22/73] m68k: convert to cpu_halted
Date: Wed, 17 Jun 2020 17:01:40 -0400
Message-Id: <20200617210231.4393-23-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::841;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x841.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/m68k/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 202498deb5..4a032a150e 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -222,7 +222,7 @@ static void cf_interrupt_all(CPUM68KState *env, int is_hw)
                 do_m68k_semihosting(env, env->dregs[0]);
                 return;
             }
-            cs->halted = 1;
+            cpu_halted_set(cs, 1);
             cs->exception_index = EXCP_HLT;
             cpu_loop_exit(cs);
             return;
-- 
2.17.1


