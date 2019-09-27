Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F54CC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:46:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05173207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y7ujYAKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05173207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDtNr-0002c4-PP
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 12:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDrSR-0002Md-Rc
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:42:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDrSP-00086A-Qk
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:42:55 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46578)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDrSP-00085z-E5
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:42:53 -0400
Received: by mail-wr1-x441.google.com with SMTP id o18so3091266wrv.13
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 07:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dsSUNhhqen/wPXXXfC/6F7Zoc+EhhtXera2UzcFSLEw=;
 b=y7ujYAKiYPpytEKqujsBCX1zMQJOLMYhDIVDJcZuOoFSp8IytHvIFUUoWVrt/OE3yl
 n1TPjhdufYd/9ZxQjLInlxLcFjuuEc2O94BhIWNS3ZhKQYeBI6hMOfSuoVkkZd3uHr8O
 1HQC6wfw7K3lkvk0TR5f5unUca04csWFs8gsyeXEzpOUcC3chVIkyjpVw0T2a6O8hb59
 L11njisSfZA2BR7YTGA0yYKQnnsFUPAU8GzkDBxAj0KVepngL+7+/OZ+OO71mPW/yMG8
 i3R62Mnp1t31Zd5jdTY1r0/kJO/J5QGBl2jKWCROkC6GfX75E9oajzXgWm5yFlU70bVr
 Di0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dsSUNhhqen/wPXXXfC/6F7Zoc+EhhtXera2UzcFSLEw=;
 b=HptbtPvgl0CZ/D2Jkk9aZ4JC0VbdoCKygxyE0m8UgWqBgvbR91eOnCY0oTUajj0Znz
 wZ+QSTuGG3Z1FJbjqtHWo2YyM86ytZV5CIeZE8YmhBmEvFQhGLqjItrCuMydCx4gafEk
 GGu4otmeFkNCbW2jc+VKUEVp5ePFGqsuJFAw8AFde2q7HTgKCzRbjwe1ukqXdyw6/JL3
 qSkRz6Evp//Xo2wbL315PF5ZCvDRVnBcefFxQGpS/AWEa2x+9vn5FSU0tniF1F+zVZnD
 mRHacdLufRQXY1ltQAjcAIiV5kPDWYIuZXt3Z/sv4JYBcJqbq1CGEC005Yx00HxDNoa0
 UoRg==
X-Gm-Message-State: APjAAAXZOixSh6bu7YkOY/3h2YG/HN/uaFM0XPpzZ0GIBGRnN8jnmdDI
 f1JxKgDH+vB0NWC/+evfBhU4JEV/ifZ60g==
X-Google-Smtp-Source: APXvYqzmM1JwtR916r3JcnQpL9M8yXs2O5SWAoEez2bIkef0xSH9RC6Ops6Q9ermYy/liAWD2fwM7w==
X-Received: by 2002:a05:600c:22d9:: with SMTP id
 25mr7064813wmg.133.1569595371711; 
 Fri, 27 Sep 2019 07:42:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y12sm2874539wrn.74.2019.09.27.07.42.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 07:42:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] target-arm queue
Date: Fri, 27 Sep 2019 15:42:40 +0100
Message-Id: <20190927144249.29999-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

target-arm queue: nothing major here, but no point
sitting on them waiting for more stuff to come along.

thanks
-- PMM

The following changes since commit 1329132d28bf14b9508f7a1f04a2c63422bc3f99:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-09-26 16:14:03 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190927

for you to fetch changes up to e4e34855e658b78ecac50a651cc847662ff02cfd:

  hw/arm/boot: Use the IEC binary prefix definitions (2019-09-27 11:44:39 +0100)

----------------------------------------------------------------
target-arm queue:
 * Fix the CBAR register implementation for Cortex-A53,
   Cortex-A57, Cortex-A72
 * Fix direct booting of Linux kernels on emulated CPUs
   which have an AArch32 EL3 (incorrect NSACR settings
   meant they could not access the FPU)
 * semihosting cleanup: do more work at translate time
   and less work at runtime

----------------------------------------------------------------
Alex Bennée (6):
      tests/tcg: clean-up some comments after the de-tangling
      target/arm: handle M-profile semihosting at translate time
      target/arm: handle A-profile semihosting at translate time
      target/arm: remove run time semihosting checks
      target/arm: remove run-time semihosting checks for linux-user
      tests/tcg: add linux-user semihosting smoke test for ARM

Luc Michel (1):
      target/arm: fix CBAR register for AArch64 CPUs

Peter Maydell (1):
      hw/arm/boot.c: Set NSACR.{CP11,CP10} for NS kernel boots

Philippe Mathieu-Daudé (1):
      hw/arm/boot: Use the IEC binary prefix definitions

 tests/tcg/Makefile.target         |   7 ++-
 tests/tcg/aarch64/Makefile.target |   8 ++-
 tests/tcg/arm/Makefile.target     |  20 ++++---
 linux-user/arm/target_syscall.h   |   3 -
 hw/arm/boot.c                     |  12 ++--
 linux-user/arm/cpu_loop.c         |   3 -
 target/arm/helper.c               | 115 +++++++++++++-------------------------
 target/arm/m_helper.c             |  18 ++----
 target/arm/translate.c            |  30 ++++++++--
 tests/tcg/arm/semihosting.c       |  45 +++++++++++++++
 10 files changed, 146 insertions(+), 115 deletions(-)
 create mode 100644 tests/tcg/arm/semihosting.c

