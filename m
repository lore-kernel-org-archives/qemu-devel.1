Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B34C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 22:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B2220663
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 22:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTn1YB3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B2220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCsZM-0008Df-GA
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 18:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jCsYg-0007KO-Ll
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 18:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jCsYf-0002qD-F4
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 18:13:34 -0400
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943]:46950)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jCsYf-0002p8-BB; Fri, 13 Mar 2020 18:13:33 -0400
Received: by mail-ua1-x943.google.com with SMTP id b2so4185417uas.13;
 Fri, 13 Mar 2020 15:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0mqIC29Kd6vc73AKYQ6RxnJcezVCR7kXLH4bMNtwE9M=;
 b=aTn1YB3ZiIO81b7Z8zGq5Jt0DM1/7OC1tZvZ3S2btHZgcSbb1aVgzBvAE8Gq889hJe
 OFuRvCVyf/9t7M8cY8zxqEPKfE1FvSRXFn8zjwYSkbwdobFZsQY4xiuNoAtFFe0Rqj3C
 xFLtxfQbHJDpmyukV6lcJ+V5tPSv7xnhbCVDynXt47p5cBtQAWElgAErWz+mkrOw2Y/L
 EDRHbx4Nmy5++Tq3b96JBvpGrhu3rnHq2m79RQsXCDTfU4aCq3jJfvazzk5RihfG/H9I
 Nnkng5tkTWAj9dDV2B4H2TdVi8tWI7jB9u1OifLb6jFakv2hU9iHO21XdApSKwsBVZyB
 9npQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0mqIC29Kd6vc73AKYQ6RxnJcezVCR7kXLH4bMNtwE9M=;
 b=A8WxQc/pZ3PjOwCAPACU9iF7/4g4YAWO5Bk01K3skM74TKxc4iUVEfTYqF9GAOBtTM
 JVvtRxqmR2/kuVIRu50wmf/iHdk6U3mnj6wPVpt/U1vp8FYv84UQwLLHA2OWfExb21n2
 ol3LNhqSb2UAmTUmG2Zly2xIAJP3h5rsKe0A+ZVbxxxuBEqYyL1iyLOuWc8B7b8jBAG3
 sokmcb/+4ykBTsSQYR85DDR/bgzrXKRg27XplXfZUdnfrmXK5D3GEX4bJF2RxRvgIeJM
 ogSf0CBkRU5n+en5LcTICZEev7/kSHb3N6aLBUgOBvLDjk/1BIKB3QgU/NqL+l8eTi5Z
 Sfhw==
X-Gm-Message-State: ANhLgQ1URx4XYc1LvlkUQ+HxSFE5n7YyMKHrgkrHp1OsLXxzK8y/Simb
 gHoe8hacAfMBxnALrnu7CwEQbGOUdK10aNlO3Ik=
X-Google-Smtp-Source: ADFU+vuy+lGeCT4x8YspRcEQEh/vRx+NQufUbsmcUsL+T9sfmFe1ezrtCSxHD05GXU0oVT7QioXQTDGPz8D8aiEyZvw=
X-Received: by 2002:ab0:143:: with SMTP id 61mr9785747uak.85.1584137612619;
 Fri, 13 Mar 2020 15:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584051142.git.alistair.francis@wdc.com>
 <ce73e32d4b399581b25d2323fad1d817d66dd11f.1584051142.git.alistair.francis@wdc.com>
 <2043ccc2-c14e-5237-af54-e8f082164ed7@vivier.eu>
 <CAKmqyKNUqEcueqfWCoO5e1sHtAeDGLGGnSCo-NOzjtHvzLbKAA@mail.gmail.com>
In-Reply-To: <CAKmqyKNUqEcueqfWCoO5e1sHtAeDGLGGnSCo-NOzjtHvzLbKAA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 13 Mar 2020 15:13:06 -0700
Message-ID: <CAKmqyKN=UaA35e49zKkVoQF4_stx347jDqci669xhJ7uDHKDLg@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] linux-user: Support futex_time64
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::943
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 13, 2020 at 3:12 PM Alistair Francis <alistair23@gmail.com> wro=
te:
>
> On Fri, Mar 13, 2020 at 1:14 AM Laurent Vivier <laurent@vivier.eu> wrote:
> >
> > Le 12/03/2020 =C3=A0 23:13, Alistair Francis a =C3=A9crit :
> > > Add support for host and target futex_time64. If futex_time64 exists =
on
> > > the host we try that first before falling back to the standard futux
> > > syscall.
> > >
> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > ---
> > >  linux-user/syscall.c | 144 +++++++++++++++++++++++++++++++++++++++--=
--
> > >  1 file changed, 131 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > > index 60fd775d9c..9ae7a05e38 100644
> > > --- a/linux-user/syscall.c
> > > +++ b/linux-user/syscall.c
> > ...
> > > @@ -6890,6 +6905,55 @@ static inline abi_long host_to_target_statx(st=
ruct target_statx *host_stx,
> > >  }
> > >  #endif
> > >
> > > +static int do_sys_futex(int *uaddr, int op, int val,
> > > +                         const struct timespec *timeout, int *uaddr2=
,
> > > +                         int val3)
> > > +{
> > > +#if HOST_LONG_BITS =3D=3D 64
> > > +#if defined(__NR_futex)
> > > +    /* always a 64-bit time_t, it doesn't define _time64 version  */
> > > +    return sys_futex(uaddr, op, val, timeout, uaddr2, val3);
> > > +
> > > +#endif
> > > +#else /* HOST_LONG_BITS =3D=3D 64 */
> > > +#if defined(__NR_futex_time64)
> > > +    if (sizeof(timeout->tv_sec) =3D=3D 8) {
> > > +        /* _time64 function on 32bit arch */
> > > +        return sys_futex_time64(uaddr, op, val, timeout, uaddr2, val=
3);
> > > +    }
> > > +#endif
> > > +#if defined(__NR_futex)
> > > +    /* old function on 32bit arch */
> > > +    return sys_futex(uaddr, op, val, timeout, uaddr2, val3);
> > > +#endif
> > > +#endif /* HOST_LONG_BITS =3D=3D 64 */
> > > +    return -TARGET_ENOSYS;
> >
> > You cannot return -TARGET_ENOSYS because return value is supposed to be
> > a host value as you have direct value from sys_futex().
> >
> > ...
> >
> > > @@ -7505,7 +7619,7 @@ static abi_long do_syscall1(void *cpu_env, int =
num, abi_long arg1,
> > >              ts =3D cpu->opaque;
> > >              if (ts->child_tidptr) {
> > >                  put_user_u32(0, ts->child_tidptr);
> > > -                sys_futex(g2h(ts->child_tidptr), FUTEX_WAKE, INT_MAX=
,
> > > +                do_sys_futex(g2h(ts->child_tidptr), FUTEX_WAKE, INT_=
MAX,
> > >                            NULL, NULL, 0);
> >
> > And return value is ignored. Anyway at this point we can't do anything
> > if it doesn't work, but it should not happen. So I think the best to do
> > is to add a g_assert_not_reached() in place of "return -TARGET_ENOSYS"
> > in do_sys_futex() (or "#error" if no futex function is available).
>
> It sounds like you applied this series, so I'm not going to fix this
> up. Let me know if you would like me to.

Ha, I read the wrong cover letter.

I'll send a new version of this.

Alistair

>
> Alistair
>
> >
> > Thanks,
> > Laurent
> >
> >

