Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0AFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:51:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BF802075A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEoeqtyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF802075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2sfD-0001sj-7k
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 04:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k2sct-0006pK-92
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 04:48:51 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:38162)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k2scr-0003TB-Rl
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 04:48:50 -0400
Received: by mail-ej1-x644.google.com with SMTP id d6so27692211ejr.5
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 01:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sku2pwwgHMkauoaWIDKj1GJaqPJmjUYS3kuL4Q6PSe8=;
 b=TEoeqtyTLN3NfOk8jgcAjg14KWw0JKhniYvkB+A8Xyp66b3ooNF5F+57/IECSbjtFn
 SsP2sR3LoL3R7MIzBtOJ0KsEfo00+00rdHXLy+DcFmExLY2ZixA+xdV2mqw6lX0kkNQY
 Vu6gWM0Vs9feGtKDS+3ufxtf6uZynMTJ1HM/3zRS+k69CSTqBP0hZEFUpuPd6S40EA1N
 LIWEBfM5u0Ac4D77rYTEsZcKQsRhQNrK3+vru7QkliewWEN4z9FCPuQulRaF3eu2TxW9
 o/V1T5Tr9AGlJLxaqd3RaKr5xWGodsOj9UV30y2PxaFiHOZZVvHfG1EBHoMZPrar7ls5
 t8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sku2pwwgHMkauoaWIDKj1GJaqPJmjUYS3kuL4Q6PSe8=;
 b=MIaki16CUUNGFMTmEKDtVeyv0OiNVClTO7LKjztRwH5mswEXyICKLvnXSwu4b9VcEm
 JUmph1FRdZrWO0DrWv/6XBtoczhOK4S8QE3BHSYh/W0fup2ESfwZC92QjoVXT30/DUSp
 /baJ8S3G1hUuogJrw6+Y/8PrLrX/qPXtDkUYCYYm5KHvaBos4lsWuRnrGQmc+vpTwsVo
 eEIQBuNFKNSNyR39nmHcDk9vc9FpCsh+Hlm8kMMY9YDiW+cCuC6CzddFFHraQBKTQ31A
 RBCsvUFuohEs7MVDvkpKaQl2tSRotXNnN5GDo0C2sVFIKVOQSJT0zIJFoB983r4d7Gk5
 IUjg==
X-Gm-Message-State: AOAM532Gjow+9TeKDA0mKOoYk8XDWyXS6X1U1sDeQmFq1yx2gD9ApC1Y
 ylUVDJmHJ3/ClErV1dp5+O6tVA3j
X-Google-Smtp-Source: ABdhPJwUSpCP+iMy+mkwi+NG61xUH3r+A4ALp3LNJJ/SbFmm6gNcTxJkDeMhkXWpnD39fo1Vo9ILzw==
X-Received: by 2002:a17:906:454f:: with SMTP id
 s15mr10122964ejq.130.1596530928116; 
 Tue, 04 Aug 2020 01:48:48 -0700 (PDT)
Received: from x1w.redhat.com (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id q11sm1299641edn.12.2020.08.04.01.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 01:48:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 2/3] MAINTAINERS: Add entry for GitHub 'Actions' config
 files
Date: Tue,  4 Aug 2020 10:48:42 +0200
Message-Id: <20200804084843.31075-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200804084843.31075-1-f4bug@amsat.org>
References: <20200804084843.31075-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add an entry for the GitHub 'Actions' configuration files
used to build the WHPX Windows installer.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0886eb3d2b..075728421d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3068,6 +3068,12 @@ R: Wainer dos Santos Moschetta <wainersm@redhat.com>
 S: Maintained
 F: .gitlab-ci.yml
 
+GitHub Actions (build Windows installer)
+M: Stefan Weil <sw@weilnetz.de>
+M: Sunil Muthuswamy <sunilmut@microsoft.com>
+S: Maintained
+F: .github/workflows/
+
 Guest Test Compilation Support
 M: Alex Bennée <alex.bennee@linaro.org>
 R: Philippe Mathieu-Daudé <f4bug@amsat.org>
-- 
2.21.3


