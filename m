Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF68CC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:17:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76D4F20704
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5advx1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D4F20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTn16-0003jm-Fu
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmqU-0005G2-Tu
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:06:06 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:40680)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmqT-00048L-6P
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:06:06 -0400
Received: by mail-wr1-x429.google.com with SMTP id h5so6580791wrv.7
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K4I6rKlRV5CwkXwi1bhz1e4ZJqjshXMHPloXxAGf1Gs=;
 b=f5advx1zgDfzeVwXM7qs/p/Ay06yMXHouCwif8kW3SK93qbRcRCb4drq5pO6ECTlYV
 0a3PqW+zA0AWf/qWBU8kJPbPj3961C/F7gUPx/rov56AIOvkwXcYxjVij1fjMnPhuKDg
 c2pxCzg8TSV2dtcH80rIm9RI/jHJPr7LHX8lzStlwM4dArT5JQIQoGkMJR1HVJ1IU3de
 RMYaC4c5bJ4ILHKSeUxMuxBOtmnsey1PGaLCHoVog1bH1U5LMLc+/Kntzg1K5ooq809Q
 1D/VdGA6uQ/BeXVB4xnh1RwMq7iiWcaEiuNIVBHM1nWdAlow/pwRbvsmGS0OqZNSOuUw
 rv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=K4I6rKlRV5CwkXwi1bhz1e4ZJqjshXMHPloXxAGf1Gs=;
 b=M+XHPWcu+B/1yWI4qifsgRRUeo3QqHFtWg3yPjre6k/6th0KFVYMDiLIHH41BT0TF7
 CtMd71ZqQAyihsKx2eC6CZD6umbyD9yh1GUD3Ooa8uful0WnBorDXCN7KF7ex8YDBPGN
 OGdwOza2/qHJOfraFlQEg3+6YpOkwN4wDo39W5iG2MPkwS9OqWwaZRPGXDa5+08hxF60
 vVFaN+4PeIvgnBXW4DEhntaehIDqdGfKLHMCay4faBqHXNODtUJwAgcQl2/fx2stVhaP
 PDPVEQHQiwrw6UP130mohHErUERJQZ0rO+fQTfquWNG0+baTRCgTz+D4Fj5Tz9ssPiO1
 4Bqg==
X-Gm-Message-State: AOAM533aattwzIE+gRv6zuJxLHlsS/s71qcuXTjXaGmtIBmYsUkyvyCI
 Jw4uQKZa3tYd6G2gj7n3W8ZgGW6p/Vo=
X-Google-Smtp-Source: ABdhPJzCxUSgdlziZfXv4uD1ng0gnQ2iPCuCmjbBBcyBT/XlH5ugoZcR1gpvUyx8zmP7Yez1X1Wypg==
X-Received: by 2002:a5d:6cad:: with SMTP id a13mr11099223wra.347.1602943561904; 
 Sat, 17 Oct 2020 07:06:01 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id b189sm7292068wmb.37.2020.10.17.07.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:06:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/44] MAINTAINERS: Downgrade MIPS Boston to 'Odd Fixes',
 fix Paul Burton mail
Date: Sat, 17 Oct 2020 16:02:41 +0200
Message-Id: <20201017140243.1078718-43-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Thomas Huth <thuth@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paul's Wavecomp email has been bouncing for months. He told us
he "no longer has access to modern MIPS CPUs or Boston hardware,
and wouldn't currently have time to spend on them if he did." [1]
but "perhaps that might change in the future." [2].
Be fair and downgrade the status of the Boston board to "Odd Fixes"
(has a maintainer but they don't have time to do much other).
Similarly to commit 2b107c2c1c (".mailmap: Update Paul Burton email
address"), update his email address here too.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg718739.html
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg728605.html

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20201013101659.3557154-4-f4bug@amsat.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 50fb9fda34d..8770cd6d05a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1162,9 +1162,9 @@ S: Maintained
 F: hw/intc/loongson_liointc.c
 
 Boston
-M: Paul Burton <pburton@wavecomp.com>
+M: Paul Burton <paulburton@kernel.org>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
-S: Maintained
+S: Odd Fixes
 F: hw/core/loader-fit.c
 F: hw/mips/boston.c
 F: hw/pci-host/xilinx-pcie.c
-- 
2.26.2


