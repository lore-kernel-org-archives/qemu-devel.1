Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1DFC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:31:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA9F2064A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IuG29Fg6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA9F2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htFrm-0007gV-G6
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 14:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59340)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1htFqT-0005vx-4E
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1htFqR-0002Sb-AD
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:30:33 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46045)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1htFqP-0002Nm-4i
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:30:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id f9so74598838wre.12
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 11:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sGrB+kzlP5nYTDQpLU+R6KMCd9bD8yYEiikR0zjNUgs=;
 b=IuG29Fg6GKfizf3Da/c/2in+A+2TBtF+9fVfskb7u8hsUPwiZgz8b2Vs04kxMnbHCe
 StBEdc/nu0r/oPwtPTZS9EJK6uKW/0WLFpRE5WCPDNrbuh6CxQEnoc8t4ANVqQ+HeY3P
 hXsnNCkHIWDRzcS1k+dWdrqOufnSOKITFhG5JdJ4ISLzKDKEhnpYRVV93qbjr/GSpl/u
 o3L3hp7UDCvthHg2Cs38cKNYxWOY1yeRGphWvgVHPJpSqK4ZYNH7BuXSfdXHO3/inAcI
 6RiFOXJIVzQkYEaVzv+3dyGRFREiOu+vl15Wi+to2OsQf+z6Vq3n3pfJwzGDCZ4r+naW
 Jn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sGrB+kzlP5nYTDQpLU+R6KMCd9bD8yYEiikR0zjNUgs=;
 b=BkWn0ewWNGPiByKAPnp46szu+e8wm8pt7ciduqWh9GGUNUZ1ymsgVwvv80UqLqpGfD
 Z0ZpnEupdndCr97eO+TigMf7sdhVVPURpc1Bbp+KYBeyAGB5Li3H848LeI6eaHSs8rws
 PA/iHZHOCitMh2lLJDCra9j6A42iN1D7eayVhm2gShCxr5qgcqTCRz+ZOba2ebNFwLim
 veM40++TrmskkpwbfMxcB6t047kw6tV8JO2khf2iBnvmSQJypgr0VFgD5XLB/PbnOogR
 FvrQ6VpXTSKACyPq5EsfNa5cGdbW3yIRH42XMjKplCOBCepMsMPM0uwJgUIyOyUSWWj5
 m5DA==
X-Gm-Message-State: APjAAAXF78jngYAWygXbCQ4jQThefg4VTzCiNb1dnBl0ijTPgRDHak0Z
 dGUAVzVNP3XwYoS3E4C8FiLn0Ag0tSIECQ==
X-Google-Smtp-Source: APXvYqxXQYMIwfP/Hir82m2oGm8qx7cregBJSYrPRqjj5J4hd7BJ42LOctbP8C3os4F2uob0FFyEBA==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr14053812wrp.188.1564684214636; 
 Thu, 01 Aug 2019 11:30:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e6sm71702104wrw.23.2019.08.01.11.30.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 11:30:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  1 Aug 2019 19:30:05 +0100
Message-Id: <20190801183012.17564-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 0/7] target/sparc: Convert to
 do_transaction_failed hook
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset converts the SPARC target away from the old
broken do_unassigned_access hook to the new (added in 2017...)
do_transaction_failed hook. In the process it fixes a number
of bugs in corner cases.

The SPARC ld/st-with-ASI helper functions are odd in that they
make use of the cpu_unassigned_access() function as a way of
raising an MMU fault. We start by making them just directly
call a new sparc_raise_mmu_fault() function so they don't go
through the hook function. This in-passing fixes a bug where
the hook was using GETPC(), which won't work inside a function
several levels deep in the callstack from a helper function.

The next four patches convert places that were using ld*_phys()
and st*_phys() and thus getting "implicitly causes an exception
via do_unassigned_access if it gets a bus error" behaviour.
We make them all use address_space_ld*/st* functions instead,
and explicitly handle the transaction-failure case. Variously:
 * for MMU passthrough, this doesn't change behaviour
 * for the MXCC stream source/destination ASI accesses,
   this doesn't change behaviour, but the current behaviour
   looks a bit weird, so a TODO comment is left in case anybody
   wants to chase up the actual right behaviour in future
 * for page table walks this fixes a bug where we would take
   an exception instead of reporting the page table walk failure
   with the correct fault status register information
 * for the page table walk in mmu_probe() this fixes a bug where
   we would take an exception when we are supposed to just report
   failure. Note that the spec says that MMU probe operations
   are supposed to set the fault status registers, but we do not;
   again I leave this pre-existing bug as a TODO note.
Next, we remove one entirely pointless and unused ldl_phys()
call from dump_mmu().

Finally, the last patch can do the very small amount of work to
change over to the new hook function. This will cause all the
"handle error" code paths in the preceding patches to become
active (when a do_unassigned_access hook is present the load
or store functions will never return an error, because the hook
will get called and throw an exception first).

I have tested that I can boot a sparc32 debian image, and
that sparc64 boots up to the firmware prompt, but this could
certainly use more extensive testing than I have given it.

(After SPARC, the only remaining unassigned-access-hook users
are RISCV, which crept in while I wasn't looking, and MIPS,
which is doing something complicated with the Jazz board that
I haven't yet investigated.)

thanks
--PMM

Peter Maydell (7):
  target/sparc: Factor out the body of sparc_cpu_unassigned_access()
  target/sparc: Check for transaction failures in MMU passthrough ASIs
  target/sparc: Check for transaction failures in MXCC stream ASI
    accesses
  target/sparc: Correctly handle bus errors in page table walks
  target/sparc: Handle bus errors in mmu_probe()
  target/sparc: Remove unused ldl_phys from dump_mmu()
  target/sparc: Switch to do_transaction_failed() hook

 target/sparc/cpu.h         |   8 +-
 target/sparc/cpu.c         |   2 +-
 target/sparc/ldst_helper.c | 319 +++++++++++++++++++++----------------
 target/sparc/mmu_helper.c  |  57 +++++--
 4 files changed, 238 insertions(+), 148 deletions(-)

-- 
2.20.1


