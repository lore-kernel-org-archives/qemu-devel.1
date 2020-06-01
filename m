Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01325C433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 07:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C32432074B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 07:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lf6WSvaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32432074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jffHY-0005MZ-2T
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 03:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jffGo-0004UQ-U7
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 03:54:06 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:39622)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jffGn-0003m5-Sz
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 03:54:06 -0400
Received: by mail-wm1-x335.google.com with SMTP id k26so10341678wmi.4
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 00:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jJ/v/EysUDhGfZCpBwRkB6y1RGEXcHe/UG8wv9qC27o=;
 b=lf6WSvaS+g8Msb9x+5SalmyMSEdr/ywIFABE17VkNJqn1xPaV3+/eZ/ST2cHrn+Zfo
 grXX4hiPD0WDCwMoWfo9YckRgHBPIbl9FcVg3m0nd5KvEiihTCwSN/E7muwXfmiA1Xbi
 +clmc2IGYsRwku/Yls2U1Zx9mPVIgrjClnLF2HwTnv4L1HWhs0jdCoA+p8nlXcrNNBNK
 jAAGNuNuMZ9myEFe+kXETGdDEJbqPzcFR0qDpjNVNN/AgdDWWn8P5uifRD6JfItvgQAj
 vRcoA5a3kQ5q0aoKTev7yuizOeuQV2jyfzHaoS3pF62slgHkkzBkV+vms5HO8L+UwL44
 bpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=jJ/v/EysUDhGfZCpBwRkB6y1RGEXcHe/UG8wv9qC27o=;
 b=YxMtVOB3UPUAWQbNMCVoPcVmcY3AR9gL2CN2nKQAnWYl0rpsHKUA8kn+7xxInlsfXs
 m44fkQAWXoaYSfn+MvMY6Er8ZNcb5PAWuTTvK3FMuMMB9A/cWdbQYQ7Viuf0wkO+xKSa
 RYf08eQZ+uMQzWwWt09uamkMSzwd/ULQCurLxYcZmk/LBTJJvy/nITWjar/iyoiZ/+s3
 lEChb1ZfoazS20odD2hVC0SXw9JguuWln5967a2CBGPmj2KNR80Zl4/Wshjym3ygXsXC
 az4ed7VIH+sdJNwGQRBBGHff7pSaKlTPSfXVrRXDDasA5Pxi4vzq7u1LTGU++7G5SOs8
 +xdw==
X-Gm-Message-State: AOAM532b9Dh5vnD4cXn3PvFhUbSUOTdhvs6a0204WXsZrIxhrZufVAmM
 Bo1bmmfQDQ4J99uxZWsMiDZEu8W9
X-Google-Smtp-Source: ABdhPJzGjBrYWa9vnhxxu0yncxw4Mbo45S/n1bqrnqkbqZA8B8wic0JF+lA4cmVNuZFyl5Pbvg90qw==
X-Received: by 2002:a1c:9a57:: with SMTP id c84mr13023717wme.62.1590998043832; 
 Mon, 01 Jun 2020 00:54:03 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id b18sm19294949wrn.88.2020.06.01.00.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 00:54:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] exec: Kill CPUReadMemoryFunc/CPUWriteMemoryFunc typedefs
Date: Mon,  1 Jun 2020 09:53:57 +0200
Message-Id: <20200601075400.2043-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Followed Peter's suggestions:

 * delete the unused MmeoryRegionMmio
 * move these typedefs into include/hw/usb.h and rename them
   to MUSBReadFunc and MUSBWriteFunc, since that's all they're
   used for now

https://www.mail-archive.com/qemu-devel@nongnu.org/msg708165.html

Philippe Mathieu-Daudé (3):
  exec/memory: Remove unused MemoryRegionMmio type
  hw/usb: Move device-specific declarations to new 'musb.h' header
  exec/cpu-common: Move MUSB specific typedefs to 'hw/usb/musb.h'

 include/exec/cpu-common.h |  3 ---
 include/exec/memory.h     |  6 -----
 include/hw/usb.h          | 30 -------------------------
 include/hw/usb/musb.h     | 47 +++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-musb.c         |  5 +++--
 hw/usb/tusb6010.c         |  1 +
 6 files changed, 51 insertions(+), 41 deletions(-)
 create mode 100644 include/hw/usb/musb.h

-- 
2.21.3


