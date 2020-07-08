Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84075C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:15:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C0620786
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C0620786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtCja-0008EI-KW
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 12:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jtChO-00060h-HF
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 12:13:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:46414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jtChM-0003R6-7J
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 12:13:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 60869AE8C;
 Wed,  8 Jul 2020 16:13:26 +0000 (UTC)
Subject: Re: [PULL 00/53] Misc patches for QEMU 5.1 soft freeze
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200706164155.24696-1-pbonzini@redhat.com>
 <CAFEAcA-F1FGde+=c3iS3wcRWG+i0RgYj5-jwafn0sX6EEYEsWA@mail.gmail.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <1a9ad36f-f4ae-2ea5-3d69-03aa5580b60e@suse.de>
Date: Wed, 8 Jul 2020 18:13:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-F1FGde+=c3iS3wcRWG+i0RgYj5-jwafn0sX6EEYEsWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:20:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 8:37 PM, Peter Maydell wrote:
> On Mon, 6 Jul 2020 at 17:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The following changes since commit fc1bff958998910ec8d25db86cd2f53ff125f7ab:
>>
>>   hw/misc/pca9552: Add missing TypeInfo::class_size field (2020-06-29 21:16:10 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to 80270507070ec73ea82741ce24cb7909a9258ea3:
>>
>>   scripts: improve message when TAP based tests fail (2020-07-06 12:14:25 -0400)
>>
>> ----------------------------------------------------------------
>> * Make checkpatch say 'qemu' instead of 'kernel' (Aleksandar)
>> * Fix PSE guests with emulated NPT (Alexander B. #1)
>> * Fix leak (Alexander B. #2)
>> * HVF fixes (Roman, Cameron)
>> * New Sapphire Rapids CPUID bits (Cathy)
>> * cpus.c and softmmu/ cleanups (Claudio)
>> * TAP driver tweaks (Daniel, Havard)
>> * object-add bugfix and testcases (Eric A.)
>> * Fix Coverity MIN_CONST and MAX_CONST (Eric B.)
>> * SSE fixes (Joseph)
>> * "-msg guest-name" option (Mario)
>> * support for AMD nested live migration (myself)
>> * Small i386 TCG fixes (myself)
>> * improved error reporting for Xen (myself)
>> * fix "-cpu host -overcommit cpu-pm=on" (myself)
>> * Add accel/Kconfig (Philippe)
>> * KVM API cleanup (Philippe)
>> * iscsi sense handling fixes (Yongji)
>> * Misc bugfixes
> 
> Hi; various build or test failures (5 total):
> 
> 1) OSX:
> 
> /Users/pm215/src/qemu-for-merges/ui/cocoa.m:1478:9: error: implicit
> declaration of function 'cpu_throttle_set' is invalid in C99 [-
> Werror,-Wimplicit-function-declaration]
>         cpu_throttle_set(throttle_pct);
>         ^
> 
> 2) aarch64 and aarch32 linux:
> 
> /home/pm/qemu/target/arm/kvm.c: In function ‘kvm_arch_init’:
> /home/pm/qemu/target/arm/kvm.c:248:29: error: passing argument 1 of
> ‘kvm_check_extension’ makes integer from pointer without a cast
>  [-Werror=int-conversion]
>   248 |     if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
>       |                             ^
>       |                             |
>       |                             KVMState * {aka struct KVMState *}
> In file included from /home/pm/qemu/target/arm/kvm.c:23:
> /home/pm/qemu/include/sysemu/kvm.h:439:38: note: expected ‘unsigned
> int’ but argument is of type ‘KVMState *’ {aka ‘struct KVMState
>  *’}
>   439 | int kvm_check_extension(unsigned int extension);
>       |                         ~~~~~~~~~~~~~^~~~~~~~~
> /home/pm/qemu/target/arm/kvm.c:248:9: error: too many arguments to
> function ‘kvm_check_extension’
>   248 |     if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
>       |         ^~~~~~~~~~~~~~~~~~~
> In file included from /home/pm/qemu/target/arm/kvm.c:23:
> /home/pm/qemu/include/sysemu/kvm.h:439:5: note: declared here
>   439 | int kvm_check_extension(unsigned int extension);
>       |     ^~~~~~~~~~~~~~~~~~~
> /home/pm/qemu/target/arm/kvm.c:253:59: error: passing argument 1 of
> ‘kvm_check_extension’ makes integer from pointer without a cast
>  [-Werror=int-conversion]
>   253 |             cap_has_inject_ext_dabt = kvm_check_extension(s,
>       |                                                           ^
>       |                                                           |
>       |
> KVMState * {aka struct KVMState *}
> In file included from /home/pm/qemu/target/arm/kvm.c:23:
> /home/pm/qemu/include/sysemu/kvm.h:439:38: note: expected ‘unsigned
> int’ but argument is of type ‘KVMState *’ {aka ‘struct KVMState
>  *’}
>   439 | int kvm_check_extension(unsigned int extension);
>       |                         ~~~~~~~~~~~~~^~~~~~~~~
> /home/pm/qemu/target/arm/kvm.c:253:39: error: too many arguments to
> function ‘kvm_check_extension’
>   253 |             cap_has_inject_ext_dabt = kvm_check_extension(s,
>       |                                       ^~~~~~~~~~~~~~~~~~~
> In file included from /home/pm/qemu/target/arm/kvm.c:23:
> /home/pm/qemu/include/sysemu/kvm.h:439:5: note: declared here
>   439 | int kvm_check_extension(unsigned int extension);
>       |     ^~~~~~~~~~~~~~~~~~~
> 
> 3) PPC64 had a failure on iotest 030 (though I think this may
> be an intermittent in master):
> 
>   TEST    iotest-qcow2: 030 [fail]
> QEMU          --
> "/home/pm215/qemu/build/all/tests/qemu-iotests/../../ppc64-softmmu/qemu-system-ppc64"
> -nodefaults -display none -accel qtest
> QEMU_IMG      -- "/home/pm215/qemu/build/all/tests/qemu-iotests/../../qemu-img"
> QEMU_IO       --
> "/home/pm215/qemu/build/all/tests/qemu-iotests/../../qemu-io"  --cache
> writeback --aio threads -f qcow2
> QEMU_NBD      -- "/home/pm215/qemu/build/all/tests/qemu-iotests/../../qemu-nbd"
> IMGFMT        -- qcow2 (compat=1.1)
> IMGPROTO      -- file
> PLATFORM      -- Linux/ppc64 gcc1-power7 3.10.0-862.14.4.el7.ppc64
> TEST_DIR      -- /home/pm215/qemu/build/all/tests/qemu-iotests/scratch
> SOCK_DIR      -- /tmp/tmp.icAW30swbG
> SOCKET_SCM_HELPER --
> /home/pm215/qemu/build/all/tests/qemu-iotests/socket_scm_helper
> 
> --- /home/pm215/qemu/tests/qemu-iotests/030.out 2019-07-15
> 15:12:04.941863802 +0000
> +++ /home/pm215/qemu/build/all/tests/qemu-iotests/030.out.bad
> 2020-07-07 18:01:06.975652394 +0000
> @@ -1,5 +1,17 @@
> -...........................
> +.............F.............
> +======================================================================
> +FAIL: test_stream_parallel (__main__.TestParallelOps)
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +  File "030", line 246, in test_stream_parallel
> +    self.assert_qmp(result, 'return', {})
> +  File "/home/pm215/qemu/tests/qemu-iotests/iotests.py", line 848, in
> assert_qmp
> +    result = self.dictpath(d, path)
> +  File "/home/pm215/qemu/tests/qemu-iotests/iotests.py", line 822, in dictpath
> +    self.fail(f'failed path traversal for "{path}" in "{d}"')
> +AssertionError: failed path traversal for "return" in "{'error':
> {'class': 'DeviceNotActive', 'desc': "Block job 'stream-node8' not
> found"}}"
> +
>  ----------------------------------------------------------------------
>  Ran 27 tests
> 
> -OK
> +FAILED (failures=1)
> 
> 4) s390x failed on iotest 267:
> 
>   TEST    iotest-qcow2: 267 [fail]
> QEMU          --
> "/home/ubuntu/qemu/build/all/tests/qemu-iotests/../../s390x-softmmu/qemu-system-s390x"
> -nodefaults -display none -accel qtest
> QEMU_IMG      -- "/home/ubuntu/qemu/build/all/tests/qemu-iotests/../../qemu-img"
> QEMU_IO       --
> "/home/ubuntu/qemu/build/all/tests/qemu-iotests/../../qemu-io"
> --cache writeback --aio threads -f qcow2
> QEMU_NBD      -- "/home/ubuntu/qemu/build/all/tests/qemu-iotests/../../qemu-nbd"
> IMGFMT        -- qcow2 (compat=1.1)
> IMGPROTO      -- file
> PLATFORM      -- Linux/s390x qemu01 4.15.0-72-generic
> TEST_DIR      -- /home/ubuntu/qemu/build/all/tests/qemu-iotests/scratch
> SOCK_DIR      -- /tmp/tmp.REW8Sy64t9
> SOCKET_SCM_HELPER --
> /home/ubuntu/qemu/build/all/tests/qemu-iotests/socket_scm_helper
> 
> --- /home/ubuntu/qemu/tests/qemu-iotests/267.out        2019-12-19
> 08:32:33.382319918 -0500
> +++ /home/ubuntu/qemu/build/all/tests/qemu-iotests/267.out.bad
> 2020-07-07 14:15:44.173300793 -0400
> @@ -137,6 +137,9 @@
>  ID        TAG                 VM SIZE                DATE       VM CLOCK
>  --        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
>  (qemu) loadvm snap0
> +Unexpected storage key flag data: 0
> +error while loading state for instance 0x0 of device 's390-skeys'
> +Error: Error -22 while loading VM state
>  (qemu) quit
> 
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
> backing_file=TEST_DIR/t.IMGFMT.base
> 
> 5) And a link error on x86-64 Linux:
> 
>   LINK    x86_64-softmmu/qemu-system-x86_64
> softmmu/cpus.o: In function `tcg_get_icount_limit':
> /home/petmay01/linaro/qemu-for-merges/softmmu/cpus.c:563: undefined
> reference to `icount_round'
> softmmu/cpus.o: In function `process_icount_data':
> /home/petmay01/linaro/qemu-for-merges/softmmu/cpus.c:618: undefined
> reference to `icount_update'
> target/i386/helper.o: In function `x86_cpu_dump_state':
> /home/petmay01/linaro/qemu-for-merges/target/i386/helper.c:547:
> undefined reference to `update_mxcsr_from_sse_status'
> target/i386/gdbstub.o: In function `x86_cpu_gdb_read_register':
> /home/petmay01/linaro/qemu-for-merges/target/i386/gdbstub.c:187:
> undefined reference to `update_mxcsr_from_sse_status'
> collect2: error: ld returned 1 exit status
> Makefile:205: recipe for target 'qemu-system-x86_64' failed
> 
> thanks
> -- PMM
> 

Hi Peter, Paolo,

I am trying to understand this failure (5), which is triggered by one of my patches,
containing clearly an issue that does not trigger here, although it is apparent to me (I did not provide all necessary stubs).

Could you provide the ./configure command line, config.status, compiler version?

Clearly it is something I have to fix, but would help to be able not to be "blind".

The patch introducing icount_round and icount_update is

"cpu-timers, icount: new modules",

and the issue stems I think from the fact that cpus.c references

icount_round() and icount_update() in code that is conditional on icount_enabled().

If the code is configured with --disable-tcg, in stubs/icount.c , icount_enabled is defined as always returning 0,
and my compiler takes that clue and elides all static functions conditional on that return value,

so I don't get any tcg_get_icount_limit() compiled in, and no errors.

I think that having comparable configure command line and compiler version/flags would help me pin down any related issue.

Thanks,

Claudio







