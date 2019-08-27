Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23657C3A59F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 00:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF94C2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 00:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWr3YozH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF94C2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2P3G-000157-0g
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 20:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2P1a-0007wc-9z
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:07:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2P1Z-00071e-4a
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:07:50 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:41914)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2P1Y-00071N-UO
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:07:49 -0400
Received: by mail-pf1-x431.google.com with SMTP id 196so12861446pfz.8
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 17:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=AavCte7KdU+l/i26jHZDloMHr1iDDUuNU0OupHHG9H8=;
 b=mWr3YozHJ/LIOqEoQdYa6knRDjZ0IBmmgfrYK81VN0Kyb3HXE6zr0p6MO+XW/hFKjT
 KTtfg0Yk+n/R7fmPCoVtA1pFQH7oYmC7WFfKbndm87+C/VoCwCQbuQ7LGNmv9GFkAVg2
 rVKGOM/s8rQpYcQj9s8vCntoFDCiVhVifsnosz3aVbhzwHQmPA7drkTrvhkiHznYtXCH
 NdD4KziWUrwqHYzzb9aj4EWpwIr7t3G8XsODX8pGHkT3SjQsG17hqW6obM139NvUJvmY
 ZPawKOoY5kG1S0Q5yK/p0lneAio4jIjkC3Q4x9e9KX5Os6gkZG0k8mt/C9+SnCWKW1Dq
 BjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=AavCte7KdU+l/i26jHZDloMHr1iDDUuNU0OupHHG9H8=;
 b=ebad0swb1eIaKQS3aZK/EH60qAdegkH1GTf8s/RwJfEmyP2Zdn6KHPuQTvRBmMlK3Q
 YbFsBfcxnQdx9dVf6LHdydY3PnYnRaJ87jWn9U7kJxBK3vVs2rYyTNOryoyOPLaLK+qe
 G8Uqbs5vpJwIvnVqRTNEc4RqVvlX6O8LT0FmLXem1Pw1APpORb10GuK5+Iq4az+yBdMD
 94+OBZVOqVAFZdRG1J5AqWI4A6rGkJUp6bFHZDzJXcmzUwcWaCc+EmEzpwURl2pOSGPT
 L1QXaAsSRS2V4m+Z4NG64yECv7L14Bjjsp0CO2AqeRjBh6sR74fEFzEsK+JDXT2LeEC3
 2zRA==
X-Gm-Message-State: APjAAAXeo47YN8JYYQP+4YmWcg1ok7Y92w/9N+KXljohSV58J0+53wI4
 w7FsDdJ6AjZhiAXNKuuJH9aVoparqE4=
X-Google-Smtp-Source: APXvYqz5+MZyFmoqyobiFCtUFvuaRKYcs8P3utvd4kUumYfmOuuNCNuKon+4D5I/YS6Sa//89R98Cw==
X-Received: by 2002:a63:6904:: with SMTP id e4mr18528987pgc.321.1566864467261; 
 Mon, 26 Aug 2019 17:07:47 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id e189sm11691067pgc.15.2019.08.26.17.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 17:07:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 17:07:32 -0700
Message-Id: <20190827000745.19645-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::431
Subject: [Qemu-devel] [PATCH 00/13] target/openrisc updates
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
Cc: shorne@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The first three fix an MTTCG race on cpu_R[0], now that
we do code generation in parallel.

Then some updates to the SPRs, cpuid checks for existing
float insns, adding the new v1.3 instructions.

I've run this through the gcc testsuite as

make check-gcc \
RUNTESTFLAGS='--target_board=or1k-qemu/-mhard-float/-mdouble-float execute.exp'

                === gcc Summary ===

# of expected passes            103979
# of unexpected failures        26
# of expected failures          400
# of unresolved testcases       1
# of unsupported tests          2539

Of the 26, none are obviously floating-point related.


r~


Richard Henderson (13):
  target/openrisc: Add DisasContext parameter to check_r0_write
  target/openrisc: Replace cpu register array with a function
  target/openrisc: Cache R0 in DisasContext
  target/openrisc: Make VR and PPC read-only
  target/openrisc: Move VR, UPR, DMMCFGR, IMMCFGR to cpu init
  target/openrisc: Add VR2 and AVR special processor registers
  target/openrisc: Fix lf.ftoi.s
  target/openrisc: Check CPUCFG_OF32S for float insns
  target/openrisc: Add support for ORFPX64A32
  target/openrisc: Implement unordered fp comparisons
  target/openrisc: Implement move to/from FPCSR
  target/openrisc: Implement l.adrp
  target/openrisc: Update cpu "any" to v1.3

 linux-user/openrisc/target_elf.h |   2 +-
 target/openrisc/cpu.h            |  24 +-
 target/openrisc/helper.h         |   6 +
 target/openrisc/cpu.c            |  30 +-
 target/openrisc/disas.c          |  81 ++++
 target/openrisc/fpu_helper.c     |  49 ++-
 target/openrisc/machine.c        |  11 +
 target/openrisc/sys_helper.c     |  38 +-
 target/openrisc/translate.c      | 716 +++++++++++++++++++++++--------
 target/openrisc/insns.decode     |  45 ++
 10 files changed, 774 insertions(+), 228 deletions(-)

-- 
2.17.1


