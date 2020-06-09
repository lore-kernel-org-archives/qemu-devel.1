Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A107DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:01:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 656DE206D5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTFUyf0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656DE206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jia8C-0003WC-Lp
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 05:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnus.damm@gmail.com>)
 id 1jia7E-000339-Sg; Tue, 09 Jun 2020 05:00:16 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:37844)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <magnus.damm@gmail.com>)
 id 1jia7C-0005NR-Rk; Tue, 09 Jun 2020 05:00:16 -0400
Received: by mail-lf1-x142.google.com with SMTP id x22so12008532lfd.4;
 Tue, 09 Jun 2020 02:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4IWGewx+sP2AfwnMFE8x0hhwFq9mhA4cIVjaj3kUazA=;
 b=iTFUyf0yPgrRxAV+/r8ENC9OShwFBW9IXuUOYhsc8XAik88HInu7a5Nc+drW6QcSeQ
 ScITqe0U2277dec5xtK3bd9n6NMD3JzHfLDNgM760J6PvknzmuS9ktpgrGQh+/VI3P60
 6kyWXUrRTKKlTidHwY9p+FZRjCzuCpyTE+VbTHncglWQnZifQXagCA2nq7MPyJ0ZFleA
 qd0GRfZjImQmvdTG+1SuiWAcCHW3A8i22Dy+DHdro95ZaiB7LkGMgTHdYZINLDCwFANg
 5WDyRuW6eYFuppjibXHR2Jey3b4/4+0JdUyEoQvSNvSQpjGpcXYYtaCDLRKkFlwWyMUU
 NIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4IWGewx+sP2AfwnMFE8x0hhwFq9mhA4cIVjaj3kUazA=;
 b=nf10OdpHhS8oeNbeF79EXhPuVsVAKyN9allWftgoodnI0PzjSl0Gn4eRML0BlvsGqN
 6flrRlvS+wlMEf1CggPJyc2rV+95mdi6zPbLt7HhnRNE/pX0YGkmVZICU1Z6sud/h+zT
 lh00n9iPwpdWfR9DH/F20KGYPPOF52fE5E6v+6PIFz0pZ1oOAl6R2/J7cyam1Jo0dURs
 f2dhQBP07ay5kJyTsfUb8+fn1hn8wlafauHxPjbTV0nqbW/VxxU/Ojn8KNMo63o1U461
 g1qblqCMZ1R349TqnLgmbe3gHBBfnoFPvbQy9Cw1yzVdreDNxfYn2WR76wWFxIpIE7Ff
 8A8Q==
X-Gm-Message-State: AOAM533lQEP3DAX2RQb9lUeGGnAl6GaOTlUW/U0i6XlkVyJJk6qjW50h
 OyC0HQIkabT/E0lGZNcmVYRWZZS1ICjSaZW/Z80=
X-Google-Smtp-Source: ABdhPJwmQLNYNvvBWOXd0Tof2LiD36GFn8+cb68IWE/HIojpw6yBRT/F3a84QLabs655nnkJg/N4OW9idGagOnHGdwg=
X-Received: by 2002:a05:6512:3214:: with SMTP id
 d20mr15000947lfe.203.1591693211796; 
 Tue, 09 Jun 2020 02:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200608090142.6793-1-f4bug@amsat.org>
 <20200608090142.6793-3-f4bug@amsat.org>
 <8f97580c-bf25-dd83-e23e-dcea1e6ce6b7@redhat.com>
 <875zc0skab.fsf@dusky.pond.sub.org>
In-Reply-To: <875zc0skab.fsf@dusky.pond.sub.org>
From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 9 Jun 2020 17:59:59 +0900
Message-ID: <CANqRtoRwWksb8zngFqJnJg-gNs5_M_NoFZ1Y=A8mHK0NfCFBCg@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] MAINTAINERS: Mark SH4 based R2D & Shix machines
 orphan
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=magnus.damm@gmail.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Markus and Thomas,

On Tue, Jun 9, 2020 at 5:41 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Thomas Huth <thuth@redhat.com> writes:
>
> > On 08/06/2020 11.01, Philippe Mathieu-Daud=C3=A9 wrote:
> >> Last commit from Magnus Damm is fc8e320ef583, which date is
> >> Fri Nov 13 2009.  As nobody else seems to care about the patches
> >> posted [*] related to the R2D and Shix machines, mark them orphan.
> >>
> >> Many thanks to Magnus for his substantial contributions to QEMU,
> >> and for introducing these SH4 based machine!
>
> s/machine/machines/
>
> >>
> >> [*] https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08519.htm=
l
> >>
> >> Cc: Magnus Damm <magnus.damm@gmail.com>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> ---
> >>  MAINTAINERS | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 49d90c70de..a012d9b74e 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -1250,14 +1250,15 @@ SH4 Machines
> >>  ------------
> >>  R2D
> >>  M: Magnus Damm <magnus.damm@gmail.com>
> >> -S: Maintained
> >> +S: Orphan
> >>  F: hw/sh4/r2d.c
> >>  F: hw/intc/sh_intc.c
> >>  F: hw/timer/sh_timer.c
> >> +F: include/hw/sh4/sh_intc.h
> >>
> >>  Shix
> >>  M: Magnus Damm <magnus.damm@gmail.com>
> >> -S: Odd Fixes
> >> +S: Orphan
> >>  F: hw/sh4/shix.c
> >
> > Having both, an "M:" entry and "S: Orphan" in a section sounds weird.
> > Magnus, are you still interested in these sections? If not, I think the
> > "M:" line should be removed...?
>
> Concur.  Of course, let's give Magnus a chance to chime in.

Thanks guys! I'm interested but don't have so much time available to
commit to this I'm afraid. In particular I'm keen on trying to keep
R2D around since I happen to have a physical machine setup in my
remote access rack. SH4 with FPU used to have alright gcc + binutils
toolchain and glibc support once while other SuperH SoCs lacked some
portions. So keeping SH4 (sh775x) around would be nice IMO.

Cheers,

/ magnus

