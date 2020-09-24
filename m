Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1842C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:22:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 317662395B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Is6odIUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317662395B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLPK9-0000zK-Vw
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 07:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLPGS-0004C0-3l; Thu, 24 Sep 2020 07:18:16 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51071)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLPGP-0003uJ-Lf; Thu, 24 Sep 2020 07:18:15 -0400
Received: by mail-wm1-x341.google.com with SMTP id e17so3140458wme.0;
 Thu, 24 Sep 2020 04:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jRYBbPZdjZNqhsxNCbQU/40Ab/DhwUD75yfurRb+dzI=;
 b=Is6odIUBW44SU+LOw24Ds41ytKCpjyYfE5RPQtYIYtm+eQ4P9Cf/DgLI/wI7IRQ0Jm
 VFaTWi/irZbMVVGWzMKlZIw1MIqIRy7xS/25LD9pBV1regbR1Cp8uoDo5ZQz/l5rPwee
 Jgcj1EhTXNVncjoaZ+OcPryas61G5V97go3najE+iOLO87Gih1Pxa19AoTQ2TK/GjZ14
 GAEWI0cHsfAmtjci5Dr2fNcBAcjil2jCbtYWAm+t2N8SEBx/nXb+GgOsU7z7s0N6tuOS
 UITzH2A55p/X4JdgLfznvCesXdYbIiD3buXZVD0xWMmCgde6np0F8jTq4sqPHm3qXxr5
 K3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=jRYBbPZdjZNqhsxNCbQU/40Ab/DhwUD75yfurRb+dzI=;
 b=KALP18+Wq25nxYa+13jBYShlFnUhT/eMkQKa0eDxYhCdJGrHjar8sq+UAm66V5Ldm9
 MggrP8RnJG9aH+W8rV5W7qPNbqe8AHbclK5S/+xfnCcBx50FnQgGitqu2x1LAtXTcuPC
 gyfFp+kQKC0ZHVsMEXdUOIbKcvmdN9F77qCd+Cd9uwxnsLBwVsYND5f+0mpH4EOIPPho
 18RRzFLJPBh7Q8+ZHZci5rFi9HRqRprbosuuEsMGMyFrzaqMPhPrKaudlq30KWCeTqU8
 fbFs1DCw7iF+kpe/Wxro1jQkzAGHV4C4U/qR7FdjXyUbR0aEzfm62tLBCnLfjrwoX3Bn
 aYSg==
X-Gm-Message-State: AOAM532XEtLjmdgW3muoSwT8kZ7idlnbb2wqec9BygIkkNiq6NRD+d2F
 ihgfbSdUODh3yDEXJdPksMP0VxJSlGI=
X-Google-Smtp-Source: ABdhPJw17Fq2a3ojds4TXZkNc+PNFxTRUe/BPZmN6b8dxI1kquU71E+U1lsh9K+nD5R0cHSXBX6WyA==
X-Received: by 2002:a05:600c:216:: with SMTP id
 22mr4004200wmi.149.1600946290374; 
 Thu, 24 Sep 2020 04:18:10 -0700 (PDT)
Received: from x1w.redhat.com (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id h76sm3400363wme.10.2020.09.24.04.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 04:18:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/8] hw/arm/raspi: QOM housekeeping to be able to add more
 machines
Date: Thu, 24 Sep 2020 13:18:00 +0200
Message-Id: <20200924111808.77168-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Machine-specific patches extracted from v2 [*] and rebased.

Series now fully reviewed.

Since v3:
- Fixed typos (Luc)
- Added Luc tags

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg680135.html

Based-on: <20200921034729.432931-1-f4bug@amsat.org>
"hw/arm/raspi: Remove ignore_memory_transaction_failures on the raspi2"

Philippe Mathieu-Daudé (8):
  hw/arm/raspi: Display the board revision in the machine description
  hw/arm/raspi: Load the firmware on the first core
  hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState
  hw/arm/raspi: Avoid using TypeInfo::class_data pointer
  hw/arm/raspi: Use more specific machine names
  hw/arm/raspi: Introduce RaspiProcessorId enum
  hw/arm/raspi: Use RaspiProcessorId to set the firmware load address
  hw/arm/raspi: Remove use of the 'version' value in the board code

 hw/arm/raspi.c | 152 +++++++++++++++++++++++++++----------------------
 1 file changed, 83 insertions(+), 69 deletions(-)

-- 
2.26.2


