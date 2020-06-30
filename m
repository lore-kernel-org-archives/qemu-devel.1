Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79C2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:03:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F3662067D
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+99aO63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3662067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqLXo-00038C-Mg
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 15:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jqLXB-0002bq-EN
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 15:03:09 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:39902)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jqLX9-0003h2-Ip
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 15:03:08 -0400
Received: by mail-lj1-x243.google.com with SMTP id b25so20277389ljp.6
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 12:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AowFWKYZXVl9oj9kkT73Qri1GJchPirscSGqx81D6bs=;
 b=R+99aO637RXvZrI9+23DLzb4rPei4OkfFbT4jp7YkUiIyw0Cr/17Yhnwk5A62wZ/bE
 sbwTASfWAkcwwZ9MO0T2LxRlbIkN45/9ysXeIuBEg1wjbBIT7huaEpF/AHql9iJvCjfx
 EWNIqCp9hlJ6+c8bGsJz0Sq/JX/w4qTQ58CokFF3+D02j+WEwjoY3x2si8r6+lG/K/2T
 c6gW6PNwbqtVFYKH7iCSNsMC7dkVU5eM3CZDsvwsqrEq5EnWI8lJqR3Y/wLYjxMgsI+k
 zU5zLxLLpfGrqdSYjWXzpg8iTx3QrYButiypIJY74QalKFI+wN3mIggXQNfIV9Fim93e
 JwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AowFWKYZXVl9oj9kkT73Qri1GJchPirscSGqx81D6bs=;
 b=IPnnJyxjX3yK5oB0XeFj9JISjHzEAbnLnVqiCHkHVYO7lC8AQyuP9tEjP0m3GYJuUx
 H3029IctBLGBWH/9f5KBNdoPevsTaiSSEdt1zsfapOo/zNDnkyhu/D5u6YZi5pHPByRj
 MZQio8iG1SvWfyTd5lWW0u9vXQKa/Tpwv2rIj3XJuVOvMaUFZ8bWiP36NVJMuWV3SlpP
 3vNB5UjxeYx7nTIeENpDwGaeh0PlqhjbO5nejo/2HCZy/rRsfvlNJh3mhGHtG2wDBDLm
 97XUAZQUn6rcbdUV4WO+Y4QwDQzYu1rYW9olus3l2YrJgwTg+KYpsLK/OMLlQ7tExJfi
 fslg==
X-Gm-Message-State: AOAM532D1103BNSQ3HvFHV5SFUdByez6X72ixEC25KZS5pzMuE6aNBE4
 0GwKSFPYVPj0sTVPHDarf3sda/8VICYdrK6u8sQ=
X-Google-Smtp-Source: ABdhPJzMo1yTTk+jh8AcejOVq0qq1VW/nQEoqdTHIqGBxd4wcBoi1+XaCw6nboDZBcuuQer4A/nY7bWNT6MqmYAeuyo=
X-Received: by 2002:a05:651c:508:: with SMTP id
 o8mr10865449ljp.112.1593543785539; 
 Tue, 30 Jun 2020 12:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
 <CAE2XoE-dOHGtJO5f0xXA7r4hEeL5LDOPB1TDNPjWNC+hf9Qyew@mail.gmail.com>
 <CALTWKrVwRhQEEjMEq444fNgBp1Dv_XyJAV7suXCEmeS40raaEQ@mail.gmail.com>
 <CAHiYmc5Em7zaVZzBZdp-13Mw2MnM_-nxZ=g+_ePnDCcBiwJrRg@mail.gmail.com>
 <CAHiYmc6cr4_q35106ZTPdAXG5geKChu7XUiKVLkDPRVhZM3Z_A@mail.gmail.com>
In-Reply-To: <CAHiYmc6cr4_q35106ZTPdAXG5geKChu7XUiKVLkDPRVhZM3Z_A@mail.gmail.com>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Tue, 30 Jun 2020 21:02:26 +0200
Message-ID: <CALTWKrXpWHRLoJOMtg7w2-m0=Go1jn9kr7E__Pjn92B81_H74w@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#2] Dissecting
 QEMU Into Three Main Parts
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 luoyonggang@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 11:52 AM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
> > As far as I know, this is how Ahmed test bed is setup:
> >
> > 1) Fresh installation on Ubuntu 18.04 on an Inter 64-bit host.
> > 2) Install QEMU build prerequisite packages.
> > 3) Install perf (this step is not necessary for Report 2, but it is
> > for Report 1).
> > 4) Install vallgrind.
> > 5) Install 16 gcc cross-compilers. (which, together with native
> > comipler, will sum up to the 17 possible QEMU targets)
> >
>
> The following commands install cross-compilers needed for creating
> table in the second part or Ahmed's Report 2:
>
> sudo apt-get install g++
> sudo apt-get install g++-aarch64-linux-gnu
> sudo apt-get install g++-alpha-linux-gnu
> sudo apt-get install g++-arm-linux-gnueabi
> sudo apt-get install g++-hppa-linux-gnu
> sudo apt-get install g++-m68k-linux-gnu
> sudo apt-get install g++-mips-linux-gnu
> sudo apt-get install g++-mips64-linux-gnuabi64
> sudo apt-get install g++-mips64el-linux-gnuabi64
> sudo apt-get install g++-mipsel-linux-gnu
> sudo apt-get install g++-powerpc-linux-gnu
> sudo apt-get install g++-powerpc64-linux-gnu
> sudo apt-get install g++-powerpc64le-linux-gnu
> sudo apt-get install g++-riscv64-linux-gnu
> sudo apt-get install g++-s390x-linux-gnu
> sudo apt-get install g++-sh4-linux-gnu
> sudo apt-get install g++-sparc64-linux-gnu
>
> Ahmed, I think this should be in an Appendix section of Report 2.
>
> Sincerely,
> Aleksandar
>
> > That is all fine if Mr. Yongang is able to do the above, or if he
> > already have similar system.
> >
> > I am fairly convinced that the setup for any Debian-based Linux
> > distribution will be almost identical as described above
> >
> > However, let's say Mr.Yongang system is Suse-bases distribution (SUSE
> > Linux Enterprise, openSUSE Leap, openSUSE Tumbleweed, Gecko). He could
> > do steps 2), 3), 4) in a fairly similar manner. But, step 5) will be
> > difficult. I know that support for cross-compilers is relatively poor
> > for Suse-based distributions. I think Mr. Yongang could run experiment
> > from the second part of Report 2 only for 5 or 6 targets, rather than
> > 17 as you did.
> >
> > The bottom line for Report 2:
> >
> > I think there should be an "Appendix" note on installing
> > cross-compilers. And some general note on your test bed, as well as
> > some guideline for all people like Mr. Yongang who wish to repro the
> > results on their own systems.
> >
> > Sincerely,
> > Aleksandar
> >
> >
> >
> >
> >
> >
> >
> >
> >
> > 2)
> >
> >
> > > Best Regards,
> > > Ahmed Karaman
Thanks Mr. Aleksandar for your input on this one.
This is indeed my setup for the testbed used for the two previous
reports and all the upcoming ones.
To help Mr. Yongang with his setup, and anybody else trying to set
this up, I plan to post a mini-report (Report 0) to lay down the
instructions for setting up a system similar to the one used in the
reports.

Best regards,
Ahmed Karaman

