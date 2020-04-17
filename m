Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEF4C38A2B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 13:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF568214AF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 13:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="InB76e91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF568214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPRTM-0008Kx-00
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 09:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jPRSZ-0007jA-6y
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jPRSX-0002Wb-W3
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:55:10 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:41644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jPRSX-0002WH-Pu
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:55:09 -0400
Received: by mail-oo1-xc41.google.com with SMTP id t3so464121oou.8
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 06:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1qGKkVLPIOtw/YCvUqno/ATBMMnNSopURWMtrEnMW9Q=;
 b=InB76e91InNRl4vyHbco2mX3gA95gKqUTLdjn05M2oFYDqF0CAuDPCwlzLNBuuZPfI
 4MKNCkdc40czeE3rueAak70LjGNoLyRag7RpIRPyQwmMXeWyKPR2d6sJRS+POCliPBsW
 Rm0Otziqg0VNrXQr2qN4xCpCOTtIpXXscyHyMey40TvFMEg04ZRYX+dfMwvUxUhFAbo5
 uRlZZekevrWmmnaOTvmg7fD7EaXijbyDsqmo+14ew/gwczaCinlSK7bS22iQH7QSDR1/
 xFf7EuUz1RwtwotdZwc6FI6wA1IN10u4ASDroMW+WzT10O5bFQiJ3komlt10ZbLzNOMf
 84pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1qGKkVLPIOtw/YCvUqno/ATBMMnNSopURWMtrEnMW9Q=;
 b=EUr21b3argAQXMNMnTPqqb+IE+jiyKPsJF2vh12Rw52mO2DeBeU03eIRUc/FmYtKU6
 i/WBspV7dmO5iSaFYmQhm4v0z85ddU4Ms1vRCnSEKj7gikjB0XNYltEkQEjbC1Hfn0EV
 Yy063XPgMDrNJRwNHjiU7UJI+N1+hdIq1RaAFQwfscPByHRL4YDtCIRHAlvc0guLRa3i
 d5zCSbOhMSiZwM2h9WHQIKzTJgLvKaGoIr4/32p6dY9MNDXjcHckSb+TuOH3v5yEyXQJ
 zFAkPe+mmXov34ozcuYtvgkEZ6a4kBEWcmFGCfFjdK5GLgrexamYieGdznqRuqskI7JU
 vWUw==
X-Gm-Message-State: AGi0PuZmsjrgWEifM0Mb/04u0jReTaVmkLZgdA9zjlhu6mAK5aYUeFHj
 2gLYZ2icky1CcV2LpSuFPwbPywj0UH5CR6p38Gx4Iw==
X-Google-Smtp-Source: APiQypIDTfiyQpnk189V+b3jR/JVtVNY8V+qgHsx26aO/iXmbTcjjwPHPe0X0jHHcFoDSvwMFPKVRIFx8YqySqhqrdU=
X-Received: by 2002:a4a:890b:: with SMTP id f11mr2576302ooi.85.1587131708881; 
 Fri, 17 Apr 2020 06:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-4-philmd@redhat.com>
 <f570579b-da9c-e89a-3430-08e82d9052c1@linaro.org>
 <CAFEAcA8K-njh=TyjS_4deD4wTjhqnc=t6SQB1DbKgWWS5rixSQ@mail.gmail.com>
 <5d9606c9-f812-f629-e03f-d72ddbce05ee@redhat.com>
In-Reply-To: <5d9606c9-f812-f629-e03f-d72ddbce05ee@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Apr 2020 14:54:57 +0100
Message-ID: <CAFEAcA-4+Jcfxc5dax8exV+kBJKYEnWZ2d-V1A6sm6uJafZdPg@mail.gmail.com>
Subject: Re: [PATCH v3 03/19] target/arm: Restrict DC-CVAP instruction to TCG
 accel
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Apr 2020 at 14:49, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 3/16/20 9:11 PM, Peter Maydell wrote:
> > On Mon, 16 Mar 2020 at 19:36, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >> I'm not 100% sure how the system regs function under kvm.
> >>
> >> If they are not used at all, then we should avoid them all en masse an=
 not
> >> piecemeal like this.
> >>
> >> If they are used for something, then we should keep them registered an=
d change
> >> the writefn like so:
> >>
> >> #ifdef CONFIG_TCG
> >>      /* existing stuff */
> >> #else
> >>      /* Handled by hardware accelerator. */
> >>      g_assert_not_reached();
> >> #endif
>
> I ended with that patch because dccvap_writefn() calls probe_read()
> which is an inlined call to probe_access(), which itself is only defined
> when using TCG. So with KVM either linking fails or I get:
>
> target/arm/helper.c: In function =E2=80=98dccvap_writefn=E2=80=99:
> target/arm/helper.c:6898:13: error: implicit declaration of function
> =E2=80=98probe_read=E2=80=99;
>       haddr =3D probe_read(env, vaddr, dline_size, mem_idx, GETPC());
>               ^~~~~~~~~~

IN this particular case, DC CVAP is really a system insn rather
than a 'register'; our register struct for it is marked up as
ARM_CP_NO_RAW, which means we'll effectively ignore it when
running KVM (it will not be migrated, have its state synced
against the kernel, or be visible in gdb). If dccvap_writefn()
ever gets called somehow that's a bug, so having it end up
with an assert is the right thing.

> I'll use your suggestion which works for me:

Your suggested patch isn't quite the same as RTH's suggestion,
because it puts the assert inside a stub probe_read()
implementation rather than having the ifdef at the level
of the writefn body. I have no opinion on whether one or
the other of these is preferable.

thanks
-- PMM

