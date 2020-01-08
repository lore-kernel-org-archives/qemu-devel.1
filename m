Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A23AC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 18:15:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3A1320656
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 18:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eU7KnPGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A1320656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipFrd-0000GY-Sj
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 13:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipFqg-0007rU-BS
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 13:14:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipFqf-0000hB-9s
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 13:14:30 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35076)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipFqf-0000gU-4L
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 13:14:29 -0500
Received: by mail-wm1-x341.google.com with SMTP id p17so3564737wmb.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 10:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vM5PJqD1hrPrPH7JYBKiGQs4swH5X3xQevLP2fWHg1k=;
 b=eU7KnPGo2xhsHXxE206hJnQdBPjQSCk3CL0p3u7jV8Mmk+vQpvu6S5orndhUgSU9Et
 eQE/uvV2/5YIVDqhks6B2w0f/29y/rlVmXouoCqMJVv1dgJGWVvU93kWhAtL9M7UZ2Ps
 ZAXAgbK4fi/qwFDmoY6SWIlxdKsgrNVi++BTxGKEcg1HDGn6r+TOj8ymXdpxfDbvmlOJ
 vsD147sA4Bpnxdng/ZPJcdJeK3mIdq91Je5Cmu99VrDCBvSStCel0IzvjPy2A8Z+J3LH
 dKre/OWLurQ9704jS3vQpmYfZNXJgKPveSipJbmOMwBBrVZpExf61cyJp4qLdm9dJ/n3
 aS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=vM5PJqD1hrPrPH7JYBKiGQs4swH5X3xQevLP2fWHg1k=;
 b=JcsNmFSUKxQjemlesnmUf58yWIGXFmGg/XCjaawhfGJuN445zj6cOQYEEieHX6Fb7a
 RI9MsSskHbSLrQJQKTZSCNRYEOGwCDdi12KzNEiQoEb88lO/HTblEy9XuF2oJka4xRWM
 VXp/Y02A3WEwnqTPVeR9Z3+q5Ff+AV4R/bT4jzxweS0F7viqUN37SJoTVsWaCBWev4wR
 +5PbNVXjVRCZqCfgJvHnIWArrnC/qLtVC84AjoFw7eo5zv4w2ZHq1Yc8JAZPSv8tH4rx
 UyMa8ogDARJ55hAgzXuNtIrSi/BpUPa5BrIZFCXcY0y5lv99AuMUsNfRyf23B+1O4zR3
 MvVw==
X-Gm-Message-State: APjAAAVWNa6KfiO1eIStB2WB0ZA6vIcYWcI2z1Gyjj8L1rVLaf2b/tcn
 yy3p/HpegrQR0ZNkQyVzVfs=
X-Google-Smtp-Source: APXvYqxlPqJFCTJGhf4RVvDznNQiwlL+bJQmukM9RsXbDdIPMMwfkdhnA6wo3UrabPB9wIBN3xZ4Xg==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr5295126wmk.124.1578507267785; 
 Wed, 08 Jan 2020 10:14:27 -0800 (PST)
Received: from x1w.redhat.com (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id l19sm2908653wmj.12.2020.01.08.10.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 10:14:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Igor Mammedov <imammedo@redhat.com>, Helge Deller <deller@gmx.de>,
 qemu-devel@nongnu.org, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 0/3] hw/hppa/machine: Do not limit the RAM to 3840MB
Date: Wed,  8 Jan 2020 19:14:22 +0100
Message-Id: <20200108181425.21485-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Following the discussion of Igor's patch "hppa: allow max
ram size upto 4Gb" [*], I tried to simplify the current
code so Igor's series doesn't change the CLI with this
machine.

Last patch is tagged RFC because it is odd to limit a machine
to 4095MB instead of 4G, but this is a current limitation of
SeaBIOS. This shouldn't be a concern if we could load a Linux
kernel directly.

https://www.mail-archive.com/qemu-devel@nongnu.org/msg667903.html

Philippe Mathieu-Daudé (3):
  hw/hppa/machine: Correctly check the firmware is in PDC range
  hw/hppa/machine: Do not limit the RAM to 3840MB
  hw/hppa/machine: Warn when using more than 4095MB of RAM

 hw/hppa/machine.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

-- 
2.21.1


