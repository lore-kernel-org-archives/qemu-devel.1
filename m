Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E261C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2909A20756
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYFMmStd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2909A20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPTTM-0006oU-AN
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPSuF-0001be-1v; Mon, 05 Oct 2020 12:00:07 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:41650)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPSuB-0002F9-Sq; Mon, 05 Oct 2020 12:00:06 -0400
Received: by mail-lf1-x141.google.com with SMTP id d24so7527713lfa.8;
 Mon, 05 Oct 2020 09:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=wMi9w96qrIg1Uz2OiTHhJdz2ItqAzCao02mrSPsMP7A=;
 b=bYFMmStd0bTpeWnDKQYqeLBnHU1I9xMikshxtChwNuEadCP1fmSpMB0gzD2a01FL7O
 0zb6gptiy2YiC1KNcy4+DCWR2DRI0YULL7ViaHrnbgo8gNXAstduA3HLjUI+o9R6J71B
 Did3tjeNXWzc1rUmKOuqc/mMgVuHwaPswP24tABypxNEF2R1E9zJnIjQTF6PbVOHrkBc
 Dbf1eQQ5/TFSLWhPra/jdibMGr8iFkWS8AIPpBlJhIJwO7BeaeuZR/ziBDk1wz/3fmPj
 HzOFiihbo24BiUWp1ejynxa1YhRGj/UwJnnbPjx532sGoeJ8rEAuk0ssvSNpbTa1ntge
 zFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=wMi9w96qrIg1Uz2OiTHhJdz2ItqAzCao02mrSPsMP7A=;
 b=MBli/qj6xUqVuhx5qsqsxxraiF8bCdOqRMOqvkka2Y48lzqfNbk1hfU6tKczOBwFxs
 +mlBMnMlvb/o2pUPg/Pptl4hQP1VL6dh8+NEwY/oJgDNgvMiOpMNytVJ4Wc9Z9UlOvqE
 TnFaoSqMfWinmNIQF1n2RIujYaaMHcEbQSXWCpRCV2jPFhJryjYbz9Tx0aOAB62p8Hsn
 DVmjbiKLJdiUkvEmU4BN1wOv8YcsjkQ2s0fykriO6UvCByFcZhPbnooCMFBLen4K+Jnr
 VnqqFO3IbU7rvszhC/KKFW5v5LVNwebeqSZrf41l2pfeanSGKZx8abraHblD1OPq5X4J
 srjw==
X-Gm-Message-State: AOAM530ewDZhUXsp/7WUMnTNlQmjqVOYwdQFKGgAYHgGvxoaLSaQ+pc2
 2cwLd3c2j7UkoHbldAtBi1568WUPbyBL+S+ZPi0f4nvhPJA=
X-Google-Smtp-Source: ABdhPJxPjazwC89pQYg7fC6BwXyODBnU0xJdHbWSazvoENZH9HwvKrhVEGHz7BwbYUtSQNr+1MSvOFviBK383MESSW4=
X-Received: by 2002:a05:6512:529:: with SMTP id o9mr39243lfc.331.1601913600689; 
 Mon, 05 Oct 2020 09:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201005155426.413-1-luoyonggang@gmail.com>
In-Reply-To: <20201005155426.413-1-luoyonggang@gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 5 Oct 2020 23:59:51 +0800
Message-ID: <CAE2XoE9RGp+xV6KsZBF6tLE-sheYBX7BMawE=1O3Pr-HfrESpg@mail.gmail.com>
Subject: Re: [PATCH v8 000/133] Fixes curses on msys2/mingw
To: qemu-level <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000214d9c05b0ee93ad"
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000214d9c05b0ee93ad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Err, sorry for this, don't know if this would broken the patchew

On Mon, Oct 5, 2020 at 11:54 PM Yonggang Luo <luoyonggang@gmail.com> wrote:
>
> V7-V8
> Rebase to master and  resolve conflict of
> *configure: fixes indent of $meson setup
>
> V6-V7
> Update the configure script for
> * curses: Fixes compiler error that complain don't have langinfo.h on
msys2/m=3D
> ingw
>
> V5-V6
> Dropping configure: Fixes ncursesw detection under msys2/mingw by convert
the=3D
> m to meson first.
> That need the meson 0.56 upstream to fixes the curses detection.
> Add
> * configure: fixes indent of $meson setup
>
> Alberto Garcia (2):
>   docs: Document the throttle block filter
>   qcow2: Use L1E_SIZE in qcow2_write_l1_entry()
>
> Alex Benn=3DC3=3DA9e (2):
>   gitlab: move linux-user plugins test across to gitlab
>   gitlab: split deprecated job into build/check stages
>
> Collin L. Walling (7):
>   s390/sclp: get machine once during read scp/cpu info
>   s390/sclp: rework sclp boundary checks
>   s390/sclp: read sccb from mem based on provided length
>   s390/sclp: check sccb len before filling in data
>   s390/sclp: use cpu offset to locate cpu entries
>   s390/sclp: add extended-length sccb support for kvm guest
>   s390: guest support for diagnose 0x318
>
> Cornelia Huck (1):
>   vfio-ccw: plug memory leak while getting region info
>
> David Hildenbrand (10):
>   s390x/tcg: Implement MONITOR CALL
>   s390x/cpumodel: S390_FEAT_MISC_INSTRUCTION_EXT ->
>     S390_FEAT_MISC_INSTRUCTION_EXT2
>   s390x/tcg: Implement ADD HALFWORD (AGH)
>   s390x/tcg: Implement SUBTRACT HALFWORD (SGH)
>   s390x/tcg: Implement MULTIPLY (MG, MGRK)
>   s390x/tcg: Implement MULTIPLY HALFWORD (MGH)
>   s390x/tcg: Implement BRANCH INDIRECT ON CONDITION (BIC)
>   s390x/tcg: Implement MULTIPLY SINGLE (MSC, MSGC, MSGRKC, MSRKC)
>   s390x/tcg: We support Miscellaneous-Instruction-Extensions Facility 2
>   s390x/tcg: Implement CIPHER MESSAGE WITH AUTHENTICATION (KMA)
>
> Dr. David Alan Gilbert (1):
>   qemu-io-cmds: Simplify help_oneline
>
> John Snow (8):
>   MAINTAINERS: Update my git address
>   ide: rename cmd_write to ctrl_write
>   ide: don't tamper with the device register
>   ide: model HOB correctly
>   ide: reorder set/get sector functions
>   ide: remove magic constants from the device register
>   ide: clear interrupt on command write
>   ide: cancel pending callbacks on SRST
>
> Kevin Wolf (32):
>   nbd: Remove unused nbd_export_get_blockdev()
>   qapi: Create block-export module
>   qapi: Rename BlockExport to BlockExportOptions
>   block/export: Add BlockExport infrastructure and block-export-add
>   qemu-storage-daemon: Use qmp_block_export_add()
>   qemu-nbd: Use raw block driver for --offset
>   block/export: Remove magic from block-export-add
>   nbd: Add max-connections to nbd-server-start
>   nbd: Add writethrough to block-export-add
>   nbd: Remove NBDExport.close callback
>   qemu-nbd: Use blk_exp_add() to create the export
>   nbd/server: Simplify export shutdown
>   block/export: Move refcount from NBDExport to BlockExport
>   block/export: Move AioContext from NBDExport to BlockExport
>   block/export: Add node-name to BlockExportOptions
>   block/export: Allocate BlockExport in blk_exp_add()
>   block/export: Add blk_exp_close_all(_type)
>   block/export: Add 'id' option to block-export-add
>   block/export: Move strong user reference to block_exports
>   block/export: Add block-export-del
>   block/export: Add BLOCK_EXPORT_DELETED event
>   block/export: Move blk to BlockExport
>   block/export: Create BlockBackend in blk_exp_add()
>   block/export: Add query-block-exports
>   block/export: Move writable to BlockExportOptions
>   nbd: Merge nbd_export_new() and nbd_export_create()
>   nbd: Deprecate nbd-server-add/remove
>   iotests: Factor out qemu_tool_pipe_and_status()
>   iotests: Introduce qemu_nbd_list_log()
>   iotests: Allow supported and unsupported formats at the same time
>   iotests: Test block-export-* QMP interface
>   qemu-storage-daemon: Fix help line for --export
>
> Paolo Bonzini (17):
>   travis: remove TCI test
>   default-configs: move files to default-configs/devices/
>   configure: convert accelerator variables to meson options
>   configure: rewrite accelerator defaults as tests
>   configure: move accelerator logic to meson
>   configure: remove dead variable
>   configure: compute derivatives of target name in meson
>   configure: remove useless config-target.mak symbols
>   configure: remove target configuration
>   default-configs: remove default-configs/devices for user-mode targets
>   configure: move OpenBSD W^X test to meson
>   default-configs: use TARGET_ARCH key
>   default-configs: remove redundant keys
>   meson: move sparse detection to Meson and rewrite check_sparse.py
>   tests: tcg: do not use implicit rules
>   dockerfiles: add diffutils to Fedora
>   readthedocs: build with Python 3.6
>
> Peter Maydell (5):
>   target/arm: Replace ARM_FEATURE_PXN with ID_MMFR0.VMSA check
>   target/arm: Move id_pfr0, id_pfr1 into ARMISARegisters
>   hw/intc/armv7m_nvic: Only show ID register values for Main Extension
>     CPUs
>   target/arm: Add ID register values for Cortex-M0
>   target/arm: Make isar_feature_aa32_fp16_arith() handle M-profile
>
> Philippe Mathieu-Daud=3DC3=3DA9 (14):
>   hw/arm/raspi: Define various blocks base addresses
>   hw/arm/bcm2835: Add more unimplemented peripherals
>   hw/arm/raspi: Remove ignore_memory_transaction_failures on the raspi2
>   hw/arm/raspi: Display the board revision in the machine description
>   hw/arm/raspi: Load the firmware on the first core
>   hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState
>   hw/arm/raspi: Avoid using TypeInfo::class_data pointer
>   hw/arm/raspi: Use more specific machine names
>   hw/arm/raspi: Introduce RaspiProcessorId enum
>   hw/arm/raspi: Use RaspiProcessorId to set the firmware load address
>   hw/arm/raspi: Remove use of the 'version' value in the board code
>   hw/ide/ahci: Do not dma_memory_unmap(NULL)
>   hw/s390x/css: Remove double initialization
>   block/sheepdog: Replace magic val by NANOSECONDS_PER_SECOND definition
>
> Richard Henderson (13):
>   target/arm: Fix sve ldr/str
>   target/arm: Fix SVE splice
>   capstone: Convert Makefile bits to meson bits
>   capstone: Update to upstream "next" branch
>   capstone: Require version 4.0 from a system library
>   disas: Move host asm annotations to tb_gen_code
>   disas: Clean up CPUDebug initialization
>   disas: Use qemu/bswap.h for bfd endian loads
>   disas: Cleanup plugin_disas
>   disas: Configure capstone for aarch64 host without libvixl
>   disas: Split out capstone code to disas/capstone.c
>   disas: Enable capstone disassembly for s390x
>   disas/capstone: Add skipdata hook for s390x
>
> Thomas Huth (13):
>   migration: Silence compiler warning in global_state_store_running()
>   travis.yml: Drop the default softmmu builds
>   travis.yml: Update Travis to use Bionic and Focal instead of Xenial
>   travis.yml: Drop the superfluous Python 3.6 build
>   travis.yml: Drop the Python 3.5 build
>   tests/docker: Use Fedora containers for MinGW cross-builds in the
>     gitlab-CI
>   gitlab-ci: Remove the Debian9-based containers and containers-layer3
>   tests/docker: Update the tricore container to debian 10
>   shippable.yml: Remove the Debian9-based MinGW cross-compiler tests
>   tests/docker: Remove old Debian 9 containers
>   gitlab-ci: Increase the timeout for the cross-compiler builds
>   configure: Bump the minimum required Python version to 3.6
>   tests/check-block: Do not run the iotests with old versions of bash
>
> Yonggang Luo (5):
>   gitignore: ignore a bit more
>   configure: fixes indent of $meson setup
>   curses: Fixes compiler error that complain don't have langinfo.h on
>     msys2/mingw
>   curses: Fixes curses compiling errors.
>   win32: Simplify gmtime_r detection not depends on if  _POSIX_C_SOURCE
>     are defined on msys2/mingw
>
> Zhenwei Pi (3):
>   target-i386: seperate MCIP & MCE_MASK error reason
>   qapi/run-state.json: introduce memory failure event
>   target-i386: post memory failure event to QMP
>
> --=3D20
> 2.28.0.windows.1
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000214d9c05b0ee93ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Err, sorry for this, don&#39;t know if this would broken t=
he patchew<br><br>On Mon, Oct 5, 2020 at 11:54 PM Yonggang Luo &lt;<a href=
=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt; wrote:<br>&=
gt;<br>&gt; V7-V8<br>&gt; Rebase to master and =C2=A0resolve conflict of<br=
>&gt; *configure: fixes indent of $meson setup<br>&gt;<br>&gt; V6-V7<br>&gt=
; Update the configure script for<br>&gt; * curses: Fixes compiler error th=
at complain don&#39;t have langinfo.h on msys2/m=3D<br>&gt; ingw<br>&gt;<br=
>&gt; V5-V6<br>&gt; Dropping configure: Fixes ncursesw detection under msys=
2/mingw by convert the=3D<br>&gt; m to meson first.<br>&gt; That need the m=
eson 0.56 upstream to fixes the curses detection.<br>&gt; Add<br>&gt; * con=
figure: fixes indent of $meson setup<br>&gt;<br>&gt; Alberto Garcia (2):<br=
>&gt; =C2=A0 docs: Document the throttle block filter<br>&gt; =C2=A0 qcow2:=
 Use L1E_SIZE in qcow2_write_l1_entry()<br>&gt;<br>&gt; Alex Benn=3DC3=3DA9=
e (2):<br>&gt; =C2=A0 gitlab: move linux-user plugins test across to gitlab=
<br>&gt; =C2=A0 gitlab: split deprecated job into build/check stages<br>&gt=
;<br>&gt; Collin L. Walling (7):<br>&gt; =C2=A0 s390/sclp: get machine once=
 during read scp/cpu info<br>&gt; =C2=A0 s390/sclp: rework sclp boundary ch=
ecks<br>&gt; =C2=A0 s390/sclp: read sccb from mem based on provided length<=
br>&gt; =C2=A0 s390/sclp: check sccb len before filling in data<br>&gt; =C2=
=A0 s390/sclp: use cpu offset to locate cpu entries<br>&gt; =C2=A0 s390/scl=
p: add extended-length sccb support for kvm guest<br>&gt; =C2=A0 s390: gues=
t support for diagnose 0x318<br>&gt;<br>&gt; Cornelia Huck (1):<br>&gt; =C2=
=A0 vfio-ccw: plug memory leak while getting region info<br>&gt;<br>&gt; Da=
vid Hildenbrand (10):<br>&gt; =C2=A0 s390x/tcg: Implement MONITOR CALL<br>&=
gt; =C2=A0 s390x/cpumodel: S390_FEAT_MISC_INSTRUCTION_EXT -&gt;<br>&gt; =C2=
=A0 =C2=A0 S390_FEAT_MISC_INSTRUCTION_EXT2<br>&gt; =C2=A0 s390x/tcg: Implem=
ent ADD HALFWORD (AGH)<br>&gt; =C2=A0 s390x/tcg: Implement SUBTRACT HALFWOR=
D (SGH)<br>&gt; =C2=A0 s390x/tcg: Implement MULTIPLY (MG, MGRK)<br>&gt; =C2=
=A0 s390x/tcg: Implement MULTIPLY HALFWORD (MGH)<br>&gt; =C2=A0 s390x/tcg: =
Implement BRANCH INDIRECT ON CONDITION (BIC)<br>&gt; =C2=A0 s390x/tcg: Impl=
ement MULTIPLY SINGLE (MSC, MSGC, MSGRKC, MSRKC)<br>&gt; =C2=A0 s390x/tcg: =
We support Miscellaneous-Instruction-Extensions Facility 2<br>&gt; =C2=A0 s=
390x/tcg: Implement CIPHER MESSAGE WITH AUTHENTICATION (KMA)<br>&gt;<br>&gt=
; Dr. David Alan Gilbert (1):<br>&gt; =C2=A0 qemu-io-cmds: Simplify help_on=
eline<br>&gt;<br>&gt; John Snow (8):<br>&gt; =C2=A0 MAINTAINERS: Update my =
git address<br>&gt; =C2=A0 ide: rename cmd_write to ctrl_write<br>&gt; =C2=
=A0 ide: don&#39;t tamper with the device register<br>&gt; =C2=A0 ide: mode=
l HOB correctly<br>&gt; =C2=A0 ide: reorder set/get sector functions<br>&gt=
; =C2=A0 ide: remove magic constants from the device register<br>&gt; =C2=
=A0 ide: clear interrupt on command write<br>&gt; =C2=A0 ide: cancel pendin=
g callbacks on SRST<br>&gt;<br>&gt; Kevin Wolf (32):<br>&gt; =C2=A0 nbd: Re=
move unused nbd_export_get_blockdev()<br>&gt; =C2=A0 qapi: Create block-exp=
ort module<br>&gt; =C2=A0 qapi: Rename BlockExport to BlockExportOptions<br=
>&gt; =C2=A0 block/export: Add BlockExport infrastructure and block-export-=
add<br>&gt; =C2=A0 qemu-storage-daemon: Use qmp_block_export_add()<br>&gt; =
=C2=A0 qemu-nbd: Use raw block driver for --offset<br>&gt; =C2=A0 block/exp=
ort: Remove magic from block-export-add<br>&gt; =C2=A0 nbd: Add max-connect=
ions to nbd-server-start<br>&gt; =C2=A0 nbd: Add writethrough to block-expo=
rt-add<br>&gt; =C2=A0 nbd: Remove NBDExport.close callback<br>&gt; =C2=A0 q=
emu-nbd: Use blk_exp_add() to create the export<br>&gt; =C2=A0 nbd/server: =
Simplify export shutdown<br>&gt; =C2=A0 block/export: Move refcount from NB=
DExport to BlockExport<br>&gt; =C2=A0 block/export: Move AioContext from NB=
DExport to BlockExport<br>&gt; =C2=A0 block/export: Add node-name to BlockE=
xportOptions<br>&gt; =C2=A0 block/export: Allocate BlockExport in blk_exp_a=
dd()<br>&gt; =C2=A0 block/export: Add blk_exp_close_all(_type)<br>&gt; =C2=
=A0 block/export: Add &#39;id&#39; option to block-export-add<br>&gt; =C2=
=A0 block/export: Move strong user reference to block_exports<br>&gt; =C2=
=A0 block/export: Add block-export-del<br>&gt; =C2=A0 block/export: Add BLO=
CK_EXPORT_DELETED event<br>&gt; =C2=A0 block/export: Move blk to BlockExpor=
t<br>&gt; =C2=A0 block/export: Create BlockBackend in blk_exp_add()<br>&gt;=
 =C2=A0 block/export: Add query-block-exports<br>&gt; =C2=A0 block/export: =
Move writable to BlockExportOptions<br>&gt; =C2=A0 nbd: Merge nbd_export_ne=
w() and nbd_export_create()<br>&gt; =C2=A0 nbd: Deprecate nbd-server-add/re=
move<br>&gt; =C2=A0 iotests: Factor out qemu_tool_pipe_and_status()<br>&gt;=
 =C2=A0 iotests: Introduce qemu_nbd_list_log()<br>&gt; =C2=A0 iotests: Allo=
w supported and unsupported formats at the same time<br>&gt; =C2=A0 iotests=
: Test block-export-* QMP interface<br>&gt; =C2=A0 qemu-storage-daemon: Fix=
 help line for --export<br>&gt;<br>&gt; Paolo Bonzini (17):<br>&gt; =C2=A0 =
travis: remove TCI test<br>&gt; =C2=A0 default-configs: move files to defau=
lt-configs/devices/<br>&gt; =C2=A0 configure: convert accelerator variables=
 to meson options<br>&gt; =C2=A0 configure: rewrite accelerator defaults as=
 tests<br>&gt; =C2=A0 configure: move accelerator logic to meson<br>&gt; =
=C2=A0 configure: remove dead variable<br>&gt; =C2=A0 configure: compute de=
rivatives of target name in meson<br>&gt; =C2=A0 configure: remove useless =
config-target.mak symbols<br>&gt; =C2=A0 configure: remove target configura=
tion<br>&gt; =C2=A0 default-configs: remove default-configs/devices for use=
r-mode targets<br>&gt; =C2=A0 configure: move OpenBSD W^X test to meson<br>=
&gt; =C2=A0 default-configs: use TARGET_ARCH key<br>&gt; =C2=A0 default-con=
figs: remove redundant keys<br>&gt; =C2=A0 meson: move sparse detection to =
Meson and rewrite check_sparse.py<br>&gt; =C2=A0 tests: tcg: do not use imp=
licit rules<br>&gt; =C2=A0 dockerfiles: add diffutils to Fedora<br>&gt; =C2=
=A0 readthedocs: build with Python 3.6<br>&gt;<br>&gt; Peter Maydell (5):<b=
r>&gt; =C2=A0 target/arm: Replace ARM_FEATURE_PXN with ID_MMFR0.VMSA check<=
br>&gt; =C2=A0 target/arm: Move id_pfr0, id_pfr1 into ARMISARegisters<br>&g=
t; =C2=A0 hw/intc/armv7m_nvic: Only show ID register values for Main Extens=
ion<br>&gt; =C2=A0 =C2=A0 CPUs<br>&gt; =C2=A0 target/arm: Add ID register v=
alues for Cortex-M0<br>&gt; =C2=A0 target/arm: Make isar_feature_aa32_fp16_=
arith() handle M-profile<br>&gt;<br>&gt; Philippe Mathieu-Daud=3DC3=3DA9 (1=
4):<br>&gt; =C2=A0 hw/arm/raspi: Define various blocks base addresses<br>&g=
t; =C2=A0 hw/arm/bcm2835: Add more unimplemented peripherals<br>&gt; =C2=A0=
 hw/arm/raspi: Remove ignore_memory_transaction_failures on the raspi2<br>&=
gt; =C2=A0 hw/arm/raspi: Display the board revision in the machine descript=
ion<br>&gt; =C2=A0 hw/arm/raspi: Load the firmware on the first core<br>&gt=
; =C2=A0 hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState<br=
>&gt; =C2=A0 hw/arm/raspi: Avoid using TypeInfo::class_data pointer<br>&gt;=
 =C2=A0 hw/arm/raspi: Use more specific machine names<br>&gt; =C2=A0 hw/arm=
/raspi: Introduce RaspiProcessorId enum<br>&gt; =C2=A0 hw/arm/raspi: Use Ra=
spiProcessorId to set the firmware load address<br>&gt; =C2=A0 hw/arm/raspi=
: Remove use of the &#39;version&#39; value in the board code<br>&gt; =C2=
=A0 hw/ide/ahci: Do not dma_memory_unmap(NULL)<br>&gt; =C2=A0 hw/s390x/css:=
 Remove double initialization<br>&gt; =C2=A0 block/sheepdog: Replace magic =
val by NANOSECONDS_PER_SECOND definition<br>&gt;<br>&gt; Richard Henderson =
(13):<br>&gt; =C2=A0 target/arm: Fix sve ldr/str<br>&gt; =C2=A0 target/arm:=
 Fix SVE splice<br>&gt; =C2=A0 capstone: Convert Makefile bits to meson bit=
s<br>&gt; =C2=A0 capstone: Update to upstream &quot;next&quot; branch<br>&g=
t; =C2=A0 capstone: Require version 4.0 from a system library<br>&gt; =C2=
=A0 disas: Move host asm annotations to tb_gen_code<br>&gt; =C2=A0 disas: C=
lean up CPUDebug initialization<br>&gt; =C2=A0 disas: Use qemu/bswap.h for =
bfd endian loads<br>&gt; =C2=A0 disas: Cleanup plugin_disas<br>&gt; =C2=A0 =
disas: Configure capstone for aarch64 host without libvixl<br>&gt; =C2=A0 d=
isas: Split out capstone code to disas/capstone.c<br>&gt; =C2=A0 disas: Ena=
ble capstone disassembly for s390x<br>&gt; =C2=A0 disas/capstone: Add skipd=
ata hook for s390x<br>&gt;<br>&gt; Thomas Huth (13):<br>&gt; =C2=A0 migrati=
on: Silence compiler warning in global_state_store_running()<br>&gt; =C2=A0=
 travis.yml: Drop the default softmmu builds<br>&gt; =C2=A0 travis.yml: Upd=
ate Travis to use Bionic and Focal instead of Xenial<br>&gt; =C2=A0 travis.=
yml: Drop the superfluous Python 3.6 build<br>&gt; =C2=A0 travis.yml: Drop =
the Python 3.5 build<br>&gt; =C2=A0 tests/docker: Use Fedora containers for=
 MinGW cross-builds in the<br>&gt; =C2=A0 =C2=A0 gitlab-CI<br>&gt; =C2=A0 g=
itlab-ci: Remove the Debian9-based containers and containers-layer3<br>&gt;=
 =C2=A0 tests/docker: Update the tricore container to debian 10<br>&gt; =C2=
=A0 shippable.yml: Remove the Debian9-based MinGW cross-compiler tests<br>&=
gt; =C2=A0 tests/docker: Remove old Debian 9 containers<br>&gt; =C2=A0 gitl=
ab-ci: Increase the timeout for the cross-compiler builds<br>&gt; =C2=A0 co=
nfigure: Bump the minimum required Python version to 3.6<br>&gt; =C2=A0 tes=
ts/check-block: Do not run the iotests with old versions of bash<br>&gt;<br=
>&gt; Yonggang Luo (5):<br>&gt; =C2=A0 gitignore: ignore a bit more<br>&gt;=
 =C2=A0 configure: fixes indent of $meson setup<br>&gt; =C2=A0 curses: Fixe=
s compiler error that complain don&#39;t have langinfo.h on<br>&gt; =C2=A0 =
=C2=A0 msys2/mingw<br>&gt; =C2=A0 curses: Fixes curses compiling errors.<br=
>&gt; =C2=A0 win32: Simplify gmtime_r detection not depends on if =C2=A0_PO=
SIX_C_SOURCE<br>&gt; =C2=A0 =C2=A0 are defined on msys2/mingw<br>&gt;<br>&g=
t; Zhenwei Pi (3):<br>&gt; =C2=A0 target-i386: seperate MCIP &amp; MCE_MASK=
 error reason<br>&gt; =C2=A0 qapi/run-state.json: introduce memory failure =
event<br>&gt; =C2=A0 target-i386: post memory failure event to QMP<br>&gt;<=
br>&gt; --=3D20<br>&gt; 2.28.0.windows.1<br>&gt;<br><br><br>--<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=
=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div>

--000000000000214d9c05b0ee93ad--

