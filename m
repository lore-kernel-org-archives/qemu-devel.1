Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A317C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 10:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363A3206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 10:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yLu0w/qM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363A3206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvf1V-0002tF-HN
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 06:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvf0k-0001ZT-Gc
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 06:51:38 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51262)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvf0g-0006oD-N3
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 06:51:38 -0400
Received: by mail-wm1-x341.google.com with SMTP id 22so5068360wmg.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 03:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=dGnxMF3+BE0/E/NEcE+xnlyQhs9bK1qpElBxzHnDP0k=;
 b=yLu0w/qMiz4b7nNw5Hm+lcqZYbXZvSDdKmRjU8Dew/SLxWF+VRaPuHaN2+mnOXyk4D
 XdIIHWQmoIJJZ7d7m6bdoQ+0JFbM0L9Epy4C4E9bOJRKROLDUZ2HI+hudc5ILIMEV+/R
 snPlBV5q3HV7OJuyRVHwyT3Is/2DatE208R6hw/UDvTP5vbw2361ZWHy+iAXRhehjppp
 Bkf4RsofrY3XRyQrLqTky7zHTXG2vACl/z0FptINvrb2zkoMn9cnXTWRkVLL8zvACT6h
 bsWkK5qGC8g96gTrG8YePuJKNwRvbDnJJ3fYibV/JbwWjKRE6nPXCuGK6aCdn97FZ7DN
 LgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=dGnxMF3+BE0/E/NEcE+xnlyQhs9bK1qpElBxzHnDP0k=;
 b=o8ZNzJnlMmLuGKCbLHsjZstcR9S8XrOhQbwUxvHu20NBku5uzGr1WfHyG1IR1817E7
 3yXiQYECFYVbPQ2megx0p6cFxXGrWEYBRuLQTuS9q5KHrFIJUsJhRXrBqUrnoML1L1PV
 Y0Xd5i6GY+yGF9Lum09fWZwHnjBvzxc3/g0HgwsVERU2aWv6yiko8YvwX5tFLtwVtWya
 u8cx0pDK8TxUnyOX1IPHbOPqmUbboJfWW0mjMufsFYtEHPHrdRSSTrpF9ydgQXr0kmvn
 ASXU6JHAvpZtP3fpFc+CiykMt1vpW761DxOxu3kda4LuD9eiI9bdpCLRy17Va49XKfzV
 p8pw==
X-Gm-Message-State: AOAM531ihh3w8z1wDCBOxsskWxeEfr808vGLgrsuChdjh4kZY3xfHdui
 m97TXQ75EDWHRBT7ypfUX3679w==
X-Google-Smtp-Source: ABdhPJx2tuX/XSLVZCHvw9y1rkN3o5fsQtbpRjwy58UpBy9sILtzptf1JPOwuOUdGqR4bvE9laeHlg==
X-Received: by 2002:a1c:ac81:: with SMTP id v123mr7779066wme.159.1594810292986; 
 Wed, 15 Jul 2020 03:51:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d28sm3436844wrc.50.2020.07.15.03.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 03:51:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9024D1FF7E;
 Wed, 15 Jul 2020 11:51:30 +0100 (BST)
References: <20200714095247.19573-1-alex.bennee@linaro.org>
 <CAFEAcA-4U-LAjcBPWQNrtfk=Kr2zsejHGYCzLWSoYq97_o9j8g@mail.gmail.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/9] final misc fixes for 5.1-rc0
In-reply-to: <CAFEAcA-4U-LAjcBPWQNrtfk=Kr2zsejHGYCzLWSoYq97_o9j8g@mail.gmail.com>
Date: Wed, 15 Jul 2020 11:51:30 +0100
Message-ID: <87lfjlxd8t.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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


Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 14 Jul 2020 at 10:52, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> The following changes since commit 20c1df5476e1e9b5d3f5b94f9f3ce01d21f14=
c46:
>>
>>   Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20200713-pull-=
request' into staging (2020-07-13 16:58:44 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/stsquad/qemu.git tags/pull-misc-for-rc0-140720-1
>>
>> for you to fetch changes up to 4e6400c97024c2660b6db8aab1f0677744449f36:
>>
>>   plugins: expand the bb plugin to be thread safe and track per-cpu (202=
0-07-14 09:08:25 +0100)
>>
>> ----------------------------------------------------------------
>> Final fixes for 5.1-rc0
>>
>>   - minor documentation nit
>>   - clean all deps on re(configure)
>>   - docker.py bootstrap fixes
>>   - tweak containers.yml wildcards
>>   - fix float16 nan detection
>>   - conditional use of -Wpsabi
>>   - fix missing iotlb data for plugins
>>   - proper locking for helper based bb count
>
> Fails "make check" on aarch32 and aarch64 hosts, because
> eg qemu-system-arm segfaults on startup:
>
> $ gdb --args ./arm-softmmu/qemu-system-arm -M virt -display none
> [...]
> (gdb) r
> Starting program: /home/pm/qemu/build/all/arm-softmmu/qemu-system-arm
> -M virt -display none
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/aarch64-linux-gnu/libthread_db.so.1=
".
> [New Thread 0xffffe873e550 (LWP 1666261)]
> [New Thread 0xffffe7f3d550 (LWP 1666262)]
> [New Thread 0xffffe72e7550 (LWP 1666263)]
>
> Thread 4 "qemu-system-arm" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0xffffe72e7550 (LWP 1666263)]
> 0x0000aaaaab1da004 in object_class_dynamic_cast_assert (class=3D0xaaaaabc=
209e0,
>     typename=3Dtypename@entry=3D0xaaaaab33bfe8 "cpu",
> file=3Dfile@entry=3D0xaaaaab3201a0 "/home/pm/qemu/accel/tcg/cputlb.c",
>     line=3Dline@entry=3D1025, func=3Dfunc@entry=3D0xaaaaab3202f0
> <__func__.35278> "tlb_fill") at /home/pm/qemu/qom/object.c:917
> 917         trace_object_class_dynamic_cast_assert(class ?
> class->type->name : "(null)",
> (gdb) bt
> #0  0x0000aaaaab1da004 in object_class_dynamic_cast_assert
>     (class=3D0xaaaaabc209e0, typename=3Dtypename@entry=3D0xaaaaab33bfe8
> "cpu", file=3Dfile@entry=3D0xaaaaab3201a0
> "/home/pm/qemu/accel/tcg/cputlb.c", line=3Dline@entry=3D1025,
> func=3Dfunc@entry=3D0xaaaaab3202f0 <__func__.35278> "tlb_fill")
>     at /home/pm/qemu/qom/object.c:917
> #1  0x0000aaaaaaded754 in tlb_fill
>     (cpu=3D0xaaaaabd301c0, addr=3D0, size=3D0, access_type=3DMMU_INST_FET=
CH,
> mmu_idx=3D2, retaddr=3D0)
>     at /home/pm/qemu/accel/tcg/cputlb.c:1025
> #2  0x0000aaaaaadf0e08 in get_page_addr_code_hostp
> (env=3D0xaaaaabd39870, addr=3Daddr@entry=3D0, hostp=3Dhostp@entry=3D0x0)
>     at /home/pm/qemu/include/exec/cpu-all.h:451
> #3  0x0000aaaaaadf0e70 in get_page_addr_code (env=3D<optimized out>,
> addr=3Daddr@entry=3D0)
>     at /home/pm/qemu/accel/tcg/cputlb.c:1243
> #4  0x0000aaaaaae08c30 in tb_htable_lookup
>     (cpu=3Dcpu@entry=3D0xaaaaabd301b0, pc=3D0, cs_base=3D<optimized out>,
> flags=3D38928384, cf_mask=3D4278714368)
>     at /home/pm/qemu/accel/tcg/cpu-exec.c:337
> #5  0x0000aaaaaae09b14 in tb_lookup__cpu_state
>     (cf_mask=3D<optimized out>, flags=3D0xffffe72e6b48,
> cs_base=3D0xffffe72e6b40, pc=3D0xffffe72e6b44, cpu=3D0xaaaaabd301b0)
>     at /home/pm/qemu/include/exec/tb-lookup.h:43
> #6  tb_find (cf_mask=3D<optimized out>, tb_exit=3D0, last_tb=3D0x0,
> cpu=3D0xaaaaabd301b0)
>     at /home/pm/qemu/accel/tcg/cpu-exec.c:404
> #7  cpu_exec (cpu=3Dcpu@entry=3D0xaaaaabd301b0) at
> /home/pm/qemu/accel/tcg/cpu-exec.c:731
> #8  0x0000aaaaaaec45c4 in tcg_cpu_exec (cpu=3D0xaaaaabd301b0) at
> /home/pm/qemu/softmmu/cpus.c:1356
> #9  0x0000aaaaaaec69ec in qemu_tcg_cpu_thread_fn
> (arg=3Darg@entry=3D0xaaaaabd301b0) at /home/pm/qemu/softmmu/cpus.c:1664
> #10 0x0000aaaaab2e1758 in qemu_thread_start (args=3D<optimized out>) at
> /home/pm/qemu/util/qemu-thread-posix.c:521
> #11 0x0000fffff57be4fc in start_thread (arg=3D0xffffffffe10f) at
> pthread_create.c:477
> #12 0x0000fffff5716f2c in thread_start () at
> ../sysdeps/unix/sysv/linux/aarch64/clone.S:78

This goes away after a make clean and rebuild. I suspect the commit:

  configure: remove all dependencies on a (re)configure

just causes the build to miss more of the bits on a rebuild. I'll drop
it for now and just live with the random syscall_nr.h files.

--=20
Alex Benn=C3=A9e

