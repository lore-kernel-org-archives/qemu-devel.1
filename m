Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311E9C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:14:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B678920796
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eku+8e4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B678920796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP8Wy-0006fO-SC
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 14:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8Nn-0002gI-FS
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:16 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36915)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8Nl-0008LU-Vp
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:15 -0400
Received: by mail-wr1-x441.google.com with SMTP id h7so3465206wre.4
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 11:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lPkditD6hs2q2H3smeJcXzWyzKVAfF5M4jBe898tJg4=;
 b=Eku+8e4tq0+nytpbDBDQ9b7yEh3gkPpTDc+vr6kUqSrDv5xkapo5ayQauZfRUqXvPC
 hu4LN9+RbEU/C17k16rR36LdKyDEIEyl0OePTikLDx4M5m3E4g0NPfVQFO8rQkubh06+
 B19bLxuhY19VG5MXbtuBrbsgkTEFumGrHcqliODUm5s7N3C8WVEmK5MVHVrV/ifXmSEL
 Xk4heAMLo1idzfO3ZGLHTLaw81w76ShAUC9qn6rOZKld3AvkBvcdcmll1qs57Blbmmss
 T3/e3NVwc4BuotQyEvprOA/6rMg7Qp3DZJ8KDKGrcWrWGv1exs6E7TSL90D44BIm38Mo
 SiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=lPkditD6hs2q2H3smeJcXzWyzKVAfF5M4jBe898tJg4=;
 b=Sqb4t1rMubXSLI6BkjFp2T+fobk7z90H51EyYft9AY1VDAA04b5tCnDs+HKEIDHIjH
 XQjuDFhBFlh1dzRmXGl0H7FRlWI7/Frf9FLEmqByVbQVqhxpSPJr67ZA9jKxAxzXc/q0
 VAolV2G+WT0EHARFAYJHJ0tfmdIkliRe9Ja1ife29QM043c1xThYHOS1XmtzKgWTlZiq
 19WHAwKhuByJRJznPOowVCWLEKiBgtbM4jCzGRrkGBflza4W6Jtfv8CBKqOwqKxjy8AJ
 fvfigVGmLYtV1JFyAriQ/B/jE+QxlzmHUoSmu6MoAsfC6BzTqMac7hPXRQ8oGeuO919x
 h5RQ==
X-Gm-Message-State: AOAM5305FPbmwrHPZ7wqMJMri/i4yUQlW+y42RpNvacBievNvhQ3G6OY
 Ixohb+zjTBiAhbHbOQSFQS2qJO+1yoyjbg==
X-Google-Smtp-Source: ABdhPJwdU4t1sWKY+IxJG/tbXeWFwBimgWQu2Wj1l+Y4OBwyr2IoltFf4wFBnoyFwqMJ8hyrw/dspg==
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr6913430wrp.179.1601834712588; 
 Sun, 04 Oct 2020 11:05:12 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j10sm9593202wrn.2.2020.10.04.11.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 11:05:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 19/21] contrib/gitdm: Add Yadro to the domain map
Date: Sun,  4 Oct 2020 20:04:41 +0200
Message-Id: <20201004180443.2035359-20-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004180443.2035359-1-f4bug@amsat.org>
References: <20201004180443.2035359-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Igor Kononenko <i.kononenko@yadro.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a number of contributions from this domain,
add its own entry to the gitdm domain map.

Cc: Igor Kononenko <i.kononenko@yadro.com>
Cc: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
One Reviewed-by/Ack-by from someone from this domain
should be sufficient to get this patch merged.
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 6b3a2c3b4e..7170ddea7a 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -41,3 +41,4 @@ wavecomp.com    Wavecomp
 wdc.com         Western Digital
 windriver.com   Wind River
 xilinx.com      Xilinx
+yadro.com       YADRO
-- 
2.26.2


