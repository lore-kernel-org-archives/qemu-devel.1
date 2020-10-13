Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ED9C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B1620708
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRKJ4aR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B1620708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSHNs-0002lK-NV
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 06:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSHMn-0001v1-F2
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:17:13 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSHMm-0001Y4-4A
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:17:13 -0400
Received: by mail-wr1-x443.google.com with SMTP id y12so17950713wrp.6
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 03:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LmpqxRDOSD6Y0ROM5eXEsmel/Juskc7iItZ6lbtqH6w=;
 b=KRKJ4aR2K2Z6kRbO6UYExKbaj3EDn4tZBpU88EUn0DL4eAqq8VQUXGBvhWRkXObPy0
 jGHp8KA7tlIf7lgNEk61QxT0cGC+GA6w9qqj59LdQH4gBZi349CP2MGdgSPantTkrNtZ
 Ix8IkPo+FuzOlJfiLwGX+Y1TT98YVeYUWrgb/a5Tk9zdfRj4ldhB6czK62d0h3V2c+ur
 9eSgU8vX5RFoqSdRmHGaWittrI5CGRTKYWpReLS3g+4DdGgZ/nQUR+Q7LV151I6L3sdD
 C47bE4s98A9WjNCEWMq4/uyh3bevHtyOCvKOImsFuY6zreOpI17ZYPPnJ+XCOQ12vxmC
 Z82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=LmpqxRDOSD6Y0ROM5eXEsmel/Juskc7iItZ6lbtqH6w=;
 b=QbLOWhAwg9moKML4wNt8I/t3uAvzvFWo/rTbVDgW/s86/s5jXc1P6AgvXW5r7K1R6m
 AXuZ2nmY4IqdDxAULvSkR5302V1aOGWhvgnzLKzjf8YrpfantO50Alhf3N7xGEyMcd1E
 Cbg6Z1hWc2jOPuBerrfD4UwUWaejcX03Frh/D/5TWVPOqTGms3MRntDJeUtjAwNap7q6
 yEZn0/AXSaA9iEk5Ah1IGGpuWi52b7IvMHZ5M/HziKzu+snZLaWYNnTgQXg2poKdKV4C
 jf2yxqD0grQuShZ1hoR+uFOa7/IRZkuYpgeHrm1Gg4S2POD93Z6WjQ+DAoTGixJEDe/J
 XelQ==
X-Gm-Message-State: AOAM532bjccebBJaf7TdAOYqvLvY9QFEGHuwOy+yV2TGriU+OTAJplck
 w+ghstyqWefZMeyxd0DgKg2xtq95IRg=
X-Google-Smtp-Source: ABdhPJzZFV4XwTpdJ9/sgH017+k5Jhj8dhpvDapIDs5fGQegPGHsgevMfMjVkqdQ4IAuNXebTSS7Qg==
X-Received: by 2002:adf:fac3:: with SMTP id a3mr8354075wrs.240.1602584230527; 
 Tue, 13 Oct 2020 03:17:10 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id t83sm16525209wmf.39.2020.10.13.03.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 03:17:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] MAINTAINERS: Remove duplicated Malta test entries
Date: Tue, 13 Oct 2020 12:16:57 +0200
Message-Id: <20201013101659.3557154-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013101659.3557154-1-f4bug@amsat.org>
References: <20201013101659.3557154-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Chen Huacai <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Malta tests are already covered in the Malta section.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d59e5c05c10..2de5943e388 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -238,8 +238,6 @@ F: include/hw/intc/mips_gic.h
 F: include/hw/mips/
 F: include/hw/misc/mips_*
 F: include/hw/timer/mips_gictimer.h
-F: tests/acceptance/linux_ssh_mips_malta.py
-F: tests/acceptance/machine_mips_malta.py
 F: tests/tcg/mips/
 K: ^Subject:.*(?i)mips
 
-- 
2.26.2


