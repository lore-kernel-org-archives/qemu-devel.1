Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A05C4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 15:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E70A5208E3
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 15:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvusHxAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70A5208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhEsq-0004iT-U3
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 11:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37885)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hhEqh-000377-Bb
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 11:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hhEqe-0007ER-Vn
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 11:01:06 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54128)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hhEqb-00079v-6H
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 11:01:02 -0400
Received: by mail-wm1-x344.google.com with SMTP id x15so11773163wmj.3
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 08:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ndCd+LsRS0Kv5W+G0EOTMeaDz1a1Vb9khCvSnJZc3eI=;
 b=BvusHxAY8kVk0Llt4A0tRM0lqTx7ZQS89VPqr6z37Z69tJWsb/xQr6lzUrPv0BkiNo
 KyRUPXdX2UeFOIS++cfddN1G/JZ5znFyMLst2L5r2AXLOk6pAGtJkjdpMDU0vWJMndjM
 bQGb0V0Dem9+h42vdhWV+jmsstumV4nJkhcQX6S4xZEQBzEs8ByH2OlkhNLX7sRm13Cc
 66BP2ZrPK2JzjZzHjYxd8vHc1gaCxzT7keBZRYQ+VbkGYmlbtnVvrn7B1CIvT9H/JbU3
 ChrWnOUgZWi5tLVk9taCw3gZSoz+y2ATLMGkHOn6S28qooEkMkb1zoShpl2WoBMVZ++s
 XJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=ndCd+LsRS0Kv5W+G0EOTMeaDz1a1Vb9khCvSnJZc3eI=;
 b=NVPHa6UzP3xen6PF7N1ryBsmCO4EV/u9xJmeLfFXNH97R3rircMIX2W1QeSjxzFvGQ
 zpCr3Jf9zUYME8D2fe0KKEN098yVkIYJBSsPjEv2Qpyromoda1ZwUczLVA2KZNdQIpNf
 iZISJJVAKypnMVG+dcGnzQ4mytIXYPtxJDQY90uChj78fgDYgYAOrPrG1iXEG12CAKpv
 YH/PTaHLFq4Y9O475GahWNsAQmU0Dcrhb/O2L8PgHMq0Yxd4oU+QlfG26lbhDk/tPHat
 Qq022YHf8/y/kIdpgA7QmnRnXO8P/CoVp9qaFyEJAW6oYH3X5/Sgtvp8vubg0Oxby9XW
 aAYA==
X-Gm-Message-State: APjAAAXN4bgRRkOzde55N7W6GE8hS+G6RXG8ihb/FTSSkaPu6vHIj0Ki
 iBP1o807uFghxZR2ol7F9DQ6DCo6
X-Google-Smtp-Source: APXvYqycByJRMMNsPq0/W3aSNy4Aa1QOs8mMkQC8zoBO3LVUmF2c7+ApFWFRe+6WT3lK7lYOM1k8dg==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr10583901wmj.71.1561820458650; 
 Sat, 29 Jun 2019 08:00:58 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id h19sm5146231wrb.81.2019.06.29.08.00.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 29 Jun 2019 08:00:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Sat, 29 Jun 2019 17:00:54 +0200
Message-Id: <20190629150056.9071-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH 0/2] tests/acceptance: Add test of NeXTcube
 framebuffer using OCR
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I was looking at Thomas' last series [*] where he adds the
NeXTcube machine, thinking about enforcing a new rule "new
machines must have tests". Then I realized the UART is not
yet implemented, so our current sample tests are not helpful.

Since the framebuffer is working, I gave a try at dumping the
screen content via the HMP 'screendump' command, then parsing
the screenshot with an OCR tool.

The default ROM dump the bootlog to a console. Using the old
good tesseract tool we can recover some useful words to be
sure the guest is sane, its framebuffer is definitively working.

This test takes less than 6s on Travis-CI:
https://travis-ci.org/philmd/qemu/builds/552174983#L1836

   AVOCADO tests/acceptance
 (3/9) /home/travis/build/philmd/qemu/tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.test_bootrom_framebuffer:  PASS (5.69 s)

Regards,

Phil.

Based-on: 20190628181536.13729-1-huth@tuxfamily.org
[*] "m68k: Add basic support for the NeXTcube machine"
https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06393.html

Philippe Mathieu-Daudé (2):
  tests/acceptance: Add test of NeXTcube framebuffer using OCR
  .travis.yml: Let the avocado job run the NeXTcube tests

 .travis.yml                               |  5 ++-
 tests/acceptance/machine_m68k_nextcube.py | 50 +++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100644 tests/acceptance/machine_m68k_nextcube.py

-- 
2.19.1


