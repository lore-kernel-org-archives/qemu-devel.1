Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83196C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BD722280
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imB1mhFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BD722280
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUFjm-0007Gd-3X
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 16:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUFif-0005xY-Io; Sun, 18 Oct 2020 16:55:58 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:40337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUFid-0003oe-Hx; Sun, 18 Oct 2020 16:55:57 -0400
Received: by mail-wr1-x436.google.com with SMTP id h5so9159793wrv.7;
 Sun, 18 Oct 2020 13:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HG+/tHEq2dm469ZJlG6P+Ifw21KkzG7c80kEcZCsTRo=;
 b=imB1mhFT3We7O673U79M4rdm8hEmot69ls9mRQD9TcDlrnEwckV3HL/awICa2NvDtb
 RTGKmsLobaiNO/iGaWDgvv0XhHpCtpSmbmHR0e6VxGjxTuryekcF+JE4x5whn5fB9WtI
 NTa2yJM6SYwbkGfDhGWhVy4waI3hPMv+92WNQS8eIkar5N3xG2sZOdEhzhmJ6qLRQA6X
 MiK5ZYqfR5vz8uXtxFmWnN8Rbl5UwNR91CgcWE4f1CJlCMY3GTxNSKMOhpH2c417AaUH
 Zn0Nxw490tMojo05u9pN5xJtcW6FUBv/Wpo7/HfaK8GID7ZAibd42vnGei4nKKFAgl17
 wihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=HG+/tHEq2dm469ZJlG6P+Ifw21KkzG7c80kEcZCsTRo=;
 b=ZFQW7RUYOaHjvsIz/nYrJF4eJZOcfuqWedlhacbaBHm9FSyC5CbV6HD+FjLjbXhw/V
 wiYgUrqnYuRusFAHs5Kjfdo4cJP+un+p+QTWW1j0K7OFZIadnKqqIjcuUXH7nORzrUUQ
 pO5PUwpr35nvTrzqRsZS0cmk7mTImNeyxJ4qXdJOKOcwfbaIuXLvEp97QuesuDRWkHCt
 Njv4zyxMzpOP/pyXLLVxU1dsN24sGY8M5FTmk7qI8eKyCucX/uTEfPsfCx9Zqg5iwaBl
 IUQaN7QQXFvYiYWXBqqD8iVLbfnfqP06fVYHWS46UaXpTfLSRan/fyJ+vvrUX+AxcR/e
 ziQA==
X-Gm-Message-State: AOAM532TplE1y+5U+jgQZGxi3EcrYPCWjPQk/weVbXIjGL5etqKTWJG2
 magJQD1nOh1rvcroOPdVn9sI6epMCqI=
X-Google-Smtp-Source: ABdhPJy7WjbPFy56fN6bux+hnnMH29PZ5nmENvrh11p3jte9TOPuQxhcJSjP8fhYAitqvCiVJ3JgoQ==
X-Received: by 2002:a5d:5009:: with SMTP id e9mr9257929wrt.104.1603054553301; 
 Sun, 18 Oct 2020 13:55:53 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id e12sm3811463wme.32.2020.10.18.13.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2020 13:55:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 0/3] hw/arm: Add the Raspberry Pi 4B
Date: Sun, 18 Oct 2020 22:55:48 +0200
Message-Id: <20201018205551.1537927-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x436.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Stewart Hildebrand <Stewart.Hildebrand@dornerworks.com>,
 Johnny Sun <psunjohnny@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Still not complete as we need to implement more firmware properties.=0D
However state good enough for review, or in case someone want to work=0D
on it and improve it.=0D
=0D
Since RFC v1:=0D
- Rebased=0D
- Used recommendations from Luc=0D
  https://www.mail-archive.com/qemu-devel@nongnu.org/msg642450.html=0D
=0D
Based-on: <20201018203358.1530378-1-f4bug@amsat.org>=0D
=0D
Philippe Mathieu-Daud=C3=A9 (3):=0D
  hw/arm/bcm2836: Add the ARMv8 BCM2838=0D
  hw/arm/raspi: Add the Raspberry Pi 4 model B=0D
  hw/arm/raspi: Remove unsupported raspi4 peripherals from device tree=0D
=0D
 include/hw/arm/bcm2836.h |   3 +=0D
 hw/arm/bcm2836.c         | 179 +++++++++++++++++++++++++++++++++++++++=0D
 hw/arm/raspi.c           |  55 ++++++++++++=0D
 hw/arm/trace-events      |   2 +=0D
 4 files changed, 239 insertions(+)=0D
=0D
-- =0D
2.26.2=0D
=0D

