Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2FBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 13:56:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D5FA2070C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 13:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5FA2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsRbk-00013S-8G
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 09:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jsRbA-0000dA-7l
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 09:55:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:59330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jsRb7-0006Gv-Bl
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 09:55:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jsRb5-0007k8-BF
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 13:55:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 502CF2E8052
 for <qemu-devel@nongnu.org>; Mon,  6 Jul 2020 13:55:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2020 13:48:56 -0000
From: "Emilio G. Cota" <1885827@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: plugins windows
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee casmac cota
X-Launchpad-Bug-Reporter: Xiaolei (casmac)
X-Launchpad-Bug-Modifier: Emilio G. Cota (cota)
References: <159357217483.1717.4076077243388027502.malonedeb@chaenomeles.canonical.com>
Message-Id: <159404333671.32118.9790463522303938909.malone@wampee.canonical.com>
Subject: [Bug 1885827] Re: building plugin failed on Windows with mingw
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="ffd32ad7291fe66b5578d7c1407aaae58d1e0170";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: f4c0ea3399c6abc6f9d2e684f508c9a656f86c18
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 09:55:51
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1885827 <1885827@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

You're getting close.

1. From the build directory, find the import library created, e.g. `find
. -name 'libqemu_plugin.dll.a'`. If you're building x86_64-linux-user,
it should be in `x86_64-linux-user/libqemu_plugin.dll.a`.

2. Go back to the `build/tests/plugin` directory.

3. Link the empty plugin with:
x86_64-w64-mingw32-gcc -shared -Wl,-soname,libempty.so -o libempty.so empty=
.o -L/path/to/libqemu_plugin.dll.a/directory -lqemu_plugin.dll

Note the added -L and -l flags.

If that works, move on to the other plugins, although you might have to
comment out the glib-dependent code. But let's not go there yet; try to
build the empty plugin first.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1885827

Title:
  building plugin failed on Windows with mingw

Status in QEMU:
  New

Bug description:
  I want to build QEMU 4.2.0's plugin module on Windows 7/10 with Mingw, bu=
t the building process faild.
   =

  The step I follow is listed below:
  1. create "dsp_build" diretory under source file folder

  2.  change directory to dsp_build , and run ../configure --target-list=3D=
dsp-softmmu --cross-prefix=3Dx86_64-w64-mingw32- --enable-gtk --enable-sdl =
--enable-debug --enable-plugins
  3. build qemu project
  4. switch dir to /dsp_build, make -C tests/plugin, yeilds error: =

     CC      bb.o
   D:/emu_devl/qemu_src/qemu-sr-dsp-a/qemu_tidsp_c3x/tests/plugin/bb.c:17:2=
4: error: variable 'qemu_plugin_version' definition is marked dllimport
     17 | QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSIO=
N;
        |                        ^~~~~~~~~~~~~~~~~~~
   D:/emu_devl/qemu_src/qemu-sr-dsp-a/qemu_tidsp_c3x/tests/plugin/bb.c:17:2=
4: warning: 'qemu_plugin_version' redeclared without dllimport attribute: p=
revious dllimport ignored [-Wattributes]
   D:/emu_devl/qemu_src/qemu-sr-dsp-a/qemu_tidsp_c3x/tests/plugin/bb.c: In =
function 'vcpu_tb_exec':
   D:/emu_devl/qemu_src/qemu-sr-dsp-a/qemu_tidsp_c3x/tests/plugin/bb.c:33:2=
9: warning: cast from pointer to integer of different size [-Wpointer-to-in=
t-cast]
     33 |     unsigned long n_insns =3D (unsigned long)udata;
        |                             ^
   D:/emu_devl/qemu_src/qemu-sr-dsp-a/qemu_tidsp_c3x/tests/plugin/bb.c: In =
function 'vcpu_tb_trans':
   D:/emu_devl/qemu_src/qemu-sr-dsp-a/qemu_tidsp_c3x/tests/plugin/bb.c:51:4=
6: warning: cast to pointer from integer of different size [-Wint-to-pointe=
r-cast]
     51 |                                              (void *)n_insns);

  5.  Then , I modified the QEMU_flags and the compilation command
  arguments($(CC) ..) in  the  makefile :

                  BUILD_DIR :=3D $(CURDIR)/../..

  		include $(BUILD_DIR)/config-host.mak
  		include $(SRC_PATH)/rules.mak

                  $(call set-vpath, $(SRC_PATH)/tests/plugin)

  		NAMES :=3D
  		NAMES +=3D bb
  		NAMES +=3D empty
  		NAMES +=3D insn
  		NAMES +=3D mem
  		NAMES +=3D hotblocks
  		NAMES +=3D howvec
  		NAMES +=3D hotpages

                  SONAMES :=3D $(addsuffix .so,$(addprefix lib,$(NAMES)))

  		QEMU_CFLAGS +=3D -fPIC	-DBUILDING_DLL  		#added  -DBUILDING_DLL
  		QEMU_CFLAGS +=3D -I$(SRC_PATH)/include/qemu

                  all: $(SONAMES)

  		lib%.so: %.o
  			$(CC) -fPIC -shared -o $@ $^ $(LDLIBS) -L /c/msys64/mingw64/lib/ -lgli=
b-2.0
  			# original cmd: $(CC) -shared -Wl,-soname,$@ -o $@ $^ $(LDLIBS)

  		clean:
  			rm -f *.o *.so *.d
  			rm -Rf .libs

                  .PHONY: all clean

  6.  Executing make yeilds:

  make: enter   =E2=80=9C/d/emu_devl/qemu_src/qemu-sr-dsp-a/qemu_tidsp_c3x/=
build_dsp/tests/plugin=E2=80=9D
    CC      bb.o
  x86_64-w64-mingw32-gcc -fPIC -shared -o libbb.so bb.o  -L /c/msys64/mingw=
64/lib/ -lglib-2.0
  C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.1.0/../../../../x8=
6_64-w64-mingw32/bin/ld.exe: bb.o: in function `plugin_exit':
  D:/emu_devl/qemu_src/qemu-sr-dsp-a/qemu_tidsp_c3x/tests/plugin/bb.c:28: u=
ndefined reference to `qemu_plugin_outs'
  C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.1.0/../../../../x8=
6_64-w64-mingw32/bin/ld.exe: D:/emu_devl/qemu_src/qemu-sr-dsp-a/qemu_tidsp_=
c3x/tests/plugin/bb.c:29: undefined reference to `__stack_chk_fail'
  C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.1.0/../../../../x8=
6_64-w64-mingw32/bin/ld.exe: bb.o: in function `vcpu_tb_trans':
  D:/emu_devl/qemu_src/qemu-sr-dsp-a/qemu_tidsp_c3x/tests/plugin/bb.c:41: u=
ndefined reference to `qemu_plugin_tb_n_insns'
  C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.1.0/../../../../x8=
6_64-w64-mingw32/bin/ld.exe: D:/emu_devl/qemu_src/qemu-sr-dsp-a/qemu_tidsp_=
c3x/tests/plugin/bb.c:44: undefined reference to `qemu_plugin_register_vcpu=
_tb_exec_inline'
  C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.1.0/../../../../x8=
6_64-w64-mingw32/bin/ld.exe: D:/emu_devl/qemu_src/qemu-sr-dsp-a/qemu_tidsp_=
c3x/tests/plugin/bb.c:46: undefined reference to `qemu_plugin_register_vcpu=
_tb_exec_inline'
  C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.1.0/../../../../x8=
6_64-w64-mingw32/bin/ld.exe: D:/emu_devl/qemu_src/qemu-sr-dsp-a/qemu_tidsp_=
c3x/tests/plugin/bb.c:49: undefined reference to `qemu_plugin_register_vcpu=
_tb_exec_cb'
  C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.1.0/../../../../x8=
6_64-w64-mingw32/bin/ld.exe: bb.o: in function `qemu_plugin_install':
  D:/emu_devl/qemu_src/qemu-sr-dsp-a/qemu_tidsp_c3x/tests/plugin/bb.c:63: u=
ndefined reference to `qemu_plugin_register_vcpu_tb_trans_cb'
  C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.1.0/../../../../x8=
6_64-w64-mingw32/bin/ld.exe: D:/emu_devl/qemu_src/qemu-sr-dsp-a/qemu_tidsp_=
c3x/tests/plugin/bb.c:64: undefined reference to `qemu_plugin_register_atex=
it_cb'
  C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.1.0/../../../../x8=
6_64-w64-mingw32/bin/ld.exe: bb.o:bb.c:(.rdata$.refptr.__stack_chk_guard[.r=
efptr.__stack_chk_guard]+0x0): undefined reference to `__stack_chk_guard'
  collect2.exe: error: ld returned 1 exit status

     It looks like linking problem(fail to link functions defined in api.c,=
 core.c...), but I have no idea what goes wrong. If I mannualy add api.o, c=
ore.o in the compilation command, still get error like undefined reference =
to '__stack_chk_guard'. =

     My collegue can build 4.2.0  plugins on Ubuntu Linux without any probl=
em.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1885827/+subscriptions

