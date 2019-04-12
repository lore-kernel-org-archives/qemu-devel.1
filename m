Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3151C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 03:32:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 691DC20675
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 03:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cse.mrt.ac.lk header.i=@cse.mrt.ac.lk header.b="AWVMJCR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691DC20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cse.mrt.ac.lk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58264 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEmv5-0004hZ-H6
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 23:32:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hEmu5-0004Hh-Jm
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 23:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hEmu3-00019F-B2
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 23:31:01 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aruna.15@cse.mrt.ac.lk>)
	id 1hEmu2-00016b-Ey
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 23:30:59 -0400
Received: by mail-wr1-x443.google.com with SMTP id t17so9928863wrw.13
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 20:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cse.mrt.ac.lk; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=zSjtjUNvqnJTVTEUMLGDSxylmm2UCGBKLw9BUM/FoWo=;
	b=AWVMJCR0gj+dmgFJKTCY4SlLDLc6rdUGxz/BO3fY+LGlTpL6iECm9DAAh2ajP9FGhA
	48n5DTOTPbIgI56eVF0aCwRPz+9nayfto8P63VorDJCx9yYPVHXDQ5mXoYLfhCzpNNyp
	f3wCC+ErCefbORGnLzFcM4EQpGvTLCGi9Gd06fWQrRvsriVcJkYXTc00FMdJyYI5tLpP
	ardDU/lqSpt1LoGl09qh+J4Ogr+nyjZAdJka93ZY/ejOaIHxWqM5ithU321mWISKZsy/
	HrTADFuR4Kj5hqA/iaNsFkYW+1rQQ1YqiJyvMooa/zzEQXssCpVR/pU9ffk9rq8e3AUa
	Xo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=zSjtjUNvqnJTVTEUMLGDSxylmm2UCGBKLw9BUM/FoWo=;
	b=ZQ1aFkb5kN+qKgUBNHVV456ah6kmmIrsbcyEQ0QRCcjf7Ydx/pkVJK5WUSPHz4o9ss
	UE9gkvoVVJrZ5FOkWrSneV+2Fe8UcFHX1/cvCfEliIe/s6XZInCw6IheE0g2bye05Kly
	s1Y3vRg56kk+LEYN2t7LxcscUtMDJq6mTQMcswYL1Bw2221U/EdOVEgihCfN4IZQU4tJ
	NFNnSW/ekZOYTOagTnfGNrXjSuXgHICCQ61A/SaWejaIOSeZPIdGkgS4X/7tH8v0wfu9
	VTLxo/guA6ySn3dsYKcwIQbsajOVIYaJ8/Kgm9uZQuaU2gEFgyq8r5rBymHwc2FZPMEE
	jB1A==
X-Gm-Message-State: APjAAAWtWSc1jKrgzcoTndRigU0s2jPTZADQpEDg3qf+ImP8zh47y6Qs
	qitTWlt8R0OgtIGlwiVc1URiSczLturoFSuj3d5u7Q==
X-Google-Smtp-Source: APXvYqyRag+GCBwdEqTTeSp3jpFtFcORQuu8AYHqFUWTt5Ru7XehUovOZAq11MV+BE3PhsxscR5DBBGiRf0hXCR9U/M=
X-Received: by 2002:adf:dc88:: with SMTP id r8mr11873620wrj.28.1555039855120; 
	Thu, 11 Apr 2019 20:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190409155635.10276-1-aruna.15@cse.mrt.ac.lk>
	<CAFEAcA-k0KEsjb0VvbhhkpvTN7nFBDNtqKwx-Lai5uYbCkztJA@mail.gmail.com>
	<CAH95U0j6rHGdZj4B8DK-Ty-SqZHMb3Kmg16w+j3jx5bdkeijLQ@mail.gmail.com>
	<CAFEAcA9DSaZE-dsKV4321meT2hBEJRLmWBLF0U5o0jG=mzcmRA@mail.gmail.com>
	<87d0lu4exq.fsf@dusky.pond.sub.org>
	<d18656fb-332b-5e01-cb86-efa692ff5daa@vivier.eu>
In-Reply-To: <d18656fb-332b-5e01-cb86-efa692ff5daa@vivier.eu>
From: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Date: Fri, 12 Apr 2019 09:00:43 +0530
Message-ID:
 <CAH95U0hA9gKrws5xfTo8yqi92-doM+NsEa-K=9QxL-9BkHa_VQ@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [Qemu-trivial]  [PATCH 0/4] Header cleanups
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
	Peter Maydell <peter.maydell@linaro.org>,
	Markus Armbruster <armbru@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412033043.6J-MJQ3xI-3eqlxm1koho4PJtXBkZ3tge9QqUm7tp9E@z>

Thanks!

On Fri, Apr 12, 2019 at 1:50 AM, Laurent Vivier <laurent@vivier.eu> wrote:

> On 10/04/2019 07:17, Markus Armbruster wrote:
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >
> >> On Tue, 9 Apr 2019 at 17:42, Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
> wrote:
> >>>
> >>> Yeah this is a stand alone patch.
> >>
> >> OK, thanks -- just wanted to check there wasn't a missing
> >> bit. I think this could go in via the qemu-trivial tree
> >> so I have cc'd them.
> >>
> >> We're in the middle of a release at the moment, but we
> >> should reopen for development in a couple of weeks. If
> >> this patch still hasn't gone anywhere by a week or so after
> >> that then please follow up with a 'ping' to check it hasn't
> >> been forgotten by accident.
> >
> > Hopefully, qemu-trivial won't wait for the next development cycle to
> > begin just to queue patches for it.
> >
> > Regardless, patch submitters should watch their patches and inquire whe=
n
> > they don't get up within a reasonable time frame.  Normally, waiting fo=
r
> > two weeks feels about right.  Perhaps give it an extra week or so when
> > the release circus is in town (like now).
> >
>
> Applied to my trivial-patches branch.
>
> Thanks,
> Laurent
>
--=20
*Aruna* Jayasena
Embedded Systems and Computer Science Engineering Undergraduate
University of Moratuwa
*=E2=9C=86 **+94719872152 *
=E2=9C=89 <aruna.15@cse.mrt.ac.lk> =E2=8C=A8 <http://archfx.github.io> in
<https://www.linkedin.com/in/arunajayasena/>
