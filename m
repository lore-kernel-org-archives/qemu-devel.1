Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2ECC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 14:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2CE20738
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 14:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4EPNqNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2CE20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jflF5-0004OL-4B
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 10:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jflE7-0002wz-Vy; Mon, 01 Jun 2020 10:15:44 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:36923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jflE6-0007xu-RB; Mon, 01 Jun 2020 10:15:43 -0400
Received: by mail-wm1-x334.google.com with SMTP id f5so11545346wmh.2;
 Mon, 01 Jun 2020 07:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Co87+uxw8YntYwEzhIRYBrH8sjuRGN7vukvRwytagO0=;
 b=I4EPNqNvnkd5D6kMaoEh2uoT5tx2nE2vSnvH+OXJ6aAg5gBVMgI1wAt2uZdLsZ2QZB
 hijWhomsWeFpVdw1IUO/HF34Rca7ZRZqv1wtF5umMPBJ/HqYJ26kq2UU9SViORuoN3RG
 nNasBr1tvDcotZN0rSrtC494Iho53cZ1ut2g0g+eXL25KJIIYTVztbOx21Tg1UMqXfJh
 MxMgtV6Kw9FDRFDaI345LdH4HdtNe4AKTWzEGJsMvqU/wFLyMcyA2KhcfGxs01qMZiAe
 cFUo0Iol8Imevqx0N/zW2BJBVYEJk//fhlmkRnAH+OWop9Qmf3qPPoWkpiLqQ9fHT1+9
 8ZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Co87+uxw8YntYwEzhIRYBrH8sjuRGN7vukvRwytagO0=;
 b=JRjY9vth4C1d+q9JCxRx3WIIwdFJzT30n6IsAC4jticTy4eD/x7GzdC4LikKS/epRy
 dyC1RaHbkcwAW4Pfrl6UI3lO7612h8flU92c0+3/MKNDtjsUYA+/gtv6ACpSasia/ybE
 aHwBp5jg3kCzi+d67KZmpGPxnZEk63I86ZVmZQpCU8Tcd0VJpO3bcGu/VbLhy6dV1Bac
 rGBrXtC46JAeM0C8tIJqhOt5hTXHodRGAxzZAWiPth+t22dA7/RfHKtVL2ZuFif7BlDH
 Uw+AEF6yxq7pY96SkBXu8VcXs093lbRMT0uCJfMChz7WPo0WAZUx/iHBz+puntoOUQvw
 WTBA==
X-Gm-Message-State: AOAM531X0qeB37t3W/puX/NbP69y/XZEIrPJe9rqU+Z2w1SlXVT8h/cU
 R6pyQgZp0ujj3mcR0FvHGIzU+CCY
X-Google-Smtp-Source: ABdhPJyn25rvYxqj2SeNlmuy3yYU4FKv8FDJFOHduNdA5SDNeh1k9wm6ERC03nWN0fAeyEXwBrOpSw==
X-Received: by 2002:a1c:3987:: with SMTP id
 g129mr21820433wma.139.1591020939579; 
 Mon, 01 Jun 2020 07:15:39 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id a124sm12864182wmh.4.2020.06.01.07.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 07:15:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] exec: Kill CPUReadMemoryFunc/CPUWriteMemoryFunc
 typedefs
Date: Mon,  1 Jun 2020 16:15:33 +0200
Message-Id: <20200601141536.15192-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x334.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Followed Peter's suggestions [1]:

 * delete the unused MmeoryRegionMmio
 * move these typedefs into include/hw/usb.h and rename them
   to MUSBReadFunc and MUSBWriteFunc, since that's all they're
   used for now

Since v1 [2], addressed Peter review:
- Renamed include/hw/usb/musb.h -> include/hw/usb/hcd-musb.h
- Added Peter's R-b tags

Series fully reviewed.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg708165.html
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg708194.html

Philippe Mathieu-Daudé (3):
  exec/memory: Remove unused MemoryRegionMmio type
  hw/usb: Move device-specific declarations to new 'hcd-musb.h' header
  exec/cpu-common: Move MUSB specific typedefs to 'hw/usb/hcd-musb.h'

 include/exec/cpu-common.h |  3 ---
 include/exec/memory.h     |  6 -----
 include/hw/usb.h          | 30 -------------------------
 include/hw/usb/hcd-musb.h | 47 +++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-musb.c         |  5 +++--
 hw/usb/tusb6010.c         |  1 +
 6 files changed, 51 insertions(+), 41 deletions(-)
 create mode 100644 include/hw/usb/hcd-musb.h

-- 
2.21.3


