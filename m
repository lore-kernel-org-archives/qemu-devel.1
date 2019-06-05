Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33A9C28CC6
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A3320874
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cEOxIocZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A3320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45991 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYYkZ-0001ZN-PX
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 12:26:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hYYhG-0007MK-MH
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hYYhF-0008Po-Ld
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:23:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hYYhF-0008NB-Ch
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:23:29 -0400
Received: by mail-wr1-x441.google.com with SMTP id x17so2069643wrl.9
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 09:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=Y38jip49UqTT4QPJc9RRgFnCIMQVWbadJBR3Nk8NCyg=;
	b=cEOxIocZg6IDhvWRl0cmxsnn4Pu4rrmHgORt+8osNeiH8iq+Rzpo8fj0BZUu9MFz93
	yJrvz9sB2O9wlZ3cU1bq2xGvasr39d505Ytuqd1ehWSd+N8c2qqr/p4uXlmEvtOoj78J
	/kUB0oWLz7BGsy5A4dVJf3ggTHViUfLasxC0AfbZtZMpewz7eLJfRTFewzQZ+rC3GP/A
	cjgXPJ9UK2MFheqjXJW/bRl0SSHm9J1jWkUsf11hb7JYFc2pwWYWU+NPfU7VkS9YAof/
	wo09rm3gzlubghoSK5np0kFEgjKM6LvErT9b1SUA2/0JbXRdP0DLZHiQA7HB2LoMgFDS
	2pUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=Y38jip49UqTT4QPJc9RRgFnCIMQVWbadJBR3Nk8NCyg=;
	b=dsQaPbbiMHMj+z4rFCWwFys5OO287D+wT3gQjJLn5n84GOtoXGI2uyDVj+fl7GatDv
	HsybAc6ah7WBD6FktPls61oeGnV4hnxTUmzwmJvxt/hdbrj19SKlHGl1yrMNlIpVu9NK
	YtBusjBHoAvqDDY6qNSmGtN3CaeqKLJPRt142YrOqLkSzbUMUcl3wHHXDl2nPNJzPhlY
	h6NslfKr3+0lMAOlFlLp85I1iP3cxAosc1XRpi1ITfmK5YsqpKlIrqyZ0xrO8CCc0kpa
	2MI2Y+a3VM1Wifir4WacAco5cPWh7eYGWNbr7NxJ8f+6y7wWUQ/hvOLXP+ZFyXhbqvx/
	e5Qw==
X-Gm-Message-State: APjAAAXM/dbCG0gb/bAs7Ccx5nxuwmUFHdBNPGb6U1oleXLehotGO3XO
	eI+g9DgCvGePIHpCGuuTje4EHIlB1L4=
X-Google-Smtp-Source: APXvYqxpgWYJ/u4/eCiw4qJ/G+jGMDCdQSQja4g9eXcK6S4XwfOdgE7xTiIWlyU5pi21GkuNb0dk7Q==
X-Received: by 2002:adf:83c5:: with SMTP id 63mr12733816wre.33.1559751807577; 
	Wed, 05 Jun 2019 09:23:27 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	k184sm41400210wmk.0.2019.06.05.09.23.26
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 05 Jun 2019 09:23:27 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 9105B1FF87;
	Wed,  5 Jun 2019 17:23:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 17:23:22 +0100
Message-Id: <20190605162326.13896-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH  v1 0/4] softmmu de-macro fix with tests
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi,

So this is the fix for the cputlb de-macro along with some tweaks to
the testing. It turns out tests/memory would detect the failure of
running aarch64-on-armv7 but we glossed over the zeroed load because
the logic didn't account for multiple zeros in a row. While I was at
it I updated the system test code to include x86_64 so I could run the
memory tests on i386 machines. However it didn't show any additional
breakage so I think the breakage reported in:

  From: Andrew Randrianasulu <randrianasulu@gmail.com>
  To: qemu-devel@nongnu.org
  Date: Sat, 1 Jun 2019 06:03:23 +0300
  Subject: [Qemu-devel] "accel/tcg: demacro cputlb" break qemu-system-x86_64

is something else - I'm continuing to investigate this.

Alex Bennée (4):
  cputlb: use uint64_t for interim values for unaligned load
  tests/tcg: better detect truncated reads
  tests/tcg: clean-up VPATH/TESTS for i386
  tests/tcg/x86_64: add a PVHVM crt.o for x86_64 system tests

 accel/tcg/cputlb.c                     |   2 +-
 tests/tcg/i386/Makefile.softmmu-target |  10 +-
 tests/tcg/multiarch/system/memory.c    |  36 +++-
 tests/tcg/x86_64/system/boot.S         | 277 +++++++++++++++++++++++++
 tests/tcg/x86_64/system/kernel.ld      |  33 +++
 5 files changed, 345 insertions(+), 13 deletions(-)
 create mode 100644 tests/tcg/x86_64/system/boot.S
 create mode 100644 tests/tcg/x86_64/system/kernel.ld

-- 
2.20.1


