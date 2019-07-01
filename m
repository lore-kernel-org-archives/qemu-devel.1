Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBAFC5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47CD321479
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCi/s/xt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47CD321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhyRs-0003is-8f
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 11:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41198)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hhyKU-0000Qz-6S
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hhyKL-0003YR-M6
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:34:50 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38496)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hhyKJ-0003Vk-QO
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:34:43 -0400
Received: by mail-wm1-x344.google.com with SMTP id s15so16436276wmj.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 08:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=snEFNM+BLWpdwzbmTboes9ya75EUHOawAqCk8aLHVko=;
 b=qCi/s/xts7iFbsGVv5pcy9n1+EAS+ne51JRya+wGJBCj7M9pfqwM0kmEjNuav9pQAX
 1fkUMPhKZcezs4Q6bz8PKpmmqf/pF/jbqyjgkATX/FMpDeryHz5XgxV3pdrXM9GOmdPF
 tLcKrqRzWt0GuuhajDke8pspOlTos5pTQz0jdykk0+niFOpVh9hVrIGde8+SE1fRmb0t
 oXregZxR8EytMVAejQwidTenxm7B48tNHG1DJSPuSpchnS3TFs5vgINxsG6cxToeQf8G
 ans3F06RRrcaZVtT2xRDwoxk7dw5BJHQOaObS1DkU6yTLSxZOCHqYIi7JW0WY3uOwYgq
 fjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=snEFNM+BLWpdwzbmTboes9ya75EUHOawAqCk8aLHVko=;
 b=uHEwi5UpL3lVJCnnk/6UhclOnRGZHTWhrTDLJtjJbEHuaEpEbK9SGZ5Wgu7xXOnr/S
 aenV9Me4aZaYLBxj5ZvCy6tX4gC5Aa2V7gG9P4CKWCzzz3S56hChQ0A0SIViuMjldu7P
 vWXO/DNlPbQwPwZaKxGO3lf9r+WkJX+ziSVJ2fCudvNEtc5GTSioG1h8wvGPpm7/5rlQ
 i6UL6c00svnGxFsaMbG3qUyOIYNFsU/XO69yTmGnou84evQnZDElI0JXNKFkw1OREwED
 yGSB1cOyO2W4OVXRFobXIwbVY2L8mu4B//t/1FtgZD2sDGPo1UJI0PMpXZ0cYpdxB9SD
 4PQg==
X-Gm-Message-State: APjAAAUFT897eTsHj5FpLABxRZm2PG5vsdYzUGn4603vukNkGgF9/6vj
 r3vAAz1oc3cEa8MX6NqYQNe1C3dV
X-Google-Smtp-Source: APXvYqzb8UyBgq4MhfSWz6f2m8L2bW8CxZHkRhoc5AanJjkI4jTE5N39kEuHbflGjOYiRfsdue+OVw==
X-Received: by 2002:a1c:9dc5:: with SMTP id g188mr18222223wme.93.1561995279325; 
 Mon, 01 Jul 2019 08:34:39 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id w24sm8922341wmc.30.2019.07.01.08.34.37
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 08:34:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:34:34 +0200
Message-Id: <20190701153436.16579-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v2 0/2] tests/acceptance: Add test of NeXTcube
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

Since v1: https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06514.html
- use the English dictionary (Thomas)
- support tesseract v3 and v4 (much better results with v4, but not
  all distros provide it)
- add a test of the framebuffer width/height

Regards,

Phil.

Based-on: 20190628181536.13729-1-huth@tuxfamily.org
[*] "m68k: Add basic support for the NeXTcube machine"
https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06393.html

Philippe Mathieu-Daudé (2):
  tests/acceptance: Add test of NeXTcube framebuffer using OCR
  .travis.yml: Let the avocado job run the NeXTcube tests

 .travis.yml                               |   7 +-
 tests/acceptance/machine_m68k_nextcube.py | 102 ++++++++++++++++++++++
 2 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 tests/acceptance/machine_m68k_nextcube.py

-- 
2.19.1


