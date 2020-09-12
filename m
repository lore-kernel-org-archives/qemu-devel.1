Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A8AC43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 08:31:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1794214F1
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 08:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeKKaH7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1794214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH0wY-0003OK-IM
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 04:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH0us-00022z-I4
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 04:29:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH0uq-00022Z-NK
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 04:29:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id a17so13612357wrn.6
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2020 01:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5pysvA1syRNHSzPZgeEEJUg4BktCjm4zQbvoXzGgB2w=;
 b=MeKKaH7CKjNaFs7w0tEmfVxr0mySHNXsn+Qs0t3g1AVcfAzOimViHBswJJGTh28cCq
 nyQLKkGwtXEmpZ4GCqRBbI0dVF9/QiuhNcUPX1mtxuvVXwdpqsbYX3CkAHcRVDdcceOz
 MOPazqGhLa6I2yN+unBzHR1x/MQ8w5GPMtxNJrH+b2RvJ7ODy4xJAa7oBC1JIlVkSVP9
 UL4xSrh/YbiVyBMhI/b/SJzUhpjni0lYG4igdtDsUqDe4T8xaI8TTlZQjyxiO2SNFNms
 3eOvjLiR6xM0d//qRcQ2Kjux2Et811SSsAmMS0J46OEqWQLxAwjBC338xHHiKtMy8f7F
 16sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=5pysvA1syRNHSzPZgeEEJUg4BktCjm4zQbvoXzGgB2w=;
 b=GQaYuR6KwRKc2WSEbboqC+ysDEMzPdQQYOl3p+JAZ/Yfxsd8SlI7HUk2yYsJ+kgerR
 c8rIH2umF6e0UB4Vpf33HasaXzy2C2cLfhFbO+GSATjM4sVHBDodwAuMp5CEriuVFwjx
 ukxPI516n9xXDiHbtVwfvCyLNC9dXi1wujVE1ETZ5tXesWpag8LU+yCDc62s6cluaRDv
 DlEXF3eTl/yTUsZ1W1nGuB71DDGHFrEwEHUiqmZpCMDESdnfT10Dp4iRxMdnA02ey/sD
 1Z1OcF1wvlHL4KYb8N+PkpL+sIvMuaEN/4TBVg0l8WfHnpV6mnhzz9ffi3XOEh48dW2F
 hvLA==
X-Gm-Message-State: AOAM531e20ArYhwrzXnhFP+1HVefxMOXGKV3bZtoTItbKUCk7HV6T0ki
 ZEWHktn6qmtIp+SwuRl43fBZb7RVnM4=
X-Google-Smtp-Source: ABdhPJxgCHjR5VE3U0GYYPFOlRcyhllXXtTzQjIQ5gMSAXJ8Yieh4lLEu2wpHoqk9wlWH8KqjOk1BQ==
X-Received: by 2002:a5d:608a:: with SMTP id w10mr5659159wrt.48.1599899386813; 
 Sat, 12 Sep 2020 01:29:46 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id t188sm9598698wmf.41.2020.09.12.01.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 01:29:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] hw/char: Remove TYPE_SERIAL_IO
Date: Sat, 12 Sep 2020 10:29:42 +0200
Message-Id: <20200912082944.890972-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the TYPE_SERIAL_IO which is simply a superset of
TYPE_SERIAL_MM, as suggested by Paolo and Peter here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg721806.html

All patches reviewed (patch #1 already queued in Paolo's misc tree).

Since v2:
- Rebased on "QOM boilerplate cleanup"

Since v1:
- Reword migration comment (Marc-André)

Philippe Mathieu-Daudé (2):
  hw/mips/mipssim: Use MMIO serial device on fake ISA I/O
  hw/char/serial: Remove TYPE_SERIAL_IO (superset of TYPE_SERIAL_MM)

 hw/char/serial.c  | 41 -----------------------------------------
 hw/mips/mipssim.c |  5 +++--
 2 files changed, 3 insertions(+), 43 deletions(-)

-- 
2.26.2


