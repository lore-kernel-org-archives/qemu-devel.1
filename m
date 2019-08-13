Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BECEC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7BC020578
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iFCo8LrV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7BC020578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxWGN-0003vf-1I
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 08:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53531)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hxWFK-0002Ge-SX
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hxWFJ-0000cY-OI
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:50 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hxWFJ-0000b8-H5
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:49 -0400
Received: by mail-wm1-x344.google.com with SMTP id p74so1390930wme.4
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 05:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=unFrNW8YfxZI1kq8HWXajrX3RMWsmQKNT0d1Tt9LFB8=;
 b=iFCo8LrVPNTQOzLrHt815uTI01WSZ45df/p+FNtIET6BxTKpeUQE7MWBLo2JsGce+t
 j02VTXAZ4EHBUqVc25T3MUbXhKy6itgDmqRHMMBGMn9ei+KlnFd/pFxPn3zX1Lf1PTAO
 mBzioRGFcInW14vTWSE+fKiIYoW3eFrkLr8FPFtzihePn+EBnwrXeKReM9L7wDpN8aaL
 zSQcQWxvbtYmLAs9602JNe5yBsUoe5dNBy+qiPc7oUn4s5YYIwfmDaFQ0sy7KpNX3ofY
 b+vOI4bauzsA8shlO6eMWEKy0SIBVyqpG6R4LDvm/grE9X7ABIJ6ePrOuusqDOudpO7a
 Syig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=unFrNW8YfxZI1kq8HWXajrX3RMWsmQKNT0d1Tt9LFB8=;
 b=gy8Gyw6sLPtSXi7aZjC0sx6XjdQZE9I6OsMUy8cSsgx/5sZgd+9TI5oenMl30BHvh2
 lRJMYJ3ExldyJiFnT3ad/94qruNrRsL9n6zZT6nSfHF/4kHfg/sWcUcTEqUmTMsSqiqh
 kB0rrQo8oBANqHOd163TsHwPFLLDBG7o1zAyb4ZLJte0CKjkAqaoD+1BR2981r+hrR42
 hKKdscpy595Q+EmBD8APkxPxi48/zarqihcycUw7SzJtz/gF/Dz3LDxtzxUKm34gRM+N
 gAk+QJIcWCSBTUf2gR/pAiF6snkV0lV8nWcrgoA/th2HU4yACvZoYUM1xBAslgI7q0nl
 Ey4g==
X-Gm-Message-State: APjAAAXunC5xWbgwuwruBUhLtHzPYVkOoryi4wV3KPWMCRuObThs9pHm
 7nxfpPvU24kIk7ab6jlNsvl+Zg==
X-Google-Smtp-Source: APXvYqxgJsOyLTMFOruC5mPhLH6TJ+SIo3OKSnZro/U08lz8Zo5TTj9kGa67UzQxWw5dEBYk+ymL9Q==
X-Received: by 2002:a05:600c:22c6:: with SMTP id 6mr3004283wmg.5.1565700587891; 
 Tue, 13 Aug 2019 05:49:47 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id p7sm1440339wmh.38.2019.08.13.05.49.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 13 Aug 2019 05:49:47 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E15BE1FF87;
 Tue, 13 Aug 2019 13:49:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 13:49:33 +0100
Message-Id: <20190813124946.25322-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH  v3 00/13] softfloat updates (include tweaks,
 rm LIT64)
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Another iteration of updates for softfloat. Instead of moving the
LIT64() macro from one file to another we convert the uses to the
stdint.h macro. I did eliminate one of the uses by converting the
squash_input_denormal functions to the new style code. However as you
can see with the follow-up patch it bloated the code a little. I'd
like to convert the x80 and 128bit FP functions to the new style but
the challenge is seeing how we can get greater re-use of the common
functions without bloating the generated code. However if we can do
that we should eliminate a class of bugs in the current code.

There are a bunch of minor checkpatch complaints as all touched lines
haven't been fully converted to the proper brace style but I avoided
do that to make the patch more readable.

The following patches need review:
   01 - fpu replace LIT64 usage with UINT64_C for special
   02 - fpu convert float 16 32 64 _squash_denormal to ne
   03 - fpu optimise float 16 32 64 _squash_denormal HACK
   04 - fpu use min max values from stdint.h for integral
   05 - fpu replace LIT64 with UINT64_C macros
   06 - target m68k replace LIT64 with UINT64_C macros
   07 - fpu remove the LIT64 macro

Alex Bennée (13):
  fpu: replace LIT64 usage with UINT64_C for specialize constants
  fpu: convert float[16/32/64]_squash_denormal to new modern style
  fpu: optimise float[16/32/64]_squash_denormal (HACK?)
  fpu: use min/max values from stdint.h for integral overflow
  fpu: replace LIT64 with UINT64_C macros
  target/m68k: replace LIT64 with UINT64_C macros
  fpu: remove the LIT64 macro
  fpu: move inline helpers into a separate header
  fpu: make softfloat-macros "self-contained"
  fpu: rename softfloat-specialize.h -> .inc.c
  target/mips: rationalise softfloat includes
  target/riscv: rationalise softfloat includes
  targets (various): use softfloat-helpers.h where we can

 ...pecialize.h => softfloat-specialize.inc.c} |  26 +-
 fpu/softfloat.c                               | 262 ++++++++----------
 include/fpu/softfloat-helpers.h               | 132 +++++++++
 include/fpu/softfloat-macros.h                |   8 +-
 include/fpu/softfloat.h                       |  65 +----
 linux-user/mips/cpu_loop.c                    |   1 +
 target/alpha/helper.c                         |   2 +-
 target/m68k/softfloat.c                       |  98 +++----
 target/microblaze/cpu.c                       |   2 +-
 target/mips/cpu.h                             |   8 +-
 target/mips/internal.h                        |   7 +
 target/mips/msa_helper.c                      |   1 +
 target/mips/op_helper.c                       |   1 +
 target/riscv/cpu.c                            |   1 +
 target/riscv/cpu.h                            |   2 +-
 target/riscv/fpu_helper.c                     |   1 +
 target/s390x/cpu.c                            |   2 +-
 target/sh4/cpu.c                              |   3 +-
 target/tricore/helper.c                       |   2 +-
 target/unicore32/cpu.c                        |   1 -
 20 files changed, 342 insertions(+), 283 deletions(-)
 rename fpu/{softfloat-specialize.h => softfloat-specialize.inc.c} (98%)
 create mode 100644 include/fpu/softfloat-helpers.h

-- 
2.20.1


