Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74227C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:38:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3567420708
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GnUGFLRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3567420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssU7-0007FB-Fh
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jssT9-0005t4-Bo
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:37:27 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:36767)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jssT7-00061K-51
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:37:26 -0400
Received: by mail-oo1-xc41.google.com with SMTP id z127so4805521ooa.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CMYUGEqSV67WOiBB3IRgU7+tg12KFY4dIR65OqiNw7Q=;
 b=GnUGFLRdo7F7ey0UdKdNHDitxlY0SSIg3n8sjXoV6SduB0NDumMf1fdqNDqurLnpDp
 ztd9XemeuRgRW6QyD11ReYxHpBF55VgYJ4Q0f2NYKh2cp7p3tG2uYulbL07h0lhXycHO
 pQngEKLXFJ8qeuFAp86JkbBxyS65bgtFlMuLYBzSvcgSGezQTFXA3qRIPsyMPLz7SPjh
 zuI2v1PQ9gQJAXnhTOijPtFdb7hmdnJ9LKP7ACfUYUkn/oxglYM0l6OSmcp2yBHO9Bau
 JlLWUs7it+tIyQj5JuLeDle5rREJSw+qGUq92eM0SLbXLlj4Af3y73jSqW8csdiZRfPU
 uy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CMYUGEqSV67WOiBB3IRgU7+tg12KFY4dIR65OqiNw7Q=;
 b=e8LYc/v8X6E+M9D+JpZlXiYT3GbYvmhdwgzNhB5dzQE67WvwxpANAVu0Bj9jcprGiO
 bfJBA7AtYY2SawI3t5rBXlFCIRB/NHpNYXTPQ8CKquIvLE3CjlZ1DhtvKVVCyjDn41Th
 efvhDFogwKp63Loh7TGhF+wKvN+O5RRNe1IqfaFSzwPn7NqHcHvHq6Yj83GNzNCcr0Os
 hwyUY1xUHyebpr7BP3uvcC3h036/kjxT3jc9Sny6Kj5s2frXHsv9o7/6h6/cNUQ1rcEb
 UMH//bFwNCW3toq0lnqJQHtmU+u37kXp1/9go0OQt0q+ushz2ztATugwndfBFjMLP25+
 aaDQ==
X-Gm-Message-State: AOAM531oqjlMa8kTNQ7P7jobcOvw+F23r6R3pG/oiea+jdI9ZZfk+eZ2
 4jidUq2PKT9iWwGfRXEKwtZ6dm/jN6m6sOxhLeR01g==
X-Google-Smtp-Source: ABdhPJzKfB+rYlvvTjbP8S/63BXWSzOPvVYcP5EJMJYRkCIyB+/T0EePFFfAxFDNb3kfzSh14l41+bBZemnl/O8afHM=
X-Received: by 2002:a4a:2f15:: with SMTP id p21mr47237604oop.20.1594147043800; 
 Tue, 07 Jul 2020 11:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200706164155.24696-1-pbonzini@redhat.com>
In-Reply-To: <20200706164155.24696-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jul 2020 19:37:12 +0100
Message-ID: <CAFEAcA-F1FGde+=c3iS3wcRWG+i0RgYj5-jwafn0sX6EEYEsWA@mail.gmail.com>
Subject: Re: [PULL 00/53] Misc patches for QEMU 5.1 soft freeze
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Jul 2020 at 17:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit fc1bff958998910ec8d25db86cd2f53ff125f7=
ab:
>
>   hw/misc/pca9552: Add missing TypeInfo::class_size field (2020-06-29 21:=
16:10 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 80270507070ec73ea82741ce24cb7909a9258ea3:
>
>   scripts: improve message when TAP based tests fail (2020-07-06 12:14:25=
 -0400)
>
> ----------------------------------------------------------------
> * Make checkpatch say 'qemu' instead of 'kernel' (Aleksandar)
> * Fix PSE guests with emulated NPT (Alexander B. #1)
> * Fix leak (Alexander B. #2)
> * HVF fixes (Roman, Cameron)
> * New Sapphire Rapids CPUID bits (Cathy)
> * cpus.c and softmmu/ cleanups (Claudio)
> * TAP driver tweaks (Daniel, Havard)
> * object-add bugfix and testcases (Eric A.)
> * Fix Coverity MIN_CONST and MAX_CONST (Eric B.)
> * SSE fixes (Joseph)
> * "-msg guest-name" option (Mario)
> * support for AMD nested live migration (myself)
> * Small i386 TCG fixes (myself)
> * improved error reporting for Xen (myself)
> * fix "-cpu host -overcommit cpu-pm=3Don" (myself)
> * Add accel/Kconfig (Philippe)
> * KVM API cleanup (Philippe)
> * iscsi sense handling fixes (Yongji)
> * Misc bugfixes

Hi; various build or test failures (5 total):

1) OSX:

/Users/pm215/src/qemu-for-merges/ui/cocoa.m:1478:9: error: implicit
declaration of function 'cpu_throttle_set' is invalid in C99 [-
Werror,-Wimplicit-function-declaration]
        cpu_throttle_set(throttle_pct);
        ^

2) aarch64 and aarch32 linux:

/home/pm/qemu/target/arm/kvm.c: In function =E2=80=98kvm_arch_init=E2=80=99=
:
/home/pm/qemu/target/arm/kvm.c:248:29: error: passing argument 1 of
=E2=80=98kvm_check_extension=E2=80=99 makes integer from pointer without a =
cast
 [-Werror=3Dint-conversion]
  248 |     if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
      |                             ^
      |                             |
      |                             KVMState * {aka struct KVMState *}
In file included from /home/pm/qemu/target/arm/kvm.c:23:
/home/pm/qemu/include/sysemu/kvm.h:439:38: note: expected =E2=80=98unsigned
int=E2=80=99 but argument is of type =E2=80=98KVMState *=E2=80=99 {aka =E2=
=80=98struct KVMState
 *=E2=80=99}
  439 | int kvm_check_extension(unsigned int extension);
      |                         ~~~~~~~~~~~~~^~~~~~~~~
/home/pm/qemu/target/arm/kvm.c:248:9: error: too many arguments to
function =E2=80=98kvm_check_extension=E2=80=99
  248 |     if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
      |         ^~~~~~~~~~~~~~~~~~~
In file included from /home/pm/qemu/target/arm/kvm.c:23:
/home/pm/qemu/include/sysemu/kvm.h:439:5: note: declared here
  439 | int kvm_check_extension(unsigned int extension);
      |     ^~~~~~~~~~~~~~~~~~~
/home/pm/qemu/target/arm/kvm.c:253:59: error: passing argument 1 of
=E2=80=98kvm_check_extension=E2=80=99 makes integer from pointer without a =
cast
 [-Werror=3Dint-conversion]
  253 |             cap_has_inject_ext_dabt =3D kvm_check_extension(s,
      |                                                           ^
      |                                                           |
      |
KVMState * {aka struct KVMState *}
In file included from /home/pm/qemu/target/arm/kvm.c:23:
/home/pm/qemu/include/sysemu/kvm.h:439:38: note: expected =E2=80=98unsigned
int=E2=80=99 but argument is of type =E2=80=98KVMState *=E2=80=99 {aka =E2=
=80=98struct KVMState
 *=E2=80=99}
  439 | int kvm_check_extension(unsigned int extension);
      |                         ~~~~~~~~~~~~~^~~~~~~~~
/home/pm/qemu/target/arm/kvm.c:253:39: error: too many arguments to
function =E2=80=98kvm_check_extension=E2=80=99
  253 |             cap_has_inject_ext_dabt =3D kvm_check_extension(s,
      |                                       ^~~~~~~~~~~~~~~~~~~
In file included from /home/pm/qemu/target/arm/kvm.c:23:
/home/pm/qemu/include/sysemu/kvm.h:439:5: note: declared here
  439 | int kvm_check_extension(unsigned int extension);
      |     ^~~~~~~~~~~~~~~~~~~

3) PPC64 had a failure on iotest 030 (though I think this may
be an intermittent in master):

  TEST    iotest-qcow2: 030 [fail]
QEMU          --
"/home/pm215/qemu/build/all/tests/qemu-iotests/../../ppc64-softmmu/qemu-sys=
tem-ppc64"
-nodefaults -display none -accel qtest
QEMU_IMG      -- "/home/pm215/qemu/build/all/tests/qemu-iotests/../../qemu-=
img"
QEMU_IO       --
"/home/pm215/qemu/build/all/tests/qemu-iotests/../../qemu-io"  --cache
writeback --aio threads -f qcow2
QEMU_NBD      -- "/home/pm215/qemu/build/all/tests/qemu-iotests/../../qemu-=
nbd"
IMGFMT        -- qcow2 (compat=3D1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/ppc64 gcc1-power7 3.10.0-862.14.4.el7.ppc64
TEST_DIR      -- /home/pm215/qemu/build/all/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.icAW30swbG
SOCKET_SCM_HELPER --
/home/pm215/qemu/build/all/tests/qemu-iotests/socket_scm_helper

--- /home/pm215/qemu/tests/qemu-iotests/030.out 2019-07-15
15:12:04.941863802 +0000
+++ /home/pm215/qemu/build/all/tests/qemu-iotests/030.out.bad
2020-07-07 18:01:06.975652394 +0000
@@ -1,5 +1,17 @@
-...........................
+.............F.............
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+FAIL: test_stream_parallel (__main__.TestParallelOps)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "030", line 246, in test_stream_parallel
+    self.assert_qmp(result, 'return', {})
+  File "/home/pm215/qemu/tests/qemu-iotests/iotests.py", line 848, in
assert_qmp
+    result =3D self.dictpath(d, path)
+  File "/home/pm215/qemu/tests/qemu-iotests/iotests.py", line 822, in dict=
path
+    self.fail(f'failed path traversal for "{path}" in "{d}"')
+AssertionError: failed path traversal for "return" in "{'error':
{'class': 'DeviceNotActive', 'desc': "Block job 'stream-node8' not
found"}}"
+
 ----------------------------------------------------------------------
 Ran 27 tests

-OK
+FAILED (failures=3D1)

4) s390x failed on iotest 267:

  TEST    iotest-qcow2: 267 [fail]
QEMU          --
"/home/ubuntu/qemu/build/all/tests/qemu-iotests/../../s390x-softmmu/qemu-sy=
stem-s390x"
-nodefaults -display none -accel qtest
QEMU_IMG      -- "/home/ubuntu/qemu/build/all/tests/qemu-iotests/../../qemu=
-img"
QEMU_IO       --
"/home/ubuntu/qemu/build/all/tests/qemu-iotests/../../qemu-io"
--cache writeback --aio threads -f qcow2
QEMU_NBD      -- "/home/ubuntu/qemu/build/all/tests/qemu-iotests/../../qemu=
-nbd"
IMGFMT        -- qcow2 (compat=3D1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/s390x qemu01 4.15.0-72-generic
TEST_DIR      -- /home/ubuntu/qemu/build/all/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.REW8Sy64t9
SOCKET_SCM_HELPER --
/home/ubuntu/qemu/build/all/tests/qemu-iotests/socket_scm_helper

--- /home/ubuntu/qemu/tests/qemu-iotests/267.out        2019-12-19
08:32:33.382319918 -0500
+++ /home/ubuntu/qemu/build/all/tests/qemu-iotests/267.out.bad
2020-07-07 14:15:44.173300793 -0400
@@ -137,6 +137,9 @@
 ID        TAG                 VM SIZE                DATE       VM CLOCK
 --        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
 (qemu) loadvm snap0
+Unexpected storage key flag data: 0
+error while loading state for instance 0x0 of device 's390-skeys'
+Error: Error -22 while loading VM state
 (qemu) quit

 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
backing_file=3DTEST_DIR/t.IMGFMT.base

5) And a link error on x86-64 Linux:

  LINK    x86_64-softmmu/qemu-system-x86_64
softmmu/cpus.o: In function `tcg_get_icount_limit':
/home/petmay01/linaro/qemu-for-merges/softmmu/cpus.c:563: undefined
reference to `icount_round'
softmmu/cpus.o: In function `process_icount_data':
/home/petmay01/linaro/qemu-for-merges/softmmu/cpus.c:618: undefined
reference to `icount_update'
target/i386/helper.o: In function `x86_cpu_dump_state':
/home/petmay01/linaro/qemu-for-merges/target/i386/helper.c:547:
undefined reference to `update_mxcsr_from_sse_status'
target/i386/gdbstub.o: In function `x86_cpu_gdb_read_register':
/home/petmay01/linaro/qemu-for-merges/target/i386/gdbstub.c:187:
undefined reference to `update_mxcsr_from_sse_status'
collect2: error: ld returned 1 exit status
Makefile:205: recipe for target 'qemu-system-x86_64' failed

thanks
-- PMM

