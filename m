Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7BFC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 07:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A1CE2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 07:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLolwH3t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1CE2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxnWE-0003i4-K1
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 03:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rashmica.g@gmail.com>) id 1hxnUd-0002Ls-Kx
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 03:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rashmica.g@gmail.com>) id 1hxnUc-0008Bl-QJ
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 03:14:47 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45752)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rashmica.g@gmail.com>)
 id 1hxnUa-00088t-N3; Wed, 14 Aug 2019 03:14:44 -0400
Received: by mail-pf1-x443.google.com with SMTP id w26so7776015pfq.12;
 Wed, 14 Aug 2019 00:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RncU1uPuVeOAdD09JRhpLrLDwrbmT2eeqdYkuhqdQeU=;
 b=sLolwH3tg2Dz5RBq6LnEPpaZwFhvTKuBgYr5TUe+fUOLs1SAYLTuZCp+4/RViNtUke
 MTKJ67gWLj6r8RQcvastVv0rdyTMEQhKeqiejX5Y+43I6bdur4T5h2+SyiSk2UYspQyz
 ssNQD81AdQ9fbWdgO+xNhNXKXil/PqEyTyMDrB+zINgszKC7ukAgDGHUkTI952odmqVe
 8Qxf7+yFV9IgJ9lLZwQ3mFrS3Xrsu1TUTfQwIw8nQiB2rYNugFp+taAJeP6JkPCARh9+
 sKqz4ovC1cUs57Sl6XroGnagXhqI9EahNLORC9gMBwPOmZPKG1S3rdvhxXeBveAFAaU7
 RVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RncU1uPuVeOAdD09JRhpLrLDwrbmT2eeqdYkuhqdQeU=;
 b=gafgV4R+iusuGIbca9FdX7vPJnNhq6uZ6MLeWMjWJEqZszKO4umLfk32tMdSjnKY4Q
 HJRQ0Q0Ose35SZpBBDmxPPHKtc6r7gL1nhALvU5TH5xspYdD/vQswv/6rtZhuTxRjHng
 uV9dt5uTO/PkXhB0GE7fgMOSIdwjrOcEGo0eSdR0AkDdcZECoKS0nFIl49OJuUBqm44g
 HzPfuip99pmyJYCgczk8RW5f90PfiBC9719DDNZapnbxHeRhKu9Md8Jg9b6jHFuB7nCx
 UGjhgVqO5hmIVzb7CmUiqzssD4PeeTcAQaXQxaypeB/+OOv12VUPZmQnEkx87UQCPjH1
 wDwQ==
X-Gm-Message-State: APjAAAWdksvC7W9WEp6YIZOx7LjirEblSGAXFZSGoHWZkhKliRBLnu5R
 rhnNAbi+++799v8yo9dp0y0=
X-Google-Smtp-Source: APXvYqyalu/HX2ZuDyKkiGbkBIkzkWC93Wc+UXLDpSO8ZKvbozuOqi09QC7kQ15rYW6Svhsu6ti0Ng==
X-Received: by 2002:a63:2a08:: with SMTP id q8mr37439392pgq.415.1565766883039; 
 Wed, 14 Aug 2019 00:14:43 -0700 (PDT)
Received: from rashmica.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id j187sm20086474pfg.178.2019.08.14.00.14.39
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 14 Aug 2019 00:14:42 -0700 (PDT)
From: Rashmica Gupta <rashmica.g@gmail.com>
To: peter.maydell@linaro.org,
	qemu-arm@nongnu.org
Date: Wed, 14 Aug 2019 17:14:30 +1000
Message-Id: <20190814071433.22243-1-rashmica.g@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v4 0/3] Add Aspeed GPIO controller model
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
Cc: andrew@aj.id.au, qemu-devel@nongnu.org, aik@ozlabs.ru, joel@jms.id.au,
 Rashmica Gupta <rashmica.g@gmail.com>, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v4:
- proper interupt handling thanks to Andrew
- switch statements for reading and writing suggested by Peter
- some small cleanups suggested by Alexey

v3:
- didn't have each gpio set up as an irq 
- now can't access set AC on ast2400 (only exists on ast2500)
- added ast2600 implementation (patch 3)
- renamed a couple of variables for clarity

v2: Addressed Andrew's feedback, added debounce regs, renamed get/set to
read/write to minimise confusion with a 'set' of registers.

Rashmica Gupta (3):
  hw/gpio: Add basic Aspeed GPIO model for AST2400 and AST2500
  aspeed: add a GPIO controller to the SoC
  hw/gpio: Add in AST2600 specific implementation

 hw/arm/aspeed_soc.c           |   17 +
 hw/gpio/Makefile.objs         |    1 +
 hw/gpio/aspeed_gpio.c         | 1054 +++++++++++++++++++++++++++++++++
 include/hw/arm/aspeed_soc.h   |    3 +
 include/hw/gpio/aspeed_gpio.h |  107 ++++
 slirp                         |    2 +-
 6 files changed, 1183 insertions(+), 1 deletion(-)
 create mode 100644 hw/gpio/aspeed_gpio.c
 create mode 100644 include/hw/gpio/aspeed_gpio.h

-- 
2.20.1


