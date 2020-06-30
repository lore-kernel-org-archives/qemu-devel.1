Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13604C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:16:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF12F20759
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+1MJilz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF12F20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqBR8-0005Il-2w
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqBOW-0001NG-65; Tue, 30 Jun 2020 04:13:32 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:38310)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqBOU-0003BF-Py; Tue, 30 Jun 2020 04:13:31 -0400
Received: by mail-ed1-x544.google.com with SMTP id n2so6285008edr.5;
 Tue, 30 Jun 2020 01:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U3siTkfLjVJQEaCMkrInYfzFvhXImBmDXKhPhC0qsnI=;
 b=m+1MJilz9DbWkTO/wHwclBjONPINORK+EgrYzLtZnj52Vd1sh1DptDFYfx8UsvacMV
 +s6mtDL833+mfqWno+VnZJksQZnxUsNrde+u2mEbxLkSwjK6bVqWp1CsbSsF+AcBvDKu
 6NYoBie51jZW8cXfLUpBXCWGYEdqnlJTa2GE4DWqocSUBjtlWRN5sYhDRF/R/4FuFZdj
 nkijdZ/DIZUouw6NdylKy4nvevJ93Ocndz8aUrGCJq1VLcXE6IpVbTNxpB7g6yoNdCCH
 67R/YlQ+tPV6iV+5IbLRc48htnGYF2hkMl/MEy6KknQdoNeQGLP5FKpvJEZCQyhp6Jcz
 5iEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=U3siTkfLjVJQEaCMkrInYfzFvhXImBmDXKhPhC0qsnI=;
 b=NXt7qnd5sj1SVUqp+rfe0WHotrFlDxuBgxmgp3QGk0DwfzzfuQ8e0Q6w9G1x7MA2Yq
 OzsiqgRi5LiR90ttgXYcakKR2Twn71RnmFhqBrsHZfqwbyZ0b6dloDSvVE99AvDH4seF
 L+6zVZ4XS4NxX3d8RYdBEl3G9gjJ2u4IgE8N6UxEuXriFoyl4qQC9pG2sT7KVxxRex5w
 CyDgyyvxkP2Q18IXDbImSjjRNMsmHF/3drWCx7TPuyOaiWSd9xmIEN9s8KDU22VxTvey
 ne8Ns/Tv2vEBN5fB+PjIVrngNuAhrJaMLHIKLUlEPdZHeeR9WcXC4vFZaKdvR118j+MM
 oifg==
X-Gm-Message-State: AOAM533Yr1SfpkiYokJFmCdtzX7kXJmWCEo3hQWI+RcOUqr+FITIyEVm
 Fg80ynuw+AZL0hBxA9uA1xI=
X-Google-Smtp-Source: ABdhPJzM7ppcEeKlZ9RjMLKultQPdB56lqYgjj0W+MxQwF8TV9IcEx/0Aen4hemdvQL/YCM4KD29Nw==
X-Received: by 2002:a50:d753:: with SMTP id i19mr22507794edj.9.1593504805954; 
 Tue, 30 Jun 2020 01:13:25 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id z1sm1425948ejb.41.2020.06.30.01.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 01:13:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Yunqiang Su <ysu@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-devel@nongnu.org
Subject: [PATCH 1/7] hw/mips/malta: Trivial code movement
Date: Tue, 30 Jun 2020 10:13:16 +0200
Message-Id: <20200630081322.19146-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630081322.19146-1-f4bug@amsat.org>
References: <20200630081322.19146-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "open list:Trivial patches" <qemu-trivial@nongnu.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Trivial code movement to make the next patch easier to review.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/malta.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index d95926a89c..5b371c1e34 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1426,6 +1426,13 @@ static const TypeInfo mips_malta_device = {
     .instance_size = sizeof(MaltaState),
 };
 
+static void mips_malta_register_types(void)
+{
+    type_register_static(&mips_malta_device);
+}
+
+type_init(mips_malta_register_types)
+
 static void mips_malta_machine_init(MachineClass *mc)
 {
     mc->desc = "MIPS Malta Core LV";
@@ -1442,10 +1449,3 @@ static void mips_malta_machine_init(MachineClass *mc)
 }
 
 DEFINE_MACHINE("malta", mips_malta_machine_init)
-
-static void mips_malta_register_types(void)
-{
-    type_register_static(&mips_malta_device);
-}
-
-type_init(mips_malta_register_types)
-- 
2.21.3


