Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C68C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:55:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ABE2207F7
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KiaWPAh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABE2207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboU0-0001kh-I4
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIO-0002ki-3w
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:48 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:42228)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIN-0006Y8-4B
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:47 -0400
Received: by mail-qt1-x841.google.com with SMTP id x12so5965725qts.9
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9s3zaT975n7OFyLauiO739G/mW0fqcwhecj+9+iav3g=;
 b=KiaWPAh38N4S3fL3nVjRC77mYVrMao+P5F0G0zi327mlEdTOHRUjDXZS7qaVSyT90N
 /iFVBezNTO1Vp8SSSzAnk4h7zTn1F4vUznS+U8swpDx1RKmdTf+sL08loxARBlOkMW3z
 j+C2EYq1+eYdh9D6JXOClchRUrWVWJHSqP/iX1Oafs9VME/DvIzBqhd5LWe9YkVlzK/V
 xVTaqdUA3QVHL6wgBOS7D42XVrZk+wMC/A8B31hWxG8c0uL2Oe0aYnTW8lxB77tUKZnU
 g3C8xKYUAB1OqBu1K7SGuayeYpTjbIq+9hu/9E1p0bsPMvVFLwAaRusmXSIuaJ8FeyqV
 0exA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9s3zaT975n7OFyLauiO739G/mW0fqcwhecj+9+iav3g=;
 b=X5iEf2lbl/AlTo7I95S+JZbgSDVEhV8nZ2DtidkbPiTX8i9tsQl8qbJ2qlRvyph2Ry
 pT40nN65xNLrGGrw3Gy7DTTIwcd1wJCE0bU56OtlWjq/+HKNpnTYPewVVJ/MFMI4++vI
 +K52jWWNjaoGIwU1TagDw9FcjSfAiHjZn/CNYMF3ADfHhRperf7CBBxVL8sWDgF0kr5z
 FnSoCsKkZDlKrMg3IvEcqO4tO8ACEA7kO6fVcF9qPibxK3dHM/OwK8gaGg/4mmp2iKCa
 8HRQ2VdUV7QxJ1ypKtY/oq2Qu8xCl6iC5r5WweIO3zLdIj99O7kp+RzL8hZROt60RTnm
 NfEg==
X-Gm-Message-State: AOAM530/6nEtesCibHInp6r/OdNkY1BpF2+nf+9tC6+wS1ahkrAXLBlu
 MFA9Tmq0+VWKAtOfhS4biXd27ql1SjnoVQ==
X-Google-Smtp-Source: ABdhPJzY587YpBTuzBXN/9VxCPFM5wS2+T2U3pwnjrFdxWK9VeQGBAXHNnVW6KkmhZtVpWiSeflnJg==
X-Received: by 2002:ac8:699a:: with SMTP id o26mr11128102qtq.92.1590079425655; 
 Thu, 21 May 2020 09:43:45 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:44 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 23/74] m68k: convert to cpu_halted
Date: Thu, 21 May 2020 12:39:20 -0400
Message-Id: <20200521164011.638-24-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: richard.henderson@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
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


