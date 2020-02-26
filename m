Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7ECC4BA09
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 00:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F14E821927
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 00:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTeANuid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14E821927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6kvK-0000oX-Uc
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 19:51:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j6kui-0000M9-5a
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 19:51:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j6kug-0003Ih-Si
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 19:51:00 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:42110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j6kug-0003GO-JD; Tue, 25 Feb 2020 19:50:58 -0500
Received: by mail-lj1-x243.google.com with SMTP id d10so965549ljl.9;
 Tue, 25 Feb 2020 16:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0DYAnu0qFK+bImu9vbQy4oZ3OX5QIv6i/7PEutObbk0=;
 b=FTeANuidsptqgb/S1bYvsl5BTsWVRp0TZtj6OsyH35iZ7ggkh0wPEjuhKFp/qEkTwx
 FBRtnLm5KTTmQXCg1fPbIuiL7LJcWhQ3VKw+ETaFaJfdMJufjGV87zh62OFDmPQnKleT
 6CGyk8t3v4g1EPB7013SELruFkFy34j7amJ7NNl5sDMZReoekwlVB7ZRiNs3f4v2qmsa
 03AM9qZmJR041pkrPZnDkBQEOUukd7Hxg4lMLUXbfAZIgO5QjgIm9QwkWShI4VXL54cX
 bBj1F5Hyn2q7KRU+hVcdhRZpfylcQ8mBfr5NQ631CTQrYGLWHdPeZ9r9+XxT/5u74JBa
 77KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0DYAnu0qFK+bImu9vbQy4oZ3OX5QIv6i/7PEutObbk0=;
 b=U/7pZ7cPyjr/2R9h6r6csGQZKKF2+NGmsuKOnKd9jOYEacnh0592hF4SsfGfDwc80Z
 jP6jsLxco/p3RyCP2p8P9WsfXO5CmKkjPwthIP9Zon+fiV9/bXBDS77WM7avfi+e2Zy8
 Hjks5czmxul8d9AyrQN29kLZoT3/4biyN+puPlkuyPpesKI9MQVqAUWL2F299l1yNC+N
 L6pN4RRYCdoe/PdbRHaQviXmEt1zGrI9AQRcdn3Lu5nB0gu8epWQ2VD1Kkg8o2zc10IA
 EB93joAZyRoJa3p3joUiWXSNvF4bCaGKk3L3xh+A8aE7ual9TVAMJPXPEdmaMNNZGktB
 GNLQ==
X-Gm-Message-State: APjAAAU84qH989gYhiYjYrRYoodYyojyuzjNEjdHL/5JkvkCsGaRW/Sx
 XAPYrGzVKugAt8I5oLs89D/YhgxzXkEQDW2mPHw=
X-Google-Smtp-Source: APXvYqxDWONWEZ+A+F8vsHyRKPtZzzZn0cXlZlwO4y0TUxMUx3h11iVoxSfqKch58uu0bMkSM9wAl1edL1J6lbeQ2g0=
X-Received: by 2002:a2e:b0db:: with SMTP id g27mr991055ljl.74.1582678256988;
 Tue, 25 Feb 2020 16:50:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582586444.git.alistair.francis@wdc.com>
 <205d84c5c51c54c8bb6a4a2927b7e1729fe42cdd.1582586444.git.alistair.francis@wdc.com>
 <4d5ad27a-0655-4c15-123a-8ae7ed6bedf2@vivier.eu>
In-Reply-To: <4d5ad27a-0655-4c15-123a-8ae7ed6bedf2@vivier.eu>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 25 Feb 2020 16:43:21 -0800
Message-ID: <CAKmqyKO82EVS-LGJrbbuNLDEAFYxn5ueJJS2DYy=9BtAk93YnQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] linux-user: Protect more syscalls
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 25, 2020 at 3:59 AM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 25/02/2020 =C3=A0 00:21, Alistair Francis a =C3=A9crit :
> > New y2038 safe 32-bit architectures (like RISC-V) don't support old
> > syscalls with a 32-bit time_t. The kernel defines new *_time64 versions
> > of these syscalls. Add some more #ifdefs to syscall.c in linux-user to
> > allow us to compile without these old syscalls.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> >  linux-user/strace.c  |  2 ++
> >  linux-user/syscall.c | 20 ++++++++++++++++++++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/linux-user/strace.c b/linux-user/strace.c
> > index 4f7130b2ff..6420ccd97b 100644
> > --- a/linux-user/strace.c
> > +++ b/linux-user/strace.c
> > @@ -775,6 +775,7 @@ print_syscall_ret_newselect(const struct syscallnam=
e *name, abi_long ret)
> >  #define TARGET_TIME_OOP      3   /* leap second in progress */
> >  #define TARGET_TIME_WAIT     4   /* leap second has occurred */
> >  #define TARGET_TIME_ERROR    5   /* clock not synchronized */
> > +#ifdef TARGET_NR_adjtimex
> >  static void
> >  print_syscall_ret_adjtimex(const struct syscallname *name, abi_long re=
t)
> >  {
> > @@ -813,6 +814,7 @@ print_syscall_ret_adjtimex(const struct syscallname=
 *name, abi_long ret)
> >
> >      qemu_log("\n");
> >  }
> > +#endif
> >
> >  UNUSED static struct flags access_flags[] =3D {
> >      FLAG_GENERIC(F_OK),
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index 8d27d10807..5a2156f95a 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -742,8 +742,10 @@ safe_syscall3(ssize_t, read, int, fd, void *, buff=
, size_t, count)
> >  safe_syscall3(ssize_t, write, int, fd, const void *, buff, size_t, cou=
nt)
> >  safe_syscall4(int, openat, int, dirfd, const char *, pathname, \
> >                int, flags, mode_t, mode)
> > +#if defined(TARGET_NR_wait4)
> >  safe_syscall4(pid_t, wait4, pid_t, pid, int *, status, int, options, \
> >                struct rusage *, rusage)
>
> safe_wait4 is also used in TARGET_NR_waitpid

Fixed!

Alistair

>
> Thanks,
> Laurent

