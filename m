Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF43C3F2C0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 22:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A3922469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 22:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+Z7qLYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3922469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7RGi-00044g-Bd
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 17:04:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j7REG-00018h-5u
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 17:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j7REE-0003k9-7F
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 17:01:59 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33915)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j7REC-0003js-Qq; Thu, 27 Feb 2020 17:01:57 -0500
Received: by mail-wr1-x441.google.com with SMTP id z15so720866wrl.1;
 Thu, 27 Feb 2020 14:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=kNMFlIjm8XBJIEBAtxi3IHrtpIfU7DEVVdeoiVTfm0o=;
 b=h+Z7qLYwpV96cJpRs4xBR8CbE+1g/hBRgA2WQrpaJUzf81kgCqfMTi8D5Y0y6pXMmf
 856AeXTiwadfM1Xcy2kTQ9P/2g45TPcLGKcfqfraFya9Z4gYUKowZh2Bi1OTPR7VK85E
 QOwgXzPETiFYHea9YbLFZwvNtu3FfNMtAbypVjqNRzXZ9z27xefbb2XaSA0adtyxxH5B
 SnuyoJg81CMR+HjuYO1ETdwrnKS916qIRHAnU1vqD6Rp5Gr+ILMUCBc3MMiVivAbVpWU
 OTWfmAV+7DQnY5RmkdXRpgObij+M8dduEAlXU9kDpDF0+4HnLtR97xYVuzUaAIXtJBgz
 oauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=kNMFlIjm8XBJIEBAtxi3IHrtpIfU7DEVVdeoiVTfm0o=;
 b=hQgte0SEv01JQ+rUnmyKLNETlyEYrBFtyAuL9nGg7X9UyEwdf3RwQQ+h+fMEIk+nEc
 K5sx/2eeu7dm1r2sHvwiHb0CrV8zmUUuLzR+vhFteF6Xhc19jroRs3zmHLWVKm63U3vX
 RX5rpYz0N/XVf2WLKr5bm1OP7zh+a1fpcnyiyKC2RuMmy7MRaXm9rywMtYGNXD24WrOY
 B26TX0+JvZ91Hc0JUcf3pm3fBc57u89IrjdpWuhAC6zWhwqEPuYIJ2N4vCpZBvTIMFyj
 CPAvWE7oPT3Sc+EFyzGNKCzbOHcYBuI7nJ25oPJ8Ihc23klyz2cXfKgcmlkj7m8w5c/M
 GHog==
X-Gm-Message-State: APjAAAWLiV9uDkSwm00HAzZosG81to38a9a3AAwlIi+0JY34pMDx3Cbe
 nXiqGh+ZPwyo9aN/JVJGNCeklMDf
X-Google-Smtp-Source: APXvYqwAi0eWgIFWbQuHP64dDwrgquZzUOdO9LR3IaI7Xh8WkIWf1N6uNj4JaO/2Ua/utwz2Lug4Qw==
X-Received: by 2002:a5d:69cb:: with SMTP id s11mr893521wrw.47.1582840915381;
 Thu, 27 Feb 2020 14:01:55 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id z14sm6447040wrg.76.2020.02.27.14.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2020 14:01:54 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/4] hw/arm/cubieboard: correct CPU type and add machine
 argument checks
Date: Thu, 27 Feb 2020 23:01:45 +0100
Message-Id: <20200227220149.6845-1-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: b.galvani@gmail.com, peter.maydell@linaro.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These patches change the Cubieboard machine definition to use the
correct CPU type, which is ARM Cortex-A8 instead of ARM Cortex-A9.

Additionally, add some sanity checks for the machine input
arguments in the initialization function.

Niek Linnenbank (4):
  hw/arm/cubieboard: use ARM Cortex-A8 as the default CPU in machine
    definition
  hw/arm/cubieboard: restrict allowed CPU type to ARM Cortex-A8
  hw/arm/cubieboard: restrict allowed RAM size to 512MiB and 1GiB
  hw/arm/cubieboard: report error when using unsupported -bios argument

 hw/arm/cubieboard.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

-- 
2.17.1


