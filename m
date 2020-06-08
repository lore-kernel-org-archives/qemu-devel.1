Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D27DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B92C2053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7vMC+Hx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B92C2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKkb-0004nB-Jm
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1jiKQO-0007so-Af; Mon, 08 Jun 2020 12:15:00 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:35596)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1jiKQ9-00023J-QF; Mon, 08 Jun 2020 12:14:59 -0400
Received: by mail-il1-x144.google.com with SMTP id l6so17362743ilo.2;
 Mon, 08 Jun 2020 09:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=V6LhXVUzdTPvGQewx4yDmhRKTL+/eIB/as3rkKXCUqs=;
 b=X7vMC+HxrOcEYok6nYcScK1eCAOjDYE1W6ZjjO6VLb27cGHKnsahXN6I/9GGL0j2Wy
 84l2wSsXuZwy0gX+DsgblBZ/mmKxcB7n61B4WlyCs6bD14zeVGnVmkBFP5nrkzyQxqwz
 jOn42KDEQw4cxxoXhd58RoMQyjT5PCL9EcfJBtBddoi3JKHexDJSRbDXqu8CS2O6981q
 glQf3eSlNokhFZL/tVN2mURZNV5ENxAcUuMr7oTk0Xuaa1FaQY1Kz9tFdCMfRwS1uX+t
 jV4v7+ho0jzEvWQ+jAvi6p7YPBwc6K9EdQLLPexsA8IP1AZe4WDWr5frX2bS//FeH9GA
 g8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=V6LhXVUzdTPvGQewx4yDmhRKTL+/eIB/as3rkKXCUqs=;
 b=B5nOpH6aawnmosqsqDaX1dA92ovDZql5CXvtaPH16iKw+STAMK2JMaI2TXNQFgg3Zl
 SoIGrhaKFVSX4WOJrWh4WEms9o3IAGIZ1CQMbdAuDUqs5ZDGpyXbjClrzpw+ZyLbRhM0
 ygLDKKHFsIaAoKtfSTvcvcqLdRH9O/ASa8OxH5StwH7gxXgeQYqWSrEvmbM4zrQihfpY
 lFUKGlsKHcBSVFnMbz5in1ZWaJuKubximt8CB0j2BF8iR0FjXOrj6+beBnrauNvJEjJp
 f87Cqrf83f+jqoUBusMMmBcsDVnVEhwgDXvUGud7H4saJbDm05z8xylw7d5y37uF5htu
 yUig==
X-Gm-Message-State: AOAM531aLI80dCC6lVR46J1v2RhnGfyk8wB+l8ciT48z/kN6Fu4DlULe
 OepM71YMXUNo0n33HJFWEtXQUei3L/ttInPJ3AA=
X-Google-Smtp-Source: ABdhPJyc6eJuGXKyL6nEvYcJLnglJ2gO2yuexwjLvtnstyMNdOc2FO9GJ8LDoiZSaOuM0tY+098yARMvJXUIGfLqaic=
X-Received: by 2002:a92:5b99:: with SMTP id c25mr22790499ilg.42.1591632884286; 
 Mon, 08 Jun 2020 09:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200331105048.27989-1-f4bug@amsat.org>
 <81737d76-06c6-4c83-1287-b0d14db4ce2f@amsat.org>
 <989bf2f5-0e23-f9c3-e9e1-0bd8c03f3231@adacore.com>
 <1b7a4c63-5a31-6efe-d807-7092e3ee0ffb@amsat.org>
 <230dbf6b-120a-f1f0-d48d-9fa4a04e05cd@adacore.com>
 <23588fda-b95b-45a9-b788-e846d26a3bc3@amsat.org>
 <7f673b61-7565-f79a-0ec6-043c44d1df77@amsat.org>
 <08b73f34-4cab-1133-e5e5-5b1e9fc7b5d0@adacore.com>
 <344c9260-e448-feea-3b37-7860dd09cd8a@amsat.org>
 <56e92e1c-6f89-5359-53bc-57c529743d5e@amsat.org>
In-Reply-To: <56e92e1c-6f89-5359-53bc-57c529743d5e@amsat.org>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Mon, 8 Jun 2020 18:14:32 +0200
Message-ID: <CACXAS8BJ7wfgAoe1WDSBkHXfsxymM3+a2GsZ28q_W-eq5fM0Vg@mail.gmail.com>
Subject: Re: [PATCH 0/7] hw/sparc/leon3: Few fixes and disable HelenOS test
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=atar4qemu@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>, Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fred Konrad <konrad@adacore.com>, Jiri Gaisler <jiri@gaisler.se>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 8, 2020 at 5:20 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> On 5/26/20 11:50 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 5/25/20 1:02 PM, Fred Konrad wrote:
> >> Sorry Philippe I missed that.
> >>
> >> Would be happy to do a PR if needed but:
> >>   * I never did that.
> >>   * Looking at https://wiki.qemu.org/Contribute/SubmitAPullRequest, I
> >> don't have
> >>     the signed GPG key either.
> >
> > Thanks Fred for following this series.
> >
> > I am not insisting for you to do the pull request, I was waiting for
> > Artyom (sparc32) and Mark (sparc64) who usually handle the pull request=
s.
> >
> > Artyom seems busy lately.
>
> Artyom, if you agree I can send a pullreq with this series and the
> empty_slot one.
>

Yes, please.
Artyom

> >
> > Mark, do you plan to send a hw/sparc* pull request soon? Do you prefer =
I
> > ask to trivial@ for this series?
> >
> > FYI there is another sparc32 candidate patch:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg701850.html
> >
> > Regards,
> >
> > Phil.
> >
> >>
> >> Cheers,
> >> Fred
> >>
> >> Le 5/23/20 =C3=A0 7:26 PM, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit :
> >>> ping?
> >>>
> >>> On 5/11/20 9:03 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>> On 4/14/20 12:00 PM, KONRAD Frederic wrote:
> >>>>> Le 4/13/20 =C3=A0 11:07 PM, Philippe Mathieu-Daud=C3=A9 a =C3=A9cri=
t :
> >>>>>> [Cc'ing Peter]
> >>>>>>
> >>>>>> On 4/13/20 12:12 PM, KONRAD Frederic wrote:
> >>>>>>> Le 4/11/20 =C3=A0 7:30 PM, Philippe Mathieu-Daud=C3=A9 a =C3=A9cr=
it :
> >>>>>>>> On 3/31/20 12:50 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>>>>>>> Philippe Mathieu-Daud=C3=A9 (7):
> >>>>>>>>>      hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to AHB=
 PnP
> >>>>>>>>>        registers
> >>>>>>>>>      hw/misc/grlib_ahb_apb_pnp: Fix AHB PnP 8-bit accesses
> >>>>>>>>
> >>>>>>>> Ping ^^^ for 5.0?
> >>>>>>>
> >>>>>>> Hi Philippe,
> >>>>>>>
> >>>>>>> You already have my rb tag for those one, and IMHO they should be
> >>>>>>> good
> >>>>>>> candidate
> >>>>>>> for 5.0 (if it's not too late).
> >>>>>>
> >>>>>> Yes, thanks for the reviews. I see Mark Cave-Ayland merged this fi=
le
> >>>>>> first, but you are listed as maintainer :) I was hoping you could
> >>>>>> send a
> >>>>>> pull request.
> >>>>>
> >>>>> Yes that's usually Mark who take the patches, sorry I didn't get it=
.
> >>>>
> >>>> No worries. As there are other sparc64 patches on the list, maybe Ma=
rk
> >>>> will prepare a pull request now.
> >>>>
> >>>>>
> >>>>>>
> >>>>>> $ scripts/get_maintainer.pl -f hw/misc/grlib_ahb_apb_pnp.c
> >>>>>> Fabien Chouteau <chouteau@adacore.com> (maintainer:Leon3)
> >>>>>> KONRAD Frederic <frederic.konrad@adacore.com> (maintainer:Leon3)
> >>>>>> qemu-devel@nongnu.org (open list:All patches CC here)
> >>>>>>
> >>>>>
> >>>>>> This is a bug but not 'security critical', so it might wait 5.1 an=
d go
> >>>>>> via qemu-trivial tree.
> >>>>>
> >>>>> Well let's do that then if you're ok.
> >>>>
> >>>> OK, then ping? :)
> >>>>
> >>>>>
> >>>>> Best Regards,
> >>>>> Fred
> >>>>>
> >>>>>>
> >>>>>> Regards,
> >>>>>>
> >>>>>> Phil.
> >>>>>>
> >>>>>>>
> >>>>>>> Cheers,
> >>>>>>> Fred
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>      hw/misc/grlib_ahb_apb_pnp: Add trace events on read access=
es
> >>>>>>>>>      hw/timer/grlib_gptimer: Display frequency in decimal
> >>>>>>>>>      target/sparc/int32_helper: Remove DEBUG_PCALL definition
> >>>>>>>>>      target/sparc/int32_helper: Extract and use excp_name_str()
> >>>>>>>>>
> >>>>>>>>>     hw/misc/grlib_ahb_apb_pnp.c             | 24
> >>>>>>>>> ++++++++++++++++++++++--
> >>>>>>>>>     target/sparc/int32_helper.c             | 23
> >>>>>>>>> ++++++++++++-----------
> >>>>>>>>>     hw/misc/trace-events                    |  4 ++++
> >>>>>>>>>     hw/timer/trace-events                   |  2 +-
> >>>>>>>>>     tests/acceptance/machine_sparc_leon3.py |  4 ++++
> >>>>>>>>>     5 files changed, 43 insertions(+), 14 deletions(-)
> >>>>>>>>>
> >>>>>>>
> >>>>>
> >>>>
> >>
> >



--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu

