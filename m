Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FB6C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:13:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83C3120719
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f2llox1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C3120719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKRkm-0004ob-KW
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 15:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRjQ-0003FH-En
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRjP-0001zp-1L
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:11:56 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36953)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jKRjO-0001tU-QA
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:11:54 -0400
Received: by mail-wr1-x442.google.com with SMTP id w10so9850861wrm.4
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 12:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QM2GUwMlwOQI4R+pF21geQZvYdTelcCEt6+CkufBHlU=;
 b=f2llox1jGooyR8qprfnqDuYhI2WM4fnQrmmIhiqQwMnUgAseLQ+PjTNsO5LGYe+WrN
 nqF2b69iTPPumNKKkUK58ZMZB4ER8diZEU6bJt0111tV9pfvBdsiXwi4Dirf6kAVgRYQ
 Jdl7N7zV483CUyo2BFNZDPhBowT112XOmx9g31cSLxpRR3onhImccKOd7KOV8nZLqd/A
 N6ga2pdtMNDQBcZjns0OT6XXzIvC/n16bVWTJg9GLeFYGnWHWGgkB61zWDPoc/RppA2C
 Em1vb6cBI6b7Zfymn9PNZNuI271hIVVxSlmpgZthdiNHTb0kXXpkfkTu6WCu1Jro679J
 +zSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QM2GUwMlwOQI4R+pF21geQZvYdTelcCEt6+CkufBHlU=;
 b=p3vyZ7TkJRlW+cEQXd52zSKd4lZeHA1be6T06mICVaeZTqaAAVUx6FCMo8LHorllF4
 uggRN/aYZtFjXrLxZet3Gz2FJt7SMZL67z1KZU4awlITB19rBtIEzUk5PxAxadypBlj5
 IyeiAbYHxgSIIUz3hVmTcHkqQYGSMdvUX+pOWSEHGpKjOkhBuzS8Ptl7brnTG+rq56EC
 v3ByXeKoewMzode3uL3M/AEojovLW97+K01zD0gjbc+2KhYAL1ltyHUSBLlJDC6jfaYa
 2qE08MOxClY6hlLrwUC2BVO6lL867WgL95ezzgmpX4NbGxKIbmtJygeGK0oDQgQEi84f
 2SEg==
X-Gm-Message-State: AGi0PuZEtmjF9vSmjcl5XEn10BMIhDPillr5BlTTELVNc/e1J7qCYxo+
 IciyKZzm2erkZhLx+82j83iEkR+kg5c=
X-Google-Smtp-Source: APiQypKaWoJzs7oCUKdJ0svRcgRrlv/zK9ZTxpIACH3q/deDFVoV8Y9iTm+qT3XflpUirH1eIqYlMQ==
X-Received: by 2002:adf:dd01:: with SMTP id a1mr11483964wrm.153.1585941112588; 
 Fri, 03 Apr 2020 12:11:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a82sm13537977wmh.0.2020.04.03.12.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 12:11:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 97D221FF7E;
 Fri,  3 Apr 2020 20:11:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 for 5.0-rc2 00/12] a selection of random fixes
Date: Fri,  3 Apr 2020 20:11:38 +0100
Message-Id: <20200403191150.863-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Here is version 3 of my random fixes series. 

I've dropped the more involved re-factoring of init_guest_space as
it's going to take more thought and is best left to 5.1. I've left in
the earlier clean-ups which fix the spacing and of the /proc/self/maps
but I can drop them if they seem too radical for rc2.

The elf-ops fix is a little cleaner, dropping the return ignored
value and using autoptr to avoid the goto magic.

I've includes the .hex and ARM gdbstub fixes which were posted
separately because I didn't have another series to put them in.
Richard's configure fix is there just so I can run my CI runs but may
well get picked up via another tree?

Anyway I intend to cut the PR on Monday with whatever hasn't been
already pulled in by other trees.

The only un-reviewed patch is:

 - linux-user: factor out reading of /proc/self/maps

Alex Bennée (9):
  elf-ops: bail out if we have no function symbols
  linux-user: protect fcntl64 with an #ifdef
  tests/tcg: remove extraneous pasting macros
  linux-user: more debug for init_guest_space
  target/xtensa: add FIXME for translation memory leak
  linux-user: factor out reading of /proc/self/maps
  linux-user: clean-up padding on /proc/self/maps
  target/arm: don't expose "ieee_half" via gdbstub
  hw/core: properly terminate loading .hex on EOF record

Denis Plotnikov (1):
  gdbstub: fix compiler complaining

Richard Henderson (2):
  softfloat: Fix BAD_SHIFT from normalizeFloatx80Subnormal
  configure: Add -Werror to PIE probe

 configure                      |  4 +-
 include/hw/elf_ops.h           | 48 ++++++++++----------
 include/qemu/selfmap.h         | 44 +++++++++++++++++++
 fpu/softfloat.c                |  3 ++
 gdbstub.c                      |  4 +-
 hw/core/loader.c               |  5 ++-
 linux-user/elfload.c           |  8 +++-
 linux-user/syscall.c           | 80 ++++++++++++++++++----------------
 target/arm/gdbstub.c           |  7 ++-
 target/xtensa/translate.c      |  5 +++
 util/selfmap.c                 | 77 ++++++++++++++++++++++++++++++++
 tests/tcg/x86_64/system/boot.S |  5 +--
 util/Makefile.objs             |  1 +
 13 files changed, 219 insertions(+), 72 deletions(-)
 create mode 100644 include/qemu/selfmap.h
 create mode 100644 util/selfmap.c

-- 
2.20.1


