Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E999C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:25:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF5120810
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GyJ/jnNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF5120810
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfYg-00066y-1P
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfED-0003SI-EW
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:13 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:41175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEB-00005t-8F
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:13 -0400
Received: by mail-qt1-x844.google.com with SMTP id w90so2749980qtd.8
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UAoGpC+tFU+Lrmci3F+3S0Zh/4YRyJd+sLsoLGG3MBc=;
 b=GyJ/jnNzWFStVefIGozuSYyimRxYRgtyThR8wWWfcLxMxTgodWUbTNsJm7+K6Gk/jt
 Swkd65jaLs9BIyGmf19466GvogyyztH+CozDC/Yte5nSHy0Nc48vCEFBTBESqoVBh1Yz
 VJrfQqCdgSOOiIX/wIuXEmdALEyCro5PgiGD1bfanKbIg7upgrfvHzwxb3cVt/+SXiQq
 DsRayPIPVCe8tJ6bsHuL4oTi2q60Bvn6YaJvRU/ejBME1KoGFLKpVYxcMX3Jxv2x2D3Z
 Zommg/zn4c9xSlxqActFrbyX0CF40LU5I6RTnHXCzm6E28z8wfAzlP0lomBbZxgeuq/G
 yX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UAoGpC+tFU+Lrmci3F+3S0Zh/4YRyJd+sLsoLGG3MBc=;
 b=LI4pNEsDl2mFDVd1ZzF6vYEa/g7m1lBF5vShVPac1S60UEoaslVz3oO1ydEjfvNoaV
 Zb4PhdSYbAjoqJradlrWb8vA+vFrUj2detdwODifSxOa2bcAYndFi0BsAWuvu+idZ+Ek
 xpN4jT5ICfT1xcpgvAEjDvFs/86GIHiuXjLFj/bO7UHZ502gmmWqZrDuFLwLE2oH7g9R
 344AgJ2luTuBTolO/RIVTjyfvqSEXGd2MiTn1Yd5e4D0lE5vmTR7PDFwdZamOB5YP15O
 Qn5dJM5fD4v2xavUixucsUJDjJDoFj4zVvjMeyWSuF3RSj+sUdiIEzG4M9QN/4mAvlXn
 ZVIg==
X-Gm-Message-State: AOAM5300Pj+7jxhWfjwRPFXMb4zl6jToFcdtkBNpLp2HjRtbQfmjdGzn
 pUBlV6h267prwyEEDdkveMhSAiTYcsmjjw==
X-Google-Smtp-Source: ABdhPJzwqD3fbpvBkGjredjWWtP1MVsaFqx1+8dr68eOHTjcOCHfO4/UbmyDCveBrHzUw3sou+F/gw==
X-Received: by 2002:ac8:6edb:: with SMTP id f27mr1039501qtv.325.1592427850072; 
 Wed, 17 Jun 2020 14:04:10 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:09 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 37/73] openrisc: use cpu_reset_interrupt
Date: Wed, 17 Jun 2020 17:01:55 -0400
Message-Id: <20200617210231.4393-38-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x844.google.com
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
Cc: robert.foley@linaro.org, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 Stafford Horne <shorne@gmail.com>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Cc: Stafford Horne <shorne@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/openrisc/sys_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 2615571ce7..e54c148d4f 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -167,7 +167,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
                 env->ttmr = (rb & ~TTMR_IP) | ip;
             } else {    /* Clear IP bit.  */
                 env->ttmr = rb & ~TTMR_IP;
-                cs->interrupt_request &= ~CPU_INTERRUPT_TIMER;
+                cpu_reset_interrupt(cs, CPU_INTERRUPT_TIMER);
             }
 
             cpu_openrisc_timer_update(cpu);
-- 
2.17.1


