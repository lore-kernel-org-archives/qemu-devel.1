Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7224EC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B12821479
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uP7wQTNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B12821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43709 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrqQ-0004S1-FZ
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:37:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hSrYu-0005nx-D5
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hSrYs-0004uz-H4
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:19:20 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:52817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hSrYr-0004od-Pj
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:19:18 -0400
Received: by mail-wm1-x334.google.com with SMTP id y3so966355wmm.2
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=U86jkrXSzoeHhxFyjGyJ6CPcLdHGVNeQyPL1R7O7p60=;
	b=uP7wQTNZOThtZFuW6arMWl1vlGRctITjrhrUB22USQa10AlGNFQRzezGfPRmbYF8r+
	ztSsdx9xgwnhHcf+l+W9+ioIyzNL42ziGvipWtH4hopjtTfc2KISBGwfGm2WRzoeB14Z
	e4qjxkz/u764TrNN3UQnP0L1gXURNASXcQDqxfOhMkjwCCvIS5DTuju+R1+eYPDq7B/h
	66g70nRM1rAhSsmi86dgMxXm/p1+MUwmP8jKnnCRvPPprxh6aGSFgsVsml8nTWbMreUx
	kzX1M5tW07JbG4uJvrigeBMxZxXxHeAKMvUo5pwxigVGGVNt3YXyWQ7QutcM9Rvcv3Zk
	lH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding;
	bh=U86jkrXSzoeHhxFyjGyJ6CPcLdHGVNeQyPL1R7O7p60=;
	b=Ja7WsiMvpjC4wuH8Y9UylA0dspVj1ZQa+gzY0qnzqdrFiqYMjFGUEx10YbcVIbZU4z
	FE0LfAQSAagwP9GiU7ygFtKx7EjFomj30lAWs/uwnIxUCwazIET3dGdc+SOjUv2B+ocO
	CWzT/QmzP6zvNyk7hqi35OEcuLdV3ifRrZ2x7YOSQLUK2HJHYyfyrIk9hthztKy/tbZ3
	kMXh2rY5nu5LHK5AyOkp67suK2kwelCt5KfMVC4xyMlClNzypOFKwPozmQYq6iPgTZhb
	AGVeL+2ErYcTQajWx4U7aFZ6Rtw5PdcldtMy/CPUPrz8b8cWAHJWILUN+X49XGSjhjBB
	ZYmQ==
X-Gm-Message-State: APjAAAWiLd+uZ4hbzlM0vi2Pt5sdoPlXEK62xHl2cNwRBglj/Tp0ZE90
	OvxbKRKeC5sbCh7B8gp/sIKl+L8Dc4U=
X-Google-Smtp-Source: APXvYqyA7L/xIO3ISf/id51cjG8RjxF/iWbqd8eRe2AIvw1zhacWqNnCxwPFoinzk8vVCjK1k2S95g==
X-Received: by 2002:a1c:4145:: with SMTP id o66mr971646wma.68.1558394352426;
	Mon, 20 May 2019 16:19:12 -0700 (PDT)
Received: from x1.local (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	b10sm44261849wrh.59.2019.05.20.16.19.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 16:19:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 01:19:06 +0200
Message-Id: <20190520231910.12184-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::334
Subject: [Qemu-devel] [PATCH 0/4] mips: Add more Avocado tests
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Caio Carrara <ccarrara@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Cleber Rosa <crosa@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

It was a rainy week-end here, so I invested it to automatize some
of my MIPS tests.

The BootLinuxSshTest is not Global warming friendly, it is not
meant to run on a CI system but rather on a workstation previous
to post a pull request.
It can surely be improved, but it is a good starting point.

Regards,

Phil.

Philippe Mathieu-Daudé (4):
  BootLinuxConsoleTest: Let extract_from_deb handle various compressions
  BootLinuxConsoleTest: Test nanoMIPS kernels on the I7200 CPU
  BootLinuxConsoleTest: Run kerneltests BusyBox on Malta
  BootLinuxSshTest: Test some userspace commands on Malta

 MAINTAINERS                              |   1 +
 tests/acceptance/boot_linux_console.py   | 112 ++++++++++-
 tests/acceptance/linux_ssh_mips_malta.py | 229 +++++++++++++++++++++++
 tests/requirements.txt                   |   1 +
 4 files changed, 341 insertions(+), 2 deletions(-)
 create mode 100644 tests/acceptance/linux_ssh_mips_malta.py

-- 
2.19.1


