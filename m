Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB95C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 17:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42474206DB
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 17:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b3I4cR+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42474206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHsgl-00018E-Co
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 13:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHsg5-0000fz-Kk
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 13:21:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHsg4-00017V-Df
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 13:21:53 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:43824)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHsg3-00014Y-Tm
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 13:21:52 -0400
Received: by mail-lj1-x243.google.com with SMTP id g27so10971195ljn.10
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 10:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NOgMP/LsvGYVv9dfR/2BbxGhuZaI5rvVvSUr86nrsiA=;
 b=b3I4cR+k4Q+OGyQKetSVRDfF+Qm5lyw/t6euOXcQzwaaM3ZqucDXGu12bGUVRYzJ3P
 jv3j17G9MD/tKsgTwzE5C/U3xhx42DpZEEzm7vf5YzQ0Xalg9Db+biPlGafGqkjeVBdO
 BXHhP0+UVHvUfVBIHxYwpGCbMdO0dfASl4r4q5OHOVPY/tZNqHRScsjIi41uSwj5hdHy
 NizqO/+oThZ/NWMF/6XbrS+7B5VeMlcheznnZCRKX4XBdGjUu7Hce/Cvj8CQx3zswTi/
 9sEuR4NF1gYCNfGLbAA8F1jnBhDuDiPrqEvL+yRTU7TbjYSGa0S+DQC8t57O+cLdnZh0
 4qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NOgMP/LsvGYVv9dfR/2BbxGhuZaI5rvVvSUr86nrsiA=;
 b=cvZ6MXrySCxJ1it3W1Bsb82wWUvpOStq0FPGDSNHs3Ett6cDZxLgso1uEmqLxoCBWW
 IvNP3Cush5qhUNcaVDxwkvwAULLYRo8BbZSZ4JOR1v1ynYKrHZys4BEg+m9mpVqLZHdk
 pMUBHhGqEjcV2MsG1kY97WFAEEVoH0AzcpSkVLZQR/VPF2IfnLf/Qx+gWy0E4si/6KL9
 lfIo/fHjG6uY9DHuXhDy5T2ofWnIm4MKumQBoBNs8yz98czC9qiQ+kLsNyXAzlbWSFVs
 Zc/bQ4iky/18n/A+j65+eqrfaGfDpfeUXFumrNo55u3tBspJgauEmWZeE4LtlJJ/U1Vm
 R+gA==
X-Gm-Message-State: AGi0Pub9HmS6NBd41BspoK+ScHbJLog2jIlTObBgVsRcTkHg6pbvj2lr
 mRsN2j/m15PFBFXWDgzjOP1hPgw6ZV6c3hrz3b0aLw==
X-Google-Smtp-Source: APiQypIEYQ1dS0t0Wrq600fPW5TINTSVGHVrKtPaKCxKVgI5fnHqk+Ng/f0DIIXh1xQfvT90S8BjYg1HgkxMQ4oSX5s=
X-Received: by 2002:a2e:9097:: with SMTP id l23mr6043347ljg.173.1585329709805; 
 Fri, 27 Mar 2020 10:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200326193156.4322-1-robert.foley@linaro.org>
 <CAHiYmc476rMd71t5ZSdz-pgVZ-i_3RBY=U3bO0aYEOOt5P3V_w@mail.gmail.com>
 <871rpennlp.fsf@linaro.org>
 <CAHiYmc5zTyUtm570NxKS8crJKWgNmEhMk-FcvnkMHf928=9CdQ@mail.gmail.com>
 <CAHiYmc7ZZi784vOQre=_40bf0dgJUGoBupD_zFE2jw-_EcxR+Q@mail.gmail.com>
In-Reply-To: <CAHiYmc7ZZi784vOQre=_40bf0dgJUGoBupD_zFE2jw-_EcxR+Q@mail.gmail.com>
From: Robert Foley <robert.foley@linaro.org>
Date: Fri, 27 Mar 2020 13:21:21 -0400
Message-ID: <CAEyhzFsW=o8jL0nXStkYXVS5nLY8Yfj-XBB1eYujsVhKVSEHCg@mail.gmail.com>
Subject: Re: [PATCH v8 00/74] per-CPU locks
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "peter.puhov@linaro.org" <peter.puhov@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 27 Mar 2020 at 06:24, Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
> >> >>
> >> >> This is a continuation of the series created by Emilio Cota.
> >> >> We are picking up this patch set with the goal to apply
> >> >> any fixes or updates needed to get this accepted.
> >> >>
> >> >
> >> > Thank for this work, Robert.
> >> >
> >> > However, I just hope you don't intend to request integrating the ser=
ies in
> >> > 5.0. The right timing for such wide-influencing patch is at the begi=
ning of
> >> > dev cycle, not really at the end of (5.0) cycle, IMHO.
> >>
> >> It's not marked for 5.0 - I don't think all patch activity on the list
> >> has to stop during softfreeze. I don't think there is any danger of it
> >> getting merged and early visibility has already generated useful
> >> feedback and discussion.
> >
> >
> > OK, nobody ever said we can
>
> Obviously, I meant here "cannot", not "can". Everbody is allowed to do an=
y experimentation and evaluation of the series at any time - of course. :)

We do not have any particular release in mind, but we are not
intending this release for sure.  It is a good point though, that we
probably should have mentioned this in our cover letter, given the
timing in the current release cycle.  We'll remember that in the
future. :)  We're just looking to get this out there now to get some
feedback and hopefully advance the series forward to the point that it
can be included in a release in the future.

Thanks & Regards,
-Rob
>
> > examine, discuss and test the series, but I remain thinking that this s=
eries arrives too late for considering for 5.0.
> >
> > Aleksandar
> >
> >
> >>
> >> --
> >> Alex Benn=C3=A9e

