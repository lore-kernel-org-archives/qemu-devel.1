Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A885C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:57:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC8A20663
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlfTlyCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC8A20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPSrV-00055D-31
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 11:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPSpA-0003HO-Mv; Mon, 05 Oct 2020 11:54:54 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:39662)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPSp7-0001Fq-5s; Mon, 05 Oct 2020 11:54:52 -0400
Received: by mail-pf1-x436.google.com with SMTP id n14so7202584pff.6;
 Mon, 05 Oct 2020 08:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bdWU4wrjYNuaHQHVjFcmCzZGZiYY+AIjBKXfUple+wU=;
 b=XlfTlyCj03Of6zSHqhzs1N9lGflfpy1jJsCStP//ynR2qvTQY6VgJaEHKfzNEbB36p
 R/OrFXI7ZxlYRo9w/DmqEmQaBhjnFq5PTbZ0JFlmsgqrrBo5tR2EOT0kVQ1wcCBRmQYs
 Lv+fbtLop+37Oa7lJ0Vl5UAlEM7Cwg+abKYG2gxjvkcXyvPNIklY+DeLw4WzEBoetBX9
 ItniN1yMX+kH2BRyttAoiFrg9qy4jcMR7GuNuDwyjwXPottZABxEyIqFvPiY3vU/9Z05
 FLHRNyXbtApdkQDW7QOyQdk7fAktUeG4HvHlAeO69BHDgS5RnzuGmR6xBbCcvYVa2pUh
 6mFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bdWU4wrjYNuaHQHVjFcmCzZGZiYY+AIjBKXfUple+wU=;
 b=ugl6M8gNO4Sw6HoSyXej/fqPDRVi20KYkhUYqKrVzh6jCtJfGAW4r4QwnxVO05wMoP
 hWiW/YZZNC5dGcHw7Kguwif/lMwH85i7Ti8AjwcwHTZyez99Ufa13eeQsKmjus8SspUq
 4nkzk30YEhDmvUBwqUod0iWQovFg5CVOphGsBqg7nnaV2muqq594Dt8EVAU2TfPJmehb
 01b/2Emz7Yb2tuIuNpC7y8ySEXeQtWP7FsAQ5cTyb4O3HSMCnaRwTJZF17CpD94IJm2K
 6aiCJ3vy00zCLEaAeOydN6JZxguTutxlBW2GGRujsVGPq+Om1JAWzuNqTOcTohTLqR58
 +JFQ==
X-Gm-Message-State: AOAM533cf5E4a1YoZX+p/ypE3Fe+Ecq0+3t35mPa1ikkFEHfgdRgfk1n
 PQgxlHuokXKXwCax+y3Y2utONKpjisY69w==
X-Google-Smtp-Source: ABdhPJwShoMXHomK5XAKSTlV5oqbTOMzHhLJPSSHfLB9BgEapxbTcYtxXMt517/D9zvuaCHRWhFjBQ==
X-Received: by 2002:a05:6a00:1585:b029:142:2501:39f5 with SMTP id
 u5-20020a056a001585b0290142250139f5mr144503pfk.68.1601913285216; 
 Mon, 05 Oct 2020 08:54:45 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id z18sm311873pfn.158.2020.10.05.08.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 08:54:44 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v8 000/133] Fixes curses on msys2/mingw
Date: Mon,  5 Oct 2020 23:52:13 +0800
Message-Id: <20201005155426.413-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

V7-V8=0D
Rebase to master and  resolve conflict of=0D
*configure: fixes indent of $meson setup=0D
=0D
V6-V7=0D
Update the configure script for=0D
* curses: Fixes compiler error that complain don't have langinfo.h on msys2=
/m=3D=0D
ingw=0D
=0D
V5-V6=0D
Dropping configure: Fixes ncursesw detection under msys2/mingw by convert t=
he=3D=0D
m to meson first.=0D
That need the meson 0.56 upstream to fixes the curses detection.=0D
Add=0D
* configure: fixes indent of $meson setup=0D
=0D
Alberto Garcia (2):=0D
  docs: Document the throttle block filter=0D
  qcow2: Use L1E_SIZE in qcow2_write_l1_entry()=0D
=0D
Alex Benn=3DC3=3DA9e (2):=0D
  gitlab: move linux-user plugins test across to gitlab=0D
  gitlab: split deprecated job into build/check stages=0D
=0D
Collin L. Walling (7):=0D
  s390/sclp: get machine once during read scp/cpu info=0D
  s390/sclp: rework sclp boundary checks=0D
  s390/sclp: read sccb from mem based on provided length=0D
  s390/sclp: check sccb len before filling in data=0D
  s390/sclp: use cpu offset to locate cpu entries=0D
  s390/sclp: add extended-length sccb support for kvm guest=0D
  s390: guest support for diagnose 0x318=0D
=0D
Cornelia Huck (1):=0D
  vfio-ccw: plug memory leak while getting region info=0D
=0D
David Hildenbrand (10):=0D
  s390x/tcg: Implement MONITOR CALL=0D
  s390x/cpumodel: S390_FEAT_MISC_INSTRUCTION_EXT ->=0D
    S390_FEAT_MISC_INSTRUCTION_EXT2=0D
  s390x/tcg: Implement ADD HALFWORD (AGH)=0D
  s390x/tcg: Implement SUBTRACT HALFWORD (SGH)=0D
  s390x/tcg: Implement MULTIPLY (MG, MGRK)=0D
  s390x/tcg: Implement MULTIPLY HALFWORD (MGH)=0D
  s390x/tcg: Implement BRANCH INDIRECT ON CONDITION (BIC)=0D
  s390x/tcg: Implement MULTIPLY SINGLE (MSC, MSGC, MSGRKC, MSRKC)=0D
  s390x/tcg: We support Miscellaneous-Instruction-Extensions Facility 2=0D
  s390x/tcg: Implement CIPHER MESSAGE WITH AUTHENTICATION (KMA)=0D
=0D
Dr. David Alan Gilbert (1):=0D
  qemu-io-cmds: Simplify help_oneline=0D
=0D
John Snow (8):=0D
  MAINTAINERS: Update my git address=0D
  ide: rename cmd_write to ctrl_write=0D
  ide: don't tamper with the device register=0D
  ide: model HOB correctly=0D
  ide: reorder set/get sector functions=0D
  ide: remove magic constants from the device register=0D
  ide: clear interrupt on command write=0D
  ide: cancel pending callbacks on SRST=0D
=0D
Kevin Wolf (32):=0D
  nbd: Remove unused nbd_export_get_blockdev()=0D
  qapi: Create block-export module=0D
  qapi: Rename BlockExport to BlockExportOptions=0D
  block/export: Add BlockExport infrastructure and block-export-add=0D
  qemu-storage-daemon: Use qmp_block_export_add()=0D
  qemu-nbd: Use raw block driver for --offset=0D
  block/export: Remove magic from block-export-add=0D
  nbd: Add max-connections to nbd-server-start=0D
  nbd: Add writethrough to block-export-add=0D
  nbd: Remove NBDExport.close callback=0D
  qemu-nbd: Use blk_exp_add() to create the export=0D
  nbd/server: Simplify export shutdown=0D
  block/export: Move refcount from NBDExport to BlockExport=0D
  block/export: Move AioContext from NBDExport to BlockExport=0D
  block/export: Add node-name to BlockExportOptions=0D
  block/export: Allocate BlockExport in blk_exp_add()=0D
  block/export: Add blk_exp_close_all(_type)=0D
  block/export: Add 'id' option to block-export-add=0D
  block/export: Move strong user reference to block_exports=0D
  block/export: Add block-export-del=0D
  block/export: Add BLOCK_EXPORT_DELETED event=0D
  block/export: Move blk to BlockExport=0D
  block/export: Create BlockBackend in blk_exp_add()=0D
  block/export: Add query-block-exports=0D
  block/export: Move writable to BlockExportOptions=0D
  nbd: Merge nbd_export_new() and nbd_export_create()=0D
  nbd: Deprecate nbd-server-add/remove=0D
  iotests: Factor out qemu_tool_pipe_and_status()=0D
  iotests: Introduce qemu_nbd_list_log()=0D
  iotests: Allow supported and unsupported formats at the same time=0D
  iotests: Test block-export-* QMP interface=0D
  qemu-storage-daemon: Fix help line for --export=0D
=0D
Paolo Bonzini (17):=0D
  travis: remove TCI test=0D
  default-configs: move files to default-configs/devices/=0D
  configure: convert accelerator variables to meson options=0D
  configure: rewrite accelerator defaults as tests=0D
  configure: move accelerator logic to meson=0D
  configure: remove dead variable=0D
  configure: compute derivatives of target name in meson=0D
  configure: remove useless config-target.mak symbols=0D
  configure: remove target configuration=0D
  default-configs: remove default-configs/devices for user-mode targets=0D
  configure: move OpenBSD W^X test to meson=0D
  default-configs: use TARGET_ARCH key=0D
  default-configs: remove redundant keys=0D
  meson: move sparse detection to Meson and rewrite check_sparse.py=0D
  tests: tcg: do not use implicit rules=0D
  dockerfiles: add diffutils to Fedora=0D
  readthedocs: build with Python 3.6=0D
=0D
Peter Maydell (5):=0D
  target/arm: Replace ARM_FEATURE_PXN with ID_MMFR0.VMSA check=0D
  target/arm: Move id_pfr0, id_pfr1 into ARMISARegisters=0D
  hw/intc/armv7m_nvic: Only show ID register values for Main Extension=0D
    CPUs=0D
  target/arm: Add ID register values for Cortex-M0=0D
  target/arm: Make isar_feature_aa32_fp16_arith() handle M-profile=0D
=0D
Philippe Mathieu-Daud=3DC3=3DA9 (14):=0D
  hw/arm/raspi: Define various blocks base addresses=0D
  hw/arm/bcm2835: Add more unimplemented peripherals=0D
  hw/arm/raspi: Remove ignore_memory_transaction_failures on the raspi2=0D
  hw/arm/raspi: Display the board revision in the machine description=0D
  hw/arm/raspi: Load the firmware on the first core=0D
  hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState=0D
  hw/arm/raspi: Avoid using TypeInfo::class_data pointer=0D
  hw/arm/raspi: Use more specific machine names=0D
  hw/arm/raspi: Introduce RaspiProcessorId enum=0D
  hw/arm/raspi: Use RaspiProcessorId to set the firmware load address=0D
  hw/arm/raspi: Remove use of the 'version' value in the board code=0D
  hw/ide/ahci: Do not dma_memory_unmap(NULL)=0D
  hw/s390x/css: Remove double initialization=0D
  block/sheepdog: Replace magic val by NANOSECONDS_PER_SECOND definition=0D
=0D
Richard Henderson (13):=0D
  target/arm: Fix sve ldr/str=0D
  target/arm: Fix SVE splice=0D
  capstone: Convert Makefile bits to meson bits=0D
  capstone: Update to upstream "next" branch=0D
  capstone: Require version 4.0 from a system library=0D
  disas: Move host asm annotations to tb_gen_code=0D
  disas: Clean up CPUDebug initialization=0D
  disas: Use qemu/bswap.h for bfd endian loads=0D
  disas: Cleanup plugin_disas=0D
  disas: Configure capstone for aarch64 host without libvixl=0D
  disas: Split out capstone code to disas/capstone.c=0D
  disas: Enable capstone disassembly for s390x=0D
  disas/capstone: Add skipdata hook for s390x=0D
=0D
Thomas Huth (13):=0D
  migration: Silence compiler warning in global_state_store_running()=0D
  travis.yml: Drop the default softmmu builds=0D
  travis.yml: Update Travis to use Bionic and Focal instead of Xenial=0D
  travis.yml: Drop the superfluous Python 3.6 build=0D
  travis.yml: Drop the Python 3.5 build=0D
  tests/docker: Use Fedora containers for MinGW cross-builds in the=0D
    gitlab-CI=0D
  gitlab-ci: Remove the Debian9-based containers and containers-layer3=0D
  tests/docker: Update the tricore container to debian 10=0D
  shippable.yml: Remove the Debian9-based MinGW cross-compiler tests=0D
  tests/docker: Remove old Debian 9 containers=0D
  gitlab-ci: Increase the timeout for the cross-compiler builds=0D
  configure: Bump the minimum required Python version to 3.6=0D
  tests/check-block: Do not run the iotests with old versions of bash=0D
=0D
Yonggang Luo (5):=0D
  gitignore: ignore a bit more=0D
  configure: fixes indent of $meson setup=0D
  curses: Fixes compiler error that complain don't have langinfo.h on=0D
    msys2/mingw=0D
  curses: Fixes curses compiling errors.=0D
  win32: Simplify gmtime_r detection not depends on if  _POSIX_C_SOURCE=0D
    are defined on msys2/mingw=0D
=0D
Zhenwei Pi (3):=0D
  target-i386: seperate MCIP & MCE_MASK error reason=0D
  qapi/run-state.json: introduce memory failure event=0D
  target-i386: post memory failure event to QMP=0D
=0D
--=3D20=0D
2.28.0.windows.1=0D
=0D

