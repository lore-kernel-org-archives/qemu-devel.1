Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5F3C33CB7
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 23:25:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C89A20663
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 23:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azCJRsxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C89A20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixffL-00061F-9h
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 18:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixfeT-0005Bo-MX
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 18:24:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixfeS-0008W7-Kt
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 18:24:41 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33575)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixfeS-0008UO-F3; Fri, 31 Jan 2020 18:24:40 -0500
Received: by mail-wm1-x343.google.com with SMTP id m10so9870983wmc.0;
 Fri, 31 Jan 2020 15:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PdPa7rRqpFIG356Bcv+JT8SG6O9NZ8A7i8enSnTCO9g=;
 b=azCJRsxaRRs9aJsqU2l3usJtfQje6uHXTSQ8F7Cle6EyOG9vG+m8VJXbbJsJfPuWgM
 ywS/DpdFXkhW6tv6jhs56y+JVpM/SiYmWXx70biADK+mc/6jhjFDDmzuqx6MNUsY2+GW
 hUVs0iVESIAl8vzzRDYm70YnnmvQvujaQQ1rMQcs/T/OHGjMl72Oygp0ZsEH3BRQFYZX
 RnarQvuboYXwXyJulb0hytehzqct8sSgov3khGkJ4A0ZUGWNa9UH0AMZrtNW6sw1UQYe
 MuY8FMEOuLi/1W647Ry8iKIdX6gWddoIP3mgkMVbnc9VMqbCbtAEI6PsqQrAeGPc0jOc
 hwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=PdPa7rRqpFIG356Bcv+JT8SG6O9NZ8A7i8enSnTCO9g=;
 b=XNg7cRfn/6U+ATLEQwtiUAKAwDz+cDVBCPCf+LOFLSnq3BMWxKKbKzbF0wpi+fMRRW
 w+61whdZjHX1VyrOMI12A4Gz3i5re2GLglw5ImwTo8+xO9oTECQI+cA+IpOm4iaR2SKN
 juoNfwZCch6jFn50Pg+LDZV8VLKFE0KN3mCd1LeD9t0/TAGxnVjfUuqNdEZiurIDWywg
 gEGHrBlS1xbapN135Lcg2iwoUYB6ebq1D5e4da7Y3/xCtLo0BsfMueaZphCb0KeA6nCK
 B2Yl9FtsQXVTcTlhx1rmQRR2zLeEqp5aFJbIrlqapZR4TaNFs5dLjkNkHJ96DqAqUvIw
 YyFg==
X-Gm-Message-State: APjAAAXqxCXKYCrvqegCMze0duHuYoBBtGiDWCvxn/c1wKfabpv0F9Fx
 +gNt2V19wvN1k4Y5ECHn37GnjVGf
X-Google-Smtp-Source: APXvYqwKyDh4mKqYL7wIShwAODhu+R1p3KHhh5jiD+k/eGJZOCzRaNndf50pJa7Jfoe28o1mepe9MQ==
X-Received: by 2002:a7b:cf01:: with SMTP id l1mr14230696wmg.86.1580513078976; 
 Fri, 31 Jan 2020 15:24:38 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id c74sm9265172wmd.26.2020.01.31.15.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2020 15:24:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/1] tests/acceptance: Count Raspberry Pi logos displayed on
 framebuffer
Date: Sat,  1 Feb 2020 00:24:35 +0100
Message-Id: <20200131232436.23548-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a simple Avocado test that use OpenCV to find the
4 Raspberry Pi logo on the framebuffer screen dump.

The resulting match can be visualised at:
https://pasteboard.co/ISzNHtx.png

It is very fast, around 11 seconds on my laptop.

The test probably won't stay in boot_linux_console.py but will
go into tests/acceptance/machine_arm_raspi.py, but I wanted to
show this test could work to test SMP CPUs.

Similar test: "integratorcp: Verify Tux is displayed on framebuffer"
https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg08103.html

Philippe Mathieu-Daudé (1):
  tests/acceptance: Count Raspberry Pi logos displayed on framebuffer

 tests/acceptance/boot_linux_console.py | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

-- 
2.21.1


