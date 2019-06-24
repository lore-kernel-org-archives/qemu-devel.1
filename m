Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B156C4646B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CEF620665
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="darZu4FQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CEF620665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54882 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfX5p-00017F-KE
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 18:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54650)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX1K-0007jG-DU
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX1J-00030m-AU
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:02 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37239)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX1J-0002yh-15
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:01 -0400
Received: by mail-wm1-x341.google.com with SMTP id f17so828318wme.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 15:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nHGLqkOCCfwnOBcAXK8lFj2re9D2oLI/1860n8gHfz0=;
 b=darZu4FQF06yq54EvPT12DTWunPyeNFxsUvEzP2R+KQjlBKHAV45FpLrLkl+8CCo8B
 4K+UFzNZjLaAJYIJFAnP2smKaSEyNC6Ie7fbVfdabaqvRUUFXkrAHQzdJZhjG4T9WwEb
 60qnxJFXf7ujAl+0VYyZUFusTc9iDL1AoHbsDKyKg4OliVYW6SXnTycYSwY7CdgOMIfl
 XjjKUbIcd/wqOBsJf8HViDuQdFeFyre1EeXMTSun2Ylh8Lol5f51A5uCgOfJt0+yNRa6
 aI7trXwlfeZ63W9tef+yZm2nsIMQ1ogA3YxmFOo7TXPXGXAhbjP66qYbDvWlZD7IvD6c
 IAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=nHGLqkOCCfwnOBcAXK8lFj2re9D2oLI/1860n8gHfz0=;
 b=Ub0eEUea+JM8tnQf+EhV1HqaQ0kMrdXBBtC6hdfHjeciLpfaHpPL5ptrS4cMyPdYSn
 c5+kKsteaNw3ZHOBjhhtN42r6hRD6jyxB+kbm8YKtH5iMU/wuUCGgVDOg1JyBgshcg6w
 +iex2FRGnwpVwiexcHgh0yrwZ6gEIK6DruvcdkpWPazFS7kXBkzeszVxnXzdxIFc6EAd
 aLpLGM5yjyngUYDdg0dXyNN8KoF8IRqVLeolk+HR7Bwn6uA/js5lctq3nQXp+4TRTZH0
 YtMtl+5mI2XkPIawFxVNOuE+5HVjWqSsE4efyU1UvqIJZZZi/cH2VW1Ruz3FeQa7bYOk
 bUHQ==
X-Gm-Message-State: APjAAAXvyMiVx+ixt9sp2Un1xa58WM4SRBofcoZSCsWs/BEgGlGJwYd4
 Mpz3ekae+Dhwj1ZsLUw0WUPiEy2j
X-Google-Smtp-Source: APXvYqxzdtUm+i2/11MDN4MBQPw7QqpBtDUmAtm8SMvTPrSb23vLPO19J+9+48ly2Neltt+oylt2/A==
X-Received: by 2002:a1c:1947:: with SMTP id 68mr16733799wmz.165.1561413658642; 
 Mon, 24 Jun 2019 15:00:58 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id z126sm1118612wmb.32.2019.06.24.15.00.57
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 15:00:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 00:00:47 +0200
Message-Id: <20190624220056.25861-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH 0/9] hw/misc: Clean the empty_slot device
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
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, this is another clean-up series, paving the road for a later
series touching the GT64120 north bridge.

It makes the EMPTY_SLOT more in shape with the UNIMPLEMENTED_DEVICE,
and slighly more powerful (allowing overlapping, trace events).

Previous discussions with Artyom and Peter:

- https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00235.html
  'TYPE_EMPTY_SLOT is not UNIMPLEMENTED_DEVICE'

- https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00336.html
  '"no bus errors when this range is touched" behaviour'

- https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00292.html
  'background region with the "RAZ/WI" behaviour'

Regards,

Phil.

Philippe Mathieu-Daudé (9):
  hw/misc: Move the 'empty_slot' device to hw/misc/
  MAINTAINERS: Add the 'empty_slot' device with the 'unimp' one
  hw/misc/empty_slot: Allow overide by device with higher priority
  hw/misc/empty_slot: Add a qdev property 'size'
  hw/misc/empty_slot: Add a qdev property 'name'
  hw/misc/empty_slot: Convert debug printf()s to trace events
  hw/sparc/sun4m: Mark some devices as 'unimplemented'
  hw/sparc/sun4m: Simplify the RAM creation
  hw/misc/empty_slot: Pass the slot name as argument

 include/hw/empty_slot.h        |   7 ---
 include/hw/misc/empty_slot.h   |  33 +++++++++++
 hw/mips/mips_malta.c           |   4 +-
 hw/{core => misc}/empty_slot.c |  65 ++++++++++++--------
 hw/sparc/sun4m.c               | 105 ++++++++-------------------------
 MAINTAINERS                    |   4 +-
 hw/core/Makefile.objs          |   1 -
 hw/misc/Makefile.objs          |   1 +
 hw/misc/trace-events           |   4 ++
 9 files changed, 108 insertions(+), 116 deletions(-)
 delete mode 100644 include/hw/empty_slot.h
 create mode 100644 include/hw/misc/empty_slot.h
 rename hw/{core => misc}/empty_slot.c (57%)

-- 
2.19.1


