Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750C9C43140
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 15:53:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F454218AC
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 15:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F454218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6d28-0001XC-IU
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 11:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <th.huth@gmail.com>) id 1i6cwR-0003lH-7m
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 11:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1i6cwQ-0007jf-2k
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 11:47:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38809)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1i6cwP-0007ir-Re
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 11:47:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id l11so9467964wrx.5
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 08:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lJY2KX4dMiks0ukBNUE6RTXhKVBOuRehxmM8BttWJBg=;
 b=Xr7vKUiWvoIcHWMVjkuw2jeFnEkdCFDf1RNdewAOnDOy+h335958bKhVfOluEAACcb
 nxriXx+4enx8YfQAVG4K/y7WIw/dumdzjYtRPoEXcjf/PYJYcEZY/NL4lqDIYbdfYk7H
 +rc3bmi2X8LHi/33L81RRCI/e04RC3dsq4IyT2d52gohbACDhk7Hdid0JL77zYvo0IJ3
 UrM80Wf1lsAUrzzDuNm0X/RXeCFY7dpubXBPTPdbMMd5Rj3ITui2fjzB1qY6lGXwaY+A
 rkFc4t1LE3ws2eL48H1yjjhar6k1Jv+NQsCalqRQ+bPW3CY6xrRKGvCvY1dcJmcacMrS
 Smdw==
X-Gm-Message-State: APjAAAVIaPeNehwOFUpYiWYXwxUZ+IzfDNxpqnfYsIIY4WB2PPnP3m5i
 FvaJoQsYBVcS+q0pC/fuK/8=
X-Google-Smtp-Source: APXvYqwVw07TpKPlsWR6f48IID8eUztL+pz/qJjFKfmBGzjOO7+RR+PyBroJehFiK30PTyB7+os0+w==
X-Received: by 2002:a05:6000:11cb:: with SMTP id
 i11mr11928200wrx.171.1567871276993; 
 Sat, 07 Sep 2019 08:47:56 -0700 (PDT)
Received: from thl530.multi.box (pD9E8385F.dip0.t-ipconnect.de.
 [217.232.56.95])
 by smtp.gmail.com with ESMTPSA id s19sm17173418wrb.14.2019.09.07.08.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2019 08:47:56 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Sat,  7 Sep 2019 17:47:42 +0200
Message-Id: <20190907154744.4136-7-huth@tuxfamily.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190907154744.4136-1-huth@tuxfamily.org>
References: <20190907154744.4136-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: [Qemu-devel] [PULL 6/8] m68k: Add an entry for the NeXTcube machine
 to the MAINTAINERS file
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I don't have much clue about the NeXT hardware, but at least I know now
the source files a little bit, so I volunteer to pick up patches and send
PULL requests for them until someone else with more knowledge steps up
to do this job instead.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190831074519.32613-7-huth@tuxfamily.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 65d8a7c2d2..50eaf005f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -910,6 +910,13 @@ F: hw/char/mcf_uart.c
 F: hw/net/mcf_fec.c
 F: include/hw/m68k/mcf*.h
 
+NeXTcube
+M: Thomas Huth <huth@tuxfamily.org>
+S: Odd Fixes
+F: hw/m68k/next-*.c
+F: hw/display/next-fb.c
+F: include/hw/m68k/next-cube.h
+
 MicroBlaze Machines
 -------------------
 petalogix_s3adsp1800
-- 
2.21.0


