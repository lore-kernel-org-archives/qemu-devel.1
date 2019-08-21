Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06368C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C521422D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8J/Vfqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C521422D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0UcA-00074h-Ic
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UQu-0000X8-Ie
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UQs-0006vD-Ou
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:04 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:39003)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0UQs-0006tL-Jt
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:02 -0400
Received: by mail-yw1-xc44.google.com with SMTP id x74so1236877ywx.6
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iC4N8jaavrth7nWSpJ+D8outStrlNYauXAH1aP/8t9E=;
 b=p8J/VfqhJwN0Hu4GY+gzwGs2qJsKSUM+OuVG1EbpTkMXQXCPm0HCfvAv1JvNAJVYkc
 GUi3Tey4yP0W+rr3vMuDSRtIzK01pA7nU5tN3fLsN17x7fHDmxct6FkHelHjmTCpgEE8
 hoBwmdbExgQgna6Cc2YKqGMnRTBpcP58GOMzLSrJxzVjjwYFs6DoQHwxTzrTTot+OpmV
 eJePmkvO0S5VXZrWSsFTq5sQ0Fxeeqm2KVdVSmSJZ/qDBKUNhiEbL4VD5hi8U6ttANif
 35804/to1Rp1Z9X2HHn2Tx5CNvgmuc3un3ae56hNJNKmfwmKkmLMZqVsJIF4a2fx0hlc
 C9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iC4N8jaavrth7nWSpJ+D8outStrlNYauXAH1aP/8t9E=;
 b=A3qXOsGQiPaGpFQO941zrjNHpRmZtNxuX7v2T0nxDhvzbYYH6Be/8rgMu99pHW27jW
 ChReAlGQ8n+QZQKusHr638S9LT4jjBhxGQw5TSZVJrZr0NqVK0LDN5COomPCuU3CvhsD
 CcsVP3bKTBcEobUF59+oRmAZa8BI/IZLBWnP7Q78UyFwRJfSjKOJ9ah/SxhP+h2LRQQH
 9FV5le7TJKyKCbAaulS/chlFqItNPjPvZfutTvpexfgBnZLmMJ10j+vbIyTqD9Duuq+Y
 hz8kvKbdBsfUFatse0UIaBzkAfIIkn5dTzmaHueP0wMxSYGPmuo3oWA5qoTbWjOdcRPX
 QREg==
X-Gm-Message-State: APjAAAW3NCZfn87uK7kmQDP0v+XIVl7LEXVffXFsR2/ZTMJgqg3Y59vJ
 Pioz/aL26NB4ghwT8a3aT0jyNohy
X-Google-Smtp-Source: APXvYqxVlhQvcLX0jWanr/TbAYqg0ZG4Iy0FzsSOa1jCfx0HS57kdMKnqWDRRavDuB9Gumz7Ns+DQw==
X-Received: by 2002:a81:67d5:: with SMTP id
 b204mr25308509ywc.416.1566408601325; 
 Wed, 21 Aug 2019 10:30:01 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:00 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:28:36 -0400
Message-Id: <20190821172951.15333-1-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [RFC PATCH v4 00/75] rewrite MMX/SSE*/AVX/AVX2 vector
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

Here comes the next version of my patch series, this time v4; the
previous version can be found at [1].

This version can decode all vector instructions up to AVX2. However,
note that this does not mean all of these instructions are implemented
correctly: to achieve that, the old ad-hoc style helpers will need to
be rewritten into the style used by gvec helpers (initial effort
towards that goal can be seen in patches 65-75). There is also a
number of instructions which have not been previously implemented at
all, for which the helpers need to be written from scratch.

Cheers,
 -Jan

Changes from v3:
  - introduce disas_insn_prefix ([2])
  - rename ck_cpuid to check_cpuid ([3])
  - clarify this series deals with vector instructions only ([4])
  - add a list of instructions per each vector ISA extension ([5])
  - change return type of check_cpuid and insnop_init to bool ([6])

References:
  1. https://lists.nongnu.org/archive/html/qemu-devel/2019-08/msg02616.html
  2. https://lists.nongnu.org/archive/html/qemu-devel/2019-08/msg02686.html
  3. https://lists.nongnu.org/archive/html/qemu-devel/2019-08/msg04120.html
  4. https://lists.nongnu.org/archive/html/qemu-devel/2019-08/msg04119.html
  5. https://lists.nongnu.org/archive/html/qemu-devel/2019-08/msg02689.html
  6. https://lists.nongnu.org/archive/html/qemu-devel/2019-08/msg02701.html

Jan Bobek (72):
  target/i386: use dflag from DisasContext
  target/i386: use prefix from DisasContext
  target/i386: introduce disas_insn_prefix
  target/i386: use pc_start from DisasContext
  target/i386: make variable b1 const
  target/i386: make variable is_xmm const
  target/i386: add vector register file alignment constraints
  target/i386: introduce gen_sse_ng
  target/i386: introduce CASES_* macros in gen_sse_ng
  target/i386: decode the 0F38/0F3A prefix in gen_sse_ng
  target/i386: introduce aliases for some tcg_gvec operations
  target/i386: introduce function check_cpuid
  target/i386: disable AVX/AVX2 cpuid bitchecks
  target/i386: introduce instruction operand infrastructure
  target/i386: introduce generic operand alias
  target/i386: introduce generic either-or operand
  target/i386: introduce generic load-store operand
  target/i386: introduce tcg register operands
  target/i386: introduce modrm operand
  target/i386: introduce operands for decoding modrm fields
  target/i386: introduce operand for direct-only r/m field
  target/i386: introduce Ib (immediate) operand
  target/i386: introduce M* (memptr) operands
  target/i386: introduce G*, R*, E* (general register) operands
  target/i386: introduce P*, N*, Q* (MMX) operands
  target/i386: introduce H*, L*, V*, U*, W* (SSE/AVX) operands
  target/i386: alias H* operands with the V* operands
  target/i386: introduce code generators
  target/i386: introduce helper-based code generator macros
  target/i386: introduce gvec-based code generator macros
  target/i386: introduce sse-opcode.inc.h
  target/i386: introduce instruction translator macros
  target/i386: introduce MMX translators
  target/i386: introduce MMX code generators
  target/i386: introduce MMX vector instructions to sse-opcode.inc.h
  target/i386: introduce SSE translators
  target/i386: introduce SSE code generators
  target/i386: introduce SSE vector instructions to sse-opcode.inc.h
  target/i386: introduce SSE2 translators
  target/i386: introduce SSE2 code generators
  target/i386: introduce SSE2 vector instructions to sse-opcode.inc.h
  target/i386: introduce SSE3 translators
  target/i386: introduce SSE3 code generators
  target/i386: introduce SSE3 vector instructions to sse-opcode.inc.h
  target/i386: introduce SSSE3 translators
  target/i386: introduce SSSE3 code generators
  target/i386: introduce SSSE3 vector instructions to sse-opcode.inc.h
  target/i386: introduce SSE4.1 translators
  target/i386: introduce SSE4.1 code generators
  target/i386: introduce SSE4.1 vector instructions to sse-opcode.inc.h
  target/i386: introduce SSE4.2 code generators
  target/i386: introduce SSE4.2 vector instructions to sse-opcode.inc.h
  target/i386: introduce AES and PCLMULQDQ translators
  target/i386: introduce AES and PCLMULQDQ code generators
  target/i386: introduce AES and PCLMULQDQ vector instructions to
    sse-opcode.inc.h
  target/i386: introduce AVX translators
  target/i386: introduce AVX code generators
  target/i386: introduce AVX vector instructions to sse-opcode.inc.h
  target/i386: introduce AVX2 translators
  target/i386: introduce AVX2 code generators
  target/i386: introduce AVX2 vector instructions to sse-opcode.inc.h
  target/i386: remove obsoleted helpers
  target/i386: cleanup leftovers in ops_sse_header.h
  target/i386: introduce aliases for helper-based tcg_gen_gvec_*
    functions
  target/i386: convert ps((l,r)l(w,d,q),ra(w,d)) to helpers to gvec
    style
  target/i386: convert pmullw/pmulhw/pmulhuw helpers to gvec style
  target/i386: convert pavgb/pavgw helpers to gvec style
  target/i386: convert pmuludq/pmaddwd helpers to gvec style
  target/i386: convert psadbw helper to gvec style
  target/i386: remove obsoleted helper_mov(l,q)_mm_T0
  target/i386: convert pshuf(w,lw,hw,d),shuf(pd,ps) helpers to gvec
    style
  target/i386: convert pmovmskb/movmskps/movmskpd helpers to gvec style

Richard Henderson (3):
  target/i386: Push rex_r into DisasContext
  target/i386: Push rex_w into DisasContext
  target/i386: Simplify gen_exception arguments

 target/i386/cpu.h            |    6 +-
 target/i386/ops_sse.h        |  812 +++---
 target/i386/ops_sse_header.h |  131 +-
 target/i386/sse-opcode.inc.h | 2069 +++++++++++++++
 target/i386/translate.c      | 4777 ++++++++++++++++++++++++++++++----
 5 files changed, 6842 insertions(+), 953 deletions(-)
 create mode 100644 target/i386/sse-opcode.inc.h

-- 
2.20.1


