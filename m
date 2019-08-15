Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BBDC32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3842A205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMg7dZP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3842A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5Er-0007gD-UH
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46581)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DC-0005sB-An
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:09:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DB-0008CW-18
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:09:58 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:33201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5DA-0008C2-TD
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:09:56 -0400
Received: by mail-yw1-xc44.google.com with SMTP id e65so306856ywh.0
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7Cn31OhcuTtoG97O6QJf31XMf6e0LXusFf2Qij9Ivoc=;
 b=PMg7dZP4QfA1euSoZxwQYUB7HJs8z4uxlpAIVtiFkmsrzWFC9mqNLCOmPHcvhqs3hc
 omg9betqFi7qQdZWLL0vPSKRcT2Y4OSFwX8AkVdYzb5Xet/pBOOen8d+VxJtaRKG5iQj
 zafzw7Jd/KlRznGRIoWDGT/0n3usqH00JB19MLZddZr7gQUId7puRKqE1D6ESLK2pr8S
 ub+5JzIB21fpUl71FAKjusTEujAKvCjz0hiu6bBsGWuHEKASnTquBtCx/oU85CuVcSEM
 9DbEyalr/oIT84imERko+b/yTrNMmnFa1uCRKpwq8KcRUdjkJsky9FVIk8DP7UuaaBZL
 eT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7Cn31OhcuTtoG97O6QJf31XMf6e0LXusFf2Qij9Ivoc=;
 b=kNRvQrQyCAM/I/QD+LmNJD8/Fqc7EKXBW+/mFckgCRhcdz3K17iHMQJvAitGhp+E97
 jAKr0CBSU5NiGlkmF+OdQLCCdUMtb0VmxX9+Veh5snPmqsz/Pm6T6xU7wN2V5W//5WDX
 c/s74aMufAgGcjJRapLfZv1LvvA87iZgKeOY4NWsgvUTbH4N1NRRvy58dvkPNzbyCfWj
 X1uZcA6bGje15sbGe2vyp3hLBUJVWoJNp3yC07LGfoytdGq23Y1m30vkRaL59Z708UMM
 UJR/5DNQg7tOvmXtypXVPfWctLym8E3OQJifs+FWgcPgn+9tmxQV0R4YT3y0NurzQlrX
 mXSw==
X-Gm-Message-State: APjAAAUenSZPOlycy78KXssjIvDnFaKTpT3TnkmtQ52kyGUxDgNQvBLk
 aAmvjA1wBXaE1xJOSkl5gkTaLYKE
X-Google-Smtp-Source: APXvYqwu4LUZcWyrVOl01XFFbcFeiY9spbmbwO1jG9VAvSgVGjXDnNwlNzJZcvCI1sks9yotIzpWEA==
X-Received: by 2002:a81:7893:: with SMTP id t141mr1541215ywc.424.1565834995600; 
 Wed, 14 Aug 2019 19:09:55 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:09:55 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:08:42 -0400
Message-Id: <20190815020928.9679-1-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [RFC PATCH v3 00/46] rewrite MMX/SSE/SSE2/SSE3
 instruction translation
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The previous version can be found at [1]. Changes compared to v2:

  - Expanded the instruction operand infrastructure a bit; I am now
    fairly confident that it is powerful enough to accommodate for all
    the use cases I will need. It's still a bit clunky to work with at
    times, but I am happy with it for now.

  - Reduced the number of various INSN_* (now called OPCODE_*) macro
    variants using variadic macros.

  - Implemented translation for instructions up to SSE3.

Cheers,
 -Jan

References:
  1. https://lists.nongnu.org/archive/html/qemu-devel/2019-08/msg01790.html

Jan Bobek (43):
  target/i386: reduce scope of variable aflag
  target/i386: use dflag from DisasContext
  target/i386: use prefix from DisasContext
  target/i386: use pc_start from DisasContext
  target/i386: make variable b1 const
  target/i386: make variable is_xmm const
  target/i386: add vector register file alignment constraints
  target/i386: introduce gen_(ld,st)d_env_A0
  target/i386: introduce gen_sse_ng
  target/i386: disable unused function warning temporarily
  target/i386: introduce mnemonic aliases for several gvec operations
  target/i386: introduce function ck_cpuid
  target/i386: introduce instruction operand infrastructure
  target/i386: introduce generic operand alias
  target/i386: introduce generic either-or operand
  target/i386: introduce generic load-store operand
  target/i386: introduce tcg_temp operands
  target/i386: introduce modrm operand
  target/i386: introduce operands for decoding modrm fields
  target/i386: introduce operand for direct-only r/m field
  target/i386: introduce operand vex_v
  target/i386: introduce Ib (immediate) operand
  target/i386: introduce M* (memptr) operands
  target/i386: introduce G*, R*, E* (general register) operands
  target/i386: introduce P*, N*, Q* (MMX) operands
  target/i386: introduce H*, V*, U*, W* (SSE/AVX) operands
  target/i386: introduce code generators
  target/i386: introduce helper-based code generator macros
  target/i386: introduce gvec-based code generator macros
  target/i386: introduce sse-opcode.inc.h
  target/i386: introduce instruction translator macros
  target/i386: introduce MMX translators
  target/i386: introduce MMX code generators
  target/i386: introduce MMX instructions to sse-opcode.inc.h
  target/i386: introduce SSE translators
  target/i386: introduce SSE code generators
  target/i386: introduce SSE instructions to sse-opcode.inc.h
  target/i386: introduce SSE2 translators
  target/i386: introduce SSE2 code generators
  target/i386: introduce SSE2 instructions to sse-opcode.inc.h
  target/i386: introduce SSE3 translators
  target/i386: introduce SSE3 code generators
  target/i386: introduce SSE3 instructions to sse-opcode.inc.h

Richard Henderson (3):
  target/i386: Push rex_r into DisasContext
  target/i386: Push rex_w into DisasContext
  target/i386: Simplify gen_exception arguments

 target/i386/cpu.h            |    6 +-
 target/i386/sse-opcode.inc.h |  699 +++++++++
 target/i386/translate.c      | 2808 ++++++++++++++++++++++++++++++----
 3 files changed, 3189 insertions(+), 324 deletions(-)
 create mode 100644 target/i386/sse-opcode.inc.h

-- 
2.20.1


