Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EFCC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC4B2220D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSPFSrA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC4B2220D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFcw6-00084i-5b
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 08:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kFcvS-0007Jv-CI
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:40:42 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631]:44719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kFcvQ-0000vH-Ux
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:40:42 -0400
Received: by mail-ej1-x631.google.com with SMTP id r7so8929028ejs.11
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 05:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=SZgrhu9aERib1Vmq6MMAjKBnZrWMmX7ACgfRSB9sMAQ=;
 b=jSPFSrA5ZJtdewchy75Ne7m1rnLBRs6RMJUePTNxlq4Nmk6njHwczvrQkdlCL1C+ur
 1yfehV1l9cBJlLzvht+e6lA3dwVIPP4OCifpBTBQ8HkgDqsR/ICbSMR5xhotVbh+3NpH
 fMrGTduDIxIFKMq0z8afhp41NGAczyu2y6W9Ld19XywyOfsDvt3UMKO6AiK+SOF6sTmh
 MB0FYjw3o3XKLjBVvDY0TFWDCEiDhvfqdrwTiu4Fhgyc3b9TRl1v27uTWWI2Rh0zvclF
 QL1MBlYWIgCUnqRIi5LzOjsFz/MZ9hAgH+aJYEOgooNZouCI5wHpyI6/AevePQh8YFnd
 mR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=SZgrhu9aERib1Vmq6MMAjKBnZrWMmX7ACgfRSB9sMAQ=;
 b=Hy+mwweijPxvXmloLd9cdq0JO+XVslbUjVIqnS/sxvtlsMTWtkOsIouoxrAq1eb+wK
 32JEJ9i/B9xeIfYtePe5ghU/NCrAfspgHDihM4ntrf1x7B04yPyb27r1oG325gK4Y8wX
 UojCmwSMfRsmE+3YEaTqcJXFa/1iL2KgtA+/6VisXK9zDx8evKS15pLRztiFLEZv1/Tp
 8R739wGlFdmgSPvHbREPVC2ktaH+yNn/xfoRjzbhEzCI8ffQcpxa3dLXeJQwz4szF4O3
 lM0hErwJfJBCPIfkA9AV6xDskDlGNSEbT5mM4Tys6nlCVftkv5VktDf6uV4R2UEJSYJQ
 whbw==
X-Gm-Message-State: AOAM5337TydLIIrUNtElquvF44gakMWnkRpwls4p5OtLqAzdeAok3oJb
 M90xx6nTQs73PPmDhk2o6+UwY7I528M=
X-Google-Smtp-Source: ABdhPJw3W+6+7TfXF7x3cLml/tF7T/wpFzT/6Z6HpG1SOpsUJ9ZyvP/tcP/eC2lFBWnQPA7rrVqK/A==
X-Received: by 2002:a17:906:49c6:: with SMTP id
 w6mr24960335ejv.445.1599568839202; 
 Tue, 08 Sep 2020 05:40:39 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id q26sm1612813ejr.97.2020.09.08.05.40.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Sep 2020 05:40:38 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] target/mips: Misc patches  
Date: Tue,  8 Sep 2020 14:40:09 +0200
Message-Id: <1599568813-9626-1-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ej1-x631.google.com
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A set of several, mostly FP, refactorings and improvements.

Aleksandar Markovic (4):
  target/mips: Demacro helpers for <ABS|CHS>.<D|S|PS>
  target/mips: Demacro helpers for M<ADD|SUB>F.<D|S>
  target/mips: Demacro helpers for <MAX|MAXA|MIN|MINA>.<D|S>
  target/mips: Refactor helpers for fp comparison instructions

 target/mips/fpu_helper.c | 276 +++++++++++++++++++++++++++------------
 1 file changed, 195 insertions(+), 81 deletions(-)

-- 
2.20.1


