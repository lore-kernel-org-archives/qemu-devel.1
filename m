Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A581BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:19:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E61C20759
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IejZtuCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E61C20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqBTy-0001OP-Mj
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqBOa-0001WG-Gf
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:13:36 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:33008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqBOZ-0003Ce-4y
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:13:36 -0400
Received: by mail-ed1-x543.google.com with SMTP id h28so15330989edz.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 01:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SGZ0w3GX0Fw/UVCGFTciL1Am4/K0WbWSFkFzf/a5Yeg=;
 b=IejZtuCP8CBNQ7wNJEVzMD8vn1uEh1LCzfmTf9kxt02JkzXHnUaxxrm+Pw6bIys1pF
 4YB9Fk7Nl5++TiyQDzXJcG/xHADMf3+t2bvROAxnNlRQDO638q9nZrB7R1h5jH9R5u/J
 vm7OhiwD+LPQfG7kKw5t0IfAnefG/aBceTyzHfjGnCj83cNAOLedfWclIHjUuaoL54Qc
 2Au6HwrOePFkFSXwyDKGznRbwFDttKvhidQUC2iqbhbwbF6PZSUylSH8LBCpjX2IdgCn
 Y6M0j9MiBbDNS9/eq1RvEGlerIj/wwZSfO+lOR62bz51cMpPUUeMAvFlBIJ/McXDYX+8
 gUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SGZ0w3GX0Fw/UVCGFTciL1Am4/K0WbWSFkFzf/a5Yeg=;
 b=fURXUFgEenwbNDQVHl/yBhqjSY7yejRVK3L9pkiHBSUNqIsNu3gMs3RqvKHe5CxpyP
 bQGd3CeWSUdIH22y1qHSZ9b8CZjhfx4kpKKhkCMkGEz8lEXY3EGSd7LPU/iC+8zt2UNs
 zSiilw7SgZCiUCft/SkZjIxw9MR3bfh05mbLjMQ0I0GHIGxB1T1lyWrAxUDXbGJsW227
 eAgFR0A3DowlHeiawoAAUts/Q40mwMIvJRgiGYbAso8Myj5u/o2y+FMVM14wWrqp8tmk
 8mnLY2J8AY58AmIFTn0RADWwqEPhs/zC411ME7/SoQTMWXIpA7xDO1ZF+D9CD6wAtHkc
 F0dQ==
X-Gm-Message-State: AOAM530mI4iTIJX1L0kLwPUjL+oZcgXDFb2uYD7HsFfW4qvvXMjkVPC+
 iXau96KCJFLB27zszjWRf7U=
X-Google-Smtp-Source: ABdhPJwFqCJKU5niLQVN0c7TBAtNOKfShqVHK68LWoGS0k6IOSwRVGQBfd/K8pFvZfsIt+P9eRhFYw==
X-Received: by 2002:a05:6402:17f6:: with SMTP id
 t22mr22447564edy.141.1593504813883; 
 Tue, 30 Jun 2020 01:13:33 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id z1sm1425948ejb.41.2020.06.30.01.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 01:13:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Yunqiang Su <ysu@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-devel@nongnu.org
Subject: [PATCH 7/7] hw/mips/malta: Allow more than 2GB on 64-bit malta-virt
Date: Tue, 30 Jun 2020 10:13:22 +0200
Message-Id: <20200630081322.19146-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630081322.19146-1-f4bug@amsat.org>
References: <20200630081322.19146-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we don't respect the hardware restrictions, there is no good
reason to limit the maximum amount of RAM to 2GB.

Suggested-by: Yunqiang Su <ysu@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/malta.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 5768b88183..277cbc0303 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1482,10 +1482,11 @@ static void malta_machine_virt_class_init(ObjectClass *oc, void *data)
     mc->is_default = true;
 #ifdef TARGET_MIPS64
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("20Kc");
+    mmc->max_ramsize = 3 * GiB;
 #else
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
-#endif
     mmc->max_ramsize = 2 * GiB;
+#endif
 }
 
 static void malta_machine_phys_class_init(ObjectClass *oc, void *data)
-- 
2.21.3


