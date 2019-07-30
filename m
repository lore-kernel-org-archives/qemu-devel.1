Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D6FC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 20:14:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B675420693
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 20:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/b9kbzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B675420693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsYWM-0007Ww-UD
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 16:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35467)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hsYVw-00075R-0b
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 16:14:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hsYVu-0001JA-Rv
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 16:14:27 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42648)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hsYVu-0001II-Kg
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 16:14:26 -0400
Received: by mail-ot1-x344.google.com with SMTP id l15so67669169otn.9
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 13:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cBupFCyDa7co+AJRr/kE6UCt0zeQsm5fgwgpp3u7VEE=;
 b=R/b9kbzPt33HIfgTeuyc/09DCU28I/xquuvpr4L0w4vBy8RVRtXDO+dw0V2E+rhww5
 9Porx2RkclBU/H0SwPxLSExXzQst3ICmm6+NsJLd0toyWKkaWszLl8Nz2E76qNfLyH4+
 wqfiTfI+WL0ZqhBViRf+vr4dOqeM69zNFTJ2F9Aqha2JaUeDRH5b+EQ1CKxi5UscATB1
 H/VshYRfRA47rXH8bb9PDO2IWmG1Ddd4OcpQ9Bsq8IPVj9j1r39+utQii0x8X1nV6rHH
 mG751E7gvXUEaXh8R8QIcrsGGjruSh+jYvpW8pCqpS3NpooXZXi07nAgE/l+AbOStPbZ
 wCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cBupFCyDa7co+AJRr/kE6UCt0zeQsm5fgwgpp3u7VEE=;
 b=roBhI+tUQHyY4Q79RWZc1ZZh4qI5Jo75LOi5YAtd6vnWoWqhkBzw58Gwuk9uoVgrd2
 w/07g8i1P6jjsX0+nA5Uzn6uFOq+rsbCHeCahiLHLWqcTHKC94+p7sHmUL00L9HkuNsw
 hZN4TOmYCeIB3VMlScgtJL8296Y2xhQMT5pDtDc8NP0Zkl8n4CoSfVfm2gw86ryMsUBG
 95StWWL7fTVEN1yAKE2aGz1sNcJCrvMLn4Pj5EujJzuuipQGtPUAA0Eq1nWlIQafKMOx
 NRUGKzZX5Q32diVwSMsY4dD2EK0Il9KHMEmuyhNGQq5vOfc2QhFbxl55VjuO5O2tjiYn
 vngQ==
X-Gm-Message-State: APjAAAX0I4jBx4puY2Ef48mL7+X4/jE9J3KztDBc/nrQ5Lx5yt2PFQG1
 YrgVBD0ef5X2sHuk/Ur20EPNQ1jQcDLGb6Axax8=
X-Google-Smtp-Source: APXvYqw/qRFkRS1Q/jJNHzVCVxMIudOBH/8wGzdxALsBvRnkuKkuptuDl+2s0KPSzT/IQcyNeLfrCmad/DkM0S/BCJw=
X-Received: by 2002:a9d:6ad7:: with SMTP id m23mr85660044otq.306.1564517665822; 
 Tue, 30 Jul 2019 13:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <8a5c6ca782b64899b7d6fbf47e8e6869@tpw09926dag18e.domain1.systemhost.net>
 <1564017946033.57669@bt.com>
 <CAL1e-=iGAiPdsbeVjs=LJWT7pMQCO-MgriS8DJDXtXXQd8xYiQ@mail.gmail.com>
 <CAFEAcA-s6zEtZ73mBjw0S7r4+y=EJ=4jPqKX57rdTOeTvQCeRQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-s6zEtZ73mBjw0S7r4+y=EJ=4jPqKX57rdTOeTvQCeRQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 30 Jul 2019 22:14:15 +0200
Message-ID: <CAL1e-=izLDXOQhFc1z84pEfBAr9SiQmSvN3-cSOawRMXP44oGw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v3 1/1] configure: Define target access
 alignment in configure
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
Cc: tony.nguyen@bt.com, Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 30, 2019 at 10:06 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Tue, 30 Jul 2019 at 21:00, Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
> >
> > On Thu, Jul 25, 2019 at 3:25 AM <tony.nguyen@bt.com> wrote:
> >
> > > Rename ALIGNED_ONLY to TARGET_ALIGNED_ONLY for clarity and move
> > > defines out of target/foo/cpu.h into configure, as we do with
> > > TARGET_WORDS_BIGENDIAN, so that it is always defined early.
> > >
> > > Also, poison the symbol in include/exec/poison.h to prevent use in
> > > common code.
> > >
> > >
> > Hi, Tony.
> >
> > Thanks for this new version.
> >
> > When one mentions "also" in the commit message, this is a kind of strong
> > indication that the patch should be split into two patches.
> >
> > So, could you please consider moving "poison" part into a separate patch?
>
> I think in this case the issue is more in the phrasing of the commit
> message rather than the patch composition. The patch is
> introducing TARGET_ALIGNED_ONLY as something defined
> by configure, and the correct status for that macro is "needs to
> be in poison.h"; having an intermediate state where the macro
> exists but isn't poisoned isn't really a logical split of the work.
> (The previous ALIGNED_ONLY didn't have so much need to be
> poisoned because it was defined in cpu.h and so the only way to
> expect to get it was by pulling in cpu.h.)
>
>
Yes, I would say the same now that I am looking at the change more
carefully.

But then, repeating what you said, something like "poisoning is needed"
(together with an explanation "why") should be in the commit message.
"Also" doesn't not fit well here.

Aleksandar


> thanks
> -- PMM
>
