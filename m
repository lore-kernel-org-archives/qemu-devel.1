Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1CAC38A2A
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 03:01:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FCD521655
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 03:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAR+oiHo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FCD521655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXFjZ-0001hD-Gv
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 23:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jXFir-0001B9-Ks
 for qemu-devel@nongnu.org; Fri, 08 May 2020 23:00:17 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:40473)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jXFip-0000wo-5o
 for qemu-devel@nongnu.org; Fri, 08 May 2020 23:00:16 -0400
Received: by mail-lj1-x242.google.com with SMTP id y4so3709177ljn.7
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 20:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SGyC04vMmQZ1Q3PPNwr6iHH4M23gvNf4HdfnG6lYuew=;
 b=iAR+oiHoKzF4k6IxAsX89TV7SAgwVO2tOhs9+BqI6qiALtg51IQ/bKAH0Y3W241rvY
 82IZTmEuQogeq6+f6GxBpKy/eGSzO/Y6XEkalWTD1fryeGVyOkDimZZNdEIip82AIRXh
 X4b67aTCIPWqBMvCmyoKcVcHUo9QAR4P5cWSB51gJF8Z2rZ6BoOsfB3E+Cp3tEdi2eBT
 AjVwJP0rCDH30upjxeF8AoT9ltwVConJmfPhXC8DQphwrc5oUr89urg37g7Bwqe2xGPk
 Rv+NxrkokeGTEVc8Tpt6zepiXwXQP8hX64paZ/O3bXsmLuwzq3DQj44GXqY/QCCtjJvo
 qL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SGyC04vMmQZ1Q3PPNwr6iHH4M23gvNf4HdfnG6lYuew=;
 b=DOP6ea5nsGJreVnsuF8nPeyfNwjlclQakVKQeu/TDk7WA25ray7LJS+z2sz4zHA/Qk
 aXgOV2nqM0kCbczNIntfeaRfHqFoGnAsTZQwSv19TIrqXaEfaP6YfDGTtIqNoIDy5qEz
 H4rfeBy4N9Rxwo9jiJ7AvMjobxvHVVyJqbG7dhrx6qcenfwohDR8BZQAlZOqoIttZP1R
 QOw3PL6aJnR8YLqHREFOADWjg/9GIA/RMyvnFP1+E6bEy+qij3HfyFNiOcwbmc9TbAbB
 uFrgbYgDzR8sLUp5rkIY7wEgW2mthIs8mj6vN1i4dFMXtCEn870Jqpv+q4McUisC9fH/
 Ls/w==
X-Gm-Message-State: AOAM532gK28vHPUC3dIlXKCYWzm/03ALQEAptEjzJLkbvh5q2ZMSRT33
 7hn37eG6QIKodLvVsVR2yk5vr4vAOInv5opvesU=
X-Google-Smtp-Source: ABdhPJwZFxa4eGsLRJCaW1fDvOvabk9jOeNIxrYLpbU8OZhToGlzdd/lc5mx6S7MMoBFZlIYy20JiAcQ0pPlo12htMk=
X-Received: by 2002:a2e:9b0f:: with SMTP id u15mr3505438lji.272.1588993213044; 
 Fri, 08 May 2020 20:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <1588501221-1205-1-git-send-email-chenhc@lemote.com>
 <CAHiYmc4GnBE7YWghRk9FUL93RBsbJ+QddNsqMZFOGsUQumhmSg@mail.gmail.com>
In-Reply-To: <CAHiYmc4GnBE7YWghRk9FUL93RBsbJ+QddNsqMZFOGsUQumhmSg@mail.gmail.com>
From: chen huacai <zltjiangshi@gmail.com>
Date: Sat, 9 May 2020 11:07:54 +0800
Message-ID: <CABDp7Voi1PJL+fnNHMpWU=T7fLG2cmS9gN1O5mFKDGYocNE-3g@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V3 0/7] mips: Add Loongson-3 machine support (with
 KVM)
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=zltjiangshi@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Aleksandar,

On Sat, May 9, 2020 at 12:55 AM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
> =D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:21 Huacai Chen =
<zltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=BE/=D0=BB=D0=B0:
> >
> > Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson-3B
> > R1/R2. Loongson-3A R1 is the oldest and its ISA is the smallest, while
> > Loongson-3A R4 is the newest and its ISA is almost the superset of all
> > others. To reduce complexity, in QEMU we just define two CPU types:
> >
> > 1, "Loongson-3A1000" CPU which is corresponding to Loongson-3A R1. It i=
s
> >    suitable for TCG because Loongson-3A R1 has fewest ASE.
> > 2, "Loongson-3A4000" CPU which is corresponding to Loongson-3A R4. It i=
s
> >    suitable for KVM because Loongson-3A R4 has the VZ ASE.
> >
>
> Hi, Huacei,
>
> Just a couple of practicalities. As you know, we can't upstream this
> series until correspondent kernel support is upstreamed into kernel.
> This is my advice, timing-wise:
>
> - I think it is too late (and not good from testing/risk perspective)
> to shoot for integrating your kernel series into kernel 5.7;
> - My advice is to try to upstream your kernel series at the beginning
> of 5.8 development cycle (which should not be too far)
> - Once this is done, it will open the door for integrating this series
> into QEMU upstream
> - This means that combination of kernel 5.8 and QEMU 5.1 will
> hopefully be a working system from Loongson KVM point of view
> - This will also mean we will have relatively sufficient time to test,
> and possibly fix some new bugs before QEMU 5.1 release.
>
> I hope this tentative plan sounds good to you.
OK, I will try to upstream kernel series at first, and send a V4 of
qemu series after that.
>
> Sincerely,
> Aleksandar



--=20
Huacai Chen

