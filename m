Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9E3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEEB720702
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1Ya1J5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEEB720702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqEs1-0005vh-3M
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 07:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqErP-0005Ud-I4
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 07:55:35 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35373)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqErN-0006KP-Gu
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 07:55:35 -0400
Received: by mail-wm1-x344.google.com with SMTP id l2so17820725wmf.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 04:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6hxRPsGhY/VRwFkjIVgSHvROOg1XU3kLuUoI9vAchWU=;
 b=T1Ya1J5vywnVlc6i3ihPcxxJ3ZKKEuq/R6T2Yh+I1BJ3VvucG+gWnVzSnlDl+mReJg
 wZoZBcw1vQljzNP+/qVIY6w/wPTCnFEgWyHWaux06mtA9BUG3DCkEsBz/CCkCbPTNIv0
 xDDORqgnbDSNc8qBT0P40cYH2v/pZPrHb1Z8eAIKxaZobbOfyHqWhhU9RSQl7KhCle9T
 b0joW53/h73BSjewIiSdzq4H+mG8kpuNoUUCv5Vyf+/h8iQ4ePe47g9hU2S26Crha9tp
 zHNNJFn3PTwps1eE353XH8K30o9Ak3D4xld8+rQ7RB9W4v+uHNTqBd0zE3065njx0nFq
 zQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6hxRPsGhY/VRwFkjIVgSHvROOg1XU3kLuUoI9vAchWU=;
 b=cBiQNeEXdcKev44cGT80xZasD5qGBb2AzlpMGleWZFPI74MhdeCwihAnnTGrWVeGGI
 dGrv7N39YFMDk2ddup2ibNLHAed2h5XhpAiVHn25eOzV7INM+7baPFYicpC3gCR+D0q0
 dg3p8hRwS5J2YDbs9UyuQHbmHK4FenoTOP4cKBBJ/kmUgGR76XXWZRRHY2zqbt9D63Z9
 kG5d3iFfiPT7iu8z/tTaGIHRz2IFAfrWufTr7tT0P65aPEeaCVGT4Nhn88UHf+fwiP+s
 Qi6pZP1dmxGydg9u2HkyqZy1BiRDxb9zvGHLwje2zGQd9rxbvF0ZehzqjrDaI0vUkmcM
 0SwQ==
X-Gm-Message-State: AOAM533vV9vZ6A1KpNZwKQSrrghWBEUE2ehIDOUltPE584s9jdCLM2J4
 +miCwIBmCNi2kGgyLRbVOehQyu6KFLaAzmSQ+wQ=
X-Google-Smtp-Source: ABdhPJyPr0hZP9JvkaFckfI+hi4FTDqpAVLQQUQTK2L54v29k68j2qTvWhf4imjxZ27kNBKe4HOPLah+vCZVb3AjeLk=
X-Received: by 2002:a1c:ac81:: with SMTP id
 v123mr20541498wme.159.1593518131762; 
 Tue, 30 Jun 2020 04:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200630081322.19146-1-f4bug@amsat.org>
 <CAHiYmc6coeBBOvCAs+=Ccw2aXfw0m3gTdSM1Pc8AQvJ4QNBhow@mail.gmail.com>
 <da6c2f55-b8b7-3492-37b3-d24a25106d72@amsat.org>
 <CAAdtpL7MObRjk77ZFsNF4Xoghdj33mwufZ9s3L8fAC3XxkJCqA@mail.gmail.com>
 <CAHiYmc59Ahpii2dvhVD8EPK4qzc8y2RNTwTbp4L1d2Mjun+Phg@mail.gmail.com>
 <3b75d15d-9195-bcd5-87aa-e243547552e5@amsat.org>
 <CAHiYmc4NOrG-ETX_rLGGR=Cac_Q_hNfjAsS3mF6PpAFFjLDHGw@mail.gmail.com>
 <2514e774-ade4-cd91-8d45-e4402c36c27f@amsat.org>
In-Reply-To: <2514e774-ade4-cd91-8d45-e4402c36c27f@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 30 Jun 2020 13:55:19 +0200
Message-ID: <CAHiYmc6vy3vmqB32w5z2Wze0k=QhX3OFnrt9M=hyDTfkt73NCQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] hw/mips/malta: Rework to allow more than 2GB of RAM
 on 64-bit
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yunqiang Su <ysu@wavecomp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=83=D1=82=D0=BE, 30. =D1=98=D1=83=D0=BD 2020. =D1=83 13:34 Philippe Math=
ieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 6/30/20 1:17 PM, Aleksandar Markovic wrote:
> > =D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30. =D1=98=D1=83=D0=BD 2020., Phi=
lippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
> > <mailto:f4bug@amsat.org>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> >     On 6/30/20 1:01 PM, Aleksandar Markovic wrote:
> >     >
> >     >
> >     > =D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30. =D1=98=D1=83=D0=BD 2020=
., Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
> >     <mailto:f4bug@amsat.org>
> >     > <mailto:f4bug@amsat.org <mailto:f4bug@amsat.org>>> =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >     >
> >     >     On Tue, Jun 30, 2020 at 12:52 PM Philippe Mathieu-Daud=C3=A9
> >     >     <f4bug@amsat.org <mailto:f4bug@amsat.org>
> >     <mailto:f4bug@amsat.org <mailto:f4bug@amsat.org>>> wrote:
> >     >     >
> >     >     > On 6/30/20 12:48 PM, Aleksandar Markovic wrote:
> >     >     > >
> >     >     > >
> >     >     > > =D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30. =D1=98=D1=83=D0=
=BD 2020., Philippe Mathieu-Daud=C3=A9
> >     <f4bug@amsat.org <mailto:f4bug@amsat.org>
> >     >     <mailto:f4bug@amsat.org <mailto:f4bug@amsat.org>>
> >     >     > > <mailto:f4bug@amsat.org <mailto:f4bug@amsat.org>
> >     <mailto:f4bug@amsat.org <mailto:f4bug@amsat.org>>>> =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >     >     > >
> >     >     > >     Hi,
> >     >     > >
> >     >     > >     Following Jiaxun Yang's patch and discussion:
> >     >     > >     https://patchwork.kernel.org/patch/11416915/
> >     <https://patchwork.kernel.org/patch/11416915/>
> >     >     <https://patchwork.kernel.org/patch/11416915/
> >     <https://patchwork.kernel.org/patch/11416915/>>
> >     >     > >     <https://patchwork.kernel.org/patch/11416915/
> >     <https://patchwork.kernel.org/patch/11416915/>
> >     >     <https://patchwork.kernel.org/patch/11416915/
> >     <https://patchwork.kernel.org/patch/11416915/>>>
> >     >     > >
> >     >     > >     - Rename the current machine as 'malta-virt' (keeping
> >     >     'malta' aliased)
> >     >     > >       Suggestions for better names are welcome, maybe
> >     >     'malta-unreal' or
> >     >     > >       'malta-unleashed' instead?
> >     >     > >     - Add 'malta-phys' which respects hardware
> >     restrictions (on
> >     >     RAM so far)
> >     >     > >     - Unleash 'malta-virt' to allow more than 2GB on 64-b=
it
> >     >     > >
> >     >     > >     Philippe Mathieu-Daud=C3=A9 (7):
> >     >     > >       hw/mips/malta: Trivial code movement
> >     >     > >       hw/mips/malta: Register the machine as a TypeInfo
> >     >     > >       hw/mips/malta: Rename 'malta' machine as 'malta-vir=
t'
> >     >     > >       hw/mips/malta: Introduce MaltaMachineClass::max_ram=
size
> >     >     > >       hw/mips/malta: Introduce the 'malta-phys' machine
> >     >     > >       hw/mips/malta: Verify malta-phys machine uses
> >     correct DIMM
> >     >     sizes
> >     >     > >       hw/mips/malta: Allow more than 2GB on 64-bit malta-=
virt
> >     >     > >
> >     >     > >      hw/mips/malta.c | 121
> >     >     +++++++++++++++++++++++++++++++++++++++---------
> >     >     > >      1 file changed, 99 insertions(+), 22 deletions(-)
> >     >     > >
> >     >     > >     --
> >     >     > >
> >     >     > >
> >     >     > >
> >     >     > > Thank you, Philippe, for providing this series.
> >     >     > >
> >     >     > > However, in previous discussion on the patch you mention
> >     above, I
> >     >     > > already expressed serious reservations on the approach
> >     taken in that
> >     >     > > patch. These reservations stay today too.
> >     >     > >
> >     >     > > There is nothing qualitatively different between the orig=
inal
> >     >     patch and
> >     >     > > this series. Naming and related stuff are just cosmetic
> >     issues.
> >     >     >
> >     >     > OK, what about considering all patches except the last one?
> >     >     > So we can run firmware on a real Malta board, not the QEMU
> >     >     > imaginary one (in the discussion you said QEMU should respe=
ct
> >     >     > real hardware, which I agree).
> >     >     >
> >     >     > >
> >     >     > > The good thing about this series is that one can apply it
> >     >     dowstream, if
> >     >     > > one finds it useful. However, it is not suitable for
> >     upstreaming
> >     >
> >     >     IOW, what is missing to have this series (except the last pat=
ch)
> >     >     accepted upstream?
> >     >
> >     >
> >     > It is not what is missing, but was already is in the series that =
makes
> >     > it not suitable for upstreaming. The very concept of the series i=
s
> >     > problematic.
> >
> >     What is the series is not suitable for upstream? Can you point to
> >     patch and code please? How would you conceptually resolve the
> >     problem?
> >
> >
> > The answer is already in the original thread on the original patch.
> >
> > The problem is artificialy imposed:
> >
> > One needs a feature not present in the physical system. The solution is
> > not in creating "virtual" upgrade - this violates the basic foundation
> > if QEMU.
> >
> > If the feature is missing, the optimal solution would be emulating the
> > physical solution that has that feature.
> >
> > In some rare cases (that should be avoided as mush as possible), and fo=
r
> > really good reasons, we can create an emulation of some imagined
> > hardware that was never designed let alone built - there are a couple o=
f
> > examples in other targets.
> >
> > But extending the emulation of existing physical system with
> > non-existing features is not acceptable.
> >
> > Hopefuly everything is clear now to you. :)
>
> I guess I understand a bit. I was confused by your use of "upstream".
> It seems you use it the wrong way, so for you "upstream" is what the
> MIPS enterprise world wants/needs, while "downstream" is what the
> open-source community wants/needs.
>
> If MIPS enterprise doesn't want a Malta machine model with 3GB of RAM,
> they can disable it in their downstream.
> If it helps the upstream community, the model is wrong anyway by using
> 2GB. It would be disastrous for all user to restrict the malta machine
> to 1GB upstream.
>

No, when I said "upstream" I meant what "upstream" always meant - our
central QEMU repository.

There is no different treatment of proposals whatever or whoever is
the origin of the proposal. The proposals are judged only on their
technical merits.

It is very difficult to cooperate with you if you constantly put in my
mouth what I would never say, like you did more than once in this
thread.

Regards,
Aleksandar

> >
> > Regards,
> > Aleksandar
> >
> >
> >
> >     >
> >     > Regards,
> >     > Aleksandar
> >     >
> >     >
> >     >
> >     >
> >     >
> >     >
> >     >
> >     >     > >
> >     >     > > Regards,
> >     >     > > Aleksandar
> >     >     > >
> >     >     > >
> >     >     > >
> >     >     > >     2.21.3
> >     >     > >
> >     >
> >

