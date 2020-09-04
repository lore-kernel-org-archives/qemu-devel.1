Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CF9C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D28620665
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOm1gHsn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D28620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEFXj-0002ZS-4j
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 13:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEFWe-00021M-NO
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 13:29:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45992
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEFWa-0005mn-IS
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 13:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599240559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eRm6rYSra+v/O/+3fHlyjHAUyfNg537Gdkd5BMeLX6Q=;
 b=HOm1gHsndGYZTF7ormuUccNbEjINtYM9rI02bgJNbaS2s6hGLvTtHrm3fD1DYqwTJ4E6RD
 U5bf+DGE8yPbIEDyS3mUE2eCi2LUAvwNhWJNq/wfh6BN715NoNxaWbi7XT08GtVDjRysyd
 AltKMghAiRdbL/osNirNc0K4yHGVz98=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-I5Qmf5JcMRCXI0WBCrqsrA-1; Fri, 04 Sep 2020 13:29:14 -0400
X-MC-Unique: I5Qmf5JcMRCXI0WBCrqsrA-1
Received: by mail-ej1-f69.google.com with SMTP id d24so2814466ejb.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 10:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eRm6rYSra+v/O/+3fHlyjHAUyfNg537Gdkd5BMeLX6Q=;
 b=k4l50eIyv7gAcikBYoPkQs3/xVXNhWmndmww0MXBZLdtUavhvM26DVToJx3AzdvNsv
 1HLyLeXFLQXAC36D1pW/V5xmZHOVE72/hJa0UPbsdMpg3Tgc2CoXWTMHNK025EZylk1g
 ilt1Bjafe7XhBW+v5t6xBFssV+7ULZhvCeFv2xKTxeBRoJ/jrhKfvJLmwmE4LU3GTLTG
 P4y/5Q2qe82Hz9P6z4Z0fbWAu3PHUjIv6E4Aauo2YTx2WGp/WZcMQXIsLEptRYMTsvTc
 n4a92IoLks35mar6oSskuVi6R1SqFogqOgnNMeT7A4320TserQVG1PxEUseh6N1Hooqt
 Q0qA==
X-Gm-Message-State: AOAM531tFipEZihIXfq/OtXJYuHgdtuKT40pHeHOcVKHobCG9aXVHNxj
 5e1dFwJpCI6rzOgV6SGJ67ovsUugyTQd6l9hqAXXwIDOwuE5ws0Zy9EjaIKP6HOQPCl4ueSAyIi
 JbjK299GK6ewJRbawKZtWA74YPLX6mxk=
X-Received: by 2002:a50:8d57:: with SMTP id t23mr9979835edt.308.1599240553464; 
 Fri, 04 Sep 2020 10:29:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhlzgIbe/3fGrtCv4acOhcck1Pdq5dqTW5avmrdwKo003niWViZz6xAbRib0kOhV6cCylXBEgiXFeaUafpWCg=
X-Received: by 2002:a50:8d57:: with SMTP id t23mr9979814edt.308.1599240553170; 
 Fri, 04 Sep 2020 10:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200903105614.17772-1-cfontana@suse.de>
 <13e066b4-03dd-e8f6-4420-25e25e404c72@suse.de>
In-Reply-To: <13e066b4-03dd-e8f6-4420-25e25e404c72@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 4 Sep 2020 19:29:01 +0200
Message-ID: <CABgObfZBARDX=tFb03xEnSVMGAiG8TPn4TAKUpGEi=_iRChmWA@mail.gmail.com>
Subject: Re: [PATCH v7 00/16] QEMU cpus.c refactoring part2
To: Claudio Fontana <cfontana@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000015251b05ae803548"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000015251b05ae803548
Content-Type: text/plain; charset="UTF-8"

Il ven 4 set 2020, 18:08 Claudio Fontana <cfontana@suse.de> ha scritto:

> btw not sure whose queues should these go through?
>

I can take this; the dust from the meson merge should settle soon.

Paolo


> Thanks,
>
> Claudio
>
> On 9/3/20 12:55 PM, Claudio Fontana wrote:
> > Motivation and higher level steps:
> >
> > https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg04628.html
> >
> > Current state is all reviewed, I think this is a good base to
> > include at this point.
> > I had to fix one build issue in patch 1 that went undetected previously
> due to
> > a meson thing (parallel build).
> >
> > Further work for future patches include:
> >
> > * additional improvements to naming consistency in QEMU files. (Claudio,
> Alex, Roman)
> >
> > * tcg vcpu start refactoring, providing then multiple structs for mttg,
> icount, normal.
> >   (Claudio, Alex)
> >
> > * possible removal of NULL check for virtual clock if the qcow2 early
> call is solved.
> >   (Claudio, Paolo, Berto)
> >
> > PATCH v6 -> PATCH v7:
> >
> > * in patch "cpu-timers, icount: new modules":
> >   - remove redundant double initialization of spice
> >   - remove lingering calls to icount_get
> >
> > PATCH v5 -> PATCH v6:
> >
> > * moved to mason build system
> >
> > * patch (new): cpus: remove checks for non-NULL cpus_accel (Richard)
> >
> >   This has however a big caveat: in some cases the virtual clock is
> >   queried before an accelerator is set or ticks are enabled; this is
> >   currently special cased (keeping the NULL check in
> cpus_get_virtual_clock),
> >   but maybe this should not happen at all? (Paolo, Berto)
> >
> > * in patch "cpu-timers, icount: new modules"
> >   do not change (yet) icount_enabled() to a function.
> >   Mimic instead what is done with tcg_enabled(). (Richard)
> >
> > * split the changes into two separate patches, with name-only changes
> >   extracted out into a separate patch (Richard).
> >   Removed existing Reviewed-by because of these changes (Alex)-
> >   Alex are you ok with them?
> >
> > * in patch "cpus: prepare new CpusAccel cpu accelerator interface"
> >   remove some unneeded stubs from stubs/cpu-synchronize-state.c
> >   Use const for the CpusAccel interface. (Richard)
> >
> > * in patch "cpus: extract out TCG-specific code to accel/tcg"
> >   use const for the CpusAccel interface. (Richard)
> >
> > * in patch "cpus: extract out qtest-specific code to accel/qtest"
> >   use const for the CpusAccel interface;
> >   use g_assert_not_reached (Richard)
> >
> > * in patch "cpus: extract out kvm-specific code to accel/kvm"
> >   use const for the CpusAccel interface. (Richard)
> >
> > * in patch "cpus: extract out hax-specific code to target/i386/"
> >   use const for the CpusAccel interface. (Richard)
> >
> > * in patch "cpus: extract out whpx-specific code to target/i386/"
> >   use const for the CpusAccel interface. (Richard)
> >
> > * in patch "cpus: extract out hvf-specific code to target/i386/hvf/"
> >   use const for the CpusAccel interface. (Richard)
> >
> >
> > RFC v4 -> PATCH v5:
> >
> > * in patch 2, move comment about cpus_get_elapsed_ticks from patch 3
> >   (Philippe)
> >
> > * in patch 11-14, do not create separate xxx-int.h files,
> >   instead use the xxx-cpus.h files (Philippe)
> >
> > RFC v3 -> v4:
> >
> > * added patch 9: cleanup unneeded includes
> >
> > * added patch 10: add handle_interrupt to the interface (Roman)
> >
> > * added patch 11-14: remove accelerator specific internal functions
> >   from global includes (Roman)
> >
> > * in patch 2, removed leftover "if hvf_enabled" hunk
> >
> > * in patch 2, convert if (!tcg_enabled) with more punctual if
> (hax_enabled)
> >   when eating dummy APC
> >
> > ----
> >
> > RFC v2 -> v3:
> >
> > * provided defaults for all methods.
> >   Only create_vcpu_thread is now a mandatory field. (Paolo)
> >
> > * separated new CpusAccel patch from its first user, new patch nr. 2:
> >   "cpus: prepare new CpusAccel cpu accelerator interface"
> >
> > * new CpusAccel methods: get_virtual_clock and get_elapsed_ticks.
> >   (Paolo)
> >
> >   In this series, get_virtual_clock has a separate implementation
> >   between TCG/icount and qtest,
> >   while get_elapsed_ticks only returns a virtual counter for icount.
> >
> >   Looking for more comments in this area.
> >
> > ----
> >
> > RFC v1 -> v2:
> >
> > * split the cpus.c accelerator refactoring into 6 patches.
> >
> > * other minor changes to be able to proceed step by step.
> >
> > ----
> >
> > * Rebased on commit 255ae6e2158c743717bed76c9a2365ee4bcd326e,
> > "replay: notify the main loop when there are no instructions"
> >
> > [SPLIT into part1 and part2]
> >
> > ----
> >
> > v6 -> v7:
> >
> > * rebased changes on top of Pavel Dovgalyuk changes to dma-helpers.c
> >   "icount: make dma reads deterministic"
> >
> > ----
> >
> > v5 -> v6:
> >
> > * rebased changes on top of Emilio G. Cota changes to cpus.c
> >   "cpu: convert queued work to a QSIMPLEQ"
> >
> > * keep a pointer in cpus.c instead of a copy of CpusAccel
> >   (Alex)
> >
> > ----
> >
> >
> > v4 -> v5: rebase on latest master
> >
> > * rebased changes on top of roman series to remove one of the extra
> states for hvf.
> >   (Is the result now functional for HVF?)
> >
> > * rebased changes on top of icount changes and fixes to icount_configure
> and
> >   the new shift vmstate. (Markus)
> >
> > v3 -> v4:
> >
> > * overall: added copyright headers to all files that were missing them
> >   (used copyright and license of the module the stuff was extracted
> from).
> >   For the new interface files, added SUSE LLC.
> >
> > * 1/4 (move softmmu only files from root):
> >
> >   MAINTAINERS: moved softmmu/cpus.c to its final location (from patch 2)
> >
> > * 2/4 (cpu-throttle):
> >
> >   MAINTAINERS (to patch 1),
> >   copyright Fabrice Bellard and license from cpus.c
> >
> > * 3/4 (cpu-timers, icount):
> >
> >   - MAINTAINERS: add cpu-timers.c and icount.c to Paolo
> >
> >   - break very long lines (patchew)
> >
> >   - add copyright SUSE LLC, GPLv2 to cpu-timers.h
> >
> >   - add copyright Fabrice Bellard and license from cpus.c to
> timers-state.h
> >     as it is lifted from cpus.c
> >
> >   - vl.c: in configure_accelerators bail out if icount_enabled()
> >     and !tcg_enabled() as qtest does not enable icount anymore.
> >
> > * 4/4 (accel stuff to accel):
> >
> >   - add copyright SUSE LLC to files that mostly only consist of the
> >     new interface. Add whatever copyright was in the accelerator code
> >     if instead they mostly consist of accelerator code.
> >
> >   - change a comment to mention the result of the AccelClass experiment
> >
> >   - moved qtest accelerator into accel/qtest/ , make it like the others.
> >
> >   - rename xxx-cpus-interface to xxx-cpus (remove "interface" from names)
> >
> >   - rename accel_int to cpus_accel
> >
> >   - rename CpusAccel functions from cpu_synchronize_* to synchronize_*
> >
> >
> > --------
> >
> > v2 -> v3:
> >
> > * turned into a 4 patch series, adding a first patch moving
> >   softmmu code currently in top_srcdir to softmmu/
> >
> > * cpu-throttle: moved to softmmu/
> >
> > * cpu-timers, icount:
> >
> >   - moved to softmmu/
> >
> >   - fixed assumption of qtest_enabled() => icount_enabled()
> >   causing the failure of check-qtest-arm goal, in test-arm-mptimer.c
> >
> >   Fix is in hw/core/ptimer.c,
> >
> >   where the artificial timeout rate limit should not be applied
> >   under qtest_enabled(), in a similar way to how it is not applied
> >   for icount_enabled().
> >
> > * CpuAccelInterface: no change.
> >
> >
> > --------
> >
> >
> > v1 -> v2:
> >
> > * 1/3 (cpu-throttle): provide a description in the commit message
> >
> > * 2/3 (cpu-timers, icount): in this v2 separate icount from cpu-timers,
> >   as icount is actually TCG-specific. Only build it under CONFIG_TCG.
> >
> >   To do this, qtest had to be detached from icount. To this end, a
> >   trivial global counter for qtest has been introduced.
> >
> > * 3/3 (CpuAccelInterface): provided a description.
> >
> > This is point 8) in that plan. The idea is to extract the unrelated parts
> > in cpus, and register interfaces from each single accelerator to the main
> > cpus module (cpus.c).
> >
> > While doing this RFC, I noticed some assumptions about Windows being
> > either TCG or HAX (not considering WHPX) that might need to be revisited.
> > I added a comment there.
> >
> > The thing builds successfully based on Linux cross-compilations for
> > windows/hax, windows/whpx, and I got a good build on Darwin/hvf.
> >
> > Tests run successully for tcg and kvm configurations, but did not test on
> > windows or darwin.
> >
> > Welcome your feedback and help on this,
> >
> > Claudio
> >
> >
> > Claudio Fontana (16):
> >   cpu-timers, icount: new modules
> >   icount: rename functions to be consistent with the module name
> >   cpus: prepare new CpusAccel cpu accelerator interface
> >   cpus: extract out TCG-specific code to accel/tcg
> >   cpus: extract out qtest-specific code to accel/qtest
> >   cpus: extract out kvm-specific code to accel/kvm
> >   cpus: extract out hax-specific code to target/i386/
> >   cpus: extract out whpx-specific code to target/i386/
> >   cpus: extract out hvf-specific code to target/i386/hvf/
> >   cpus: cleanup now unneeded includes
> >   cpus: remove checks for non-NULL cpus_accel
> >   cpus: add handle_interrupt to the CpusAccel interface
> >   hvf: remove hvf specific functions from global includes
> >   whpx: remove whpx specific functions from global includes
> >   hax: remove hax specific functions from global includes
> >   kvm: remove kvm specific functions from global includes
> >
> >  MAINTAINERS                    |    5 +-
> >  accel/kvm/kvm-all.c            |   14 +-
> >  accel/kvm/kvm-cpus.c           |   88 ++
> >  accel/kvm/kvm-cpus.h           |   24 +
> >  accel/kvm/meson.build          |    5 +-
> >  accel/meson.build              |    2 +-
> >  accel/qtest/meson.build        |    7 +
> >  accel/qtest/qtest-cpus.c       |   91 ++
> >  accel/qtest/qtest-cpus.h       |   17 +
> >  accel/{ => qtest}/qtest.c      |   13 +-
> >  accel/stubs/hax-stub.c         |   10 -
> >  accel/stubs/hvf-stub.c         |   30 -
> >  accel/stubs/kvm-stub.c         |   23 -
> >  accel/stubs/meson.build        |    2 -
> >  accel/stubs/whpx-stub.c        |   47 -
> >  accel/tcg/cpu-exec.c           |   43 +-
> >  accel/tcg/meson.build          |    2 +-
> >  accel/tcg/tcg-all.c            |   43 +-
> >  accel/tcg/tcg-cpus.c           |  569 +++++++++++
> >  accel/tcg/tcg-cpus.h           |   17 +
> >  accel/tcg/translate-all.c      |    3 +-
> >  dma-helpers.c                  |    4 +-
> >  docs/replay.txt                |    6 +-
> >  exec.c                         |    4 -
> >  hw/core/cpu.c                  |   14 +-
> >  hw/core/ptimer.c               |    8 +-
> >  hw/i386/x86.c                  |    3 +-
> >  include/exec/cpu-all.h         |    4 +
> >  include/exec/exec-all.h        |    4 +-
> >  include/hw/core/cpu.h          |   14 -
> >  include/qemu/timer.h           |   24 +-
> >  include/sysemu/cpu-timers.h    |   90 ++
> >  include/sysemu/cpus.h          |   50 +-
> >  include/sysemu/hax.h           |   17 -
> >  include/sysemu/hvf.h           |    8 -
> >  include/sysemu/hw_accel.h      |   69 +-
> >  include/sysemu/kvm.h           |    7 -
> >  include/sysemu/qtest.h         |    2 +
> >  include/sysemu/replay.h        |    4 +-
> >  include/sysemu/whpx.h          |   19 -
> >  replay/replay.c                |    6 +-
> >  softmmu/cpu-timers.c           |  279 ++++++
> >  softmmu/cpus.c                 | 1697 +++-----------------------------
> >  softmmu/icount.c               |  492 +++++++++
> >  softmmu/meson.build            |   10 +-
> >  softmmu/qtest.c                |   34 +-
> >  softmmu/timers-state.h         |   69 ++
> >  softmmu/vl.c                   |    8 +-
> >  stubs/clock-warp.c             |    7 -
> >  stubs/cpu-get-clock.c          |    3 +-
> >  stubs/cpu-get-icount.c         |   21 -
> >  stubs/cpu-synchronize-state.c  |    9 +
> >  stubs/cpus-get-virtual-clock.c |    8 +
> >  stubs/icount.c                 |   45 +
> >  stubs/meson.build              |    6 +-
> >  stubs/qemu-timer-notify-cb.c   |    8 +
> >  stubs/qtest.c                  |    5 +
> >  target/alpha/translate.c       |    3 +-
> >  target/arm/helper.c            |    7 +-
> >  target/i386/hax-all.c          |   17 +-
> >  target/i386/hax-cpus.c         |   84 ++
> >  target/i386/hax-cpus.h         |   33 +
> >  target/i386/hax-i386.h         |    2 +
> >  target/i386/hax-mem.c          |    2 +-
> >  target/i386/hax-posix.c        |   13 +-
> >  target/i386/hax-windows.c      |   22 +-
> >  target/i386/hax-windows.h      |    2 +
> >  target/i386/hvf/hvf-cpus.c     |  131 +++
> >  target/i386/hvf/hvf-cpus.h     |   25 +
> >  target/i386/hvf/hvf.c          |   12 +-
> >  target/i386/hvf/meson.build    |    1 +
> >  target/i386/hvf/x86hvf.c       |    2 +
> >  target/i386/hvf/x86hvf.h       |    1 -
> >  target/i386/meson.build        |   14 +-
> >  target/i386/whpx-all.c         |   13 +-
> >  target/i386/whpx-cpus.c        |   96 ++
> >  target/i386/whpx-cpus.h        |   34 +
> >  target/riscv/csr.c             |    8 +-
> >  tests/ptimer-test-stubs.c      |    5 +-
> >  tests/test-timed-average.c     |    2 +-
> >  util/main-loop.c               |   12 +-
> >  util/qemu-timer.c              |   14 +-
> >  82 files changed, 2637 insertions(+), 2031 deletions(-)
> >  create mode 100644 accel/kvm/kvm-cpus.c
> >  create mode 100644 accel/kvm/kvm-cpus.h
> >  create mode 100644 accel/qtest/meson.build
> >  create mode 100644 accel/qtest/qtest-cpus.c
> >  create mode 100644 accel/qtest/qtest-cpus.h
> >  rename accel/{ => qtest}/qtest.c (81%)
> >  delete mode 100644 accel/stubs/hvf-stub.c
> >  delete mode 100644 accel/stubs/whpx-stub.c
> >  create mode 100644 accel/tcg/tcg-cpus.c
> >  create mode 100644 accel/tcg/tcg-cpus.h
> >  create mode 100644 include/sysemu/cpu-timers.h
> >  create mode 100644 softmmu/cpu-timers.c
> >  create mode 100644 softmmu/icount.c
> >  create mode 100644 softmmu/timers-state.h
> >  delete mode 100644 stubs/clock-warp.c
> >  delete mode 100644 stubs/cpu-get-icount.c
> >  create mode 100644 stubs/cpu-synchronize-state.c
> >  create mode 100644 stubs/cpus-get-virtual-clock.c
> >  create mode 100644 stubs/icount.c
> >  create mode 100644 stubs/qemu-timer-notify-cb.c
> >  create mode 100644 target/i386/hax-cpus.c
> >  create mode 100644 target/i386/hax-cpus.h
> >  create mode 100644 target/i386/hvf/hvf-cpus.c
> >  create mode 100644 target/i386/hvf/hvf-cpus.h
> >  create mode 100644 target/i386/whpx-cpus.c
> >  create mode 100644 target/i386/whpx-cpus.h
> >
>
>

--00000000000015251b05ae803548
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 4 set 2020, 18:08 Claudio Fontana &lt;<a href=
=3D"mailto:cfontana@suse.de">cfontana@suse.de</a>&gt; ha scritto:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">btw not sure whose queues should these go th=
rough?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">I can take this; the dust from the meson merge should settle soon.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
Thanks,<br>
<br>
Claudio<br>
<br>
On 9/3/20 12:55 PM, Claudio Fontana wrote:<br>
&gt; Motivation and higher level steps:<br>
&gt; <br>
&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg04=
628.html" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.gnu=
.org/archive/html/qemu-devel/2020-05/msg04628.html</a><br>
&gt; <br>
&gt; Current state is all reviewed, I think this is a good base to<br>
&gt; include at this point.<br>
&gt; I had to fix one build issue in patch 1 that went undetected previousl=
y due to<br>
&gt; a meson thing (parallel build).<br>
&gt; <br>
&gt; Further work for future patches include:<br>
&gt; <br>
&gt; * additional improvements to naming consistency in QEMU files. (Claudi=
o, Alex, Roman)<br>
&gt; <br>
&gt; * tcg vcpu start refactoring, providing then multiple structs for mttg=
, icount, normal.<br>
&gt;=C2=A0 =C2=A0(Claudio, Alex)<br>
&gt; <br>
&gt; * possible removal of NULL check for virtual clock if the qcow2 early =
call is solved.<br>
&gt;=C2=A0 =C2=A0(Claudio, Paolo, Berto)<br>
&gt; <br>
&gt; PATCH v6 -&gt; PATCH v7:<br>
&gt; <br>
&gt; * in patch &quot;cpu-timers, icount: new modules&quot;:<br>
&gt;=C2=A0 =C2=A0- remove redundant double initialization of spice<br>
&gt;=C2=A0 =C2=A0- remove lingering calls to icount_get<br>
&gt; <br>
&gt; PATCH v5 -&gt; PATCH v6:<br>
&gt; <br>
&gt; * moved to mason build system<br>
&gt; <br>
&gt; * patch (new): cpus: remove checks for non-NULL cpus_accel (Richard)<b=
r>
&gt; <br>
&gt;=C2=A0 =C2=A0This has however a big caveat: in some cases the virtual c=
lock is<br>
&gt;=C2=A0 =C2=A0queried before an accelerator is set or ticks are enabled;=
 this is<br>
&gt;=C2=A0 =C2=A0currently special cased (keeping the NULL check in cpus_ge=
t_virtual_clock),<br>
&gt;=C2=A0 =C2=A0but maybe this should not happen at all? (Paolo, Berto)<br=
>
&gt; <br>
&gt; * in patch &quot;cpu-timers, icount: new modules&quot;<br>
&gt;=C2=A0 =C2=A0do not change (yet) icount_enabled() to a function.<br>
&gt;=C2=A0 =C2=A0Mimic instead what is done with tcg_enabled(). (Richard)<b=
r>
&gt; <br>
&gt; * split the changes into two separate patches, with name-only changes<=
br>
&gt;=C2=A0 =C2=A0extracted out into a separate patch (Richard).<br>
&gt;=C2=A0 =C2=A0Removed existing Reviewed-by because of these changes (Ale=
x)-<br>
&gt;=C2=A0 =C2=A0Alex are you ok with them?<br>
&gt; <br>
&gt; * in patch &quot;cpus: prepare new CpusAccel cpu accelerator interface=
&quot;<br>
&gt;=C2=A0 =C2=A0remove some unneeded stubs from stubs/cpu-synchronize-stat=
e.c<br>
&gt;=C2=A0 =C2=A0Use const for the CpusAccel interface. (Richard)<br>
&gt; <br>
&gt; * in patch &quot;cpus: extract out TCG-specific code to accel/tcg&quot=
;<br>
&gt;=C2=A0 =C2=A0use const for the CpusAccel interface. (Richard)<br>
&gt; <br>
&gt; * in patch &quot;cpus: extract out qtest-specific code to accel/qtest&=
quot;<br>
&gt;=C2=A0 =C2=A0use const for the CpusAccel interface;<br>
&gt;=C2=A0 =C2=A0use g_assert_not_reached (Richard)<br>
&gt; <br>
&gt; * in patch &quot;cpus: extract out kvm-specific code to accel/kvm&quot=
;<br>
&gt;=C2=A0 =C2=A0use const for the CpusAccel interface. (Richard)<br>
&gt; <br>
&gt; * in patch &quot;cpus: extract out hax-specific code to target/i386/&q=
uot;<br>
&gt;=C2=A0 =C2=A0use const for the CpusAccel interface. (Richard)<br>
&gt; <br>
&gt; * in patch &quot;cpus: extract out whpx-specific code to target/i386/&=
quot;<br>
&gt;=C2=A0 =C2=A0use const for the CpusAccel interface. (Richard)<br>
&gt; <br>
&gt; * in patch &quot;cpus: extract out hvf-specific code to target/i386/hv=
f/&quot;<br>
&gt;=C2=A0 =C2=A0use const for the CpusAccel interface. (Richard)<br>
&gt; <br>
&gt; <br>
&gt; RFC v4 -&gt; PATCH v5:<br>
&gt; <br>
&gt; * in patch 2, move comment about cpus_get_elapsed_ticks from patch 3<b=
r>
&gt;=C2=A0 =C2=A0(Philippe)<br>
&gt; <br>
&gt; * in patch 11-14, do not create separate xxx-int.h files,<br>
&gt;=C2=A0 =C2=A0instead use the xxx-cpus.h files (Philippe)<br>
&gt; <br>
&gt; RFC v3 -&gt; v4:<br>
&gt; <br>
&gt; * added patch 9: cleanup unneeded includes<br>
&gt; <br>
&gt; * added patch 10: add handle_interrupt to the interface (Roman)<br>
&gt; <br>
&gt; * added patch 11-14: remove accelerator specific internal functions<br=
>
&gt;=C2=A0 =C2=A0from global includes (Roman)<br>
&gt; <br>
&gt; * in patch 2, removed leftover &quot;if hvf_enabled&quot; hunk<br>
&gt; <br>
&gt; * in patch 2, convert if (!tcg_enabled) with more punctual if (hax_ena=
bled)<br>
&gt;=C2=A0 =C2=A0when eating dummy APC<br>
&gt; <br>
&gt; ----<br>
&gt; <br>
&gt; RFC v2 -&gt; v3:<br>
&gt; <br>
&gt; * provided defaults for all methods.<br>
&gt;=C2=A0 =C2=A0Only create_vcpu_thread is now a mandatory field. (Paolo)<=
br>
&gt; <br>
&gt; * separated new CpusAccel patch from its first user, new patch nr. 2:<=
br>
&gt;=C2=A0 =C2=A0&quot;cpus: prepare new CpusAccel cpu accelerator interfac=
e&quot;<br>
&gt; <br>
&gt; * new CpusAccel methods: get_virtual_clock and get_elapsed_ticks.<br>
&gt;=C2=A0 =C2=A0(Paolo)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0In this series, get_virtual_clock has a separate implement=
ation<br>
&gt;=C2=A0 =C2=A0between TCG/icount and qtest,<br>
&gt;=C2=A0 =C2=A0while get_elapsed_ticks only returns a virtual counter for=
 icount.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0Looking for more comments in this area.<br>
&gt; <br>
&gt; ----<br>
&gt; <br>
&gt; RFC v1 -&gt; v2:<br>
&gt; <br>
&gt; * split the cpus.c accelerator refactoring into 6 patches.<br>
&gt; <br>
&gt; * other minor changes to be able to proceed step by step.<br>
&gt; <br>
&gt; ----<br>
&gt; <br>
&gt; * Rebased on commit 255ae6e2158c743717bed76c9a2365ee4bcd326e,<br>
&gt; &quot;replay: notify the main loop when there are no instructions&quot=
;<br>
&gt; <br>
&gt; [SPLIT into part1 and part2]<br>
&gt; <br>
&gt; ----<br>
&gt; <br>
&gt; v6 -&gt; v7:<br>
&gt; <br>
&gt; * rebased changes on top of Pavel Dovgalyuk changes to dma-helpers.c<b=
r>
&gt;=C2=A0 =C2=A0&quot;icount: make dma reads deterministic&quot;<br>
&gt; <br>
&gt; ----<br>
&gt; <br>
&gt; v5 -&gt; v6:<br>
&gt; <br>
&gt; * rebased changes on top of Emilio G. Cota changes to cpus.c<br>
&gt;=C2=A0 =C2=A0&quot;cpu: convert queued work to a QSIMPLEQ&quot;<br>
&gt; <br>
&gt; * keep a pointer in cpus.c instead of a copy of CpusAccel<br>
&gt;=C2=A0 =C2=A0(Alex)<br>
&gt; <br>
&gt; ----<br>
&gt; <br>
&gt; <br>
&gt; v4 -&gt; v5: rebase on latest master<br>
&gt; <br>
&gt; * rebased changes on top of roman series to remove one of the extra st=
ates for hvf.<br>
&gt;=C2=A0 =C2=A0(Is the result now functional for HVF?)<br>
&gt; <br>
&gt; * rebased changes on top of icount changes and fixes to icount_configu=
re and<br>
&gt;=C2=A0 =C2=A0the new shift vmstate. (Markus)<br>
&gt; <br>
&gt; v3 -&gt; v4:<br>
&gt; <br>
&gt; * overall: added copyright headers to all files that were missing them=
<br>
&gt;=C2=A0 =C2=A0(used copyright and license of the module the stuff was ex=
tracted from).<br>
&gt;=C2=A0 =C2=A0For the new interface files, added SUSE LLC.<br>
&gt; <br>
&gt; * 1/4 (move softmmu only files from root):<br>
&gt; <br>
&gt;=C2=A0 =C2=A0MAINTAINERS: moved softmmu/cpus.c to its final location (f=
rom patch 2)<br>
&gt; <br>
&gt; * 2/4 (cpu-throttle):<br>
&gt; <br>
&gt;=C2=A0 =C2=A0MAINTAINERS (to patch 1),<br>
&gt;=C2=A0 =C2=A0copyright Fabrice Bellard and license from cpus.c<br>
&gt; <br>
&gt; * 3/4 (cpu-timers, icount):<br>
&gt; <br>
&gt;=C2=A0 =C2=A0- MAINTAINERS: add cpu-timers.c and icount.c to Paolo<br>
&gt; <br>
&gt;=C2=A0 =C2=A0- break very long lines (patchew)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0- add copyright SUSE LLC, GPLv2 to cpu-timers.h<br>
&gt; <br>
&gt;=C2=A0 =C2=A0- add copyright Fabrice Bellard and license from cpus.c to=
 timers-state.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0as it is lifted from cpus.c<br>
&gt; <br>
&gt;=C2=A0 =C2=A0- vl.c: in configure_accelerators bail out if icount_enabl=
ed()<br>
&gt;=C2=A0 =C2=A0 =C2=A0and !tcg_enabled() as qtest does not enable icount =
anymore.<br>
&gt; <br>
&gt; * 4/4 (accel stuff to accel):<br>
&gt; <br>
&gt;=C2=A0 =C2=A0- add copyright SUSE LLC to files that mostly only consist=
 of the<br>
&gt;=C2=A0 =C2=A0 =C2=A0new interface. Add whatever copyright was in the ac=
celerator code<br>
&gt;=C2=A0 =C2=A0 =C2=A0if instead they mostly consist of accelerator code.=
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0- change a comment to mention the result of the AccelClass=
 experiment<br>
&gt; <br>
&gt;=C2=A0 =C2=A0- moved qtest accelerator into accel/qtest/ , make it like=
 the others.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0- rename xxx-cpus-interface to xxx-cpus (remove &quot;inte=
rface&quot; from names)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0- rename accel_int to cpus_accel<br>
&gt; <br>
&gt;=C2=A0 =C2=A0- rename CpusAccel functions from cpu_synchronize_* to syn=
chronize_*<br>
&gt; <br>
&gt; <br>
&gt; --------<br>
&gt; <br>
&gt; v2 -&gt; v3:<br>
&gt; <br>
&gt; * turned into a 4 patch series, adding a first patch moving<br>
&gt;=C2=A0 =C2=A0softmmu code currently in top_srcdir to softmmu/<br>
&gt; <br>
&gt; * cpu-throttle: moved to softmmu/<br>
&gt; <br>
&gt; * cpu-timers, icount:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0- moved to softmmu/<br>
&gt; <br>
&gt;=C2=A0 =C2=A0- fixed assumption of qtest_enabled() =3D&gt; icount_enabl=
ed()<br>
&gt;=C2=A0 =C2=A0causing the failure of check-qtest-arm goal, in test-arm-m=
ptimer.c<br>
&gt; <br>
&gt;=C2=A0 =C2=A0Fix is in hw/core/ptimer.c,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0where the artificial timeout rate limit should not be appl=
ied<br>
&gt;=C2=A0 =C2=A0under qtest_enabled(), in a similar way to how it is not a=
pplied<br>
&gt;=C2=A0 =C2=A0for icount_enabled().<br>
&gt; <br>
&gt; * CpuAccelInterface: no change.<br>
&gt; <br>
&gt; <br>
&gt; --------<br>
&gt; <br>
&gt; <br>
&gt; v1 -&gt; v2:<br>
&gt; <br>
&gt; * 1/3 (cpu-throttle): provide a description in the commit message<br>
&gt; <br>
&gt; * 2/3 (cpu-timers, icount): in this v2 separate icount from cpu-timers=
,<br>
&gt;=C2=A0 =C2=A0as icount is actually TCG-specific. Only build it under CO=
NFIG_TCG.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0To do this, qtest had to be detached from icount. To this =
end, a<br>
&gt;=C2=A0 =C2=A0trivial global counter for qtest has been introduced.<br>
&gt; <br>
&gt; * 3/3 (CpuAccelInterface): provided a description.<br>
&gt; <br>
&gt; This is point 8) in that plan. The idea is to extract the unrelated pa=
rts<br>
&gt; in cpus, and register interfaces from each single accelerator to the m=
ain<br>
&gt; cpus module (cpus.c).<br>
&gt; <br>
&gt; While doing this RFC, I noticed some assumptions about Windows being<b=
r>
&gt; either TCG or HAX (not considering WHPX) that might need to be revisit=
ed.<br>
&gt; I added a comment there.<br>
&gt; <br>
&gt; The thing builds successfully based on Linux cross-compilations for<br=
>
&gt; windows/hax, windows/whpx, and I got a good build on Darwin/hvf.<br>
&gt; <br>
&gt; Tests run successully for tcg and kvm configurations, but did not test=
 on<br>
&gt; windows or darwin.<br>
&gt; <br>
&gt; Welcome your feedback and help on this,<br>
&gt; <br>
&gt; Claudio<br>
&gt; <br>
&gt; <br>
&gt; Claudio Fontana (16):<br>
&gt;=C2=A0 =C2=A0cpu-timers, icount: new modules<br>
&gt;=C2=A0 =C2=A0icount: rename functions to be consistent with the module =
name<br>
&gt;=C2=A0 =C2=A0cpus: prepare new CpusAccel cpu accelerator interface<br>
&gt;=C2=A0 =C2=A0cpus: extract out TCG-specific code to accel/tcg<br>
&gt;=C2=A0 =C2=A0cpus: extract out qtest-specific code to accel/qtest<br>
&gt;=C2=A0 =C2=A0cpus: extract out kvm-specific code to accel/kvm<br>
&gt;=C2=A0 =C2=A0cpus: extract out hax-specific code to target/i386/<br>
&gt;=C2=A0 =C2=A0cpus: extract out whpx-specific code to target/i386/<br>
&gt;=C2=A0 =C2=A0cpus: extract out hvf-specific code to target/i386/hvf/<br=
>
&gt;=C2=A0 =C2=A0cpus: cleanup now unneeded includes<br>
&gt;=C2=A0 =C2=A0cpus: remove checks for non-NULL cpus_accel<br>
&gt;=C2=A0 =C2=A0cpus: add handle_interrupt to the CpusAccel interface<br>
&gt;=C2=A0 =C2=A0hvf: remove hvf specific functions from global includes<br=
>
&gt;=C2=A0 =C2=A0whpx: remove whpx specific functions from global includes<=
br>
&gt;=C2=A0 =C2=A0hax: remove hax specific functions from global includes<br=
>
&gt;=C2=A0 =C2=A0kvm: remove kvm specific functions from global includes<br=
>
&gt; <br>
&gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 5 +-<br>
&gt;=C2=A0 accel/kvm/kvm-all.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A014 +-<br>
&gt;=C2=A0 accel/kvm/kvm-cpus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A088 ++<br>
&gt;=C2=A0 accel/kvm/kvm-cpus.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A024 +<br>
&gt;=C2=A0 accel/kvm/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 5 +-<br>
&gt;=C2=A0 accel/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 2 +-<br>
&gt;=C2=A0 accel/qtest/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A0 7 +<br>
&gt;=C2=A0 accel/qtest/qtest-cpus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A091 ++<br>
&gt;=C2=A0 accel/qtest/qtest-cpus.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A017 +<br>
&gt;=C2=A0 accel/{ =3D&gt; qtest}/qtest.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A013 +-<br>
&gt;=C2=A0 accel/stubs/hax-stub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A010 -<br>
&gt;=C2=A0 accel/stubs/hvf-stub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A030 -<br>
&gt;=C2=A0 accel/stubs/kvm-stub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A023 -<br>
&gt;=C2=A0 accel/stubs/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A0 2 -<br>
&gt;=C2=A0 accel/stubs/whpx-stub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A047 -<br>
&gt;=C2=A0 accel/tcg/cpu-exec.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A043 +-<br>
&gt;=C2=A0 accel/tcg/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 2 +-<br>
&gt;=C2=A0 accel/tcg/tcg-all.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A043 +-<br>
&gt;=C2=A0 accel/tcg/tcg-cpus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 569 +++++++++++<br>
&gt;=C2=A0 accel/tcg/tcg-cpus.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A017 +<br>
&gt;=C2=A0 accel/tcg/translate-all.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 3 +=
-<br>
&gt;=C2=A0 dma-helpers.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 4 +-<br>
&gt;=C2=A0 docs/replay.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 6 +-<br>
&gt;=C2=A0 exec.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 4 -<br>
&gt;=C2=A0 hw/core/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A014 +-<br>
&gt;=C2=A0 hw/core/ptimer.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A0 8 +-<br>
&gt;=C2=A0 hw/i386/x86.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 3 +-<br>
&gt;=C2=A0 include/exec/cpu-all.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A0 4 +<br>
&gt;=C2=A0 include/exec/exec-all.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A0 4 +-<br>
&gt;=C2=A0 include/hw/core/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A014 -<br>
&gt;=C2=A0 include/qemu/timer.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A024 +-<br>
&gt;=C2=A0 include/sysemu/cpu-timers.h=C2=A0 =C2=A0 |=C2=A0 =C2=A090 ++<br>
&gt;=C2=A0 include/sysemu/cpus.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A050 +-<br>
&gt;=C2=A0 include/sysemu/hax.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A017 -<br>
&gt;=C2=A0 include/sysemu/hvf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 8 -<br>
&gt;=C2=A0 include/sysemu/hw_accel.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A069 +=
-<br>
&gt;=C2=A0 include/sysemu/kvm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 7 -<br>
&gt;=C2=A0 include/sysemu/qtest.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A0 2 +<br>
&gt;=C2=A0 include/sysemu/replay.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A0 4 +-<br>
&gt;=C2=A0 include/sysemu/whpx.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A019 -<br>
&gt;=C2=A0 replay/replay.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 6 +-<br>
&gt;=C2=A0 softmmu/cpu-timers.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 279 ++++++<br>
&gt;=C2=A0 softmmu/cpus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 1697 +++-----------------------------<br>
&gt;=C2=A0 softmmu/icount.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 492 +++++++++<br>
&gt;=C2=A0 softmmu/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A010 +-<br>
&gt;=C2=A0 softmmu/qtest.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A034 +-<br>
&gt;=C2=A0 softmmu/timers-state.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A069 ++<br>
&gt;=C2=A0 softmmu/vl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 8 +-<br>
&gt;=C2=A0 stubs/clock-warp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 7 -<br>
&gt;=C2=A0 stubs/cpu-get-clock.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 3 +-<br>
&gt;=C2=A0 stubs/cpu-get-icount.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A021 -<br>
&gt;=C2=A0 stubs/cpu-synchronize-state.c=C2=A0 |=C2=A0 =C2=A0 9 +<br>
&gt;=C2=A0 stubs/cpus-get-virtual-clock.c |=C2=A0 =C2=A0 8 +<br>
&gt;=C2=A0 stubs/icount.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A045 +<br>
&gt;=C2=A0 stubs/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 6 +-<br>
&gt;=C2=A0 stubs/qemu-timer-notify-cb.c=C2=A0 =C2=A0|=C2=A0 =C2=A0 8 +<br>
&gt;=C2=A0 stubs/qtest.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 5 +<br>
&gt;=C2=A0 target/alpha/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A0 3 +-<br>
&gt;=C2=A0 target/arm/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 7 +-<br>
&gt;=C2=A0 target/i386/hax-all.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A017 +-<br>
&gt;=C2=A0 target/i386/hax-cpus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A084 ++<br>
&gt;=C2=A0 target/i386/hax-cpus.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A033 +<br>
&gt;=C2=A0 target/i386/hax-i386.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A0 2 +<br>
&gt;=C2=A0 target/i386/hax-mem.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 2 +-<br>
&gt;=C2=A0 target/i386/hax-posix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A013 +-<br>
&gt;=C2=A0 target/i386/hax-windows.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A022 +=
-<br>
&gt;=C2=A0 target/i386/hax-windows.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +=
<br>
&gt;=C2=A0 target/i386/hvf/hvf-cpus.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 131 +++<br=
>
&gt;=C2=A0 target/i386/hvf/hvf-cpus.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A025 +=
<br>
&gt;=C2=A0 target/i386/hvf/hvf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A012 +-<br>
&gt;=C2=A0 target/i386/hvf/meson.build=C2=A0 =C2=A0 |=C2=A0 =C2=A0 1 +<br>
&gt;=C2=A0 target/i386/hvf/x86hvf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A0 2 +<br>
&gt;=C2=A0 target/i386/hvf/x86hvf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A0 1 -<br>
&gt;=C2=A0 target/i386/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A014 +-<br>
&gt;=C2=A0 target/i386/whpx-all.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A013 +-<br>
&gt;=C2=A0 target/i386/whpx-cpus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A096 ++<br>
&gt;=C2=A0 target/i386/whpx-cpus.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A034 +<br>
&gt;=C2=A0 target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 8 +-<br>
&gt;=C2=A0 tests/ptimer-test-stubs.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 5 +=
-<br>
&gt;=C2=A0 tests/test-timed-average.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 2 +=
-<br>
&gt;=C2=A0 util/main-loop.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A012 +-<br>
&gt;=C2=A0 util/qemu-timer.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A014 +-<br>
&gt;=C2=A0 82 files changed, 2637 insertions(+), 2031 deletions(-)<br>
&gt;=C2=A0 create mode 100644 accel/kvm/kvm-cpus.c<br>
&gt;=C2=A0 create mode 100644 accel/kvm/kvm-cpus.h<br>
&gt;=C2=A0 create mode 100644 accel/qtest/meson.build<br>
&gt;=C2=A0 create mode 100644 accel/qtest/qtest-cpus.c<br>
&gt;=C2=A0 create mode 100644 accel/qtest/qtest-cpus.h<br>
&gt;=C2=A0 rename accel/{ =3D&gt; qtest}/qtest.c (81%)<br>
&gt;=C2=A0 delete mode 100644 accel/stubs/hvf-stub.c<br>
&gt;=C2=A0 delete mode 100644 accel/stubs/whpx-stub.c<br>
&gt;=C2=A0 create mode 100644 accel/tcg/tcg-cpus.c<br>
&gt;=C2=A0 create mode 100644 accel/tcg/tcg-cpus.h<br>
&gt;=C2=A0 create mode 100644 include/sysemu/cpu-timers.h<br>
&gt;=C2=A0 create mode 100644 softmmu/cpu-timers.c<br>
&gt;=C2=A0 create mode 100644 softmmu/icount.c<br>
&gt;=C2=A0 create mode 100644 softmmu/timers-state.h<br>
&gt;=C2=A0 delete mode 100644 stubs/clock-warp.c<br>
&gt;=C2=A0 delete mode 100644 stubs/cpu-get-icount.c<br>
&gt;=C2=A0 create mode 100644 stubs/cpu-synchronize-state.c<br>
&gt;=C2=A0 create mode 100644 stubs/cpus-get-virtual-clock.c<br>
&gt;=C2=A0 create mode 100644 stubs/icount.c<br>
&gt;=C2=A0 create mode 100644 stubs/qemu-timer-notify-cb.c<br>
&gt;=C2=A0 create mode 100644 target/i386/hax-cpus.c<br>
&gt;=C2=A0 create mode 100644 target/i386/hax-cpus.h<br>
&gt;=C2=A0 create mode 100644 target/i386/hvf/hvf-cpus.c<br>
&gt;=C2=A0 create mode 100644 target/i386/hvf/hvf-cpus.h<br>
&gt;=C2=A0 create mode 100644 target/i386/whpx-cpus.c<br>
&gt;=C2=A0 create mode 100644 target/i386/whpx-cpus.h<br>
&gt; <br>
<br>
</blockquote></div></div></div>

--00000000000015251b05ae803548--


