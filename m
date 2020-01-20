Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51DDC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:53:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F0D4206A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atWe3LhF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0D4206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itgra-0002Sv-AP
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 18:53:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgpz-0000mz-FG
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:52:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgpw-0007WJ-0f
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:52:07 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54519)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgpv-0007W2-RL; Mon, 20 Jan 2020 18:52:03 -0500
Received: by mail-wm1-x342.google.com with SMTP id b19so1110941wmj.4;
 Mon, 20 Jan 2020 15:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7HJThwEvYD1FmZ5poiATpwK/QswiQTPe2ZhfsOHLU3E=;
 b=atWe3LhFpvT4TIJY1YNvk8I9Sp3errVuvkaRyo2H+R3x8PzVnjM3pmS7Jb/p/6kE0j
 mJVxfLbir7gz1ldEuzrr//3ppdcrgdHm/X1Ru9d3Qwqf+h5yanbfIimNNSJQzJj1Y256
 2qDojxa+8ZcCpXrk8zN0cxjABD9JNuApo12zXxY2b8QlVAhBe/VeM9+w2GDvyUbnZx+1
 Q8iB6EFem8GQpQArDtHBmBlL+5EAZWQEDlzCWulZAIF5m3AYZ9xQXnkS7ykgUbPDtCfc
 XGxRuRdWVv4Jj1kCwEGG0BxCG5YnM8bITm1Oeg7A0rEBBwUq4MM3Xt2JrbtkaXK02GxR
 N1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=7HJThwEvYD1FmZ5poiATpwK/QswiQTPe2ZhfsOHLU3E=;
 b=kLD/QinjO7jCUnZeL71WYwWDPaA408wcfGmeQyodyakDkqI3n2KMlDjGav5HfDvyZq
 T95YDpqbnwyuUCz/IYXwc2Fzo+w+SRjYRQbShh4nhypG8VGLDBCFkCre55D0C3MC1cu4
 tdYfkXCAC+N+JdEitmytg+7QsCEzarZvczhaxu8cif4MLAEOcK3oTPBCVpTXjh6IJnKe
 es/c2x0RRUXoF0+prQUd0Y/KsPfGVlF9lLFO9O831Q2munu07v8vLjmo6phVUhNSxSfX
 wyzS4nWVbtPWcj35RJlxtx6OOaApkjG6KotSZe7jSrgI7fhGLtCm2Fs1MN7reeBMLUIr
 P2Ow==
X-Gm-Message-State: APjAAAX82FPCeh1AcEqMUep2O8pfuwCMPyviq4R9ZO6viUhPWxJsdNRI
 yn8ios3c/hMFIG1QsbZ3cjM23kDX
X-Google-Smtp-Source: APXvYqxYVPbS6I+f6B5nkZuktF+yq4fQ06n1ZdtaFdcgu3QjGjKFm5jVIg5mnAjvN5fpPHLqW0jX7Q==
X-Received: by 2002:a1c:6588:: with SMTP id z130mr1213272wmb.0.1579564322403; 
 Mon, 20 Jan 2020 15:52:02 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id d8sm48655269wrx.71.2020.01.20.15.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 15:52:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/7] hw/arm/raspi: Run U-Boot on the raspi machines
Date: Tue, 21 Jan 2020 00:51:52 +0100
Message-Id: <20200120235159.18510-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Following Laurent report:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg639950.html

The SYS_timer is already merged, see:
https://git.qemu.org/?p=qemu.git;a=commit;h=d05be883fc
"hw/timer/bcm2835: Add the BCM2835 SYS_timer"

The first patch should fix Laurent other issue.
Then few python patches are require to break into U-Boot console,
and the last patches add U-Boot tests for Raspi2 and Raspi3.

Laurent, if you successfully test U-Boot with this patchset again,
do you mind replying with a "Tested-by:" tag?

Regards,

Phil.

Since v3:
- rewrote '-smp' fix.
- tests use Debian 'trustable' u-boot.elf

previous feedbacks from Peter on v3:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg655415.html

v3: https://www.mail-archive.com/qemu-devel@nongnu.org/msg653807.html
Supersedes: <20191019234715.25750-1-f4bug@amsat.org>

Philippe Mathieu-Daudé (7):
  hw/arm/raspi: Remove obsolete use of -smp to set the soc
    'enabled-cpus'
  Acceptance tests: Extract _console_interaction()
  Acceptance tests: Add interrupt_interactive_console_until_pattern()
  python/qemu/machine: Allow to use other serial consoles than default
  tests/boot_linux_console: Test booting U-Boot on the Raspberry Pi 2
  tests/boot_linux_console: Test booting U-Boot on the Raspberry Pi 3
  tests/boot_linux_console: Tag Emcraft Smartfusion2 as running 'u-boot'

 hw/arm/raspi.c                            |  2 -
 python/qemu/machine.py                    |  9 +++-
 tests/acceptance/avocado_qemu/__init__.py | 59 +++++++++++++++++------
 tests/acceptance/boot_linux_console.py    | 54 +++++++++++++++++++++
 4 files changed, 107 insertions(+), 17 deletions(-)

-- 
2.21.1


