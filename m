Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668F5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 23:39:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F24F20810
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 23:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iS3/kdeN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F24F20810
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlLAy-0004vE-GR
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 19:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jkz@google.com>) id 1jlLA5-0004UJ-Bk
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 19:38:38 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35676)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jkz@google.com>) id 1jlLA2-0002J4-02
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 19:38:37 -0400
Received: by mail-pf1-x441.google.com with SMTP id h185so215010pfg.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 16:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SLCQyxADoY9Udr+OLtdkmLEKPEdo10KLRFtdqOBx8Uk=;
 b=iS3/kdeNi1sgJYNrqEdb2V5SF7VxjWh/geCHD03Aro6EbAm0mO1X82xdmrl23r7UyT
 hf1zEx+hkqkC6z/gsAMyX02c+eptiZcNTc5q0xWJHFu2wzxyDTh85jCU56PZZVWg5BcJ
 jlMEhFCZ+5doXGEP3EaqyYI/gDsIEMt3jXtladvXnw2iQumNMFPvllsVY/Y+/vojjz74
 My0VTiDOkh+xBwe5DY4jPf96hIKhqzGcjJfx8N1Y9SLmfpWpUi0CNNpVNonv1lP3q2sT
 lw5mVzQnAUzCRB6pABuAmutzTvzwqMl+ukjbYhJvfjwmNDw0WEOuHzKde7HlI3XGClFm
 qksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SLCQyxADoY9Udr+OLtdkmLEKPEdo10KLRFtdqOBx8Uk=;
 b=Ee4GZOxhoKuj35Or9vJ0RV+vOXra3hph6aslrBzDy0LShrMmmSMg2xyCIx/rigKKK2
 eE7+tAo0NMUGbJZF900zm5Zlsoqvc497hpBA2nhY7CU3MJimcifDxtJGDDkN8ZFKimf+
 u7bTPB++feLmRdok+BPhJC+x/BPPOFfTQEqvxeZ6hkga1geWKCcQlYJinXAzIgNaA+fw
 G3JMOnGotPTJKRmghHr5bXBdTAito1t4SeM1QSsEPyTtGcGj03RKEU4WUZzKrA6TBvBh
 2oBDMie0WCFIZhjoZy0q5uMW9ZJZqpQB9amBQ9fDqfoDgEEXv25PGB4zHMyoO4m5pwO4
 fPGw==
X-Gm-Message-State: AOAM531Qr3C25M8V+nr6ryGF4HmdhsfBhy1bYSZNBYzfQY7PkOwi4v4i
 yqqCu3gIJnXaSrENpQrQ7uhVF3V4bJyeGWFIm9VksQ==
X-Google-Smtp-Source: ABdhPJzDTAk15nt+USxzPQ+xQN1GyNYcl3vMz8BUrAFiWFqQL8w7plaHefbjBV95ZJkJffMhtrZCclgy0V0JnCoW90U=
X-Received: by 2002:a63:ae44:: with SMTP id e4mr3998801pgp.428.1592350710813; 
 Tue, 16 Jun 2020 16:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200612014606.147691-1-jkz@google.com>
 <87k107yp6p.fsf@linaro.org>
 <CAFEAcA86xAJDmoDBrz5etKYGLye2qxf4idPXUWUAYMLcQy_+Yw@mail.gmail.com>
In-Reply-To: <CAFEAcA86xAJDmoDBrz5etKYGLye2qxf4idPXUWUAYMLcQy_+Yw@mail.gmail.com>
From: Josh Kunz <jkz@google.com>
Date: Tue, 16 Jun 2020 16:38:19 -0700
Message-ID: <CADgy-2sm8nAHdO=CJ_XY0dpi_bTWt4TgaV5Z-C=7z0aRJrwDRg@mail.gmail.com>
Subject: Re: [PATCH 0/5] linux-user: Support extended clone(CLONE_VM)
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="0000000000007a6f4805a83c0a00"
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=jkz@google.com; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007a6f4805a83c0a00
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2020 at 9:32 AM Peter Maydell <peter.maydell@linaro.org>
wrote:
>
> On Tue, 16 Jun 2020 at 17:08, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> > Apart from "a more perfect emulation" is there a particular use case
> > served by the extra functionality? AIUI up until this point we've
> > basically supported glibc's use of clone() which has generally been
> > enough. I'm assuming you've come across stuff that needs this more fine
> > grained support?
>
> There are definitely cases we don't handle that cause problems;
> notably https://bugs.launchpad.net/qemu/+bug/1673976 reports
> that newer glibc implement posix_spawn() using CLONE_VM|CLONE_VFORK
> which we don't handle correctly (though it is now just "we don't
> report failures correctly" rather than "guest asserts").

This originally came up for us at Google in multi-threaded guest binaries
using TCMalloc (https://github.com/google/tcmalloc). TCMalloc does not have
any special `at_fork` handling, so guest processes using TCMalloc spawn
subprocesses using a custom bit of code based on `clone(CLONE_VM)` (notably
*not* vfork()).

We've also been using this patch to work around similar issues in QEMU
itself when creating subprocesses with fork()/vfork(). Since QEMU (and
GLib) rely on locks to emulate multi-threaded guests that share virtual
memory, QEMU itself is also vulnerable to deadlocks when a guest forks.
Without this patch we've run into deadlocks with TCG region trees, and
GLib's `g_malloc`, there are likely others as well, since we could still
reproduce the deadlocks after fixing these specific problems.

The issues caused by using fork() in multi-threaded guests are pretty
tricky to debug. They are fundamentally data races (was another thread in
the critical section or not?), and they usually manifest as deadlocks,
which show up as timeouts or hangs to users. I suspect this issue happens
frequently in the wild, but at a low enough rate/user that nobody bothered
fixing it/reporting it yet. Use of `vfork()` with `CLONE_VM` is common as
mentioned by Alex. For example it is the only way to spawn subprocesses in
Go on most platforms:
https://github.com/golang/go/blob/master/src/syscall/exec_linux.go#L218

I tried to come up with a good reproducer for these issues, but I haven't
been able to make one. The cases we have at Google that trigger this issue
reliably are big and they contain lots of code I can't share. When
compiling QEMU itself with TCMalloc, I can pretty reliably reproduce a
deadlock with a program that just calls vfork(), but that's somewhat
synthetic.

> The problem has always been that glibc implicitly assumes it
> knows what the process's threads are like, ie that it is the
> only thing doing any clone()s. (The comment in syscall.c mentions
> it "breaking mutexes" though I forget what I had in mind when
> I wrote that comment.) I haven't looked at these patches,
> but the risk of being clever is that we end up implicitly
> depending on details of glibc's internal implementation in a
> potentially fragile way.
>
>
> I forget whether QEMU can build against musl libc, but if we do
> then that might be an interesting test of whether we have
> accidental dependencies on the libc internals.

I agree it would be interesting to test against musl. I'm pretty sure it
would work (this patch only relies on POSIX APIs + Platform ABIs for TLS),
but it would be interesting to confirm.

--
Josh Kunz

--0000000000007a6f4805a83c0a00
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Tue, Jun 16, 2020 at 9:32 AM Peter Maydell &lt;<a href=
=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wrote=
:<br>&gt;<br>&gt; On Tue, 16 Jun 2020 at 17:08, Alex Benn=C3=A9e &lt;<a hre=
f=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<b=
r>&gt; &gt; Apart from &quot;a more perfect emulation&quot; is there a part=
icular use case<br>&gt; &gt; served by the extra functionality? AIUI up unt=
il this point we&#39;ve<br>&gt; &gt; basically supported glibc&#39;s use of=
 clone() which has generally been<br>&gt; &gt; enough. I&#39;m assuming you=
&#39;ve come across stuff that needs this more fine<br>&gt; &gt; grained su=
pport?<br>&gt;<br>&gt; There are definitely cases we don&#39;t handle that =
cause problems;<br>&gt; notably <a href=3D"https://bugs.launchpad.net/qemu/=
+bug/1673976">https://bugs.launchpad.net/qemu/+bug/1673976</a> reports<br>&=
gt; that newer glibc implement posix_spawn() using CLONE_VM|CLONE_VFORK<br>=
&gt; which we don&#39;t handle correctly (though it is now just &quot;we do=
n&#39;t<br>&gt; report failures correctly&quot; rather than &quot;guest ass=
erts&quot;).<br><br>This originally came up for us at Google in multi-threa=
ded guest binaries using TCMalloc (<a href=3D"https://github.com/google/tcm=
alloc">https://github.com/google/tcmalloc</a>). TCMalloc does not have any =
special `at_fork` handling, so guest processes using TCMalloc spawn subproc=
esses using a custom bit of code based on `clone(CLONE_VM)` (notably *not* =
vfork()).<br><br>We&#39;ve also been using this patch to work around simila=
r issues in QEMU itself when creating subprocesses with fork()/vfork(). Sin=
ce QEMU (and GLib) rely on locks to emulate multi-threaded guests that shar=
e virtual memory, QEMU itself is also vulnerable to deadlocks when a guest =
forks. Without this patch we&#39;ve run into deadlocks with TCG region tree=
s, and GLib&#39;s `g_malloc`, there are likely others as well, since we cou=
ld still reproduce the deadlocks after fixing these specific problems.<br><=
br>The issues caused by using fork() in multi-threaded guests are pretty tr=
icky to debug. They are fundamentally data races (was another thread in the=
 critical section or not?), and they usually manifest as deadlocks, which s=
how up as timeouts or hangs to users. I suspect this issue happens frequent=
ly in the wild, but at a low enough rate/user that nobody bothered fixing i=
t/reporting it yet. Use of `vfork()` with `CLONE_VM` is common as mentioned=
 by Alex. For example it is the only way to spawn subprocesses in Go on mos=
t platforms: <a href=3D"https://github.com/golang/go/blob/master/src/syscal=
l/exec_linux.go#L218">https://github.com/golang/go/blob/master/src/syscall/=
exec_linux.go#L218</a><br><br>I tried to come up with a good reproducer for=
 these issues, but I haven&#39;t been able to make one. The cases we have a=
t Google that trigger this issue reliably are big and they contain lots of =
code I can&#39;t share. When compiling QEMU itself with TCMalloc, I can pre=
tty reliably reproduce a deadlock with a program that just calls vfork(), b=
ut that&#39;s somewhat synthetic.<br><br>&gt; The problem has always been t=
hat glibc implicitly assumes it<br>&gt; knows what the process&#39;s thread=
s are like, ie that it is the<br>&gt; only thing doing any clone()s. (The c=
omment in syscall.c mentions<br>&gt; it &quot;breaking mutexes&quot; though=
 I forget what I had in mind when<br>&gt; I wrote that comment.) I haven&#3=
9;t looked at these patches,<br>&gt; but the risk of being clever is that w=
e end up implicitly<br>&gt; depending on details of glibc&#39;s internal im=
plementation in a<br>&gt; potentially fragile way.<br>&gt;<br>&gt;<br>&gt; =
I forget whether QEMU can build against musl libc, but if we do<br>&gt; the=
n that might be an interesting test of whether we have<br>&gt; accidental d=
ependencies on the libc internals.<br><br>I agree it would be interesting t=
o test against musl. I&#39;m pretty sure it would work (this patch only rel=
ies on POSIX APIs + Platform ABIs for TLS), but it would be interesting to =
confirm.<div><br></div><div>--</div><div>Josh Kunz</div></div>

--0000000000007a6f4805a83c0a00--

