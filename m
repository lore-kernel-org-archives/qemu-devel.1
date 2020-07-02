Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5334AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 06:19:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1546320884
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 06:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlsLo67K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1546320884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqsZG-0000R5-92
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 02:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgaluk@gmail.com>)
 id 1jqsYS-0008Hs-NP
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 02:18:40 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733]:39766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pavel.dovgaluk@gmail.com>)
 id 1jqsYQ-0007C5-R0
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 02:18:40 -0400
Received: by mail-qk1-x733.google.com with SMTP id l6so24636546qkc.6
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 23:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5WlTcU+vqZ8TmOacx8AvaiFyv/4272pk8vVbqRlVqQE=;
 b=HlsLo67KKEDJFXlB8df98ryz0zFEVzqGuytBNMBu5ysmO7Gpl/YHjAjrQag2pJz5UY
 LUZGIfTMIXwyLqC/OxoOia8nPwQ3KllyQ05K0QZLyx//KKnGhTacFj4q3tPsWVo93y16
 7s41IVxPSsW4+i9lzpJWaUzaZ0pMvO9zVZ99w8wEp7rUEvUy7hSQ4xrnhC8Lr+VQu+4p
 4aTpXvUohcH8YyPFEJELEQe6AIQNQ0eccMMYOVJO8xEPbv0lWVIXpNd6RKYko+ufFaii
 JAbo6cmCmIZM6k1RprN+Ne7j1iU81F0K15uzzkHhk6Qw2bYEhXA2pBy1ShxpRySyPBv0
 n+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5WlTcU+vqZ8TmOacx8AvaiFyv/4272pk8vVbqRlVqQE=;
 b=MngyxHZn3ddhuYbjiVpdk0LxPmfKY7E5hPajt+ows+QbVOQhvPG2gVS1cdI4xJw4x0
 0u+PKS3ZVXuE3AUb5RnSeqykZUKieW+4L1r6echy8WsKIRmZNGhc1fRzWGzbrlu7TO//
 JILfAReFdVSDkAy+DyFvuM5NQX4LGWA89MiywW5AE7h6wM/xcHZMw3s2NEAVrmZa/pbQ
 GRuTYDg6SxlyNu5PkPuuJiDpKDHUrnMF6EVGIQHckh60/QcN4eHvN4ONVPUTPGs2ank3
 8vqK5DSZ7GAsKnqtETWYjhXeWnu3wSTfd1sQ/WUvdGTW0RBuDizB9lNzYGWB2UxUadlk
 1y/A==
X-Gm-Message-State: AOAM533daOGM7IdoCXePXdXS1m4XEyfCOuh6E+/m6zElmhlOMzpe/LZi
 NuPpR3Xc9Ln17vGkAZWekV7yGoqr8MgKWg5VtMc=
X-Google-Smtp-Source: ABdhPJy3pfd4tt/dbIWKX6gUxO8NMCDpU3TU7D+NMKk/tKo2cWQNoBcp62dJlxrlYXUpAvk1Pe4pzozkl2+Dvohilqk=
X-Received: by 2002:ae9:eb0a:: with SMTP id b10mr28919173qkg.198.1593670717395; 
 Wed, 01 Jul 2020 23:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <87v9j7qyuh.fsf@linaro.org>
In-Reply-To: <87v9j7qyuh.fsf@linaro.org>
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
Date: Thu, 2 Jul 2020 09:18:26 +0300
Message-ID: <CAMgSi0G+_3ZVDMpYL5XYWvUyUUtP__zUCLPpRJ+adn3t7B8a7g@mail.gmail.com>
Subject: Re: Race with atexit functions in system emulation
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000ffd6df05a96f6006"
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=pavel.dovgaluk@gmail.com; helo=mail-qk1-x733.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Pavel.Dovgaluk" <pavel.dovgalyuk@ispras.ru>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ffd6df05a96f6006
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Is it true, that semihosting can be used to access (read and write) host
files from the guest?
In such a case it can't be used with RR for the following reasons:
1. We don't preserve modified files, therefore the execution result may
change in the future runs.
2. Even in the case, when all the files are read only, semihosting FDs
can't be saved, therefore it may not be used with reverse debugging.

On Wed, Jul 1, 2020 at 2:06 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:

> Hi,
>
> While running some TSAN tests I ran into the following race condition:
>
>   WARNING: ThreadSanitizer: data race (pid=3D1605)
>     Write of size 4 at 0x55c437814d98 by thread T2 (mutexes: write M619):
>       #0 replay_finish
> /home/alex.bennee/lsrc/qemu.git/replay/replay.c:393:17
> (qemu-system-aarch64+0xc55116)
>       #1 at_exit_wrapper() <null> (qemu-system-aarch64+0x368988)
>       #2 handle_semihosting
> /home/alex.bennee/lsrc/qemu.git/target/arm/helper.c:9740:25
> (qemu-system-aarch64+0x5e75b0)
>       #3 arm_cpu_do_interrupt
> /home/alex.bennee/lsrc/qemu.git/target/arm/helper.c:9788:9
> (qemu-system-aarch64+0x5e75b0)
>       #4 cpu_handle_exception
> /home/alex.bennee/lsrc/qemu.git/accel/tcg/cpu-exec.c:504:13
> (qemu-system-aarch64+0x4a4690)
>       #5 cpu_exec
> /home/alex.bennee/lsrc/qemu.git/accel/tcg/cpu-exec.c:712:13
> (qemu-system-aarch64+0x4a4690)
>       #6 tcg_cpu_exec /home/alex.bennee/lsrc/qemu.git/cpus.c:1452:11
> (qemu-system-aarch64+0x441157)
>       #7 qemu_tcg_rr_cpu_thread_fn
> /home/alex.bennee/lsrc/qemu.git/cpus.c:1554:21
> (qemu-system-aarch64+0x441157)
>       #8 qemu_thread_start
> /home/alex.bennee/lsrc/qemu.git/util/qemu-thread-posix.c:521:9
> (qemu-system-aarch64+0xe38bd0)
>
>     Previous read of size 4 at 0x55c437814d98 by main thread:
>       #0 replay_mutex_lock
> /home/alex.bennee/lsrc/qemu.git/replay/replay-internal.c:217:9
> (qemu-system-aarch64+0xc55c03)
>       #1 os_host_main_loop_wait
> /home/alex.bennee/lsrc/qemu.git/util/main-loop.c:239:5
> (qemu-system-aarch64+0xe5af4f)
>       #2 main_loop_wait
> /home/alex.bennee/lsrc/qemu.git/util/main-loop.c:518:11
> (qemu-system-aarch64+0xe5af4f)
>       #3 qemu_main_loop
> /home/alex.bennee/lsrc/qemu.git/softmmu/vl.c:1664:9
> (qemu-system-aarch64+0x5ce806)
>       #4 main /home/alex.bennee/lsrc/qemu.git/softmmu/main.c:49:5
> (qemu-system-aarch64+0xdbf8b7)
>
>     Location is global 'replay_mode' of size 4 at 0x55c437814d98
> (qemu-system-aarch64+0x0000021a9d98)
>
> Basically we have a clash between semihosting wanting to do an exit,
> which is useful for reporting status and the fact that we have atexit()
> handlers to clean up that clash with the main loop accessing the mutex
> while we go. Ultimately I think this is harmless as we are shutting down
> anyway but I was wondering how we would clean something like this up?
>
> Should we maybe defer the exit to once the main loop has been exited
> with a some sort of vmstop? Or could we have an atexit handler that
> kills the main thread?
>
> I should point out that linux-user has a fairly heavy preexit_cleanup
> function to do this sort of tidying up. atexit() is also fairly heavily
> used for other devices in system emulation.
>
> Ideas?
>
> --
> Alex Benn=C3=A9e
>


--=20
Pavel Dovgalyuk

--000000000000ffd6df05a96f6006
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Is it true, that semihosting can be used to access (read a=
nd write) host files from the guest?<div>In such a case it can&#39;t be use=
d with RR for the following reasons:</div><div>1. We don&#39;t preserve mod=
ified files, therefore the execution result may change in the future runs.<=
/div><div>2. Even in the case, when all the files are read only, semihostin=
g FDs can&#39;t be saved, therefore it may not be used with reverse debuggi=
ng.</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gma=
il_attr">On Wed, Jul 1, 2020 at 2:06 PM Alex Benn=C3=A9e &lt;<a href=3D"mai=
lto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
While running some TSAN tests I ran into the following race condition:<br>
<br>
=C2=A0 WARNING: ThreadSanitizer: data race (pid=3D1605)<br>
=C2=A0 =C2=A0 Write of size 4 at 0x55c437814d98 by thread T2 (mutexes: writ=
e M619):<br>
=C2=A0 =C2=A0 =C2=A0 #0 replay_finish /home/alex.bennee/lsrc/qemu.git/repla=
y/replay.c:393:17 (qemu-system-aarch64+0xc55116)<br>
=C2=A0 =C2=A0 =C2=A0 #1 at_exit_wrapper() &lt;null&gt; (qemu-system-aarch64=
+0x368988)<br>
=C2=A0 =C2=A0 =C2=A0 #2 handle_semihosting /home/alex.bennee/lsrc/qemu.git/=
target/arm/helper.c:9740:25 (qemu-system-aarch64+0x5e75b0)<br>
=C2=A0 =C2=A0 =C2=A0 #3 arm_cpu_do_interrupt /home/alex.bennee/lsrc/qemu.gi=
t/target/arm/helper.c:9788:9 (qemu-system-aarch64+0x5e75b0)<br>
=C2=A0 =C2=A0 =C2=A0 #4 cpu_handle_exception /home/alex.bennee/lsrc/qemu.gi=
t/accel/tcg/cpu-exec.c:504:13 (qemu-system-aarch64+0x4a4690)<br>
=C2=A0 =C2=A0 =C2=A0 #5 cpu_exec /home/alex.bennee/lsrc/qemu.git/accel/tcg/=
cpu-exec.c:712:13 (qemu-system-aarch64+0x4a4690)<br>
=C2=A0 =C2=A0 =C2=A0 #6 tcg_cpu_exec /home/alex.bennee/lsrc/qemu.git/cpus.c=
:1452:11 (qemu-system-aarch64+0x441157)<br>
=C2=A0 =C2=A0 =C2=A0 #7 qemu_tcg_rr_cpu_thread_fn /home/alex.bennee/lsrc/qe=
mu.git/cpus.c:1554:21 (qemu-system-aarch64+0x441157)<br>
=C2=A0 =C2=A0 =C2=A0 #8 qemu_thread_start /home/alex.bennee/lsrc/qemu.git/u=
til/qemu-thread-posix.c:521:9 (qemu-system-aarch64+0xe38bd0)<br>
<br>
=C2=A0 =C2=A0 Previous read of size 4 at 0x55c437814d98 by main thread:<br>
=C2=A0 =C2=A0 =C2=A0 #0 replay_mutex_lock /home/alex.bennee/lsrc/qemu.git/r=
eplay/replay-internal.c:217:9 (qemu-system-aarch64+0xc55c03)<br>
=C2=A0 =C2=A0 =C2=A0 #1 os_host_main_loop_wait /home/alex.bennee/lsrc/qemu.=
git/util/main-loop.c:239:5 (qemu-system-aarch64+0xe5af4f)<br>
=C2=A0 =C2=A0 =C2=A0 #2 main_loop_wait /home/alex.bennee/lsrc/qemu.git/util=
/main-loop.c:518:11 (qemu-system-aarch64+0xe5af4f)<br>
=C2=A0 =C2=A0 =C2=A0 #3 qemu_main_loop /home/alex.bennee/lsrc/qemu.git/soft=
mmu/vl.c:1664:9 (qemu-system-aarch64+0x5ce806)<br>
=C2=A0 =C2=A0 =C2=A0 #4 main /home/alex.bennee/lsrc/qemu.git/softmmu/main.c=
:49:5 (qemu-system-aarch64+0xdbf8b7)<br>
<br>
=C2=A0 =C2=A0 Location is global &#39;replay_mode&#39; of size 4 at 0x55c43=
7814d98 (qemu-system-aarch64+0x0000021a9d98)<br>
<br>
Basically we have a clash between semihosting wanting to do an exit,<br>
which is useful for reporting status and the fact that we have atexit()<br>
handlers to clean up that clash with the main loop accessing the mutex<br>
while we go. Ultimately I think this is harmless as we are shutting down<br=
>
anyway but I was wondering how we would clean something like this up?<br>
<br>
Should we maybe defer the exit to once the main loop has been exited<br>
with a some sort of vmstop? Or could we have an atexit handler that<br>
kills the main thread?<br>
<br>
I should point out that linux-user has a fairly heavy preexit_cleanup<br>
function to do this sort of tidying up. atexit() is also fairly heavily<br>
used for other devices in system emulation.<br>
<br>
Ideas?<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr">Pavel Dovgalyuk</div></div>

--000000000000ffd6df05a96f6006--

