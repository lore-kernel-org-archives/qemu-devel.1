Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ADDC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 22:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C320921479
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 22:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvL+4maH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C320921479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42689 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSqRx-00037p-V4
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 18:08:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hSqQa-00024i-49
	for qemu-devel@nongnu.org; Mon, 20 May 2019 18:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hSqQZ-0007wH-6h
	for qemu-devel@nongnu.org; Mon, 20 May 2019 18:06:40 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hSqQY-0007vA-Uv; Mon, 20 May 2019 18:06:39 -0400
Received: by mail-wm1-x344.google.com with SMTP id 198so850380wme.3;
	Mon, 20 May 2019 15:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=KlpNHL/v/anaIc9onQH5hEjQJXL2cVxWwbCFEtiFDL4=;
	b=EvL+4maH6NdCRhulb/0UYtPdOYZZDaZfxAX2LslCQXT+V4ofkomGfZLd5AEEQnjpYD
	DEqp9hjJDSIFRtxGQbatIHi2BNpy86Fm/8W0FXxG/+gfMsTVPufWiu57w+mqJxZldSI+
	fbcEu+Ika0w8wDEmLey4bGh1C7vCMtP16Dy5hgviqJ/Y6P1iFf5MvyQGIgYPczwi3AYC
	wFHemrv4g9VZCrlYZU2BWwfvVnL6WwYDZNnzMzM+TBmB6pc3Qpee/5QAhFN7obXpCYFi
	T50kdg/lPFvxO/Piw6cUSj5LLwPrpQxutTo/aJZ+5jLS408ueJjrjLxvlr5g6ux5ZqPw
	YVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding;
	bh=KlpNHL/v/anaIc9onQH5hEjQJXL2cVxWwbCFEtiFDL4=;
	b=oev1PHXhnhjqRDSLOrh+pYIeeEcL6ASrRfeZTBtzwnCnTTqWgz/JD0bjlCPR2MyvjZ
	mgDE2PGaGpSNZckR+EldIyr71Zq/fesCeSZ8gSGmpJXC1LeEgwplp/mh8LFNBKW0TJ8a
	5nyDRbenwSNoZDagxIjYmubOfDWRw9xz0/AY1N1esijmgn9Dx+iLrnqf2qlrysRQKRQ/
	olZZMaIzfNipd0QN5+Hc0OqXeDcaZ+qS5tzQy7cj6gS6RvQJjB9DUtLJx+HEHNXo+oKQ
	ifUSNjrOaY2MFZuu7vTwWTau7AGqTpyBVCCCl/3d8ZLenPK9mMVDMjpmdRMEB9xmEl2U
	VGWg==
X-Gm-Message-State: APjAAAXB+S/9W0Z3Ru+ahxLRwcCirYbgUqpcMNConZdFChDvkROsZzu5
	3vETU/i3d8QGjGadT780xohmz0nwRds=
X-Google-Smtp-Source: APXvYqykrTAg3nxqmTY5YPctg2QIDAA/FezuZEcO4hVFDAB4sgi9RdDpCOvPkoL+bKi7NHhjmxeNzw==
X-Received: by 2002:a1c:9a83:: with SMTP id c125mr807121wme.39.1558389996959; 
	Mon, 20 May 2019 15:06:36 -0700 (PDT)
Received: from x1.local (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	y40sm35462259wrd.96.2019.05.20.15.06.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 15:06:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 00:06:33 +0200
Message-Id: <20190520220635.10961-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH 0/2] tests: Avocado-test for the SmartFusion2
 board
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Caio Carrara <ccarrara@redhat.com>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-arm@nongnu.org,
	Cleber Rosa <crosa@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I added test guide lines from Subbaraya Sundeep [*] to avoid this
board to bitrot.

Regards,

Phil.

[*] https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03810.html

Philippe Mathieu-Daudé (2):
  BootLinuxConsoleTest: Do not log empty lines
  BootLinuxConsoleTest: Test the SmartFusion2 board

 tests/acceptance/boot_linux_console.py | 33 ++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

-- 
2.19.1


