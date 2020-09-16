Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6430C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:30:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 322AE22450
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9J/5Sq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322AE22450
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIZO0-0004Za-MG
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 11:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kIZNK-00049E-Lk
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 11:29:38 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:40948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kIZNJ-00072D-1y
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 11:29:38 -0400
Received: by mail-io1-xd44.google.com with SMTP id j2so8687759ioj.7
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 08:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mj+hkOo1gmvDN5xY/KyOKc3yiTF7uHE8zreCZ8haNaU=;
 b=D9J/5Sq6bDPqkI17u2d2WQsanKKZb2cYMi0Lmu7UShJKLQA995PaKZgHLIJkurl3ox
 MLf9nY5PeIUvUXpikz5TvDQU7ZuXAV/jSG72CVHWyX1fJU+Py/xnkCPg1Qg6D3j8HXpe
 b04UTSzyoyLPxVQt8iMAXNayPgS9Ma7JBDrAUnsjwIeVCRfyjdnDkBLNuzIkgbw21hck
 cENUa2X/mytYHUh9peSNilPHiVLIA+XbYzkZsdCE8mE8KsMzHSpG6TF3gNtcae3rSZSv
 h72rRZLmHQYYpNGavaHuKji1ZwVP7f4GTwbPuIe4mJGrA/OLBRt+RoDAaOXFNjt3Mswc
 eOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mj+hkOo1gmvDN5xY/KyOKc3yiTF7uHE8zreCZ8haNaU=;
 b=BMYFTTtlOC20kC3jmgbb70GZcoqw6OcfkpxdCA6mOe1O5/gEglPrlwbEcsbxQYgKfd
 jY58E1bSDqAWoI3kVigUZMMSpwAjk+06YXmvnQDC0FpMmkJ+dknxd0FHrZEWDesoVCvu
 Jq2pT6m7RbTySYZFTlgoIa+LMnKUjUv3cwcXS+WKHCx8qcP/gBKRT/+0D8hJ/EPMkOk3
 3hdFGg/OUFk9OutWpPGkG5FjlIAEpFlpiSOxqIJxQ4hWk4vRKHYySJcIGfX2RqxU2eGA
 pGqXglbZpTB0sSAUxrwxGEGdUmgue+oxs8yxAHQRFGcA/zUXHLETuptKpx8/NQ6bJOC4
 Al2g==
X-Gm-Message-State: AOAM530u4XZ6CG18ANSagftJ6nt8WDjmm8JsKBZLxaxowwz64Fj2FWHu
 vh50xlKlCgiimmcQ1o5503WkORj6mixOa4ghhPA=
X-Google-Smtp-Source: ABdhPJwqGm1J/+01BCe1vjtUaf8+71wl8ICEF/eI6eTSwtQiyXR1u419THPNWSiiWtd6u20nT0L2uEuOeJb85SC+jzo=
X-Received: by 2002:a05:6602:2245:: with SMTP id
 o5mr20396049ioo.105.1600270175940; 
 Wed, 16 Sep 2020 08:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <9435182.tdPhlSkOF2@farino>
In-Reply-To: <9435182.tdPhlSkOF2@farino>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 16 Sep 2020 08:18:25 -0700
Message-ID: <CAKmqyKPqg4no7DM+z-EdJAAKzta9Mcfn=Fz0DjC5dbSKEtDtCg@mail.gmail.com>
Subject: Re: riscv32 wait() problem, qemu or glibc?
To: =?UTF-8?B?QW5kcmVhcyBLLiBIw7x0dGVs?= <dilfridge@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: GNU C Library <libc-alpha@sourceware.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 14, 2020 at 1:14 AM Andreas K. H=C3=BCttel via Libc-alpha
<libc-alpha@sourceware.org> wrote:
>
> Hi,
>
> first of all, sorry for crossposting, but I'm dealing with many moving an=
d
> experimental parts here...
>
> Situation: riscv32 (ilp32) qemu-user [1] chroot, Linux [2], glibc [3], gc=
c [4]
>
> The following small program outputs "child exited with status 40", which =
is
> rather unexpected (it should be 42). Any idea what is going on?
>
> (This is a simplified version of code in a configure test. The test has o=
ther
> potential issues [5], but in any case it cant produce useful results on
> riscv32 right now.)
>
> TIA,
> Andreas
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> #include <stdlib.h>
> #include <unistd.h>
> #include <stdio.h>
> #include <sys/wait.h>
>
> main(c, v)
>      int c;
>      char **v;
> {
>   pid_t pid, p;
>   int s, i, n;
>
>   s =3D 0;
>   pid =3D fork();
>   if (pid =3D=3D 0)
>     exit (42);
>
>   /* wait for the process */
>   p =3D wait(&s);

The wait() function internally in glibc calls waitid()
(https://github.com/bminor/glibc/blob/master/posix/wait.c#L25)

The waitid() function then does a waitid syscall
(https://github.com/bminor/glibc/blob/master/sysdeps/unix/sysv/linux/waitid=
.c#L29)

QEMU has support for waitid()
(https://github.com/qemu/qemu/blob/master/linux-user/syscall.c#L8308)
so this should work.

I also don't see any obvious size mismatches.

My guess is that somewhere in QEMU the types don't match what RV32 is
using. It's probably worth printing out the size, alignment and value
of everything at every stage and see what breaks.

AFAIK RV32 linux-user mode is pretty much un-tested. So their might be
all sorts of issues with it unfortunately.

Alistair

>   if (p !=3D pid)
>     exit (255);
>
>   if (WIFEXITED(s))
>   {
>      int r=3DWEXITSTATUS(s);
>      printf("child exited with status %i\n",r);
>   }
> }
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> [1] qemu built from git master, Sep 12, 2020 16:30:37 EEST
> [2] host kernel is 5.8.8
> [3] glibc-2.32 with the rv32 patch series backported from master
> [4] (Gentoo 10.2.0-r1 p2)
> [5] https://lists.gnu.org/archive/html/bug-bash/2020-09/msg00033.html
>
> --
> Andreas K. H=C3=BCttel
> dilfridge@gentoo.org
> Gentoo Linux developer
> (council, qa, toolchain, base-system, perl, libreoffice)

