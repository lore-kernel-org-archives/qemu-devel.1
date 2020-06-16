Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06999C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB212071A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RgldMa0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB212071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlE9A-0003Aq-0S
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 12:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlE8M-0002GR-TW
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 12:08:22 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlE8K-0004bq-Cy
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 12:08:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id t18so21381172wru.6
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 09:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=2FtOmvb1/YQDnr+61OKSPHDEbr4Stl6zvtvVmBPPc2M=;
 b=RgldMa0WF7aWW5qks02ATEJTYV8LIpZ6HNADMyJ1G8eNHswQqGlsU8lSkojcDaZrBh
 Ugc/phcDwNRRBix407pNeKh2+j38jhNcmv9wSjEQEutPWrCaJV3kS3sBCoijhiyBM7L2
 qPwioHa3SX10HwQn/2ZECJofdtpxIGNkxp0ckG80+JfDgAM0DPrROoQWv2TgSUhOd1bA
 BaG0YPauWJxpld8F3lZ0tLlzjET3OXVUE8VjJCDqd6jPKzFF9cIRBE1OuIW6rjs5q8N+
 zX01jhE7m4J0+/4iSWQO0Xic+UyA5xNPVR1h+Z96damTkDtAUUA/5FSS51HKdLcgrij+
 MKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=2FtOmvb1/YQDnr+61OKSPHDEbr4Stl6zvtvVmBPPc2M=;
 b=FY+Je1erUt+ZTi0Yxn+tVB3cj5EFA51V2FLzgWyZ+puvRIszkKFGYM20igsurSZUGt
 HTK2r7WAmBOTQbDTAZdHKAzlhxcu/6ZLdf+aqmzJLBO5taL0uvtlxUgbijo7xs5h77r0
 eclYTXFPHYSlC2UwLzpl6w1mu/7/meRmnLTvjJYq1xV7Yo3ht70XFvOxQABv7uaChPRa
 mvbPU0xo7NmhNn/vsh/9wui6gX4R8V/rkNFD171XQsEC2li9z6/TS6Tgcs/5OrAdcf3P
 fzCyNosE/6swHo5BnCYq84vATa7mxgzReynkd0on2P3I5hhI+xxiuCTY6ZEeAh6QO88y
 yczQ==
X-Gm-Message-State: AOAM530+NxYgEuetZ8z2xWyLBjil7/t00nNFMPPekls8Tuh7WxcKWVcZ
 P4h0AVur6RfFrfVSFXm5ZfehZg==
X-Google-Smtp-Source: ABdhPJxoICU/2/IaZx6DaDd5j4g+NOliwZTHk+SMaLnWXzpgxIOWxWFtoPFr5GSh/J/0Awx0Mo/koA==
X-Received: by 2002:adf:e285:: with SMTP id v5mr3717333wri.129.1592323698350; 
 Tue, 16 Jun 2020 09:08:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e25sm5434495wrc.69.2020.06.16.09.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 09:08:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 56BCB1FF7E;
 Tue, 16 Jun 2020 17:08:16 +0100 (BST)
References: <20200612014606.147691-1-jkz@google.com>
 <20200612014606.147691-5-jkz@google.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Josh Kunz <jkz@google.com>
Subject: Re: [PATCH 4/5] linux-user: Support CLONE_VM and extended clone
 options
In-reply-to: <20200612014606.147691-5-jkz@google.com>
Date: Tue, 16 Jun 2020 17:08:16 +0100
Message-ID: <87h7vbyowf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: riku.voipio@iki.fi, qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Josh Kunz <jkz@google.com> writes:

> The `clone` system call can be used to create new processes that share
> attributes with their parents, such as virtual memory, file
> system location, file descriptor tables, etc. These can be useful to a
> variety of guest programs.
>
> Before this patch, QEMU had support for a limited set of these attributes.
> Basically the ones needed for threads, and the options used by fork.
> This change adds support for all flag combinations involving CLONE_VM.
> In theory, almost all clone options could be supported, but invocations
> not using CLONE_VM are likely to run afoul of linux-user's inherently
> multi-threaded design.
>
> To add this support, this patch updates the `qemu_clone` helper. An
> overview of the mechanism used to support general `clone` options with
> CLONE_VM is described below.
>
> This patch also enables by-default the `clone` unit-tests in
> tests/tcg/multiarch/linux-test.c, and adds an additional test for duplica=
te
> exit signals, based on a bug found during development.

Which by the way fail on some targets:

    TEST    linux-test on alpha
  /home/alex/lsrc/qemu.git/tests/tcg/multiarch/linux-test.c:709: child did =
not receive PDEATHSIG on parent death
  make[2]: *** [../Makefile.target:153: run-linux-test] Error 1
  make[1]: *** [/home/alex/lsrc/qemu.git/tests/tcg/Makefile.qemu:76: run-gu=
est-tests] Error 2
  make: *** [/home/alex/lsrc/qemu.git/tests/Makefile.include:851: run-tcg-t=
ests-alpha-linux-user] Error 2

Have you managed a clean check-tcg with docker enabled so all the guest
architectures get tested?

>
> !! Overview
>
> Adding support for CLONE_VM is tricky. The parent and guest process will
> share an address space (similar to threads), so the emulator must
> coordinate between the parent and the child. Currently, QEMU relies
> heavily on Thread Local Storage (TLS) as part of this coordination
> strategy. For threads, this works fine, because libc manages the
> thread-local data region used for TLS, when we create new threads using
> `pthread_create`. Ideally we could use the same mechanism for
> "process-local storage" needed to allow the parent/child processes to
> emulate in tandem. Unfortunately TLS is tightly integrated into libc.
> The only way to create TLS data regions is via the `pthread_create` API
> which also spawns a new thread (rather than a new processes, which is
> what we want). Worse still, TLS itself is a complicated arch-specific
> feature that is tightly integrated into the rest of libc and the dynamic
> linker. Re-implementing TLS support for QEMU would likely require a
> special dynamic linker / libc. Alternatively, the popular libcs could be
> extended, to allow for users to create TLS regions without creating
> threads. Even if major libcs decide to add this support, QEMU will still
> need a temporary work around until those libcs are widely deployed. It's
> also unclear if libcs will be interested in supporting this case, since
> TLS image creation is generally deeply integrated with thread setup.
>
> In this patch, I've employed an alternative approach: spawning a thread
> an "stealing" its TLS image for use in the child process. This approach
> leaves a dangling thread while the TLS image is in use, but by design
> that thread will not become schedulable until after the TLS data is no
> longer in-use by the child (as described in a moment). Therefore, it
> should cause relatively minimal overhead. When considered in the larger
> context, this seems like a reasonable tradeoff.

*sharp intake of breath*

OK so the solution to the complexity of handling threads is to add more
threads? cool cool cool....

>
> A major complication of this approach knowing when it is safe to clean up
> the stack, and TLS image, used by a child process. When a child is
> created with `CLONE_VM` its stack, and TLS data, need to remain valid
> until that child has either exited, or successfully called `execve` (on
> `execve` the child is given a new VMM by the kernel). One approach would
> be to use `waitid(WNOWAIT)` (the `WNOWAIT` allows the guest to reap the
> child). The problem is that the `wait` family of calls only waits for
> termination. The pattern of `clone() ... execve()` for long running
> child processes is pretty common. If we waited for child processes to
> exit, it's likely we would end up using substantially more memory, and
> keep the suspended TLS thread around much longer than necessary.
> Instead, in this patch, I've used an "trampoline" process. The real
> parent first clones a trampoline, the trampoline then clones the
> ultimate child using the `CLONE_VFORK` option. `CLONE_VFORK` suspends
> the trampoline process until the child has exited, or called `execve`.
> Once the trampoline is re-scheduled, we know it is safe to clean up
> after the child. This creates one more suspended process, but typically,
> the trampoline only exists for a short period of time.
>
> !! CLONE_VM setup, step by step
>
> 1. First, the suspended thread whose TLS we will use is created using
>    `pthread_create`. The thread fetches and returns it's "TLS pointer"
>    (an arch-specific value given to the kernel) to the parent. It then
>    blocks on a lock to prevent its TLS data from being cleaned up.
>    Ultimately the lock will be unlocked by the trampoline once the child
>    exits.
> 2. Once the TLS thread has fetched the TLS pointer, it notifies the real
>    parent thread, which calls `clone()` to create the trampoline
>    process. For ease of implementation, the TLS image is set for the
>    trampoline process during this step. This allows the trampoline to
>    use functions that require TLS if needed (e.g., printf). TLS location
>    is inherited when a new child is spawned, so this TLS data will
>    automatically be inherited by the child.
> 3. Once the trampoline has been spawned, it registers itself as a
>    "hidden" process with the signal subsystem. This prevents the exit
>    signal from the trampoline from ever being forwarded to the guest.
>    This is needed due to the way that Linux sets the exit signal for the
>    ultimate child when `CLONE_PARENT` is set. See the source for
>    details.
> 4. Once setup is complete, the trampoline spawns the final child with
>    the original clone flags, plus `CLONE_PARENT`, so the child is
>    correctly parented to the kernel task on which the guest invoked
>    `clone`. Without this, kernel features like PDEATHSIG, and
>    subreapers, would not work properly. As previously discussed, the
>    trampoline also supplies `CLONE_VFORK` so that it is suspended until
>    the child can be cleaned up.
> 5. Once the child is spawned, it signals the original parent thread that
>    it is running. At this point, the trampoline process is suspended
>    (due to CLONE_VFORK).
> 6. Finally, the call to `qemu_clone` in the parent is finished, the
>    child begins executing the given callback function in the new child
>    process.
>
> !! Cleaning up
>
> Clean up itself is a multi-step process. Once the child exits, or is
> killed by a signal (cleanup is the same in both cases), the trampoline
> process becomes schedulable. When the trampoline is scheduled, it frees
> the child stack, and unblocks the suspended TLS thread. This cleans up
> the child resources, but not the stack used by the trampoline itself. It
> is possible for a process to clean up its own stack, but it is tricky,
> and architecture-specific. Instead we leverage the TLS manager thread to
> clean up the trampoline stack. When the trampoline is cloned (in step 2
> above), we additionally set the `CHILD_SETTID` and `CHILD_CLEARTID`
> flags. The target location for the SET/CLEAR TID is set to a special field
> known by the TLS manager. Then, when the TLS manager thread is unsuspende=
d,
> it performs an additional `FUTEX_WAIT` on this location. That blocks the
> TLS manager thread until the trampoline has fully exited, then the TLS
> manager thread frees the trampoline process's stack, before exiting
> itself.
>
> !! Shortcomings of this patch
>
> * It's complicated.
> * It doesn't support any clone options when CLONE_VM is omitted.
> * It doesn't properly clean up the CPU queue when the child process
>   terminates, or calls execve().
> * RCU unregistration is done in the trampoline process (in clone.c), but
>   registration happens in syscall.c This should be made more explicit.
> * The TLS image, and trampoline stack are not cleaned up if the parent
>   calls `execve` or `exit_group` before the child does. This is because
>   those cleanup tasks are handled by the TLS manager thread. The TLS
>   manager thread is in the same thread group as the parent, so it will
>   be terminated if the parent exits or calls `execve`.
>
> !! Alternatives considered
>
> * Non-standard libc extension to allow creating TLS images independent
>   of threads. This would allow us to just `clone` the child directly
>   instead of this complicated maneuver. Though we probably would still
>   need the cleanup logic. For libcs, TLS image allocation is tightly
>   connected to thread stack allocation, which is also arch-specific. I
>   do not have enough experience with libc development to know if
>   maintainers of any popular libcs would be open to supporting such an
>   API. Additionally, since it will probably take years before a libc
>   fix would be widely deployed, we need an interim solution anyways.

We could consider a custom lib stub that intercepts calls to the guests
original libc and replaces it with a QEMU aware one?

> * Non-standard, Linux-only, libc extension to allow us to specify the
>   CLONE_* flags used by `pthread_create`. The processes we are creating
>   are basically threads in a different thread group. If we could alter
>   the flags used, this whole processes could become a `pthread_create.`
>   The problem with this approach is that I don't know what requirements
>   pthreads has on threads to ensure they function properly. I suspect
>   that pthreads relies on CHILD_CLEARTID+FUTEX_WAKE to cleanup detached
>   thread state. Since we don't control the child exit reason (Linux only
>   handles CHILD_CLEARTID on normal, non-signal process termination), we
>   probably can't use this same tracking mechanism.
> * Other mechanisms for detecting child exit so cleanup can happen
>   besides CLONE_VFORK:
>   * waitid(WNOWAIT): This can only detect exit, not execve.
>   * file descriptors with close on exec set: This cannot detect children
>     cloned with CLONE_FILES.
>   * System V semaphore adjustments: Cannot detect children cloned with
>     CLONE_SYSVSEM.
>   * CLONE_CHILD_CLEARTID + FUTEX_WAIT: Cannot detect abnormally
>     terminated children.
> * Doing the child clone directly in the TLS manager thread: This saves the
>   need for the trampoline process, but it causes the child process to be
>   parented to the wrong kernel task (the TLS thread instead of the Main
>   thread) breaking things like PDEATHSIG.

Have you considered a daemon which could co-ordinate between the
multiple processes that are sharing some state?


> Signed-off-by: Josh Kunz <jkz@google.com>
> ---
>  linux-user/clone.c               | 415 ++++++++++++++++++++++++++++++-
>  linux-user/qemu.h                |  17 ++
>  linux-user/signal.c              |  49 ++++
>  linux-user/syscall.c             |  69 +++--
>  tests/tcg/multiarch/linux-test.c |  67 ++++-
>  5 files changed, 592 insertions(+), 25 deletions(-)
>
> diff --git a/linux-user/clone.c b/linux-user/clone.c
> index f02ae8c464..3f7344cf9e 100644
> --- a/linux-user/clone.c
> +++ b/linux-user/clone.c
> @@ -12,6 +12,12 @@
>  #include <stdbool.h>
>  #include <assert.h>
>=20=20
> +/* arch-specifc includes needed to fetch the TLS base offset. */
> +#if defined(__x86_64__)
> +#include <asm/prctl.h>
> +#include <sys/prctl.h>
> +#endif
> +
>  static const unsigned long NEW_STACK_SIZE =3D 0x40000UL;
>=20=20
>  /*
> @@ -62,6 +68,397 @@ static void completion_finish(struct completion *c)
>      pthread_mutex_unlock(&c->mu);
>  }
>=20=20
> +struct tls_manager {
> +    void *tls_ptr;
> +    /* fetched is completed once tls_ptr has been set by the thread. */
> +    struct completion fetched;
> +    /*
> +     * spawned is completed by the user once the managed_tid
> +     * has been spawned.
> +     */
> +    struct completion spawned;
> +    /*
> +     * TID of the child whose memory is cleaned up upon death. This memo=
ry
> +     * location is used as part of a futex op, and is cleared by the ker=
nel
> +     * since we specify CHILD_CLEARTID.
> +     */
> +    int managed_tid;
> +    /*
> +     * The value to be `free`'d up once the janitor is ready to clean up=
 the
> +     * TLS section, and the managed tid has exited.
> +     */
> +    void *cleanup;
> +};
> +
> +/*
> + * tls_ptr fetches the TLS "pointer" for the current thread. This pointer
> + * should be whatever platform-specific address is used to represent the=
 TLS
> + * base address.
> + */
> +static void *tls_ptr()

This and a number of other prototypes need void args to stop the
compiler complaining about missing prototypes.

> +{
> +    void *ptr;
> +#if defined(__x86_64__)
> +    /*
> +     * On x86_64, the TLS base is stored in the `fs` segment register, w=
e can
> +     * fetch it with `ARCH_GET_FS`:
> +     */
> +    (void)syscall(SYS_arch_prctl, ARCH_GET_FS, (unsigned long) &ptr);
> +#else
> +    ptr =3D NULL;
> +#endif
> +    return ptr;
> +}
> +
> +/*
> + * clone_vm_supported returns true if clone_vm() is supported on this
> + * platform.
> + */
> +static bool clone_vm_supported()
> +{
> +#if defined(__x86_64__)
> +    return true;
> +#else
> +    return false;
> +#endif
> +}
<snip>

--=20
Alex Benn=C3=A9e

