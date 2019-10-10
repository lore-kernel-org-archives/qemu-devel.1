Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E13C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:47:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E20B72067B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSmwd/oK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20B72067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXqV-0008Pu-Kb
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iIXRm-0000HV-Px
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iIXRl-0005g6-Kw
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:21:34 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:52501)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iIXRl-0005fJ-DC
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:21:33 -0400
Received: by mail-wm1-x32d.google.com with SMTP id r19so6714296wmh.2
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 05:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FLB6qStTaqTyx6FlLrnb5V4WtUte/BoT07QLcwG8btA=;
 b=DSmwd/oKiuVjqnIaV3eIL+wV788Gdl7W0mWhfy//CGpD7N845C1tukPpVINYWq9dbi
 uaq8I6We7+oyFsFSga78Etq4I8NUGsUCRvc+H14EpgqKb57NGRfB4Xda3W4SesjoSCcS
 Zbf2lPStQJP3i18IBNaJOAXArLMPYUi+b5OozGK6V7E3YPONfKP+NXVXVwGQOosEW901
 Jy90F+0APxnSuOWad5nQnsBXi4EnyVXXELOeC7AzkUw7a35dbXenEfp9daPzqkCon8Hd
 L8u9x0QoOxAOMuw9Z0uh14sAnPSWoi+i0+0Vumc0bwDFqUtneJlUvmaAhkpno5eGIbjK
 L42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=FLB6qStTaqTyx6FlLrnb5V4WtUte/BoT07QLcwG8btA=;
 b=adkinTj6hRXr7Yl7o0+szkQ+9Mw8zYcbLoOOKo0rrVh3Y3ZgglTsmAif6NUBmvB/Y4
 XOW9UDwwzlhnKqXW04p5ySGUlBAALHFZ0Hbw/5HVIVO8esiHFHayRLTKapmQPnIPMMwb
 e1eA7rtGVvp84zFuYy0t6V8JWNH6xqnGMSXszMGx2zHyRusK3KiWfrV7SEhaIx7QcAJk
 KHA1i9Wc59Zi87ts1ktJsL3jOmcW5dBrkEMjgIbjlu5kDL5fXRjOe6iqYyDUjP68qSvt
 D5ipURSXXVjBW21S4XcLHZvpu7PZWm4CXK9hSR93PhxnOyqWfNzNAAaorHhOsGgHL5g/
 b4CA==
X-Gm-Message-State: APjAAAWArTPKVjSHEix9XMu3+IsF1UyA4vHyDCXbPg43Xt77HfTQrsHq
 bvlXgsfmhufd1h+DVS+cDbvpgHzp0r0=
X-Google-Smtp-Source: APXvYqzOEMTpxhR7pG2tSyksLDaWlY+lMoNhHEoGQjf+Vnh/h12uxqyzhEI5eYFHDdIAydJ9egevGA==
X-Received: by 2002:a1c:f714:: with SMTP id v20mr7684893wmh.55.1570710091432; 
 Thu, 10 Oct 2019 05:21:31 -0700 (PDT)
Received: from x1w.redhat.com (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id o4sm12413169wre.91.2019.10.10.05.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2019 05:21:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] tests/acceptance: Add tests for the PA-RISC machine
Date: Thu, 10 Oct 2019 14:21:26 +0200
Message-Id: <20191010122128.29000-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>, Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This tests boot a HP-UX firmware CD-ROM which allow serial
console interaction. This exercise the PCI LSI53C895A SCSI
controller.

I'm not adding it to the Travis-CI list because I'm not sure
how to split/rename the current job, see:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg644753.html

Philippe Mathieu-Daudé (2):
  tests/boot_console: Send <carriage return> on serial lines
  tests/boot_console: Test booting HP-UX firmware upgrade

 tests/acceptance/boot_linux_console.py | 27 +++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

-- 
2.21.0


