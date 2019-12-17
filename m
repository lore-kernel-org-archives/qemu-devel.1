Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E20C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0107620733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cj4L/hfr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0107620733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihHaa-0002SM-So
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 13:28:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ihHZI-00014D-MY
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:27:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ihHZG-0003XI-Kf
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:27:36 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40352)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ihHZG-0003X4-F2; Tue, 17 Dec 2019 13:27:34 -0500
Received: by mail-wr1-x441.google.com with SMTP id c14so12407099wrn.7;
 Tue, 17 Dec 2019 10:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sWACAQsf60rInZdjnYNJIzYNJovtyKvCUnze/9ZfBDg=;
 b=cj4L/hfrqJ1dS8TQp6lUfRYWKHFhndilaAQXzyv04YBZe5enQgyzB6HZEmOrFQmGeQ
 Eg/0khdTe2ZlrfqPZksbu3OYIs3mAE4030q6rabkxsBiYqvmnVni0ccEncTgmMR/dJ8d
 RhWX6CBaAdjXyyHLoI+p4ShOCNtA0j3pB6kqcrEuftcSv7CRDFKb2WE5nNnrQFI+WBgG
 5mKeJ0tllZx98t87/RmyZPneN/uMO/Dwn3j7c55MviZQb7bzzRIgFIBUXg9G43OasMlf
 PfBJBNzboHCB1R77wlrF+XT4JD/7EyETnthW3uCRPYkkokb5Ue7gb3sHj48TfticjB+z
 vg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=sWACAQsf60rInZdjnYNJIzYNJovtyKvCUnze/9ZfBDg=;
 b=uY0Tdyv6W876gz5wHs7w3KoVm10H04RqF2J6NA+JHzKMfF2FRGGjAvCc7Rx9Um5xpl
 VSfuyqxIoqBupDwfx3I1rydqgOyztflzra4VrMYSAZjr+yh5xOevy/l7lCiJlFzh+jIG
 UTOm1VQdnppiSRZkj55arlEDPV+OZR6HrB5fSMacZjkf1V30vwsQ4Tf74UszQ47RITI7
 M4Or3whgn6lqstqOIhCCNOpkCUo/jyhOJkZyn0Hk1LbZJ3JRdUuJHPZJeXg6wIZJmBwS
 IYpxpWxZIJULRHJWFVpW3Whl4lrE8siPq+N7hx+y8YkT/LL+b/DFpX/Y0vsTw+RWsj5F
 zrSA==
X-Gm-Message-State: APjAAAUSj4p61B4JpnsQaxat8ZqzFJW7inlHnYfgYdvggNkk6q/UlBPI
 5Eb9P1B8WrqF15r/pQ859vP3Tps3
X-Google-Smtp-Source: APXvYqwf8A894T4a5VQdrdHMhirdZXGVO1EmaZk0q3fDn66iJ1I3ycbS8qjdyh5PRD0Bq+edlC4tNQ==
X-Received: by 2002:a5d:6ac5:: with SMTP id u5mr2863265wrw.271.1576607252684; 
 Tue, 17 Dec 2019 10:27:32 -0800 (PST)
Received: from x1w.redhat.com (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id u18sm26006975wrt.26.2019.12.17.10.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 10:27:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] tests/boot_linux_console: Add various OrangePi PC tests
Date: Tue, 17 Dec 2019 19:27:25 +0100
Message-Id: <20191217182730.943-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series collect the examples given by Niek on:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg665532.html

Based-on: <20191216233519.29030-1-nieklinnenbank@gmail.com>

Philippe Mathieu-Daudé (5):
  tests/boot_linux_console: Add a quick test for the OrangePi PC board
  tests/boot_linux_console: Add initrd test for the Orange Pi PC board
  tests/boot_linux_console: Add a SD card test for the OrangePi PC board
  !fixup "hw: arm: add Xunlong Orange Pi PC machine"
  tests/boot_linux_console: Add a SLOW test booting Ubuntu on OrangePi
    PC

 hw/arm/orangepi.c                      |   1 +
 tests/acceptance/boot_linux_console.py | 150 +++++++++++++++++++++++++
 2 files changed, 151 insertions(+)

-- 
2.21.0


