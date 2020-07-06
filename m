Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5A6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 08:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD64F2067D
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 08:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GwK48Ghm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD64F2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsMuY-0003TY-4c
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 04:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linus.walleij@linaro.org>)
 id 1jsMtx-0002qf-8c
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 04:55:01 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:36670)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <linus.walleij@linaro.org>)
 id 1jsMtu-00024B-Pb
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 04:55:00 -0400
Received: by mail-lj1-x244.google.com with SMTP id d17so29622192ljl.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cNNvIPbyRDyhu5ZgEEiWbAIxYQhb/2gTkX3OL9Va+WQ=;
 b=GwK48GhmFmirpg3fdswa9lBUePOmYDIUGRR8hdVDdkSej4xaxCeCZAFSNgxfHMX6Yy
 w9Kla9Zz94g96jzu2SdkDHlz3/g7x+cSsfL0CLrYgCZP6J19zRAdLsZs87JfMO7sIJE6
 hD8DhDJnDAm0DcZzdnRoijixEc6U2wSUxDKr/PyrnIZ6sDA3NJltPdTHsLduPer5Awad
 NUwH5K/XHmbz5gpeAqR5kYWsh2PSuS+J5l9UTHxPSnjzSl1GyAg/pMTCqSfzmJ/+quNd
 zVd7EeWl6Jy5ia0GEmuuMG516H4zo1kh4cHrXJacH0rZz+cmV3uWqvNIF5fVl3UCZoOV
 qcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cNNvIPbyRDyhu5ZgEEiWbAIxYQhb/2gTkX3OL9Va+WQ=;
 b=msfv5J8m7ys0Wxta0E5xgjKZK1GtpSA3/gU9WLXAfgpjzCDTBeuVN1WJlKRicRAU9S
 Lb9nD2NNLEesnZ76pwmA3+47Z7GfusxeErBmClrf+5hj/h9zS8sRtcd+k6rIk8byWt5P
 3d+aLmZLj8rbzCTJUuDWhS7mYCf+gNHcExJMFWtnudJ4EI/ECPAB6OrT8OtT0eOQDkv8
 EZ61VmhI+o1ytLz5k+cPImZrIJMwAYxObNC2LuK+qj2HCwLGPVBFA8AZ/ibM4i37jWMa
 auGipafOUuHN84QeF7RD5IUMeYtGmljcJ4MDaX+upjriC65iM6Kb5lGHhKTWbAvkmiJS
 +alA==
X-Gm-Message-State: AOAM533sLrjdK8ujQ1AgVdM93rfhIcxpOwDa+Fc9qHAQM2daNQoDiljR
 aqIQ3+cVshTtsjp8F7+PyKPYT2QHn33LM4Oh2lpUEw==
X-Google-Smtp-Source: ABdhPJylBq/GlipYoQiOaeWdyv7Nd1mhikRAHRzoHcrBYF2Tgt2xn3B345Rezd2yDNMo2CkzdbSQ8juxx+Oe1fm99VA=
X-Received: by 2002:a2e:7a1a:: with SMTP id v26mr10720535ljc.104.1594025696518; 
 Mon, 06 Jul 2020 01:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200529072017.2906-1-linus.walleij@linaro.org>
 <CAFEAcA-x0y6ufRXebckRdGSLOBzbdBsk=uw+foK4p+HDeVrA9A@mail.gmail.com>
In-Reply-To: <CAFEAcA-x0y6ufRXebckRdGSLOBzbdBsk=uw+foK4p+HDeVrA9A@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 6 Jul 2020 10:54:45 +0200
Message-ID: <CACRpkdZk-Pv49PyhtrW7ZQo+iebOapVb7L2T_cxh0SpYtcv5Xw@mail.gmail.com>
Subject: Re: [PATCH v2] fcntl: Add 32bit filesystem mode
To: "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=linus.walleij@linaro.org; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Linux API <linux-api@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Florian Weimer <fw@deneb.enyo.de>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Andy Lutomirski <luto@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 23, 2020 at 12:08 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> On Fri, 29 May 2020 at 08:22, Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > It was brought to my attention that this bug from 2018 was
> > still unresolved: 32 bit emulators like QEMU were given
> > 64 bit hashes when running 32 bit emulation on 64 bit systems.
> >
> > This adds a flag to the fcntl() F_GETFD and F_SETFD operations
> > to set the underlying filesystem into 32bit mode even if the
> > file handle was opened using 64bit mode without the compat
> > syscalls.
>
> I somewhat belatedly got round to updating my QEMU patch
> that uses this new fcntl() flag to fix the bug. Sorry for
> the delay getting round to this. You can find the QEMU patch here:
> https://patchew.org/QEMU/20200623100101.6041-1-peter.maydell@linaro.org/
> (it's an RFC because obviously we won't put it into QEMU until
> the kernel side has gone upstream and the API is final.)
>
> What's the next step for moving this forward?

Ted, can you merge this patch?

It seems QEMU is happy and AFICT it uses the approach you want :)

Yours,
Linus Walleij

