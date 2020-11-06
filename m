Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B15C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 14:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409C8208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 14:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409C8208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb3DI-0004tU-Mi
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 09:59:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kb3Ck-0004RX-9k
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 09:59:06 -0500
Received: from relay68.bu.edu ([128.197.228.73]:58633)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kb3Ci-0007DO-23
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 09:59:05 -0500
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 0A6EwfRZ001270
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 6 Nov 2020 09:58:44 -0500
Date: Fri, 6 Nov 2020 09:58:41 -0500
From: Alexander Bulekov <alxndr@bu.edu>
To: Daniele Buono <dbuono@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/9] Add support for Control-Flow Integrity
Message-ID: <20201106145841.pijovw2xkieikgrg@mozz.bu.edu>
References: <20201105221905.1350-1-dbuono@linux.vnet.ibm.com>
 <20201106134747.7c9a5050.cohuck@redhat.com>
 <e2e27a18-a0d0-77c2-5e5d-b4c210fec177@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2e27a18-a0d0-77c2-5e5d-b4c210fec177@linux.vnet.ibm.com>
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 08:21:42
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 201106 0835, Daniele Buono wrote:
> Hi Cornelia,
> 
> I don't have a real preference either way.
> 
> So if it is acceptable to have the clang11+ patches separated and
> handled by the maintainers for the proper subsystem, I'd say whatever
> the maintainers prefer.
> 
> In my opinion, the patches for clang11+ support may be merged
> separately.
> 
> I'm saying this because, from my tests, the only feature that needs
> clang11+ to compile with Control-Flow Integrity is fuzzing.
> However, the main way we're fuzzing QEMU is through OSSfuzz, and I don't
> think their infrastructure is using a compiler that new, so we wouldn't
> be able to enable it anyway. (Alex can chip in to confirm this)

I think oss-fuzz is using a bleeding edge version of Clang, so that
might not be a problem.
Here is the oss-fuzz build-log from earlier today:
https://oss-fuzz-build-logs.storage.googleapis.com/log-1747e14f-6b87-43e0-96aa-07ea159e7eb2.txt

...
Step #4: C compiler for the host machine: clang (clang 12.0.0 "clang version 12.0.0 (https://github.com/llvm/llvm-project.git c9f69ee7f94cfefc373c3c6cae08e51b11e6d3c2)")
Step #4: C linker for the host machine: clang ld.bfd 2.26.1
Step #4: Host machine cpu family: x86_64
...

I'm not sure what the status of LTO/LLD support is on oss-fuzz/libfuzzer. There
are some sparse mentions of lld/lto in the repo:
https://github.com/google/oss-fuzz/issues/933
https://github.com/google/oss-fuzz/pull/3597

I haven't found any projects actively using lld on oss-fuzz, but I might
not be grepping hard enough. I personally haven't tried building the
fuzzers with LTO yet, but it seems like a good idea. I'll try it out.

-Alex

> On the other hand, if someone is looking for temporary support in-house,
> they can just add -Wno-[...] as extra-cflags until the additional
> patches land. (Assuming CFI lands before the clang11+ patches).
> 
> Regards,
> Daniele
> 
> On 11/6/2020 7:47 AM, Cornelia Huck wrote:
> > On Thu,  5 Nov 2020 17:18:56 -0500
> > Daniele Buono <dbuono@linux.vnet.ibm.com> wrote:
> > 
> > > This patch adds supports for Control-Flow Integrity checks
> > > on indirect function calls.
> > > 
> > > Requires the use of clang, and link-time optimizations
> > > 
> > > Changes in v3:
> > > 
> > > - clang 11+ warnings are now handled directly at the source,
> > > instead of disabling specific warnings for the whole code.
> > > Some more work may be needed here to polish the patch, I
> > > would kindly ask for a review from the corresponding
> > > maintainers
> > 
> > Process question :)
> > 
> > Would you prefer to have this series merged in one go, or should
> > maintainers pick the patches for their subsystem?
> > 
> > > - Remove configure-time checks for toolchain compatibility
> > > with LTO.
> > > - the decorator to disable cfi checks on functions has
> > > been renamed and moved to include/qemu/compiler.h
> > > - configure-time checks for cfi support and dependencies
> > > has been moved from configure to meson
> > > 
> > > Link to v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg753675.html
> > > Link to v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg718786.html
> > > 
> > > Daniele Buono (9):
> > >    fuzz: Make fork_fuzz.ld compatible with LLVM's LLD
> > >    s390x: fix clang 11 warnings in cpu_models.c
> > >    hw/usb: reorder fields in UASStatus
> > >    s390x: Avoid variable size warning in ipl.h
> > >    scsi: fix overflow in scsi_disk_new_request_dump
> > >    configure,meson: add option to enable LTO
> > >    cfi: Initial support for cfi-icall in QEMU
> > >    check-block: enable iotests with cfi-icall
> > >    configure/meson: support Control-Flow Integrity
> > > 
> > >   accel/tcg/cpu-exec.c          | 11 +++++++++
> > >   configure                     | 26 ++++++++++++++++++++
> > >   hw/s390x/ipl.h                |  4 +--
> > >   hw/scsi/scsi-disk.c           |  4 +++
> > >   hw/usb/dev-uas.c              |  2 +-
> > >   include/qemu/compiler.h       | 12 +++++++++
> > >   meson.build                   | 46 +++++++++++++++++++++++++++++++++++
> > >   meson_options.txt             |  4 +++
> > >   plugins/core.c                | 37 ++++++++++++++++++++++++++++
> > >   plugins/loader.c              |  7 ++++++
> > >   target/s390x/cpu_models.c     |  8 +++---
> > >   tcg/tci.c                     |  7 ++++++
> > >   tests/check-block.sh          | 18 ++++++++------
> > >   tests/qtest/fuzz/fork_fuzz.ld | 12 ++++++++-
> > >   util/main-loop.c              | 11 +++++++++
> > >   util/oslib-posix.c            | 11 +++++++++
> > >   16 files changed, 205 insertions(+), 15 deletions(-)
> > > 
> > 
> > 

