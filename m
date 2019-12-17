Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F3DC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26A8A2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B55oxhTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A8A2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihHV6-000733-Ct
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 13:23:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ihHU3-0005zd-J4
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:22:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ihHU2-00022l-IX
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:22:11 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:46263)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ihHU2-00021e-DI
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:22:10 -0500
Received: by mail-ot1-x330.google.com with SMTP id c22so3496911otj.13
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 10:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Vz86b3WTAfSjD6rcKjhZrP0ZAplU7XkOqGN6prAlIsE=;
 b=B55oxhTaOoqYrXo08xCdJ9jSvRhz21F1KxFviJbsOtgVaGv0eZ/ujGcN7EYOOlgvPe
 2ouPJQUrW50Nifm9ZcaIAyhqqn2vpMg4kpcuVlpOm4nryH7e3WihbfmHvWGEHpB7kiFp
 Rd4u6O9VwneuIi+3a+5x2AxENDJBaX1fxD/wYN3oLj6nPu0M7UHDbkDCPrOJvAdt8vY/
 eJjmUWtFfBMVuVp56OX82PMMRkMx/LKuY5jT+qpYERwty66+rw3fR4VmpLUL4coXD2yF
 sFbln1uzBgWpTk/+iGOjKpOeAXrTVyITJhdlIujNFQw6j5iGSrTrW3/Qvt+bOEb/O3cg
 vKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Vz86b3WTAfSjD6rcKjhZrP0ZAplU7XkOqGN6prAlIsE=;
 b=BbDMsp/1pPyMuCCWtWVMEf7eC8Xsv8H98TwmRh9lJjyDcP3C2TkfCGBvBXuLv84O1N
 yhNzsAQvqEKB4SxPFEB8vS8DkXehink06CoH8RqVJs7z1RxaNRAvGOyYnesyHzA2VEzh
 4BeLe9+FDZtPsvDelabX6Ppmx20wSjLVnJz1GnZn/KctX1JBpZZeIexSglUH24ovZ1Qt
 DYNLPjPJsmXfdwX1yfffFDUvjrcrXYYuEGMKfz5JCYJduISq62/oFS3M0V4T/r3hAaKw
 kW3+9l819OnnpmDcYBnJJw3vLXI3tvRW040uoe8tVDGsJcbhrMwwICSZ1rN7emtMlHuk
 Vz5Q==
X-Gm-Message-State: APjAAAUZXvJIooQFjuRW/ubGGYrxAWNB1mQRm7ti21EBwPlpetY285fB
 q9vVcFW6CKx8Rrt2MfZTC22j8upyeEA6Bi9RAZloyg==
X-Google-Smtp-Source: APXvYqxt/4Jd1Pj2Xu3KLe9ve3azbW6+G75xnddO/j5XV6enEF/wcaPV8y/be9E0Q9vCig9i7OghKUre6mZO1bxP9XI=
X-Received: by 2002:a9d:6745:: with SMTP id w5mr37128302otm.221.1576606929532; 
 Tue, 17 Dec 2019 10:22:09 -0800 (PST)
MIME-Version: 1.0
References: <1576605445-28158-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA96uWaOD0wN5g6Q7+eMH-RbkiCYo-aE-d_KvkSFVmUP3Q@mail.gmail.com>
 <bd58ac3a-0430-a3ae-a438-2473ef5d80ea@redhat.com>
In-Reply-To: <bd58ac3a-0430-a3ae-a438-2473ef5d80ea@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Dec 2019 18:21:58 +0000
Message-ID: <CAFEAcA_G2O-GRTUzcHcE4e7=Mdrjeju33utbr=gfB-Y5_vcfGA@mail.gmail.com>
Subject: Re: [PULL v2 00/62] Misc patches for 2019-12-16
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Dec 2019 at 18:21, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 17/12/19 19:13, Peter Maydell wrote:
> > On Tue, 17 Dec 2019 at 17:59, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
> >>
> >> The following changes since commit 084a398bf8aa7634738e6c6c0103236ee1b=
3b72f:
> >>
> >>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-reque=
st' into staging (2019-12-13 18:14:07 +0000)
> >>
> >> are available in the git repository at:
> >>
> >>
> >>   git://github.com/bonzini/qemu.git tags/for-upstream
> >>
> >> for you to fetch changes up to 74c14076700436f9d340652042c81f46eaf0cf9=
f:
> >>
> >>   colo: fix return without releasing RCU (2019-12-17 14:03:44 +0100)
> >>
> >> ----------------------------------------------------------------
> >> * More uses of RCU_READ_LOCK_GUARD (Dave, myself)
> >> * QOM doc improvments (Greg)
> >> * Cleanups from the Meson conversion (Marc-Andr=C3=A9)
> >> * Support for multiple -accel options (myself)
> >> * Many x86 machine cleanup (Philippe, myself)
> >> * tests/migration-test cleanup (Juan)

> > I could probably figure out the resolution but I'm about 5 minutes
> > from having to leave the office; sorry.
>
> I pushed a merge commit to the same place.

A what? I can't merge a merge commit. Just fix the series
and resend, please.

-- PMM

