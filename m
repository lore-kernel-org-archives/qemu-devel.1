Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F45C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:52:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8439620679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wdgRjK1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8439620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgWd5-0006Oo-MT
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 12:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jgWcN-0005Ux-L1
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:51:55 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:42414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jgWcM-0003rY-HF
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:51:55 -0400
Received: by mail-lj1-x244.google.com with SMTP id y11so1979645ljm.9
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 09:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2KrX060EMlLhfQ80LsLD5h3aY3ERGaiQ+olYbhWdmH0=;
 b=wdgRjK1NYRUzefU68mRkx6y4NRSzedvKNo0A3ub+ekq+WH5FBJ3bzXEeo7k/ML22r+
 7fUe8wmFKzT1zdXs90I6yQavfzx/byH8I+lBs7VOLeQJ1ToPYfL/gnKgfxNOlSsBm8iA
 BvJgMvHouFWXvIM8zV0u2Ojw8y/YuXMvNwdLy2WKqHh0KKDt4ViF2dXztkNL88yZQSSl
 +O/A9PGzfynOXO5gmsQVVWODv1X6Xd0KbOQKX7WAVw0l84a6RGTyyIpFLAGlxnoCvCPW
 6Npiw4G4E+A1bGKu7U/oEDyRY6V4p9OWT6WtL2HB00WwxxyP6E59wXSglouO1bVsuS8D
 /HPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2KrX060EMlLhfQ80LsLD5h3aY3ERGaiQ+olYbhWdmH0=;
 b=reIcKRr1IVKxuNXhDEUg2tpRt/lUspoo/pe9kzwawRmKKonbh7U0ZmWx8vcArGaha4
 oyPd6XbV3qxBypSM4GN1qj1M1L0MTKrhasjcAMLfQPk7z5ATWVDxYzrfVgbN0JhYRn+g
 z6LDiptah0C2PvB3/WdKCie9Ws2BZXu2uGn//+2M4/oO4M7rknucXYzeJ8W4kiCE736Q
 B3Ksq8yCSn3+m3sp+hn1IgbcmB7odBqYEigj1t5I8C9IBGfVy97q6Loq9VfgWX3Ryjjz
 hQuPZA8PeYu07tUKKaPHKY5ZPCd8lWwMBc2QLZLR560dWQAtrwfMj5hsCJqLrwDN7uwF
 v7rw==
X-Gm-Message-State: AOAM531nSV9yckAoHqbKg8LFq5iTi0EN6tf4riZIm6HytOIq1nvhjrNz
 tVkzenYKT2unUldltUrbsGcxTc9SByz/RraCjvK/Kg==
X-Google-Smtp-Source: ABdhPJzMPl764B7A9pFtgD8VGCqv8NYZXTKOBhmI/WpU/Stv/ANIBS/EiyPQ7Z7N4avldLvn2vyO32NPFDo8By1EJQE=
X-Received: by 2002:a2e:1445:: with SMTP id 5mr60961lju.193.1591203112486;
 Wed, 03 Jun 2020 09:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200529132341.755-1-robert.foley@linaro.org>
 <87eeqx6zoa.fsf@linaro.org>
In-Reply-To: <87eeqx6zoa.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Wed, 3 Jun 2020 12:51:51 -0400
Message-ID: <CAEyhzFsuY1KRYn=HCrH7wt8Z9McY=8wt4X4bkEacUz0Q=bADbg@mail.gmail.com>
Subject: Re: [PATCH v1 01/12] configure: add --enable-tsan flag + fiber
 annotations for coroutine-ucontext
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Lingfeng Yang <lfy@google.com>, Peter Puhov <peter.puhov@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jun 2020 at 15:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
>
> Robert Foley <robert.foley@linaro.org> writes:
>
> > From: Lingfeng Yang <lfy@google.com>
<snip>
> >
> > +# Thread sanitizer is, for now, much noisier than the other sanitizers=
;
> > +# keep it separate until that is not the case.
>
> I think we also need to stop both being enabled at once. On my clang-9
> setup I get:
>
>   make: *** [qapi/qobject-output-visitor.o] Error 1
>   clang: error: invalid argument '-fsanitize=3Daddress' not allowed with =
'-fsanitize=3Dthread'
>   clang: error: invalid argument '-fsanitize=3Daddress' not allowed with =
'-fsanitize=3Dthread'
>   clang: errorclang: : errorinvalid argument '-fsanitize=3Daddress' not a=
llowed with '-fsanitize=3Dthread':
>   invalid argument '-fsanitize=3Daddress' not allowed with '-fsanitize=3D=
thread'
>   clang: error: invalid argument '-fsanitize=3Daddress' not allowed with =
'-fsanitize=3Dthread'

Good point.  I see a similar error if I use --enable-sanitizers and
--enable-tsan.
Will look to add an error check for this.  Wondering if there are any
other interactions
we need to avoid?  Will poke around a bit here.

<snip>

>
> Are we missing any LDFLAGS? On Ubuntu 18.04 with clang-9 I'm seeing:
>
>     LINK    qemu-ga
>   /usr/lib/llvm-9/lib/clang/9.0.0/lib/linux/libclang_rt.tsan-x86_64.a(tsa=
n_rtl_amd64.S.o): warning: common of `__interception::real_setjmp' overridd=
en by definition
>   /usr/lib/llvm-9/lib/clang/9.0.0/lib/linux/libclang_rt.tsan-x86_64.a(tsa=
n_interceptors.cc.o): warning: defined here

Looks like these warnings come from use of --warn-common, so I think we nee=
d to
exclude this when using TSan if we want to silence these warnings from
the TSan libraries.

Thanks & Regards,
-Rob

>   /usr/lib/llvm-9/lib/clang/9.0.0/lib/linux/libclang_rt.tsan-x86_64.a(tsa=
n_rtl_amd64.S.o): warning: common of `__interception::real__setjmp' overrid=
den by definition
>   /usr/lib/llvm-9/lib/clang/9.0.0/lib/linux/libclang_rt.tsan-x86_64.a(tsa=
n_interceptors.cc.o): warning: defined here
>   /usr/lib/llvm-9/lib/clang/9.0.0/lib/linux/libclang_rt.tsan-x86_64.a(tsa=
n_rtl_amd64.S.o): warning: common of `__interception::real_sigsetjmp' overr=
idden by definition
>   /usr/lib/llvm-9/lib/clang/9.0.0/lib/linux/libclang_rt.tsan-x86_64.a(tsa=
n_interceptors.cc.o): warning: defined here
>   /usr/lib/llvm-9/lib/clang/9.0.0/lib/linux/libclang_rt.tsan-x86_64.a(tsa=
n_rtl_amd64.S.o): warning: common of `__interception::real___sigsetjmp' ove=
rridden by definition
>   /usr/lib/llvm-9/lib/clang/9.0.0/lib/linux/libclang_rt.tsan-x86_64.a(tsa=
n_interceptors.cc.o): warning: defined here
>   libqemuutil.a(osdep.o):/usr/lib/llvm-9/lib/clang/9.0.0/include/sanitize=
r/tsan_interface.h:41: multiple definition of `__tsan_mutex_linker_init'
>   libqemuutil.a(control.o):/usr/lib/llvm-9/lib/clang/9.0.0/include/saniti=
zer/tsan_interface.h:41: first defined here
>   libqemuutil.a(osdep.o):/usr/lib/llvm-9/lib/clang/9.0.0/include/sanitize=
r/tsan_interface.h:50: multiple definition of `__tsan_mutex_not_static'
>   libqemuutil.a(control.o):/usr/lib/llvm-9/lib/clang/9.0.0/include/saniti=
zer/tsan_interface.h:50: first defined here
>   libqemuutil.a(osdep.o):/usr/lib/llvm-9/lib/clang/9.0.0/include/sanitize=
r/tsan_interface.h:55: multiple definition of `__tsan_mutex_read_lock'
>   libqemuutil.a(control.o):/usr/lib/llvm-9/lib/clang/9.0.0/include/saniti=
zer/tsan_interface.h:55: first defined here
>   libqemuutil.a(osdep.o):/usr/lib/llvm-9/lib/clang/9.0.0/include/sanitize=
r/tsan_interface.h:45: multiple definition of `__tsan_mutex_read_reentrant'
>   libqemuutil.a(control.o):/usr/lib/llvm-9/lib/clang/9.0.0/include/saniti=
zer/tsan_interface.h:45: first defined here
>   libqemuutil.a(osdep.o):/usr/lib/llvm-9/lib/clang/9.0.0/include/sanitize=
r/tsan_interface.h:64: multiple definition of `__tsan_mutex_recursive_lock'
>   libqemuutil.a(control.o):/usr/lib/llvm-9/lib/clang/9.0.0/include/saniti=
zer/tsan_interface.h:64: first defined here
>   libqemuutil.a(osdep.o):/usr/lib/llvm-9/lib/clang/9.0.0/include/sanitize=
r/tsan_interface.h:68: multiple definition of `__tsan_mutex_recursive_unloc=
k'
>
> <snip>
>
> --
> Alex Benn=C3=A9e

