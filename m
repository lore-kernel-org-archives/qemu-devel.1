Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8CCC31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 14:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09CAA20820
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 14:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/+C2Yme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09CAA20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40272 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcW7v-000371-T8
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 10:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34757)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hcW3Z-00017V-Mr
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 10:22:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hcW3Y-0006MM-5v
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 10:22:53 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:41323)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lucienmp.qemu@gmail.com>)
 id 1hcW3X-0006Lt-Vu
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 10:22:52 -0400
Received: by mail-pl1-x635.google.com with SMTP id s24so2995556plr.8
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 07:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:mime-version:content-disposition
 :user-agent; bh=TdLMGDwMyPUmXeFUR1KJqEinhOw2s/SFETAhE2fm+Yg=;
 b=d/+C2YmekdacxjrzJVdzBhHnwSz0ceR7gjPKMOmsUyONbLr3m9F89mohadM8zPmszV
 Gv8G0tj9oQwuzrT/ffUgT4krOWLWwy10/YhasQurTTS7xBvBEInbkHgKKCSJxIuFBX/P
 8cECV68JH4G3YjGoenor0yumXq5VOmgqjblkMUhc1e3tcZP5ShFDWTtD0Jnv5WOpU1ev
 Vd1ZeolhDgYfQ7W3CBwFVIMVUxUCCsDFn9HJkB675Dn/Qz6ipMKc5iWrFR6aLle09PUK
 +RyUGKImnIi+4TBhWMv8P37ypML1R9OS4uSISRQdgclT2Aq/nV/+P+X9AY5L4NXKhV2q
 HeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=TdLMGDwMyPUmXeFUR1KJqEinhOw2s/SFETAhE2fm+Yg=;
 b=pkdYd2AIsL1DrPuQOOqmAwuA4URGYeQ4UENGfiX04CoRclutrNBtMINDTkKxCB6sa/
 IsZT2NUh1/UCpdNqI6LuzokKxIkAJfvkTJVaNMLHt3Uwz4OJgH1sVz0HlHaOM3hi9Pr1
 TiJ7lboK7IdFwBSrZxrT14u3XK/e5b7jVNg17MPtrqzg/ikWFBjVaOJuQZXX0UQ+NFAy
 atJdTHrNqVtYGR2KVJTWDYHscSAHxKiAi42VBN8FrxX4+9LTzFDcadr1jGk2PHS9SCWW
 zROKPRLy+q5VlK0U7zUQqiD+OU7IHWl3LKocXx03sACGUqT1JIkHt1f2Zc6vLr3z21g+
 jNXA==
X-Gm-Message-State: APjAAAWUH8RaVAJTnMM9GV4Rry+YfIcA7K/8KEODIb4M9KMIRtq9y57O
 DIv8waH4/92iOx4GSNkTSXU9K2vf
X-Google-Smtp-Source: APXvYqxYildzaPhC0bYvg+FB7X5/WgRQORSLVwP20q0Vl6EowFlfy23hqHgiV0duUnDaaXUWNAW0Iw==
X-Received: by 2002:a17:902:2a69:: with SMTP id
 i96mr94258671plb.108.1560694970594; 
 Sun, 16 Jun 2019 07:22:50 -0700 (PDT)
Received: from localhost.localdomain (i60-43-49-30.s30.a048.ap.plala.or.jp.
 [60.43.49.30])
 by smtp.gmail.com with ESMTPSA id t25sm8296085pgv.30.2019.06.16.07.22.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 16 Jun 2019 07:22:50 -0700 (PDT)
Date: Sun, 16 Jun 2019 23:22:47 +0900
From: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Message-ID: <20190616142247.GA71199@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::635
Subject: [Qemu-devel] [PATCH 0/6] target/m68k: Overhaul of MOVEC instruction
 to support exception/MSP
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

The 68000 does not support the MOVEC instruction, it was added with the 68010.
A new 68010 CPU class was created, and the MOVEC instruction moved to that class.

Futher on the 68010, 68060 and CPU32 the ISP doesnt exist.
These CPUs only have SSP/USP.
(NOTE: ColdFire has a different MOVEC helper, this hasnt been touched.)

Unsupported contrl registers (CR) generate a cpu abort, this has been fixed to
correctly generate an ILLEGAL INSTRUCTION exception.

On supporting CPUs the SR register also implements a single bit,  the "M"
(master-mode) bit that determines which of the ISP/MSP is active at the time.
A fix was enetered to support this behavior, with an MSP feature being greated.


Brief overview;
 - Added "CPU class" m68k_feature to each CPU init
   so MOVEC can detect wrong CR (Control Register) access
 - Added cascaded "inheritance" of m68k_features by calling m680xx_cpu_initfn()
   of previous CPU so that 68060 inherits 68040, and so on
 - Added comments above m680xx_cpu_initfn to identify additional supported
   features for that CPU class
 - Added more detailed comments, including CPU classes supported,
   to enum m68k_features
 - Added more detailed comments to each case of m68k_move_to/from helpers
   to list the supported CPUs for that CR
 - Added CPU class detection for each CR type, exits switch if unsupported
 - Added ILLEGAL INSTRUCITON exception condition when the helper fails to
   decode the CR
 - Moved abort only to handle unimplemented control registers,
   all other unknown CR will cause ILLEGAL instruciton
 - Fixed m68k_switch_sp so it switches only if MSP feature is implemented
 - Changed the MOVEC instruction in translate to be 68010 not 68000
 - Added missing BUSCR/PCR CR defines, and decodes for helpers for the 68060

Long overview;

MOVEC EXCEPTIONS
===============================================================================
Because the MOVEC MSP support results in an illegal instruction exception
if the wrong Control Register is accessed then it was necessary to
know the CPU class in the MOVEC instruction (or a less wider method
would be to only check for MOVEC support).

A broader approach was taken to allow any unsupported CR to generate
exceptions.

To do this a sizable overhaul of the CPU initialize funcitons was needed
to add a feature showing the CPU class.

So in the CPU classes the m680XX_cpu_initfn functions have been rearranged
to cascade starting from the base 68000, so that the 68010 then inherits
from this, and so on until the 68060.

Because each cpu class inherits the previous CPU class, then for example
the 68020 also has the feature 68010, and 68000 and so on upto the 68060.

To do this the patch adds classes for each CPU family 680[012346] so that
illegal access to specific control registers can be checked.

The helpers m68k_movec_to, and m68k_movec_from have been updated to support
the exception ILLEGAL INSTRUCTION for all control registers that
are illegal per CPU class, and for any unkown control register.

All other cases will result in an ILLEGAL INSTRUCTION exception as per the
manual. (rather than the abort it used to trigger)


EXTENDED SUPPORT FOR MISSING CONTROL REGISTERS
===============================================================================
Added defines for BUS, and Processor Configuration Register (PCR) for MC68060,
and case statements in the helper for the missing Cache Address Register (CAAR),
and the new BUS, and PCR which results in a cpu abort (unimplemented error)
which doesnt change the behavior for these registers.


SR "M" bit
===============================================================================
The stack swapper helper was fixed to correctly check if the CPU has the MSP,
otherwise defaulting to the ISP always.


COMMENTS
===============================================================================
Additional comments added to the features set to claify
exactly what differentiates each cpu class.  (m68k_features)

Added some more detailed comments to each cpu initialization function
to make it clear the instructions added/changed for that CPU to make
future debugging easier, and the reason for the feature flags more clear.

These comments could go deeper into explaining supported/ehnaced modes,
but this wasnt done in this patch.

There are comments in the existing code referring to the EC/L/and-so-on
classes, however no code has been implemented to handle these specific
varitations of each CPU class, and so no m68k_feature was mde to
distinguish them that way.



Notes:
    Splitting of original patch for clarity as requested by Laurent

    Patch: 20190609164349.GA60211@localhost.localdomain
    ([PATCH v2] Incorrect Stack Pointer shadow register support on some m68k CPUs)
      v1->v2
        - Submitted previous patch to fix existing non-compliant comment style 
        - Added a comment about sp in CPUM68KState structure
        - updated movec in the same patch to issue exception
        - Reworked code in m68k_movec_from()/m68k_movec_to() because 
          as they trigger a cpu_abort() with unknown code, 
        - Above rework then required some additions for CPU class and so on.
        - Maybe this is becoming more of an RFC? / should be split for the rework?

Based-on: 20190606234125.GA4830@localhost.localdomain
([PATCH v2] m68k comments break patch submission due to being incorrectly formatted)



Lucien Murray-Pitts (6):
  m68k cpu instantiation comments improvements
  Cascade m68k_features by m680xx_cpu_initfn() to improve readability
  Improved comments on m68k_move_to/from helpers
  Add missing BUSCR/PCR CR defines, and BUSCR/PCR/CAAR CR to
    m68k_move_to/from
  MOVEC insn. doesnt generate exception if wrong CR is accessed
  Added MSP detection support for stack pointer swap helpers

 target/m68k/cpu.c       | 109 ++++++++++++++----
 target/m68k/cpu.h       |  56 ++++++---
 target/m68k/helper.c    | 246 +++++++++++++++++++++++++++++++---------
 target/m68k/translate.c |   2 +-
 4 files changed, 320 insertions(+), 93 deletions(-)

-- 
2.21.0



