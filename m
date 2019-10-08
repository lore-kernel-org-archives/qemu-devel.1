Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFB0C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 20:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0344C2070B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 20:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOcER1WL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0344C2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHwZI-0001oq-4B
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 16:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iHwXm-0000Ts-BN
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iHwXl-0002Sn-8N
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:57:18 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:35774)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iHwXl-0002SD-0O
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:57:17 -0400
Received: by mail-lj1-x242.google.com with SMTP id m7so264796lji.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 13:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LzUtaF7vK7c0x0tdepO69D9vN8F8r3IQyn1ygxLFyvw=;
 b=JOcER1WLjSfg8HJCmOWFVet/g+na0rs9P2GM0aGzd30WrrTIOH8zexfQOe2Ug+4IST
 t1UKvR8D0YwgS3g4R7ChwEyao1Hb2CY6a4Xz1t5TtpFgt+uM1cBq6C+dtNsLKF0htheP
 /zZ2w1YH2IYhnDFuCiaSSbD/fTlEWJmnCP+MLWh37OrFt2OijfEqPzW6EjhlnP2Ual7M
 hKK1+kPehQoeLDdDVtkglxnABj5mVl6G2Fnu9wm560MWIoAzfmBD7sDeqSpGzOxoHaKB
 yD/n2KDF6/sJAud5HUWm0LKGPs62mwKNLjkkVPFYVPaDkwrzcWur5NESPDQ5EuAvimQI
 kbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LzUtaF7vK7c0x0tdepO69D9vN8F8r3IQyn1ygxLFyvw=;
 b=sHMB2GyAvV+Ysh9fBDfL1E1PZvxlorYIII87lKvAO+8bTOg/0ZHHo3RMrzeUsYkcr6
 nkyLT30S6WMpe2/+AaPHiDsVCMNnBr8LwghgWTd9kMUpk9x5QWR2mHt6AOMB+lSIoFGl
 KDtKcdobqQElIifxEPwOX9day3hRP8HrVrwN3lNp90zO5/9IGonm37mZDHUZwkaxbEcV
 WFC1sX2rrGOjedHKdIYl3zqKakRO2JSDaTFt7UXV3MxLvbCU+bgJs+1VV6cGrm2W/rjK
 zLh0V1JqEVtcwLgkvsX04CfcKlYfpmne3+qQniJO12YPuL2cFkynA4XXd7Xeg1bpt6rV
 tFdA==
X-Gm-Message-State: APjAAAV52UhgYQi9MSe5LstnKCeHys+MWzqiS3ss+k9UEJdiIvZHYfoJ
 yxOM6NldH2dzwYTDkzeqv9j8sRChCD8yTemxTH0=
X-Google-Smtp-Source: APXvYqw/pIVLs3MlG3SBWLO6hpGHBN/b7XK87d5n1EOzccdmNGZsuW5Qi0/96Zf9JIpKVubROS+JXmk/gwSkL6WZ6qI=
X-Received: by 2002:a2e:b17b:: with SMTP id a27mr104168ljm.7.1570568235548;
 Tue, 08 Oct 2019 13:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA-O6b5zc=Qp-49Fc9_tQ+a+Stk6DfnwwzDON+RZfSDSfA@mail.gmail.com>
 <mhng-86e6be44-c5dd-4ecb-bdcb-1f490db0f2cf@palmer-si-x1e>
 <CAKmqyKN6byATOyb9MatRsh6LUZ5LXb5yf_wCa+0EQZYa53FuHQ@mail.gmail.com>
In-Reply-To: <CAKmqyKN6byATOyb9MatRsh6LUZ5LXb5yf_wCa+0EQZYa53FuHQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 8 Oct 2019 13:52:17 -0700
Message-ID: <CAKmqyKOu94-cdzr1uSafhRFpR7Rpc1ZxcrvuG+rGFXOMQfrpZA@mail.gmail.com>
Subject: Re: [PATCH] memory: Replace DEBUG_UNASSIGNED printf calls by trace
 events
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Desnogues <laurent.desnogues@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 8, 2019 at 1:41 PM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Tue, Oct 8, 2019 at 1:41 PM Palmer Dabbelt <palmer@sifive.com> wrote:
> >
> > On Fri, 20 Sep 2019 07:20:34 PDT (-0700), Peter Maydell wrote:
> > > On Fri, 20 Sep 2019 at 15:17, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > >> I think it's simplest if all series (RISC-V, remove unassigned_access,
> > >> this one) go through the RISC-V tree.
> > >
> > > I don't inherently object but IME the risc-v tree tends to move
> > > comparatively slowly. The initial risc-v conversion patchset
> > > should definitely go via the risc-v tree, anyway.
> >
> > We still don't have the riscv_cpu_unassigned_access() removal patches in, which
> > IIRC got blocked on review but I can no longer dig out of my inbox.  IIRC the
> > patches Alistair sent were still "From: Palmer", which means I can't review
> > them.
>
> The patches are reviewed by Richard and Philippe, they should be ready to merge.

Just sent a v2, so you should be able to find them now.

Alistair

>
> Alistair
>
> >
> > I'm fine taking this on top of those, but it looks like there's still some
> > debate about the patch itself.  I don't see a v2.
> >

