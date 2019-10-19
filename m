Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE5FCA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 602E02082C
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZYoQVI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602E02082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLqmZ-0006hA-Bc
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqkc-00055N-76
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqkb-0002p5-2p
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:42 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:35124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqka-0002oq-Tb
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:41 -0400
Received: by mail-wm1-x336.google.com with SMTP id 14so2102613wmu.0
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 08:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZBjvq5Gq6WI0VhQ4eujUzv4jptL5JIN6BLkKWa/bFf8=;
 b=aZYoQVI16zjX4i8IRxZSdk/v/6S6IdX7FvIh8r3miChbImCXSoitQj6NiYGxQOkTLx
 BJJDtqYXUAJrT7wvTME1MRKtjutweqcX9xlSq39tae3JLCIHS5pExFyqYdXjq+0KOIwH
 3wO3TR18TYT+dZ35bAXTZsWkg9BWN307GA0+bW8H4so2Kshf8NmHzllNr89BYpt5UOt5
 llnkC1qUslkmbBf97hCPyYwoaNof9FYl2P4RqiYbrL+3LYDr/UCPF4b5ivOyTn4SkEbu
 Fp0r+K90BeymO5uWwxGlQdPtmTFWgXdTUKZ1oBO+8O5gHKCwRnTrxt7X0rKGP/al5Dqk
 /33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=ZBjvq5Gq6WI0VhQ4eujUzv4jptL5JIN6BLkKWa/bFf8=;
 b=UWi6zMRKu/TdOXw00374h/u4LZgTkjj5eZbguEqevUzMdj9Ol2FyCA2229W/WkIlVI
 VftcSvZTR6K69ZpYcSK1DxUqhkxZr0Fx1MsRQCSdJl/3r3lvcwyMy44UmEYuRNMgns7c
 CHCKWmJ32wU07/QgzKkIs/ZyhJqUmM4sEUAokhMjvXO2gOvO8ni+tv4lTpgWPb/9DTMJ
 4Q2dQ59a/MRW8R0IlK3JyrP4BZfTpD7WD4sBgfRFD0eLLKn2AKXMr+VfMBX+a0SuAH55
 XohMjszt9Jd/ESCCg/zErqArs+fvOSltw51Dlz+XH5kLokXbNTX0zj+LneE/YUF9WIYv
 YjIw==
X-Gm-Message-State: APjAAAW/wu7F6lz5bEtE0gvmtTc9LYvhr4CBnc4/jaC1pUUZzjF3zrFF
 YydUDWvQQzp2Vyk8wdV6UjodLISn
X-Google-Smtp-Source: APXvYqxc+wRv4wy8qgExG9VcHP3HkNMxInTIQ//DADqaFwPXCRxSvvdiFVrw/MV3X1ILWLIzxzM8BA==
X-Received: by 2002:a1c:7517:: with SMTP id o23mr12675353wmc.34.1571499279524; 
 Sat, 19 Oct 2019 08:34:39 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id j19sm15245605wre.0.2019.10.19.08.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 08:34:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/11] tests/acceptance: Fix 64-bit MIPS target tests
Date: Sat, 19 Oct 2019 17:34:26 +0200
Message-Id: <20191019153437.9820-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2:
- Fixed GIT_COMMITTER_NAME
- do no include Aleksandar Rikalo mailmap change

Commit 9090d3332cdcc introduced a regression which makes the
64-bit target tests to fail.

This series fix it (by previously refactoring the linux_ssh_malta
test), and also add another test for the 5KEc CPU.

I had to include Avocado-related patches not yet merged again to
avoid sending patches that will later not apply.

Please review,

Phil.

Cleber Rosa (1):
  Acceptance tests: refactor wait_for_console_pattern

Philippe Mathieu-Daudé (10):
  tests/acceptance: Fixe wait_for_console_pattern() hangs
  tests/acceptance: Send <carriage return> on serial lines
  tests/acceptance: Refactor exec_command_and_wait_for_pattern()
  tests/boot_linux_console: Use Avocado archive::gzip_uncompress()
  tests/boot_linux_console: Run BusyBox on 5KEc 64-bit cpu
  tests/ssh_linux_malta: Run tests using a snapshot image
  tests/ssh_linux_malta: Remove duplicated test
  tests/ssh_linux_malta: Match stricter console output
  tests/ssh_linux_malta: Refactor how to get image/kernel info
  tests/ssh_linux_malta: Fix 64-bit target tests

 tests/acceptance/avocado_qemu/__init__.py |  45 ++++++++
 tests/acceptance/boot_linux_console.py    |  88 ++++++++-------
 tests/acceptance/linux_ssh_mips_malta.py  | 124 +++++++++++-----------
 3 files changed, 158 insertions(+), 99 deletions(-)

-- 
2.21.0


