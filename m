Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B801AC35249
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 02:56:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8783B2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 02:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j7NUhoer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8783B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyoOQ-00063P-Mb
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 21:56:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jkz@google.com>) id 1iyoNI-0004Dp-Cs
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:55:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jkz@google.com>) id 1iyoNH-0001SF-2G
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:55:40 -0500
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41]:45133)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jkz@google.com>) id 1iyoNG-0001Ng-RG
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:55:39 -0500
Received: by mail-vs1-xe41.google.com with SMTP id v141so10359205vsv.12
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 18:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=AjotzeK7h3JDM6MwEoJHhOY0PYQqG9fWVozvZWu/TyI=;
 b=j7NUhoerWtpwEPHrP7qv4WveSDE5GRQBc2oOOZ6lywiHJM2TeS96AABMxYg64So7M4
 j2oUQUz1J/lECamv1xnQbrwtC2TrEAHHqD+SB0Rt0Tdy1H7fOveOkqP6H5/DHOm5ZAcg
 zak8hkqw6vdYr9uI0sqtAWw4z29S+eIgGuFPCIcbldp7yw14xLwly4RhsveuhwG410ZH
 CJ4elsGzGutQTnuP1zh+wJfIry7j472W4kUlmIcGUimO4unHWtmeoSX0ZZp3wPbQHAoY
 98Y1SUzXl9q+y8zURafBMA6D1Rq8H14ECuQgVCRiNIByd/Bs4Mo7HD5dfm2o1oRIgrAv
 sx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AjotzeK7h3JDM6MwEoJHhOY0PYQqG9fWVozvZWu/TyI=;
 b=Kyrv8jw/g51OT1A2gA50d5jibXN+hk1PayeUAWmJblQcrHPMVkbloEg+9aIAWNV1Yk
 5oHnK6c0E57uMk+2ln2yCzOIbzWZWWGfEPtXljeOAig2Ul32oHjc5RHBGLe0Of978jp4
 gphw59yIc6HlLe243kwJInBNlBOmtFj801q64m+Q5k1IK2pfXM31DahiBRcJLyPGdog8
 QHC5raBPArHNFWIxaCVSp4LmukQUH5kYLlxFp9Gd+YxG1NK67MIfJP4tiG2uRAhD6idp
 /hl6c90Cy0J3X+Tl923T6QH7vo2XVOMX4L6tnKdBNlqQRlIN+GnUdkE5EGI4BBfA3It7
 18lg==
X-Gm-Message-State: APjAAAWaPDna6k5P3BN9Tsi9vGvFhlRiyfay2K2oGzO/82viYDhetKMA
 LtnekjRJitubOpv6RUtcWj/TkWBWsgfbE5yxiikvSrhM
X-Google-Smtp-Source: APXvYqzhENWzn6kSWtCtvh67ZatJbw1+vIkPFDnD6SlKy3WpWo6eEhLY+kgZ1dJbde3GkUunMPRBrItsVisks1ffriQ=
X-Received: by 2002:a05:6102:7a4:: with SMTP id
 x4mr16274143vsg.85.1580784937716; 
 Mon, 03 Feb 2020 18:55:37 -0800 (PST)
MIME-Version: 1.0
References: <20200117192808.129398-1-jkz@google.com>
 <20200117192808.129398-3-jkz@google.com>
 <ab5d3c15-9060-47be-fdb6-70ab76dfcc06@vivier.eu>
In-Reply-To: <ab5d3c15-9060-47be-fdb6-70ab76dfcc06@vivier.eu>
From: Josh Kunz <jkz@google.com>
Date: Mon, 3 Feb 2020 18:55:26 -0800
Message-ID: <CADgy-2v0kmErHVNx0X3tAcsw9ozGgfJ_pvC0xiStWo_trOcjEQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] linux-user: Use `qemu_log' for strace
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, armbru@redhat.com, 
 Warner Losh <imp@bsdimp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e41
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

On Tue, Jan 28, 2020 at 7:07 AM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 17/01/2020 =C3=A0 20:28, Josh Kunz a =C3=A9crit :
> > This change switches linux-user strace logging to use the newer `qemu_l=
og`
> > logging subsystem rather than the older `gemu_log` (notice the "g")
> > logger. `qemu_log` has several advantages, namely that it allows loggin=
g
> > to a file, and provides a more unified interface for configuration
> > of logging (via the QEMU_LOG environment variable or options).
> >
> > This change introduces a new log mask: `LOG_STRACE` which is used for
> > logging of user-mode strace messages.
> >
> > Signed-off-by: Josh Kunz <jkz@google.com>
> > ---
> >  include/qemu/log.h   |   2 +
> >  linux-user/main.c    |  30 ++-
> >  linux-user/qemu.h    |   1 -
> >  linux-user/signal.c  |   2 +-
> >  linux-user/strace.c  | 479 ++++++++++++++++++++++---------------------
> >  linux-user/syscall.c |  13 +-
> >  util/log.c           |   2 +
> >  7 files changed, 278 insertions(+), 251 deletions(-)
> >
> ...
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index 629f3a21b5..54e60f3807 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -12098,14 +12098,15 @@ abi_long do_syscall(void *cpu_env, int num, a=
bi_long arg1,
> >      record_syscall_start(cpu, num, arg1,
> >                           arg2, arg3, arg4, arg5, arg6, arg7, arg8);
> >
> > -    if (unlikely(do_strace)) {
> > +    if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
> >          print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
> > -        ret =3D do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
> > -                          arg5, arg6, arg7, arg8);
> > +    }
> > +
> > +    ret =3D do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
> > +                      arg5, arg6, arg7, arg8);
> > +
> > +    if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
> >          print_syscall_ret(num, ret);
> > -    } else {
> > -        ret =3D do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
> > -                          arg5, arg6, arg7, arg8);
> >      }
> >
> >      record_syscall_return(cpu, num, ret);
>
> In term of performance perhaps it sould be better to only test once for
> the mask as it is done before?

Modern compilers will generate functionally identical sequences for
test once or testing twice (which is to say, they recognize they are
the same compare: https://godbolt.org/z/VyrMHf IMO testing twice is
nicer to read, so I'm leaving it that way for now unless you object.

