Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F8CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:05:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59FCC206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoAHRHT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FCC206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc37H-0000hL-8m
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc36C-0007dy-Nv
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:04:28 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:33013)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc36B-0005Fg-3D
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:04:28 -0500
Received: by mail-wm1-x335.google.com with SMTP id p19so5004447wmg.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 01:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eCXHKYh4lVPWKiXFFFX5qUAEWPiMN2L7aJ2HSBoHyCw=;
 b=AoAHRHT2Ric26fZZYxd9czir48a3ypfboI1LOQZ614ETnM3YOxu6DDjyDQ6P74aYP8
 kWgkILPBYR1b3uA4lFlyMeyRTFNcMj2lD2XV+XSXvG0go5RozTLMJdxhm0Fi2t0BoAfw
 2dfY11Jo++N0NZDda2NBOk5UPBa2HivLmaPAHPQvg6sOUDf98bdM/hOqhfWgzoYC0sLF
 WwXWhGgAwtc1vr5YUQcUV1GFifyFOjiNTcfpwbsJKxz/SJdR9Sgt6IMy3XxbJVfK8VJQ
 YjXvHewPePjG4O5R1LESz03X9qkU4agEArNpmCPFOHD9tJE6FclzKaBw3q/Nh1CDokHO
 eWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=eCXHKYh4lVPWKiXFFFX5qUAEWPiMN2L7aJ2HSBoHyCw=;
 b=DgGwB8qTYcbGQOhzhj7YkWG0uQaJIPt3MSOwkZTgoC5I9ltnNfqrNXqpYEvUwraRjX
 BFp/aCq/GD2CrCb4r0SopHgjXOoCn5181zHwrvhaMS3zKrzawCtXK185Ry/YYFvrPa7h
 YolUy2hRSk/2xn9h31tcbaxf22HPU/elvvgP8JzsGTiFYGofidc3rtpEs+5j24JgJvcx
 Y74dcT8SzIOmAJBLqN2F08xgzqORsrzqcEK5/2bsJXiNxrqcVHubdwETYpyHZ8zdO/vs
 chb9psQhRY7qAhJCaHFfbvgpPrDGGrW4a57n9GOhtkONu9Dco+WDI36ybzTv/ECsFxV1
 elqg==
X-Gm-Message-State: AOAM533Zmn+azoVjoktCcR6b0jNLoBXnKyMPhqBaPuOwvOQLygVqQtH/
 bpTwg0NpEF8pPhqBaWB+Io29mv7PJb4=
X-Google-Smtp-Source: ABdhPJyNRTjnoYPXKgAkJi0MIDLef/cJUEy3MZ2/dE4EPKShYA8JuHTZJ1SWOf/81FV+Gvr8+RBBDw==
X-Received: by 2002:a1c:9e0e:: with SMTP id h14mr13099214wme.18.1604912665436; 
 Mon, 09 Nov 2020 01:04:25 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id c6sm9330364wrh.74.2020.11.09.01.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 01:04:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 0/2] target/mips: CP0 housekeeping patches for Nov 2020
Date: Mon,  9 Nov 2020 10:04:20 +0100
Message-Id: <20201109090422.2445166-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x335.google.com
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: <20201108234234.2389789-1-f4bug@amsat.org>=0D
=0D
Philippe Mathieu-Daud=C3=A9 (2):=0D
  target/mips: Replace magic values by CP0PM_MASK or=0D
    TARGET_PAGE_BITS_MIN=0D
  target/mips: Do not include CP0 helpers in user-mode emulation=0D
=0D
 target/mips/cp0_helper.c | 9 +++------=0D
 target/mips/helper.c     | 4 ++--=0D
 target/mips/meson.build  | 2 +-=0D
 3 files changed, 6 insertions(+), 9 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

