Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985C2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 08:07:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B0B20578
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 08:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZxPTBBSJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B0B20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvcRj-0001j3-HQ
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 04:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvcQu-00019s-0Y
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 04:06:28 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvcQs-0000YF-0T
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 04:06:27 -0400
Received: by mail-ot1-x342.google.com with SMTP id t18so802804otq.5
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 01:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=i8FFUzltE7ITEHW+sgrutAJEOPLY7vqHqHRKg4Svlnc=;
 b=ZxPTBBSJdYPrtPdjDLNR3bQKwNEGDFVFnfIX9LQpdUfdIOVMRpVMEKIDGOeaz1VmNU
 dvqQ6K524xhpRKmwpsq4tsjA5vaANvozQ8PEqvpYLPVNOdZ/OlRPKfjMXpLFb1lAArZd
 1SqIIx5cmNkt9/Fj+fM5y6RBIu/lhJjDYd1mpmX7fUTKrZEQRmiardsqRACIzuQoDT+s
 l7ghQXdsf9Xa26bCbI+RcsKtEutQ2371Bp3Na7aLbjwRHkU8LJmBXQLlKLifzKtc3WAF
 Ab7IJWsRvNtAByMPJXdnLeDZvPviXTZctikZEIhjTCW4l7qgW2y7EM36TFl0LFrkozd2
 G/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=i8FFUzltE7ITEHW+sgrutAJEOPLY7vqHqHRKg4Svlnc=;
 b=iAFMPQvgvQQqFpcGZ2PVcatidZuD7sIWRWdb1NjKcMpWyeGhkvetc7ap8idpwH+Zsk
 cvmkvGfwT2POGpVi9QckC0ZasjCJu0Y8AN01cwp9utJgy7PKUONRg0uYpZ5GrfheVwnM
 5/MWNiBp9LFPVwlrdr8+/jw/fTQDjrpK0rRBChWHeji/yl61gcJ6Zlui66Jz899zkqHb
 rFQ6+xR1HmaJLCAa0MaXLAGuBPdsi4mHs9C3dKjuPDTCj2ymb2jnRfflyz1lfwu5xh7Q
 a1p04G1Hvumz/B7+XJ6BMGo3iDtusO2tC8sy+MJGX8RzaYodWe6uFtjg5qWiuPXVtynb
 ht1Q==
X-Gm-Message-State: AOAM5302XKH90V3i2JXlCVN83l8/1uvqYDctmYl8TNcw7C4G21Jgvi+s
 C8EqemuwqBpDwQidnYtwzIK1+AIH0l9PLk8KdwaTgA==
X-Google-Smtp-Source: ABdhPJz468ea1iMEmDDNv2cug6sEGh2aZwXHTyxi0MHqqdnWu3VafgZvBFugRDADMaQU4KsPVT6PapMUlpVKYzFt4MA=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr7933004oto.135.1594800384429; 
 Wed, 15 Jul 2020 01:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200714095247.19573-1-alex.bennee@linaro.org>
In-Reply-To: <20200714095247.19573-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Jul 2020 09:06:13 +0100
Message-ID: <CAFEAcA-4U-LAjcBPWQNrtfk=Kr2zsejHGYCzLWSoYq97_o9j8g@mail.gmail.com>
Subject: Re: [PULL 0/9] final misc fixes for 5.1-rc0
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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

On Tue, 14 Jul 2020 at 10:52, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 20c1df5476e1e9b5d3f5b94f9f3ce01d21f14c=
46:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20200713-pull-r=
equest' into staging (2020-07-13 16:58:44 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-misc-for-rc0-140720-1
>
> for you to fetch changes up to 4e6400c97024c2660b6db8aab1f0677744449f36:
>
>   plugins: expand the bb plugin to be thread safe and track per-cpu (2020=
-07-14 09:08:25 +0100)
>
> ----------------------------------------------------------------
> Final fixes for 5.1-rc0
>
>   - minor documentation nit
>   - clean all deps on re(configure)
>   - docker.py bootstrap fixes
>   - tweak containers.yml wildcards
>   - fix float16 nan detection
>   - conditional use of -Wpsabi
>   - fix missing iotlb data for plugins
>   - proper locking for helper based bb count

Fails "make check" on aarch32 and aarch64 hosts, because
eg qemu-system-arm segfaults on startup:

$ gdb --args ./arm-softmmu/qemu-system-arm -M virt -display none
[...]
(gdb) r
Starting program: /home/pm/qemu/build/all/arm-softmmu/qemu-system-arm
-M virt -display none
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/aarch64-linux-gnu/libthread_db.so.1".
[New Thread 0xffffe873e550 (LWP 1666261)]
[New Thread 0xffffe7f3d550 (LWP 1666262)]
[New Thread 0xffffe72e7550 (LWP 1666263)]

Thread 4 "qemu-system-arm" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0xffffe72e7550 (LWP 1666263)]
0x0000aaaaab1da004 in object_class_dynamic_cast_assert (class=3D0xaaaaabc20=
9e0,
    typename=3Dtypename@entry=3D0xaaaaab33bfe8 "cpu",
file=3Dfile@entry=3D0xaaaaab3201a0 "/home/pm/qemu/accel/tcg/cputlb.c",
    line=3Dline@entry=3D1025, func=3Dfunc@entry=3D0xaaaaab3202f0
<__func__.35278> "tlb_fill") at /home/pm/qemu/qom/object.c:917
917         trace_object_class_dynamic_cast_assert(class ?
class->type->name : "(null)",
(gdb) bt
#0  0x0000aaaaab1da004 in object_class_dynamic_cast_assert
    (class=3D0xaaaaabc209e0, typename=3Dtypename@entry=3D0xaaaaab33bfe8
"cpu", file=3Dfile@entry=3D0xaaaaab3201a0
"/home/pm/qemu/accel/tcg/cputlb.c", line=3Dline@entry=3D1025,
func=3Dfunc@entry=3D0xaaaaab3202f0 <__func__.35278> "tlb_fill")
    at /home/pm/qemu/qom/object.c:917
#1  0x0000aaaaaaded754 in tlb_fill
    (cpu=3D0xaaaaabd301c0, addr=3D0, size=3D0, access_type=3DMMU_INST_FETCH=
,
mmu_idx=3D2, retaddr=3D0)
    at /home/pm/qemu/accel/tcg/cputlb.c:1025
#2  0x0000aaaaaadf0e08 in get_page_addr_code_hostp
(env=3D0xaaaaabd39870, addr=3Daddr@entry=3D0, hostp=3Dhostp@entry=3D0x0)
    at /home/pm/qemu/include/exec/cpu-all.h:451
#3  0x0000aaaaaadf0e70 in get_page_addr_code (env=3D<optimized out>,
addr=3Daddr@entry=3D0)
    at /home/pm/qemu/accel/tcg/cputlb.c:1243
#4  0x0000aaaaaae08c30 in tb_htable_lookup
    (cpu=3Dcpu@entry=3D0xaaaaabd301b0, pc=3D0, cs_base=3D<optimized out>,
flags=3D38928384, cf_mask=3D4278714368)
    at /home/pm/qemu/accel/tcg/cpu-exec.c:337
#5  0x0000aaaaaae09b14 in tb_lookup__cpu_state
    (cf_mask=3D<optimized out>, flags=3D0xffffe72e6b48,
cs_base=3D0xffffe72e6b40, pc=3D0xffffe72e6b44, cpu=3D0xaaaaabd301b0)
    at /home/pm/qemu/include/exec/tb-lookup.h:43
#6  tb_find (cf_mask=3D<optimized out>, tb_exit=3D0, last_tb=3D0x0,
cpu=3D0xaaaaabd301b0)
    at /home/pm/qemu/accel/tcg/cpu-exec.c:404
#7  cpu_exec (cpu=3Dcpu@entry=3D0xaaaaabd301b0) at
/home/pm/qemu/accel/tcg/cpu-exec.c:731
#8  0x0000aaaaaaec45c4 in tcg_cpu_exec (cpu=3D0xaaaaabd301b0) at
/home/pm/qemu/softmmu/cpus.c:1356
#9  0x0000aaaaaaec69ec in qemu_tcg_cpu_thread_fn
(arg=3Darg@entry=3D0xaaaaabd301b0) at /home/pm/qemu/softmmu/cpus.c:1664
#10 0x0000aaaaab2e1758 in qemu_thread_start (args=3D<optimized out>) at
/home/pm/qemu/util/qemu-thread-posix.c:521
#11 0x0000fffff57be4fc in start_thread (arg=3D0xffffffffe10f) at
pthread_create.c:477
#12 0x0000fffff5716f2c in thread_start () at
../sysdeps/unix/sysv/linux/aarch64/clone.S:78

thanks
-- PMM

