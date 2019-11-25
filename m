Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D60C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 08:49:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D37082071E
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 08:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUWCGWei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37082071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZA45-0003Pk-1M
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 03:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZA1m-0000oP-Bn
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 03:47:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZA1k-0006df-7x
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 03:47:26 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33411
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZA1k-0006av-3l
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 03:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574671642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iueunew/GuToVOXb1zCOXci7h6NqsoVLnLZpiOKqOoA=;
 b=gUWCGWeimXhlVq4OLngwkixKWlRgJQP3UVoWW5qQlCBq5/w0e6eJY4F5XiIv0rSLbcvhsq
 H5TDXrHh+o1Z7yTa27YMZV0T+x55cPzVneTtgm8QffE8+rNemc+92FV1sw9I3lKj8g1gv0
 k1MI7rQxrxvRrplTa+4WzJSwW3QPVEE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-rqcVHHX9OHmreKOWLEfWzA-1; Mon, 25 Nov 2019 03:47:20 -0500
Received: by mail-wr1-f71.google.com with SMTP id q6so8429357wrv.11
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 00:47:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q2wcVoreB12Fhyr/jM3YDOlErg0jBZkpOFcdUtpbY/A=;
 b=GYBxVozSenBggSQeEKFGtwtWcQ0zvk3WtRa8MOYvMLKryv8HC12S9kGOy3ZYhkFsxn
 HL1Mbiw7TyO1lLc0BHSud36AaFGb8ZijHwvWnilab7Iprb/6wYUtVUYVsyjVZiWHFPxs
 ZIVlL4rlYVweW50SALYclirLrpH0b/roc6bsAPAJCGZCNM3vJWxK/CVMnqxGq++wH9nx
 HhMGt4lYbhFMSFxaouIuIhSaJHiJGCAZXU45m/oaU8ZNx4axuldPT8CSZ7VQEljVfZZi
 hEWiUw1fzEoiEoyCiGxhEy9pkwA3ZxAN23ooGWuimOSOwcHJ8Dbhm+jVt+Xcxtp5iNft
 aXtw==
X-Gm-Message-State: APjAAAXTctRdgJ7dxTKRYGRGiJg7qg4sGglwYqc4BSAaZd2EHvgcbdgb
 8Bfsk4ZgFc/6ya2rbrwNZ7VWGmeiweElmdA+E2oe4wOL1Z7wASEyEufdLxDP86C2eeii3iXV1QB
 quaPQjO/WRKKcyYI=
X-Received: by 2002:adf:a31a:: with SMTP id c26mr29399108wrb.330.1574671639212; 
 Mon, 25 Nov 2019 00:47:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqzYqppYljbP5M8nV0BC7vRPN3viyW9r+HU2rsvWOvRnCeRORoFFGQ7swDD08jdZBlrr+2xaog==
X-Received: by 2002:adf:a31a:: with SMTP id c26mr29399067wrb.330.1574671638857; 
 Mon, 25 Nov 2019 00:47:18 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id i127sm7962783wma.35.2019.11.25.00.47.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2019 00:47:17 -0800 (PST)
Subject: Re: [PATCH v36 00/17] QEMU AVR 8 bit cores
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org,
 Joaquin de Andres <me@xcancerberox.com.ar>
References: <20191124050225.30351-1-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9cb4b0d6-fd5e-269f-3afe-580c37e3bf6e@redhat.com>
Date: Mon, 25 Nov 2019 09:47:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191124050225.30351-1-mrolnik@gmail.com>
Content-Language: en-US
X-MC-Unique: rqcVHHX9OHmreKOWLEfWzA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: dovgaluk@ispras.ru, thuth@redhat.com, richard.henderson@linaro.org,
 aleksandar.m.mail@gmail.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Joaquin who is implementing the ATmega328.

On 11/24/19 6:02 AM, Michael Rolnik wrote:
> This series of patches adds 8bit AVR cores to QEMU.
> All instruction, except BREAK/DES/SPM/SPMX, are implemented. Not fully te=
sted yet.
> However I was able to execute simple code with functions. e.g fibonacci c=
alculation.
> This series of patches include a non real, sample board.
> No fuses support yet. PC is set to 0 at reset.
>=20
> the patches include the following
> 1. just a basic 8bit AVR CPU, without instruction decoding or translation
> 2. CPU features which allow define the following 8bit AVR cores
>       avr1
>       avr2 avr25
>       avr3 avr31 avr35
>       avr4
>       avr5 avr51
>       avr6
>       xmega2 xmega4 xmega5 xmega6 xmega7
> 3. a definition of sample machine with SRAM, FLASH and CPU which allows t=
o execute simple code
> 4. encoding for all AVR instructions
> 5. interrupt handling
> 6. helpers for IN, OUT, SLEEP, WBR & unsupported instructions
> 7. a decoder which given an opcode decides what istruction it is
> 8. translation of AVR instruction into TCG
> 9. all features together
>=20
> changes since v3
> 1. rampD/X/Y/Z registers are encoded as 0x00ff0000 (instead of 0x000000ff=
) for faster address manipulaton
> 2. ffs changed to ctz32
> 3. duplicate code removed at avr_cpu_do_interrupt
> 4. using andc instead of not + and
> 5. fixing V flag calculation in varios instructions
> 6. freeing local variables in PUSH
> 7. tcg_const_local_i32 -> tcg_const_i32
> 8. using sextract32 instead of my implementation
> 9. fixing BLD instruction
> 10.xor(r) instead of 0xff - r at COM
> 11.fixing MULS/MULSU not to modify inputs' content
> 12.using SUB for NEG
> 13.fixing tcg_gen_qemu_ld/st call in XCH
>=20
> changes since v4
> 1. target is now defined as big endian in order to optimize push_ret/pop_=
ret
> 2. all style warnings are fixed
> 3. adding cpu_set/get_sreg functions
> 4. simplifying gen_goto_tb as there is no real paging
> 5. env->pc -> env->pc_w
> 6. making flag dump more compact
> 7. more spacing
> 8. renaming CODE/DATA_INDEX -> MMU_CODE/DATA_IDX
> 9. removing avr_set_feature
> 10. SPL/SPH set bug fix
> 11. switching stb_phys to cpu_stb_data
> 12. cleaning up avr_decode
> 13. saving sreg, rampD/X/Y/Z, eind in HW format (savevm)
> 14. saving CPU features (savevm)
>=20
> changes since v5
> 1. BLD bug fix
> 2. decoder generator is added
>=20
> chages since v6
> 1. using cpu_get_sreg/cpu_set_sreg in avr_cpu_gdb_read_register/avr_cpu_g=
db_write_register
> 2. configure the target as little endian because otherwise GDB does not w=
ork
> 3. fixing and testing gen_push_ret/gen_pop_ret
>=20
> changes since v7
> 1. folding back v6
> 2. logging at helper_outb and helper_inb are done for non supported yet r=
egisters only
> 3. MAINTAINERS updated
>=20
> changes since v8
> 1. removing hw/avr from hw/Makefile.obj as it should not be built for all
> 2. making linux compilable
> 3. testing on
>      a. Mac, Apple LLVM version 7.0.0
>      b. Ubuntu 12.04, gcc 4.9.2
>      c. Fedora 23, gcc 5.3.1
> 4. folding back some patches
> 5. translation bug fixes for ORI, CPI, XOR instructions
> 6. propper handling of cpu register writes though memory
>=20
> changes since v9
> 1. removing forward declarations of static functions
> 2. disabling debug prints
> 3. switching to case range instead of if else if ...
> 4. LD/ST IN/OUT accessing CPU maintainder registers are not routed to any=
 device
> 5. commenst about sample board and sample IO device added
> 6. sample board description is more descriptive now
> 7. memory_region_allocate_system_memory is used to create RAM
> 8. now there are helper_fullrd & helper_fullwr when LD/ST try to access r=
egisters
>=20
> changes since v10
> 1. movig back fullwr & fullrd into the commit where outb and inb were int=
roduced
> 2. changing tlb_fill function signature
> 3. adding empty line between functions
> 4. adding newline on the last line of the file
> 5. using tb->flags to generae full access ST/LD instructions
> 6. fixing SBRC bug
> 7. folding back 10th commit
> 8. whenever a new file is introduced it's added to Makefile.objs
>=20
> changes since v11
> 1. updating to v2.7.0-rc
> 2. removing assignment to env->fullacc from gen_intermediate_code
>=20
> changes since v12
> 1. fixing spacing
> 2. fixing get/put_segment functions
> 3. removing target-avr/machine.h file
> 4. VMSTATE_SINGLE_TEST -> VMSTATE_SINGLE
> 5. comment spelling
> 6. removing hw/avr/sample_io.c
> 7. char const* -> const char*
> 8. proper ram allocation
> 9. fixing breakpoint functionality.
> 10.env1 -> env
> 11.fixing avr_cpu_gdb_write_register & avr_cpu_gdb_read_register function=
s
> 12.any cpu is removed
> 12.feature bits are not saved into vm state
>=20
> changes since v13
> 1. rebasing to v2.7.0-rc1
>=20
> changes since v14
> 1. I made self review with git gui tool. (I did not know such a thing exi=
sts)
> 2. removing all double/tripple spaces
> 3. removing comment reference to SampleIO
> 4. folding back some changes, so there is not deleted lines in my code
> 5. moving avr configuration, within configure file, before chris
>=20
> changes since v15
> 1. removing IO registers cache from CPU
> 2. implementing CBI/SBI as read(helper_inb), modify, write(helper_outb)
> 3. implementing CBIC/SBIC as read(helper_inb), check, branch
> 4. adding missing tcg_temp_free_i32 for tcg_const_i32
>=20
> changes since v16
> 1. removing EXT IO registers knoledge from CPU. These registers are acces=
sible
>     by LD/ST only. CPU has no interest in them
>=20
> changes since v17 (by Richard Henderson)
> This is Michael's v17, with some adjustments of my own:
>=20
> 1. Fix the whitespace errors reported by "git am",
> 2. Replace the utf-8 characters with normal ascii,
> 3. Ditch the separate compilation of translate.c.
>=20
> I retained the two separate files that could be regenerated
> from the included cpugen program, but merged in translate-insn.c.
> Not that it matters, but the code generated is about 3k smaller.
>=20
> changes since v18
> 1.  moving target-avr into target/avr
> 2.  do not call cpu_exec_initfn function from avr_cpu_initfn
> 3.  call cpu_exec_realizefn avr_cpu_realizefn
> 4.  do not fail sample machine creation if no rom is suplied
> 5.  add tcg_gen_exit_tb(0) for BS_BRANCH in gen_intermediate_code
> 6.  fix a register getters/setters in machine.c
> 7.  changing QEMU_ARCH_AVR from 1<<17 to 1<<18
>=20
> changes since v19
> 1.  use decodetree.py tool to decode instructions
> 2.  adding USART
> 3.  adding 16 bit timer peripherals
> 4.  changing QEMU_ARCH_AVR from 1<<18 to 1<<20
> 5.  renaming tlb_fill to avr_cpu_tlb_fill
>=20
> changes since v20
> 1.  use one CPU naming convention
> 2.  merging insn16.decode & insn32.decode files
> 3.  modifying skip next instruction mechanizm
> 4.  translate BREAK as NOP for now
>=20
> changes since v21
> 1.  Reorganize bstate.
>      This will make transition to <exec/translator.h> easier, and fixes a=
 couple of bugs wrt single stepping
>      by richard.henderson@linaro.org
> 2.  Drop cpc and fix page cross condition.
>      by richard.henderson@linaro.org
> 3.  Refactor checking supported/unsupported instructions
> 4.  Add gdb-xml/avr-cpu.xml
>=20
> changes since v22
> 1.  Rebase
> 2.  Split long comment
>=20
> changes since v23
> 1.  remove avr_cpu_list_compare function
> 2.  modify avr_cpu_class_by_name function
> 3.  modify avr_cpu_list_entry function
> 4.  modify avr_cpu_list function
>=20
> changes since v24
> 1.  remove AVR_CPU_TYPE_NAME macro
>=20
> changes since v25
> 1.  fix patches. every file belong to one patch only
> 2.  change copyright year from 2016 to 2019
> 3.  create mask device to emulate prr0/prr1
>=20
> changes since v26
> 1.  add avocado acceptence test
> 2.  add boot serial test
>=20
> changes since v27
> 1.  list atmel2560 devices as unimplemented
> 2.  fix sram base/size
>=20
> changes since v28
> 1.  rebase
> 2.  fix includes & build
>=20
> changes since v29
> 1.  fixing ownership
> 2.  using 'since' instread of 'added in'
>=20
> changes since v30
> 1.  rebase
>=20
> changes since v31
> 1.  splitting 'Add instruction translation' commit
> 2.  fixing typo in qapi/machine.json sicne -> since
> 3.  removing unintended changes in configure file
> 4.  adding Richard Henderson as a co developer to 'Add instruction transl=
ation - CPU main translation funcions' commit
>=20
> changes since v32
> 1.  modify cpu_get_sreg to treat sreg C as other flags, except sreg Z
>=20
> changes since v33
> 1.  ensure flag C is always calculated as one bit
> 2.  calculate flag Z as one bit, without using inverse logic
>=20
> changes since v34
> 1.  rebase
>=20
> changes since v35
> 1.  rebase
> 2.  use NANOSECONDS_PER_SECOND instead of 1000000000 in avr_timer16.c
> 3.  split "target/avr: Register AVR support with the rest of QEMU" into t=
hree patches
>      1.  "target/avr: Register AVR support with the rest of QEMU"
>      2.  "target/avr: Update build system"
>      3.  "target/avr: Update MAINTAINERS file"
> 4.  split "target/avr: Add tests" patch into two patches
>      1.  "target/avr: Add Avocado test"
>      2.  "target/avr: Add boot serial test"
> 5.  Add instruction disassembly function
> 6.  change "since 4.2" to "since 5.0"


