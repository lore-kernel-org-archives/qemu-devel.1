Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2B6C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D8D720665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rq+eWeGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8D720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAg4a-00007b-DW
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg2v-0006qJ-7g
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 16:59:57 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35156)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg2t-0001bZ-2s
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 16:59:56 -0400
Received: by mail-pf1-x444.google.com with SMTP id k1so1453751pfu.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 13:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W1MTXW2SVg5aAGduwVUHJqQVnQiE4xQUeFKNjCbr0Ss=;
 b=Rq+eWeGEhxI97XM/KHrkXO9WRFclSSpdzQJ16FDCPH46cveLOlp0bgFosFXBAo7A1y
 9hyJ0d7ziEcQ617qXBcQpHP9x7lRRW8jem37Jqhx/OpA/215MMlRGl8dCpv5Jmw/XdMf
 0Sz+D6RLpv/XqoTOEHf23+2s3BVSGqvcLSf6HIEDJfkVAgbjHXtWBlldiw0kBk8Y85qQ
 ekuxgifmKRZAltlU7eecfCDa3dpgBFqZufW7v/0xcRcnkEKOM+UCZMKOZCI6B4dvtaMJ
 wtE6yEcYIgwQvKMsbQITxFFaTs6oFwUStWNkno9slStphBkGbJuYPt7AoUvoaZ0vbkpg
 gRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W1MTXW2SVg5aAGduwVUHJqQVnQiE4xQUeFKNjCbr0Ss=;
 b=ty4ZXx9b87Rh8rdXIqmtCfefirzjbxBZO+t8T5/Nk7jLdW/t/D5Be8ixRBR/wJt52L
 NG7Q/hEQ9UbmGV/h5ZcLfrTts+Q5nqX4GK/fs4qySwyZhsvQHT31zQLtRXdGmDwrh//q
 IZFJhAG4F9vZX4+TAYTkBeKb4SpvwQ2CEXjn1I/Qdf/KsfDOjxEpASbyQXmJS8QWDQZT
 XLmTw42IP5FAyEwBR0ddDB+cY/oJbhs2H1sVKQ2T4VYZEUDzTbeejyQXfkVQ4D/kcggh
 M1ezB2Z6uGyA3JOyqBGZK5eS9Co9cFmEkNYqxuNbdP7jP7uZItqtLp9LVqR8wHRxloZm
 MdsQ==
X-Gm-Message-State: AOAM530TBSVod7LyDaoDwjjaar5L9+rH5owZh6Q0LYqav3i/H3XD322+
 b/bi1BAWps6c46iDllUQ+VC8MoQJ5KkJbA==
X-Google-Smtp-Source: ABdhPJydA4RTNCGrSfuesU8E1UMSZM/4fyZxP+xDn1LKlBl7mXy+0QvWRL4SRcwKwgOW9LFj/0K4EQ==
X-Received: by 2002:a17:902:bb89:: with SMTP id
 m9mr5657528pls.108.1598389192669; 
 Tue, 25 Aug 2020 13:59:52 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.13.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 13:59:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/77] target/microblaze improvements
Date: Tue, 25 Aug 2020 13:58:33 -0700
Message-Id: <20200825205950.730499-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Well, this is larger than I expected.

I started off thinking conversion to decodetree would be quick,
after I reviewed the mttcg patches last week.  Then I realized
that this could also use conversion to the generic translation loop.
Then I realized that there were a number of bugs, and some
inefficiencies, that could be fixed by using tcg exception unwind
properly.

Hopefully most of these are small and easy to understand.

I begin by adding enough stuff to test/tcg to make use of a
self-built musl cross-environment.  I'll note that linuxtest
does not pass before or after this patch set -- I think that
linux-user/microblaze/signal.c needs work -- but that the
other tests do work.

I also have an old copy of a microblaze system test image,
which I think used to be hosted on our wiki.  After basic kernel
boot, it contains a "selftest" script which runs a bunch of
user-land isa tests.  That still works fine too.

HOWEVER: That's not nearly complete.  There are cpu config options
that aren't default and I don't know how to change or test.

In addition, the manual is really not clear on what's supposed to
happen under various edge conditions, especially with MSR[EE] unset.
E.g. unaligned access: Does the insn get nop-ed out?  Do the low
bits of the address get ignored?  Right now (before and after) the
access simply happens unaligned, which doesn't seem correct.
I assume the reason for having this configure option is to reduce
the size of the FPGA so that the unaligned access handling hw
simply isn't present.

Lemme know what you think.


r~


Richard Henderson (77):
  tests/tcg: Add microblaze to arches filter
  tests/tcg: Do not require FE_TOWARDZERO
  tests/tcg: Do not require FE_* exception bits
  target/microblaze: Tidy gdbstub
  target/microblaze: Split out PC from env->sregs
  target/microblaze: Split out MSR from env->sregs
  target/microblaze: Split out EAR from env->sregs
  target/microblaze: Split out ESR from env->sregs
  target/microblaze: Split out FSR from env->sregs
  target/microblaze: Split out BTR from env->sregs
  target/microblaze: Split out EDR from env->sregs
  target/microblaze: Split the cpu_SR array
  target/microblaze: Fix width of PC and BTARGET
  target/microblaze: Fix width of MSR
  target/microblaze: Fix width of ESR
  target/microblaze: Fix width of FSR
  target/microblaze: Fix width of BTR
  target/microblaze: Fix width of EDR
  target/microblaze: Remove cpu_ear
  target/microblaze: Tidy raising of exceptions
  target/microblaze: Mark raise_exception as noreturn
  target/microblaze: Remove helper_debug and env->debug
  target/microblaze: Rename env_* tcg variables to cpu_*
  target/microblaze: Tidy mb_tcg_init
  target/microblaze: Split out MSR[C] to its own variable
  target/microblaze: Use DISAS_NORETURN
  target/microblaze: Check singlestep_enabled in gen_goto_tb
  target/microblaze: Convert to DisasContextBase
  target/microblaze: Convert to translator_loop
  target/microblaze: Remove SIM_COMPAT
  target/microblaze: Remove DISAS_GNU
  target/microblaze: Remove empty D macros
  target/microblaze: Remove LOG_DIS
  target/microblaze: Ensure imm constant is always available
  target/microblaze: Add decodetree infrastructure
  target/microblaze: Convert dec_add to decodetree
  target/microblaze: Convert dec_sub to decodetree
  target/microblaze: Implement cmp and cmpu inline
  target/microblaze: Convert dec_pattern to decodetree
  target/microblaze: Convert dec_and, dec_or, dec_xor to decodetree
  target/microblaze: Convert dec_mul to decodetree
  target/microblaze: Convert dec_div to decodetree
  target/microblaze: Unwind properly when raising divide-by-zero
  target/microblaze: Convert dec_bit to decodetree
  target/microblaze: Convert dec_barrel to decodetree
  target/microblaze: Convert dec_imm to decodetree
  target/microblaze: Convert dec_fpu to decodetree
  target/microblaze: Fix cpu unwind for fpu exceptions
  target/microblaze: Mark fpu helpers TCG_CALL_NO_WG
  target/microblaze: Replace MSR_EE_FLAG with MSR_EE
  target/microblaze: Cache mem_index in DisasContext
  target/microblaze: Fix cpu unwind for stackprot
  target/microblaze: Convert dec_load and dec_store to decodetree
  target/microblaze: Assert no overlap in flags making up tb_flags
  target/microblaze: Move bimm to BIMM_FLAG
  target/microblaze: Store "current" iflags in insn_start
  tcg: Add tcg_get_insn_start_param
  target/microblaze: Use cc->do_unaligned_access
  target/microblaze: Replace clear_imm with tb_flags_to_set
  target/microblaze: Replace delayed_branch with tb_flags_to_set
  target/microblaze: Tidy mb_cpu_dump_state
  target/microblaze: Try to keep imm and delay slot together
  target/microblaze: Convert brk and brki to decodetree
  target/microblaze: Convert mbar to decodetree
  target/microblaze: Reorganize branching
  target/microblaze: Use tcg_gen_lookup_and_goto_ptr
  target/microblaze: Convert dec_br to decodetree
  target/microblaze: Convert dec_bcc to decodetree
  target/microblaze: Convert dec_rts to decodetree
  target/microblaze: Tidy do_rti, do_rtb, do_rte
  target/microblaze: Convert msrclr, msrset to decodetree
  target/microblaze: Convert dec_msr to decodetree
  target/microblaze: Convert dec_stream to decodetree
  target/microblaze: Remove last of old decoder
  target/microblaze: Remove cpu_R[0]
  target/microblaze: Add flags markup to some helpers
  target/microblaze: Reduce linux-user address space to 32-bit

 include/tcg/tcg.h                   |   15 +
 target/microblaze/cpu-param.h       |   15 +
 target/microblaze/cpu.h             |   67 +-
 target/microblaze/helper.h          |   49 +-
 tests/tcg/multiarch/float_helpers.h |   17 +
 target/microblaze/insns.decode      |  253 +++
 linux-user/elfload.c                |    9 +-
 linux-user/microblaze/cpu_loop.c    |   26 +-
 linux-user/microblaze/signal.c      |    8 +-
 target/microblaze/cpu.c             |    9 +-
 target/microblaze/gdbstub.c         |  193 +-
 target/microblaze/helper.c          |  164 +-
 target/microblaze/mmu.c             |    4 +-
 target/microblaze/op_helper.c       |  175 +-
 target/microblaze/translate.c       | 3250 ++++++++++++++-------------
 tests/tcg/multiarch/float_convs.c   |    2 +
 tests/tcg/multiarch/float_madds.c   |    2 +
 target/microblaze/meson.build       |    3 +
 tests/tcg/configure.sh              |    2 +-
 19 files changed, 2309 insertions(+), 1954 deletions(-)
 create mode 100644 target/microblaze/insns.decode

-- 
2.25.1


