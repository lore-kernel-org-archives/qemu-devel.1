Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75824C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:37:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 228152078E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228152078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKBhS-0001Ih-BH
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 22:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBgf-0000Ui-3R
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:36:17 -0400
Received: from relay68.bu.edu ([128.197.228.73]:34212)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kKBgc-0001pu-Qy
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:36:16 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 08L2ZNmB015893
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 20 Sep 2020 22:35:30 -0400
Date: Sun, 20 Sep 2020 22:35:23 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Dima Stepanov <dstepanov.src@gmail.com>
Subject: Re: [PATCH 00/12] Add a General Virtual Device Fuzzer
Message-ID: <20200921023523.qqjflrnhpfdauf3l@mozz.bu.edu>
References: <20200723033933.21883-1-alxndr@bu.edu>
 <20200826111047.GA16426@dimastep-nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826111047.GA16426@dimastep-nix>
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 22:36:14
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Cc: thuth@redhat.com, qemu-devel@nongnu.org, f4bug@amsat.org,
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 andrew@coatesdev.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200826 1410, Dima Stepanov wrote:
> Hi Alex,
> 
> Thanks for the nice general fuzzer implementation, looks pretty
> exciting. Are there any future plans discussion which i can read
> or maybe join? I have some ideas about it so it could be great to
> syncronize.
> 
> Regards, Dima.

Hi Dima,
Apologies about the late response - I needed to catch up on some
academic work but things seem to be going back to normal now. We have
fuzzing meetings at 10 AM on Thursdays. Does this work for you? 
Thanks!
-Alex

> On Wed, Jul 22, 2020 at 11:39:21PM -0400, Alexander Bulekov wrote:
> > This is a general virtual-device fuzzer, designed to fuzz devices over Port IO,
> > MMIO, and DMA.
> > To get started with this:
> >  1. Build the fuzzers (see docs/devel/fuzzing.txt)
> >     Note: Build with --enable-sanitizers, or create a "dictionary file":
> >     echo kw1=\"\x84\x05\x5C\x5E\" > dict
> >     and pass it as an argument to libFuzzer with -dict=./dict
> >     This magic value is a command separator that lets the fuzzer perform
> >     multiple IO actions with a single input.
> > 
> >  2. Pick the qemu arguments you wish to fuzz:
> >     export QEMU_FUZZ_ARGS="-M q35 -device virtio-balloon"
> > 
> >  3. Tell the fuzzer which QOM objects or MemoryRegion names to fuzz. I find the
> >  "info qom-tree", "info qtree" and "info mtree" commands useful for identifying
> >  these. Supports globbing. Here I will try to simultaneously fuzz(for no good
> >  reason) virtio-balloon and e1000e, which is included by default in the q35:
> >     export QEMU_FUZZ_OBJECTS='virtio* e1000*'
> >     You can also try to fuzz the whole machine:
> >     export QEMU_FUZZ_OBJECTS='*'
> > 
> >  4. Run the fuzzer for 0 inputs. The fuzzer should output a list of
> >  MemoryRegions/PCI Devices it will try to fuzz. Confirm that these match your
> >  expectations.
> >     ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=general-fuzz -runs=0
> > 
> >  5. Run the fuzzer:
> >     ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=general-fuzz 
> > 
> > 
> > Basically, at the core, this fuzzer is an interpreter that splits the input
> > into a series of commands, such as mmio_write, pio_write, etc. We structure
> > these commands to hit only MemoryRegions that are associated with the devices
> > specified in QEMU_FUZZ_OBJECTS. Additionally, these patches add "hooks" to
> > functions that are typically used by virtual-devices to read from RAM (DMA).
> > These hooks attempt to populate these DMA regions with fuzzed data, just in
> > time.
> > 
> > Patch 1 changes the way we tell QTest to log to stderr (becomes important when
> > building reproducers with this fuzzer)
> > 
> > Patches 2-6 add the fuzzer and the necessary DMA callbacks
> > 
> > Patches 7-10 are my (very rough) attempt at integrating this into OSS-Fuzz
> > 
> > Patches 11-12 contain the "reordering" and minimization scripts used to
> > produce a QTest reproducer for a crash.
> > 
> > Additional notes:
> >  * With the latest changes, the
> >  fuzzer is quite effective at only targeting the device we care about,
> >  so it will probably be beneficial to allow reboot() as an option for
> >  resetting state, rather than fork(), for devices where that works well.
> > 
> >  * We have only scratched the surface for device "backends". I.e. I am using
> >  fake null-co:// drives for block devices and SLiRP for network devices (see
> >  scripts/oss-fuzz/general_fuzzer_configs.yml). Using more complex backends will
> >  likely break due to forking/threading/statefulness related reasons and will
> >  require more work.
> > 
> > * Because I still can't figure out how to make QOS do what I want, this
> >   only maps PCI BARs on i386. For other targets, the fuzzer can still
> >   try to do it on its own :). Only did a very simple test on ppc and arm
> > 
> >  * This is failing on GitLab due to a leak:
> >  https://gitlab.com/a1xndr/qemu/-/jobs/652179729
> >  I am not sure how to work around it yet, since I don't think we can
> >  free what the trace says we should free (argv from wordexp that we pass
> >  to qemu_main).
> > 
> > 
> > Some of the issues I have found or reproduced with this fuzzer:
> > https://bugs.launchpad.net/bugs/1525123
> > https://bugs.launchpad.net/bugs/1681439
> > https://bugs.launchpad.net/bugs/1777315
> > https://bugs.launchpad.net/bugs/1878034
> > https://bugs.launchpad.net/bugs/1878043
> > https://bugs.launchpad.net/bugs/1878054
> > https://bugs.launchpad.net/bugs/1878057
> > https://bugs.launchpad.net/bugs/1878067
> > https://bugs.launchpad.net/bugs/1878134
> > https://bugs.launchpad.net/bugs/1878136
> > https://bugs.launchpad.net/bugs/1878253
> > https://bugs.launchpad.net/bugs/1878255
> > https://bugs.launchpad.net/bugs/1878259
> > https://bugs.launchpad.net/bugs/1878263
> > https://bugs.launchpad.net/bugs/1878323
> > https://bugs.launchpad.net/bugs/1878641
> > https://bugs.launchpad.net/bugs/1878642
> > https://bugs.launchpad.net/bugs/1878645
> > https://bugs.launchpad.net/bugs/1878651
> > https://bugs.launchpad.net/bugs/1879223
> > https://bugs.launchpad.net/bugs/1879227
> > https://bugs.launchpad.net/bugs/1879531
> > https://bugs.launchpad.net/bugs/1880355
> > https://bugs.launchpad.net/bugs/1880539
> > https://bugs.launchpad.net/bugs/1884693
> > https://bugs.launchpad.net/bugs/1886362
> > https://bugs.launchpad.net/bugs/1887303
> > https://bugs.launchpad.net/bugs/1887309
> > https://bugs.launchpad.net/bugs/697510
> > 
> > -Alex
> > 
> > Alexander Bulekov (12):
> >   fuzz: Change the way we write qtest log to stderr
> >   fuzz: Add general virtual-device fuzzer
> >   fuzz: Add PCI features to the general fuzzer
> >   fuzz: Add DMA support to the generic-fuzzer
> >   fuzz: Declare DMA Read callback function
> >   fuzz: Add fuzzer callbacks to DMA-read functions
> >   scripts/oss-fuzz: Add wrapper program for generic fuzzer
> >   scripts/oss-fuzz: Add general-fuzzer build script
> >   scripts/oss-fuzz: Add general-fuzzer configs for oss-fuzz
> >   scripts/oss-fuzz: build the general-fuzzer configs
> >   scripts/oss-fuzz: Add script to reorder a general-fuzzer trace
> >   scripts/oss-fuzz: Add crash trace minimization script
> > 
> >  exec.c                                        |   2 +
> >  include/exec/memory.h                         |  16 +
> >  include/exec/memory_ldst_cached.inc.h         |   3 +
> >  memory_ldst.inc.c                             |   4 +
> >  scripts/oss-fuzz/build.sh                     |   8 +-
> >  scripts/oss-fuzz/build_general_fuzzers.py     |  62 ++
> >  scripts/oss-fuzz/general_fuzzer_configs.yml   | 103 +++
> >  scripts/oss-fuzz/minimize_qtest_trace.py      | 117 +++
> >  .../oss-fuzz/reorder_fuzzer_qtest_trace.py    |  94 +++
> >  scripts/oss-fuzz/target.c                     |  40 +
> >  softmmu/memory.c                              |  14 +
> >  tests/qtest/fuzz/Makefile.include             |   1 +
> >  tests/qtest/fuzz/fuzz.c                       |   5 +-
> >  tests/qtest/fuzz/general_fuzz.c               | 758 ++++++++++++++++++
> >  14 files changed, 1223 insertions(+), 4 deletions(-)
> >  create mode 100755 scripts/oss-fuzz/build_general_fuzzers.py
> >  create mode 100644 scripts/oss-fuzz/general_fuzzer_configs.yml
> >  create mode 100755 scripts/oss-fuzz/minimize_qtest_trace.py
> >  create mode 100755 scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py
> >  create mode 100644 scripts/oss-fuzz/target.c
> >  create mode 100644 tests/qtest/fuzz/general_fuzz.c
> > 
> > -- 
> > 2.27.0
> > 
> 

