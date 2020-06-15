Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E010C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58EFE20663
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WACv8GLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EFE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jklLk-0006fR-LE
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 05:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jklLB-0006D1-9n
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 05:23:41 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jklL9-0002vq-Jf
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 05:23:40 -0400
Received: by mail-ot1-x343.google.com with SMTP id k15so12570856otp.8
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 02:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OIYbvPwuZZGUSDw606KOMKG7AO1nw+7ti0rK9vhyemE=;
 b=WACv8GLdP96zHgOChXgFWWiPKYq2KRAfZlzkNHU2Wz6lFs6NMbVXRc4v46YoyMxmMD
 YeZt38QIJRmFoO5zSmDnIBsX/u1JmC4SIdYdaR2H0J7DWWlpt8lwt8eqDeq6G6oVz27t
 3ABzAHjX3uVBc7vkq4mtikZorUrTcahsEcip0sKQpJdROwBXgoWanPWlGK4E04fMyPE7
 QmQwz8P5DodgLNAWvv+VsKJnaq4ZkL9YynsVdCLVzfnzX1HXusCfJ+rK5AFMrS/l7Wwm
 ms5AeA2pOfldbR77Dt9IkQgMUd5qFYzkIjwPTGg54WSHdX17AolMystVbgNNhOs+mrIh
 nSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OIYbvPwuZZGUSDw606KOMKG7AO1nw+7ti0rK9vhyemE=;
 b=LFp+bvkrJY13JVZils4ErDRIg7QE0/RL0usHxLIQMfS4055nIFedV+4kNMozGWQ2RU
 nDwUAuu554DK8h/An3MTMm1+zwHbWl6Ogwmfal7WoD9U19L0+ZcJBIJ68IrEpBJiu0mK
 CqTzUFm/B45vPT0KXHRqflvkKXNRkPJ3Ptj04zKkoIdiNOH1KrYxzyVPlBpjQMxFxGt6
 BQwLHuKPCpEOGWoIH3ENyuW56ExPpnGEvH5TYzYe+OvCqVaVt7Aa8SvhOf/fdrUs8+zd
 o7Mkm3zpzgZ2Eug+i87njC5cMj3ispR6ef4SqvTvJ5i4nDV7ici43o2opyFU+9IgU3e9
 aMoQ==
X-Gm-Message-State: AOAM532GSEO/C8DMP7p6uby3hsrCp/EN4E6HwJG4ADGS+uNVtq+/Mp3i
 +yabigjd+37T37fU8ey9XzodEFFNw44/wchrpuGeYQ==
X-Google-Smtp-Source: ABdhPJykjuLLOabi23mGZO9j/OC0nZpKUckuVphKqegDuPWlmbTCsn1RZoq1pveGwfEuwQdkhiqfDSwpu2YgpVNtieE=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr19766919otn.221.1592213017925; 
 Mon, 15 Jun 2020 02:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200614034729.3004-1-jiaxun.yang@flygoat.com>
 <CAHiYmc5haGPCxR4Nr-WmL_4PG48F+dqeJLzvVRHjcoBZKykr8Q@mail.gmail.com>
 <CAFEAcA_dBdns09k=kxpc=OqpYK3FJH=DZCx2+FgpqnKh_6Oxkg@mail.gmail.com>
 <9a3f44fc-d279-c003-a8f6-0771e86cc3d0@flygoat.com>
In-Reply-To: <9a3f44fc-d279-c003-a8f6-0771e86cc3d0@flygoat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 10:23:27 +0100
Message-ID: <CAFEAcA8f3TsKz7qK00c-ert+cNGEo6gsN_MYmSSmFBWkbJnWDQ@mail.gmail.com>
Subject: Re: [PATCH] target/mips: Fix PageMask with variable page size
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 "aleksandar.rikalo@syrmia.com" <aleksandar.rikalo@syrmia.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 15 Jun 2020 at 10:17, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
>
>
> =E5=9C=A8 2020/6/15 17:13, Peter Maydell =E5=86=99=E9=81=93:
> > On Sun, 14 Jun 2020 at 22:52, Aleksandar Markovic
> > <aleksandar.qemu.devel@gmail.com> wrote:
> >> When you change machine.c the way you did it, you need to bump the ver=
sion. Please see git log on machine.c for details.
> >
> >>> --- a/target/mips/cpu.h
> >>> +++ b/target/mips/cpu.h
> >>> @@ -617,7 +617,8 @@ struct CPUMIPSState {
> >>>   /*
> >>>    * CP0 Register 5
> >>>    */
> >>> -    int32_t CP0_PageMask;
> >>> +    target_ulong CP0_PageMask;
> >>> +#define CP0PM_MASK 13
> >
> > Does CP0_PageMask ever actually hold a value that won't fit
> > in an int32_t? If not, it might be preferable to avoid changing
> > its type to avoid the migration compat break, even if MIPS
> > doesn't have any versioned boards where we have a strict
> > don't-break-compat promise to users.
>
> In Release2, PageMask was extended to 64bit on MIPS64 processors.
>
> Is it necessary to follow that?

Ah, I see. I'd assumed that you were only fixing the
variable-page-size change (which shouldn't require a
change in the type), but as Aleksandar says you've
mixed in a new feature implementation in the same commit
(which from what you're saying does need the type to change).
If the new feature means the register is now 64 bits then
it is possible to implement this in a migration-compatible
way by using a vmstate subsection; I'll leave it up to
Aleksandar whether that complexity is something that makes
sense for MIPS targets or if it's better to just break migration
compat by bumping the version.

thanks
-- PMM

