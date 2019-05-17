Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1910EC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 17:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7BDF20848
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 17:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DCAtE7GF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7BDF20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51718 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRgsN-0000Px-2B
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 13:42:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRgqp-0007tB-3Z
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:41:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRgqm-00036B-Ig
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:40:58 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:45448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRgqg-0002rC-I6
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:40:54 -0400
Received: by mail-wr1-x42e.google.com with SMTP id b18so7947445wrq.12
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 10:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=YOpfEDFzZy4Bh83FC8/CXHXQeQcGsenvuDmMohFWPoI=;
	b=DCAtE7GFpnydgbppUYAk6frtkYM8Hl5MB/EWbn3aiA7giY6H9T03J1KsQxR0+cBagf
	NK8daIaolG4lG2pVVwlC2ez162rwQ5Fsa29F9Cs9Pvp8Mx+omNv5o7+F0QS+Y/8opErV
	+VTBCnFS/XmntN5oy3/EH824AReQMt8kdmSKl2qfwxyrU4GnOksbCbhrfYs3mk6WcGFX
	J2lHHqj1H8M/dr/o5aNH2t3LcucKypbqlzwMphbpVbiE/I5/k48slWgbOa7XzdoThOOE
	lSVD60+baZjRIlK9Zpgr9LNwEt0JL7mSqGnRDJk4IYmgFd2bNM/rh/eKrrCZR9KYcUNt
	GzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=YOpfEDFzZy4Bh83FC8/CXHXQeQcGsenvuDmMohFWPoI=;
	b=BGLVRm2JQqLaSL/DTjCAZcbfkNCn3Ku9tLAn1vXRiF63ALcPzsVoK8TgOjOvQ2JiUq
	W4S6lLpkLZVQZ9kfkkCXydc7CfWc+cfYKRn0Te6biBRlF3idupU9WjGSrjkVxX3kXRok
	Umooab7DCaesijiYSkv9oEIKPXwWaB+wdJi+PKghurBaRgBoAuwdeQcEJReTIDEVcMit
	t2pluYcO0odVXLubd4ebP/wW+4kpfS981Teed4QJkjtFbC67QUO1YAutOlcHzbGzXtEz
	qokPL0LCTXKbFjDIyC5Zn01ppd5f5pY6akZeh7274qW8lT13HWXlRIGiAfIbuYbLNiqq
	RCHw==
X-Gm-Message-State: APjAAAU1/NHiNj63TEKcx9Q8exxF46VT5V5nNRPQYTd6cUxNSzXG1sxC
	ld7EDry5GTSxpV8VNkfU4qFrww==
X-Google-Smtp-Source: APXvYqx71JzGeEBeQDYVRazqEcCEje5lrJZnKFWgetPMn8jylU9bjFQDfFvI5JGjMjPnj/JHcQQgiw==
X-Received: by 2002:adf:ba10:: with SMTP id o16mr26325374wrg.89.1558114849009; 
	Fri, 17 May 2019 10:40:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	y18sm5418641wmd.29.2019.05.17.10.40.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 10:40:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Fri, 17 May 2019 18:40:42 +0100
Message-Id: <20190517174046.11146-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42e
Subject: [Qemu-devel] [PATCH 0/4] Disable FPU/DSP for CPU0 on musca-a and
 mps2-an521
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The SSE-200 hardware has configurable integration settings which
determine whether its two CPUs have the FPU and DSP:
 * CPU0_FPU (default 0)
 * CPU0_DSP (default 0)
 * CPU1_FPU (default 1)
 * CPU1_DSP (default 1)

Similarly, the IoTKit has settings for its single CPU:
 * CPU0_FPU (default 1)
 * CPU0_DSP (default 1)

Of our four boards that use either the IoTKit or the SSE-200:
 * mps2-an505, mps2-an521 and musca-a use the default settings
 * musca-b1 enables FPU and DSP on both CPUs

Currently QEMU models all these boards using CPUs with
both FPU and DSP enabled. This means that we are incorrect
for mps2-an521 and musca-a, which should not have FPU or DSP
on CPU0.

This patchset fixes this (fairly minor) inaccuracy by
implementing properties on the CPU to disable the relevant
CPU features and then wiring them up through the armv7m
object and the ARMSSE SoC container object, so that our
IotKit and SSE200 models behave by default the same way as
the hardware default does, and our Musca-B1 board model
forces the FPU/DSP to be present on CPU, as the hardware does.

The 'neon' property is not strictly required for the M-profile
issues described above, but I implemented it on the CPU
object because disable-neon and disable-vfp interact
for A-profile CPUs.

thanks
-- PMM

Peter Maydell (4):
  target/arm: Allow VFP and Neon to be disabled via a CPU property
  target/arm: Allow M-profile CPUs to disable the DSP extension via CPU
    property
  hw/arm/armv7m: Forward "vfp" and "dsp" properties to CPU
  hw/arm: Correctly disable FPU/DSP for some ARMSSE-based boards

 include/hw/arm/armsse.h |   7 ++
 include/hw/arm/armv7m.h |   4 +
 target/arm/cpu.h        |   6 ++
 hw/arm/armsse.c         |  58 ++++++++++---
 hw/arm/armv7m.c         |  18 ++++
 hw/arm/musca.c          |   8 ++
 target/arm/cpu.c        | 179 ++++++++++++++++++++++++++++++++++++++--
 7 files changed, 262 insertions(+), 18 deletions(-)

-- 
2.20.1

