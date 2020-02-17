Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5D7C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C47206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wjppmEY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C47206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3d4S-0003NU-PP
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 04:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3d3e-0002mo-DC
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:51:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3d3c-0006tt-Vy
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:51:17 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46015)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3d3c-0006r8-Lh
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:51:16 -0500
Received: by mail-ot1-x342.google.com with SMTP id 59so15488270otp.12
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 01:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eIj3pcX+cu38WlJqrjU9icvt5rk8G461KC2HqJqYeUQ=;
 b=wjppmEY8fO4qlqW5SesLwykAsqMJGN4iiYA3vVjFyH19/rOHPYZ/b6P98lNRW2Jftl
 8zteog06c2cfSSDsFJ34Q1H0KNkpLxbl3GLXaKuO0q9Lrz693P/p0OaSuCwh/kmR5UtU
 NqJYhnLIxDF8jebh+0VqSo82GasJ5h6faYgLFGVQk36EOOkxMlmUx6ws70C0YfcJ+TKE
 qiEyTCsRSn8ahLZG/5wPkDjkq/lb6M0VQq19ziWuAeZeXX6nL8gBWaF+8IFMEUwqRmnF
 Oo3dkie+OIwbEziluZZg3KBcmSeVNdtSgRLa9i/3AbbhyAekLdLItTO5PGWGat8Br3UF
 WhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eIj3pcX+cu38WlJqrjU9icvt5rk8G461KC2HqJqYeUQ=;
 b=SYM5Sa77F6p5zvrtWZLn55lt38z2xFLH0lqI0SP9+1qgltemxe/D0IHdK6NPMJuLri
 dyZ4rsiRD+Ty+w4KZRn3QxIjKXKJIAMwiBAcvpy0rAfivPKeXXxMzu6UmhX2WIdPjh89
 InG0SJ4H6TehENtJCqn4z7wO8Ch5l+dG2UyuISCfxsKo+tZGqSP98qGMqut+qVsB/Pc8
 eWRczWcuT8VoTQy2VG9LCpgn03aZ0q57zCWg+lfAND/9eLqSUT7C0e1IcmimYGv+/yQz
 lFoaWJuEW5JKqDQa471QGOQghaAs/ufR1/5CLWH1TjRfDf0taQ3ChRyxRYrdhFjGnuOF
 B2cQ==
X-Gm-Message-State: APjAAAW2Y7m6boajT6fvTDjUOAm/IDkEVPpH96d5lZ509SiPlykilBuA
 GhFKylxDAm2QYscNKJK3TNXT1u4lDZQBD9zCth2npw==
X-Google-Smtp-Source: APXvYqwjynN2Zdzqe5f4HwZrEobUG2HbagjiAi1WbQn3Q33BR1A2PM0a5Z40PuhqRtcg1dO0l4P3w8R1oznCU1Y4Gj8=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr10787927otq.97.1581933075601; 
 Mon, 17 Feb 2020 01:51:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581904461.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1581904461.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2020 09:51:04 +0000
Message-ID: <CAFEAcA8zGoFt7TyocG-HEezdsNFoiyT=OWgZdr4qFf7JUSaLkQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Enable hardfloat for PPC
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 John Arbuckle <programmingkidx@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paul Clarke <pc@us.ibm.com>, Howard Spoelstra <hsp.cat7@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Feb 2020 at 02:43, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> Hello,
>
> This is an RFC series to start exploring the possibility of enabling
> hardfloat for PPC target that haven't progressed in the last two years.
> Hopefully we can work out something now. Previously I've explored this
> here:
>
> https://lists.nongnu.org/archive/html/qemu-ppc/2018-07/msg00261.html
>
> where some ad-hoc benchmarks using lame mp3 encoder is also explained
> that has two versions: one using VMX and another only using FP. Both
> are mostly floating point bounded. I've run this test on mac99 under
> MorphOS before and after my patches, also verifying that md5sum of
> resulting mp3 matches (this is no proof for correctness but maybe
> shows it did not break too much at least those ops used by this
> program).

> I hope others can contribute to this by doing more testing to find out
> what else this would break or give some ideas how this could be
> improved.

I think the ideal would be to test against a reference using
risu to see whether this changes behaviour (FP results should
be bit-for-bit identical; usually application level testing is
often not sufficient to detect this). You could test either
against real hardware or against the non-hardfloat QEMU.
I'm not sure how comprehensive the coverage for ppc insns
is but there are a fair number of fp insns covered already:
https://git.linaro.org/people/peter.maydell/risu.git/tree/

It's also worth testing any alternate/non-standard config
modes the FPU might have (eg different default rounding modes,
any flush-to-zero or alternate denormal handling, that kind
of thing), and not just the default how-the-CPU-boots-up mode.

thanks
-- PMM

