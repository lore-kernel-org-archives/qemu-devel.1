Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E3DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:35:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E9ED204EA
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbusDdVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E9ED204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jizxA-0003Mf-QW
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 08:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jizke-0006cV-Ca; Wed, 10 Jun 2020 08:22:41 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33669)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jizkc-0008Iu-Mw; Wed, 10 Jun 2020 08:22:40 -0400
Received: by mail-wr1-x443.google.com with SMTP id l11so2055885wru.0;
 Wed, 10 Jun 2020 05:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=H0sdQdgQplvvjh9X7YgkX6cmx596uRFI9hwBtgM9XZc=;
 b=UbusDdVvDckuEbxbbVPg2hXX52AH1pryr+x4fmO6aBYMQKq4mpwu/txUw40p/jnviM
 /71ljl3xPZf8TVQr2cVfhZT5qgwVMN/gA4aBtalINx+sqR4rfgWIUXea6apBWZAg4miD
 DG+FlUayRlQbLhzVRYYS/9TBjuGXw727kS6L8I+TL089RItglFb1Lhsw5cwYEFO1wEeo
 PINQVlr/OFiVV9VtNmwVrkNbjO2pMeYN0uHO9fxukM5zeRbkeqFkOZzRqPEqtMEhl6T4
 JH7f5Uxgwv8oTb9s4zjdVpXa42ApNHsmgE8CTYnrheGghFRAelmjU7AyzX15voVxwopI
 UR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=H0sdQdgQplvvjh9X7YgkX6cmx596uRFI9hwBtgM9XZc=;
 b=ET6mB+feWtj6w4myUOFTkiGbIwkF+e7CwZX90Vlu+cxNhuqAFUt5uleHy0dLurauU5
 s8Pa8cKFNXy7uxzeDdoD+UePWYGHz8Kux5o+Njy3qskulrQ3QC5kd1mmb4veBrwwzRAV
 ru5rJuT62l0D+63AkiDSwltBmv5wlEpAEs7uJqqdZXN2caicejkJR/SgUWDLHxpdqSKI
 1eNw51ck9cxohivWlCLTxTHYr2GzR9uSmmmRiCw/mwT9+C0Yb1Et3aaMSnlwQyQf+Sm/
 obDR8mtrO56b9e98sSRuA7dhrARj/9Gz/2O4vKoGS8opwc5Zo+6Oi/swOY5ffvICUBDj
 +M0A==
X-Gm-Message-State: AOAM5308/sMeUdmMs9AX8pjPHNpJnkjvXQxjC8W4jytg9d50bPHiEH7g
 Tnk6CAFC2CfROke+YkB4KEZzjopJcpzBCMCD9xA=
X-Google-Smtp-Source: ABdhPJw5XJDUN0EUy/lP6gp2osGvlB1+QxzTe7gril4Kt7/0HrGWngH803gkS0e9B6ndLIO8Y12f16VHheO3fHoqAQY=
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr3397771wrv.162.1591791757094; 
 Wed, 10 Jun 2020 05:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200608090142.6793-1-f4bug@amsat.org>
 <20200608090142.6793-2-f4bug@amsat.org>
 <CAHiYmc5UUaSKB6Ee0ds_hj0FBTzt0iLxzNWySt0mcZ9dvtZNyA@mail.gmail.com>
 <2503a468-d343-b40a-bf4e-628f3e8f56e3@amsat.org>
In-Reply-To: <2503a468-d343-b40a-bf4e-628f3e8f56e3@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 10 Jun 2020 14:22:23 +0200
Message-ID: <CAHiYmc4Bu2QEGkdcDGf0YJzsp2sWDHKoLWH+Pzf_icQXv6XC6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] MAINTAINERS: Mark SH4 hardware orphan
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=81=D1=80=D0=B5, 10. =D1=98=D1=83=D0=BD 2020. =D1=83 14:06 Philippe Math=
ieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 6/10/20 1:08 PM, Aleksandar Markovic wrote:
> > =D0=BF=D0=BE=D0=BD, 8. =D1=98=D1=83=D0=BD 2020. =D1=83 11:05 Philippe M=
athieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
> > =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >>
> >> Aurelien Jarno expressed his desire to orphan the SH4 hardware [*]:
> >>
> >>   I don't mind being [...] removed from there.
> >>   I do not really have time to work on that.
> >>
> >> Mark the SH4 emulated hardware orphan.
> >>
> >> Many thanks to Aurelien for his substantial contributions to QEMU,
> >> and for maintaining the SH4 hardware for various years!
> >>
> >> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg708400.html
> >>
> >> Message-Id: <20200601214125.GA1924990@aurel32.net>
> >> Acked-by: Aurelien Jarno <aurelien@aurel32.net>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> ---
> >
> > The basic idea of the patch (as read from the title and the commit
> > message) is good and positive.
> >
> > The problem is that the patch does something different than the commit
> > message says - pretending that it just orphans something. Which is not
> > good. Actually, very clumsy and bad.
>
> I can improve my English (actually I am trying, I started to take
> lessons 2 years ago). Remember it is not easy for non native English
> speaker to elaborate non-technical topics.
> As a side note, it is also hard sometimes to understand contributors who
> uses a very advanced English level with fancy words, as we have to take
> the time to translate to understand. Even if we learn new word, this is
> not often the best use of our time.
>
> > It creates a whole new subsection in MAINTAINERS file (not said in the
> > commit message), without any consistency with the current organization
> > in the file. That new subsection looks completely misplaced, living
> > with "TCG CPUs" neighbours. On top of that, it creates a new
> > precedent, leaving many unanswered questions, like: Should other
> > targets follow the same pattern?
>
> If you look at git-log history, you'll see at the beginning there
> were not much separations in directories. Everything was altogether.
> Adding a new machine meant add the TCG emulation code and the hardware.
> The contributor adding TCG emulation was doing the harder work,
> usually doing it for a particular machine (hardware). Then other
> contributors could add other machines, and were maintaining only
> their machines. See commit b6f97c14f59 importing the short
> MAINTAINERS from SVN. It was already split in 3 broad categories:
> - TCG cores
> - Machines / Hardware
> - Subsystems (the rest)
>
> In October 2010 (fd5d5c566af0) Anthony Liguori rewrote MAINTAINERS
> using Linux style tags.
>
> In January 2011 (42f5a7e9367) Aurelien Jarno clarified the
> difference between the TCG host part (backend, under the tcg/
> directory) VS the target part (frontend, under target/).
>
> Then the project grew, and eventually in May 2012 Paolo Bonzini
> started to clean, by moving files into "subsystem" directories
> (see 5e8861a0361..c353f261946). In March 2013 he followed by
> splitting various hardware files from the hw/ directory
> (see 0d09e41a51a..47b43a1f414).
>
> In November 2013 (f05b328c9d8) Stefan Hajnoczi clarified the
> importance of the 'block' subsystem (later completed in
> commit e7c6e631b1 in April 2015).
>
> 2015 still, Paolo keeps cleaning (c17652ee409 cover the
> TCG backend disassembler, 062710000db introduce Peter
> Maydell for the ARM hardware).
>
> In October 2018 Thomas Huth added the target/ folder
> (commit fcf5ef2ab).
>
> Recently last year (6347e1f1cc7) Markus Armbruster tried
> to better describe the TCG frontend ("Overall TCG CPUs")
> and backend ("TCG target") differences.
>
>
> So while the difference between TCG emulation (or other
> accelerators, KVM, ...) versus the hardware emulation is
> not perfect, there is a separation (and the community
> failed at clarifying it).
>
> You can see when you were introduced as maintainer for the
> MIPS target (commit c92023bfd) you were also added as
> maintainer of the MIPSSIM and Fuloong 2E machines.
>
> In commit 485cd9820 you volunteered to maintain the Malta
> machine, so I believe you have a good understanding about
> the difference between target code and hardware code.
>
> >
> > I personally think that creating a new subsection is just a code
> > churn, waste of everybody's time on unimportant things.
>
> Eh... I read that after spending 1h writing the previous
> paragraph. Yes, you are right.
>
> >
> > Wouldn't it be simpler that you just changed statuses of all Aurelien
> > sh4 sections to "Orphaned", as he already said he approves, and leave
> > sh4 sections reorganization to a future maintainer?
> >
> > If you really want to reorganize sh4 sections, these changes should be
> > in a separate patch. "Orphaning" patch should contain only changes of
> > statuses.
>
> Good idea! Maybe if you send a patch to show me how to do it, it
> will be easier to understand what you mean.
>
> Thanks for also caring about the SH4 hardware, the code was
> prone to bitrot and needed maintainer to look after it.
>

Thank you very much for the analysis above, Philippe.

I think the whole thing is blown out of proportions, possibly to a
great degree by my fault.

Again, I think it is this simple: Yoshimori has the best conditions
among us for maintaining rx and sh4, he needs it, he wants it - and we
just give it to him.

Nothing more and nothing less.

Regards,
Aleksandar

> Regards,
>
> Phil.
>
> >
> > Regards,
> > Aleksandar
> >
> >>  MAINTAINERS | 10 ++++++++--
> >>  1 file changed, 8 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 6e7890ce82..49d90c70de 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -299,9 +299,7 @@ SH4 TCG CPUs
> >>  M: Aurelien Jarno <aurelien@aurel32.net>
> >>  S: Odd Fixes
> >>  F: target/sh4/
> >> -F: hw/sh4/
> >>  F: disas/sh4.c
> >> -F: include/hw/sh4/
> >>
> >>  SPARC TCG CPUs
> >>  M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >> @@ -1948,6 +1946,14 @@ F: hw/*/*xive*
> >>  F: include/hw/*/*xive*
> >>  F: docs/*/*xive*
> >>
> >> +SH4 Hardware
> >> +S: Orphan
> >> +F: hw/sh4/
> >> +F: hw/char/sh_serial.c
> >> +F: hw/intc/sh_intc.c
> >> +F: hw/timer/sh_timer.c
> >> +F: include/hw/sh4/
> >> +
> >>  Subsystems
> >>  ----------
> >>  Audio
> >> --
> >> 2.21.3
> >>
> >>
> >

