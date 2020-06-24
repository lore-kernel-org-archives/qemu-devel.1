Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE55C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 13:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C89220781
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 13:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLI59hXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C89220781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo5sC-0004h1-Nh
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 09:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jo5r4-0003bF-2F; Wed, 24 Jun 2020 09:54:22 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:38238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jo5r1-0005mV-UX; Wed, 24 Jun 2020 09:54:21 -0400
Received: by mail-il1-x142.google.com with SMTP id t85so2128986ili.5;
 Wed, 24 Jun 2020 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I5Rjf8ii59Aiql206cPhopkdhvS2t9/pnAmPDhHAzHk=;
 b=gLI59hXKvqfXsyokQCjmeCpQs47SlbzLM22btqFyZbdPLLiDoqU0Gw9VhKk52UgqJF
 3uk7uA7Z1NlPm3rdb9CKIBujjEbNwbEqGk7jKCC1QBpaVjGeh+E7pApricfBbOiN5//w
 CX4e6jobrYWNGnKJVbirxH5OGJHdUN2ES22PHYtaS+cqT/QCiXOYjrlpSLdcHjMc5WDO
 udtSU9QZziHvFHrMEOalsu7pRJaBfwOYI8aqI2sbMRi3io4hUa4DAXd7KS/MsuF81IuM
 ZhQN2skTfkO0k7FWP1RtfS/la1bUkJKzCx3sF3f2tb4/5GZ2VjTbKblcqXYApgIlYt8n
 6aWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I5Rjf8ii59Aiql206cPhopkdhvS2t9/pnAmPDhHAzHk=;
 b=eOE5fQbDP38mb7QSUlWXAIu/BX7ra3Cpn5ONUWyngCRYSJz5ZjsJPkCRqKYJE6U616
 drDERmDS79qzsJD8aDTo45dI+O7e8QSWiYanh1BqN49giKMQUrTPM2EqRMrxKBWu8epZ
 2I1SUtiA2dqsihGVg48FN6NLiQRqwaNedsTtEZCYd356SeXzEZ2MwCyoxRpWaszE2P/y
 uaaSprVvRg208jxtp/ufZtt7bAfBQ8MrH0fmSoW0l700XkZ4QK4OVF7OTI1za7Leiiks
 JHB25/ZRXKqyYizx9JrwVOy+60IHQevgbKWj6tVJkFPYsn/fzLpbU30s7I1Hf2pBryAl
 agKQ==
X-Gm-Message-State: AOAM532f8e2T6nPTCfNwWOBHnvIwMc83Ts4J/IchIL127qKyraQokn4z
 VknRxSwaTCIfPDctK/qrfCOKbGUSy9lBxoYKBo8=
X-Google-Smtp-Source: ABdhPJztM2/Kh9Rf5qJXEazNqh15/BfaT/JKyJiTIlSs5nJ3l6d0kYBOBBkDdQ5Uot62G+3CNJiZrmuMIKLsrf7eXdI=
X-Received: by 2002:a92:c213:: with SMTP id j19mr21902108ilo.40.1593006858418; 
 Wed, 24 Jun 2020 06:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200623215920.2594-1-zhiwei_liu@c-sky.com>
In-Reply-To: <20200623215920.2594-1-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 24 Jun 2020 06:44:44 -0700
Message-ID: <CAKmqyKPWH70gGHFmO4EBgC3yT=OnbgEfUieqEHgB8BSqjUWO9Q@mail.gmail.com>
Subject: Re: [PATCH v11 00/61] target/riscv: support vector extension v0.7.1
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, wenmeng_zhang@c-sky.com,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 23, 2020 at 3:00 PM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> This patchset implements the vector extension for RISC-V on QEMU.
>
> You can also find the patchset and all *test cases* in
> my repo(https://github.com/romanheros/qemu.git branch:vector-upstream-v11).
> All the test cases are in the directory qemu/tests/riscv/vector/. They are
> riscv64 linux user mode programs.
>
> You can test the patchset by the script qemu/tests/riscv/vector/runcase.sh.
>
> Features:
>   * support specification riscv-v-spec-0.7.1.(https://github.com/riscv/riscv-v-spec/releases/tag/0.7.1/)
>   * support basic vector extension.
>   * support Zvlsseg.
>   * support Zvamo.
>   * not support Zvediv as it is changing.
>   * SLEN always equals VLEN.
>   * element width support 8bit, 16bit, 32bit, 64bit.
>
> Changelog:
>
> v11
>   * fix all non-ASCII characters.
>
> v10
>   * rebase to https://github.com/alistair23/qemu/tree/riscv-to-apply.next.
>   * fix compile error in patch 57/61.
>   * fix review tag typo.
>
> v9
>   * always set dynamic rounding mode for vector float insns.
>   * bug fix atomic implementation.
>   * bug fix first-only-fault.
>   * some small tidy up.
>
> v8
>   * support different float rounding modes for vector instructions.
>   * use lastest released TCG GVEC DUP IR.
>   * set RV_VLEN_MAX to 256 bits, as GVEC IR uses simd_desc.
>
> v7
>   * move vl == 0 check to translation time by add a global cpu_vl.
>   * implement vector element inline load and store function by TCG IR.
>   * based on vec_element_load(store), implement some permutation instructions.
>   * implement rsubs GVEC IR.
>   * fixup vsmul, vmfne, vfmerge, vslidedown.
>   * some other small bugs and indentation errors.
>
> v6
>   * use gvec_dup Gvec IR to accellerate move and merge.
>   * a better way to implement fixed point instructions.
>   * a global check when vl == 0.
>   * limit some macros to only one inline function call.
>   * fixup sew error when use Gvec IR.
>   * fixup bugs for corner cases.
>
> v5
>   * fixup a bug in tb flags.
>
> v4
>   * no change
>
> v3
>   * move check code from execution-time to translation-time
>   * use a continous memory block for vector register description.
>   * vector registers as direct fields in RISCVCPUState.
>   * support VLEN configure from qemu command line.
>   * support ELEN configure from qemu command line.
>   * support vector specification version configure from qemu command line.
>   * probe pages before real load or store access.
>   * use probe_page_check for no-fault operations in linux user mode.
>   * generation atomic exit exception when in parallel environment.
>   * fixup a lot of concrete bugs.
>
> V2
>   * use float16_compare{_quiet}
>   * only use GETPC() in outer most helper
>   * add ctx.ext_v Property
>
>
>
> LIU Zhiwei (61):
>   target/riscv: add vector extension field in CPURISCVState
>   target/riscv: implementation-defined constant parameters
>   target/riscv: support vector extension csr
>   target/riscv: add vector configure instruction
>   target/riscv: add an internals.h header
>   target/riscv: add vector stride load and store instructions
>   target/riscv: add vector index load and store instructions
>   target/riscv: add fault-only-first unit stride load
>   target/riscv: add vector amo operations
>   target/riscv: vector single-width integer add and subtract
>   target/riscv: vector widening integer add and subtract
>   target/riscv: vector integer add-with-carry / subtract-with-borrow
>     instructions
>   target/riscv: vector bitwise logical instructions
>   target/riscv: vector single-width bit shift instructions
>   target/riscv: vector narrowing integer right shift instructions
>   target/riscv: vector integer comparison instructions
>   target/riscv: vector integer min/max instructions
>   target/riscv: vector single-width integer multiply instructions
>   target/riscv: vector integer divide instructions
>   target/riscv: vector widening integer multiply instructions
>   target/riscv: vector single-width integer multiply-add instructions
>   target/riscv: vector widening integer multiply-add instructions
>   target/riscv: vector integer merge and move instructions
>   target/riscv: vector single-width saturating add and subtract
>   target/riscv: vector single-width averaging add and subtract
>   target/riscv: vector single-width fractional multiply with rounding
>     and saturation
>   target/riscv: vector widening saturating scaled multiply-add
>   target/riscv: vector single-width scaling shift instructions
>   target/riscv: vector narrowing fixed-point clip instructions
>   target/riscv: vector single-width floating-point add/subtract
>     instructions
>   target/riscv: vector widening floating-point add/subtract instructions
>   target/riscv: vector single-width floating-point multiply/divide
>     instructions
>   target/riscv: vector widening floating-point multiply
>   target/riscv: vector single-width floating-point fused multiply-add
>     instructions
>   target/riscv: vector widening floating-point fused multiply-add
>     instructions
>   target/riscv: vector floating-point square-root instruction
>   target/riscv: vector floating-point min/max instructions
>   target/riscv: vector floating-point sign-injection instructions
>   target/riscv: vector floating-point compare instructions
>   target/riscv: vector floating-point classify instructions
>   target/riscv: vector floating-point merge instructions
>   target/riscv: vector floating-point/integer type-convert instructions
>   target/riscv: widening floating-point/integer type-convert
>     instructions
>   target/riscv: narrowing floating-point/integer type-convert
>     instructions
>   target/riscv: vector single-width integer reduction instructions
>   target/riscv: vector wideing integer reduction instructions
>   target/riscv: vector single-width floating-point reduction
>     instructions
>   target/riscv: vector widening floating-point reduction instructions
>   target/riscv: vector mask-register logical instructions
>   target/riscv: vector mask population count vmpopc
>   target/riscv: vmfirst find-first-set mask bit
>   target/riscv: set-X-first mask bit
>   target/riscv: vector iota instruction
>   target/riscv: vector element index instruction
>   target/riscv: integer extract instruction
>   target/riscv: integer scalar move instruction
>   target/riscv: floating-point scalar move instructions
>   target/riscv: vector slide instructions
>   target/riscv: vector register gather instruction
>   target/riscv: vector compress instruction
>   target/riscv: configure and turn on vector extension from command line

Thanks!

Applied to the RISC-V tree.

Alistair

>
>  target/riscv/Makefile.objs              |    2 +-
>  target/riscv/cpu.c                      |   50 +
>  target/riscv/cpu.h                      |   82 +-
>  target/riscv/cpu_bits.h                 |   15 +
>  target/riscv/csr.c                      |   75 +-
>  target/riscv/fpu_helper.c               |   33 +-
>  target/riscv/helper.h                   | 1069 +++++
>  target/riscv/insn32-64.decode           |   11 +
>  target/riscv/insn32.decode              |  372 ++
>  target/riscv/insn_trans/trans_rvv.inc.c | 2888 +++++++++++++
>  target/riscv/internals.h                |   41 +
>  target/riscv/translate.c                |   27 +-
>  target/riscv/vector_helper.c            | 4899 +++++++++++++++++++++++
>  13 files changed, 9520 insertions(+), 44 deletions(-)
>  create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
>  create mode 100644 target/riscv/internals.h
>  create mode 100644 target/riscv/vector_helper.c
>
> --
> 2.23.0
>
>

