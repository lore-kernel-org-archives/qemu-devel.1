Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B9BC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 17:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 449AF20724
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 17:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CybKCi2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449AF20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrlhY-0004Ox-F3
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 13:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jrlgn-0003Zq-BU
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 13:10:57 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233]:33669)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jrlgl-0003Xt-Bg
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 13:10:57 -0400
Received: by mail-lj1-x233.google.com with SMTP id e8so6195732ljb.0
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 10:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wbWTFvoG9vqSttdZDRJ5rqkwxbhbCiQaHwG6Z/uJNsE=;
 b=CybKCi2+WNRZLVv5+tLFf/vILRiB3bdjDN3Q7Ms5bse1qtT+MGwTjXy+6CIIYbfcTs
 MQh20YXrJ3pdHeAQHmp7Bxfbnjyf1kpXaq9NMTgH0IDivv16nL5KIg62vs0Hn9xVvI7Q
 rtqupYOah5f3V+lVHfN7nUZy73i7czaEc9wM3DWgJX2ic9uOHhMFPV/otZ6tF+wtlwED
 g8VF3BztEJY8z3LZX7+13ITYEnG3DQgsCd+3xAEjiQ/ZOyWVzbnF9pwGeyuPnVNlqRVy
 AoEoY3oON9KLJo1z2d/SXNotm5Y+HtP0L4iVOGLBNi50nKdKU5AQvfdrB67YkYCTgWpR
 xoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wbWTFvoG9vqSttdZDRJ5rqkwxbhbCiQaHwG6Z/uJNsE=;
 b=uabProOcn/6DM3ngG0AtTTxR1Pmn0jeNqcCzHOZL5kaOKVP7bOoR1yVub6wuF24Qi6
 K93s4O/sxQ7jt5dp0ptVA8sI4FkQ877VgICjb89cjwhorBXIHKhvzlyW1nsE0T5Mg+/t
 rXW5efjJtZ0fP+sRXv7/Ca9stwFHM+iVu6lwWoYZkwr//WJVy3OF1+eljHrEWhTN1Lfe
 hDEXQn09Sdvp5w8n4MFYTFFN6xuHX1QOnYgF9G38Afh/aPlzaNnINSKlXYjGI6jOMChn
 RHB+yBIBKWhPmFaDuJJVFBalv8CY1KcOqXTwrzreRuVtwbDBpbmvleoQaFREfnaVRqJJ
 hNmg==
X-Gm-Message-State: AOAM533ipkSCoh63tlXdirZhQfxK+KwRbDIt5t8e+Psge+2tVGLZWSlO
 UpGQYw9rkC+fWzlTceRhvDn7diI2kNfBM+A69mw=
X-Google-Smtp-Source: ABdhPJyK3O+qfkijvBOx/JE7+nZYQb1PTjkpX5MwgFVvBdjBt/GdcJjmfeoaAxaTYhDmeGeKXTj9gatJdv3TQMgvoqY=
X-Received: by 2002:a05:651c:1044:: with SMTP id
 x4mr21698424ljm.409.1593882653232; 
 Sat, 04 Jul 2020 10:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
 <878sg5svu5.fsf@linaro.org>
 <CALTWKrVx+e0oRVrvd27WeXAbAAZHVispG27cRPKwVo3HfNYbkQ@mail.gmail.com>
 <87sgebqm1i.fsf@linaro.org>
 <CAHiYmc4R2hP=ROCC_O0+0sO09TcH-ybwbk3aijxQo=LPpBztpg@mail.gmail.com>
 <87fta7fz3n.fsf@linaro.org>
In-Reply-To: <87fta7fz3n.fsf@linaro.org>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Sat, 4 Jul 2020 19:10:18 +0200
Message-ID: <CALTWKrXDf5efimui3NAzXKBA91Qs-qbpAEqVbTuDpvTBfmdrGA@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#2] Dissecting
 QEMU Into Three Main Parts
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x233.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 4, 2020 at 10:45 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> writes:
>
> > On Wednesday, July 1, 2020, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> >
> >>
> >> Ahmed Karaman <ahmedkhaledkaraman@gmail.com> writes:
> >>
> >> > On Mon, Jun 29, 2020 at 6:03 PM Alex Benn=C3=A9e <alex.bennee@linaro=
.org>
> >> wrote:
> >> >>
> >> >> Assuming your test case is constant execution (i.e. runs the same e=
ach
> >> >> time) you could run in through a plugins build to extract the numbe=
r of
> >> >> guest instructions, e.g.:
> >> >>
> >> >>   ./aarch64-linux-user/qemu-aarch64 -plugin tests/plugin/libinsn.so=
 -d
> >> plugin ./tests/tcg/aarch64-linux-user/sha1
> >> >>   SHA1=3D15dd99a1991e0b3826fede3deffc1feba42278e6
> >> >>   insns: 158603512
> >> >>
> >> >> --
> >> >> Alex Benn=C3=A9e
> >> >
> >> > Hi Mr. Alex,
> >> > I've created a plugins build as you've said using "--enable-plugins"
> >> option.
> >> > I've searched for "libinsn.so" plugin that you've mentioned in your
> >> > command but it isn't in that path.
> >>
> >> make plugins
> >>
> >> and you should find them in tests/plugins/
> >>
> >>
> > Hi, both Alex and Ahmed,
> >
> > Ahmed showed me tonight the first results with number of guest
> > instructions. It was almost eye-opening to me. The thing is, by now, I =
had
> > only vague picture that, on average, "many" host instructions are gener=
ated
> > per one guest instruction. Now, I could see exact ratio for each target=
,
> > for a particular example.
> >
> > A question for Alex:
> >
> > - What would be the application of this new info? (Except that one has =
nice
> > feeling, like I do, of knowing the exact ratio host/guest instruction f=
or a
> > particular scenario.)
>
> Well I think the total number of guest instructions is important because
> some architectures are more efficient than others and this will an
> impact on the total executed instructions.
>
> > I just have a feeling there is more significance of this new data that =
I
> > currently see. Could it be that it can be used in analysis of performan=
ce?
> > Or measuring quality of emulation (TCG operation)? But how exactly? Wha=
t
> > conclusion could potentially be derived from knowing number of guest
> > instructions?
>
> Knowing the ratio (especially as it changes between workloads) means you
> can better pin point where the inefficiencies lie. You don't want to
> spend your time chasing down an inefficiency that is down to the guest
> compiler ;-)
>
> >
> > Sorry for a "stupid" question.
> >
> > Aleksandar
> >
> >
> >
> >
> >> >
> >> > Are there any other options that I should configure my build with?
> >> > Thanks in advance.
> >> >
> >> > Regards,
> >> > Ahmed Karaman
> >>
> >>
> >> --
> >> Alex Benn=C3=A9e
> >>
>
>
> --
> Alex Benn=C3=A9e

Thanks Mr. Alex for your help!

Regards,
Ahmed Karaman

