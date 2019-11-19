Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CBBC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 21:36:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F17D620722
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 21:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpXNqtgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17D620722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXBAm-0008Ki-4G
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 16:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXB9w-0007ti-Ua
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 16:35:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXB9v-0003wK-NZ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 16:35:40 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38493)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iXB9v-0003w2-Ip; Tue, 19 Nov 2019 16:35:39 -0500
Received: by mail-oi1-x244.google.com with SMTP id a14so20461619oid.5;
 Tue, 19 Nov 2019 13:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=otk+rBTnVVseVaVDCP5qr8KGPdAqhcdvC79IPBEKfLA=;
 b=DpXNqtgmozC3UoS8CoCJP8NGNAsVj7JVs1lgosqPR0t/IB7xKCd1dJBmkhRzK1/f3N
 ZBHDBNlun/as7MzGFUgQxpPPB/phTpmZCQZQwLCtn4nuYgbyyHx+3RyTI7uutgijVajc
 3emjmZeW1oFlVWiDgIIlViVzn4treY/nNgP/TdQMDuH3MzLaTZ1XCFdxSH0IZ9JQWu1A
 /1Mfc9Z1Kze6d743fAAJlp54KFrSZbQcQ1WBW4ELxICX0wYZIjmvWbL32CSfUx7THfaR
 U7qMaVHP7ooQQVrINqQ35M2yoKISMpo9pFaUZtJEoJCroXagSmndgnCcMfFO0DcikJuH
 rwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=otk+rBTnVVseVaVDCP5qr8KGPdAqhcdvC79IPBEKfLA=;
 b=Huc9DTFXa+/qdkBg2nCOo7AqBIgST3/nLzvzPPQrC2OhI7EjETlew6X9DBCu+C60Xh
 Sxr72XVdzVk+tkL1EKg4P4FjNBNVNuCO7nUYO7pN9oshFh4OIKziii/K5WJa9f3DJ5yG
 bVTnAFYCyoRCqebyk/WcY2JFLEZLtA53NM/KEQ7dzz78MuNG0A9vMbYimbEDyO8mrMV7
 5YajtGjMNKEo5znVPlB+4AHrbVLGoM5JBOFDoVU6w+2rGdSXa3cnaDoY8/G56D+VQsf+
 2tUaHFSVXgzFK1a6yRMIX1vSj55LRig90vWOEN1F3RzgrsXMzC/rNrQb9CBsTNYC0nRm
 VJoQ==
X-Gm-Message-State: APjAAAUzz7t2OgJGoGC6of0YNiVRlyeJAW6Oh3fVTfGEGPHqof6vvZBM
 4cRfNqp0EkzpmnCCVsrZaBpZAxZNVuNZP2AEnjg=
X-Google-Smtp-Source: APXvYqwJ/8cj+bFJJ3AcK794aR9LMVokdOzDwC6kys+Bz9mq3AEIGKsuRP6b+ZfFLdt5r6nTSDn0gwi/gZ+GJ0ierKs=
X-Received: by 2002:aca:484f:: with SMTP id v76mr6175179oia.62.1574199338641; 
 Tue, 19 Nov 2019 13:35:38 -0800 (PST)
MIME-Version: 1.0
References: <20191119204551.240792-1-stefanha@redhat.com>
 <CAL1e-=ibQBWUzUZvsvSWCZ5SwFk5T+b2P94D068W8G_taWVASg@mail.gmail.com>
In-Reply-To: <CAL1e-=ibQBWUzUZvsvSWCZ5SwFk5T+b2P94D068W8G_taWVASg@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 19 Nov 2019 22:35:27 +0100
Message-ID: <CAL1e-=iEN9GEGDzEvoYM9q477Le4rs-mQZEgxOdzr51ZxLJd0w@mail.gmail.com>
Subject: Re: [PULL for-4.2-rc2 0/2] Tracing patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "open list:bochs" <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 19, 2019 at 10:14 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
> On Tue, Nov 19, 2019 at 9:46 PM Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> >
> > The following changes since commit f086f22d6c068ba151b0f6e81e75a64f130d=
f712:
> >
> >   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-fixes-201911=
18.0' into staging (2019-11-18 21:35:48 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/stefanha/qemu.git tags/tracing-pull-request
> >
> > for you to fetch changes up to 6b904f1a528a6d8c21f7fbdeab13b9603d1b6df7=
:
> >
> >   hw/mips/gt64xxx: Remove dynamic field width from trace events (2019-1=
1-19 16:17:05 +0000)
> >
> > ----------------------------------------------------------------
> > Pull request
> >
> > Tracing fixes for MIPS.
> >
> > ----------------------------------------------------------------
> >
>
> Hello, Stefan, Philippe, Peter.
>
> This appears to be a duplicate of the pull request sent today by Philippe
> (and already applied by Peter just hours ago):
>
> https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg02894.html
>
> The patches from the two pull requests appear to be identical, except
> some minor details in commit messages: Stefan's versions contain
> "Message-Id:" identifiers, while Philippe's don't (my suggestion to
> Philippe is to include "Message-Id:" for all patches that are part of any
> pull request in future; this can be achieved effortlessly/automatically
> by applying patches using patchwork).
>
> In summary, for this very situation, it looks to me we are all set, no ne=
ed
> for Peter to process this pull request.
>

And just another really friendly advice for Philippe: When you apply
some patches or a series to your pull request, just inform others
about that by replying to the patches or a series: "I applied XXX to
my queue/pull request" - this helps avoiding duplicate efforts like
it happened here. This is also reminder to me too, I didn't do it in
all cases of my applying to my my pull requests, and I should have,
but I will improve too.

Thanks for these fixes!

Aleksandar

> Regards,
> Aleksandar
>
> > Philippe Mathieu-Daud=C3=A9 (2):
> >   hw/block/pflash: Remove dynamic field width from trace events
> >   hw/mips/gt64xxx: Remove dynamic field width from trace events
> >
> >  hw/block/pflash_cfi01.c |  8 ++++----
> >  hw/block/pflash_cfi02.c |  8 ++++----
> >  hw/block/trace-events   |  8 ++++----
> >  hw/mips/gt64xxx_pci.c   | 16 ++++++++--------
> >  hw/mips/trace-events    |  4 ++--
> >  5 files changed, 22 insertions(+), 22 deletions(-)
> >
> > --
> > 2.23.0
> >
> >

