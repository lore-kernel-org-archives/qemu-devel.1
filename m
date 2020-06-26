Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAA1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:11:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC5D207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GULjc3sk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC5D207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jop4k-0000Do-PO
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 10:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jop3w-0007c9-IO; Fri, 26 Jun 2020 10:10:40 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:39827)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jop3u-0008Kc-Ot; Fri, 26 Jun 2020 10:10:40 -0400
Received: by mail-ej1-x643.google.com with SMTP id w6so9521504ejq.6;
 Fri, 26 Jun 2020 07:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BS4NyKw/eQjqIQeqjru8JtNN/x9B5olCUCO3H2/Mp0Q=;
 b=GULjc3skOq1ZIuQwdyKXSzSeJw47OONkx5GbV4cR7KOWeOooITTgmZIZ6RS3PLpamL
 h01foO+AviDszvBHXx7KOHV9c/v+0nG2raqpEjoSf3U3Q+CeS8RJYi5rQiZEURsbBD79
 J0H1lGF/ijDR8gCXLQ4lYETdwQTE+lq7N3d05is06OOBeC6lB8iJRVfRBD2C3eJvpNsO
 DL0KFZhhnrv94K3NTvhzHMXmGe6fztgS16ePWRTQ//0ozpAcRjCkyODFWu9jfRx+bpB1
 MApsQjTaURV/GP3aPNWDzOgM6OLNbJ9I7w5DRZhsn+izRl1luN2a474Wv0/U/p4QNY2t
 eb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BS4NyKw/eQjqIQeqjru8JtNN/x9B5olCUCO3H2/Mp0Q=;
 b=eft07aWUXAzzz/qT+4P8Hmey+LVYz6sdlKwtjhLUpYrpoDxIN5XcX5I4Pi34rZ2ZX1
 UFEtkynUiEAdWdMtCScnhs41kzLeLNxYLzGbZ4sCqipLC/7WUwUz9aq5idqOrm3s5WuF
 mspFOi3pifEtkWP1aNw4MDSS2uyl8+R9UVOG+hWJvH4TVVxCHlXyX1geciQ7l6bbTn4p
 4xK5Ufhyn+srUfJbQJAVrHD0E2t56Mu4iZjpyvMiLjJcmuw09E9Qt3dnC0mz/C8H6kzl
 prETO3yBQvUoil8bv1f3KiGPNbBo3DvDF23iurA9cjHfbhLdRK2PnYZxYmeNmZ5XTA+B
 AMkw==
X-Gm-Message-State: AOAM532qzf2md9/sqHdW4vywOwjje099nRIqtjKpJmmLeIhtpmpNUafq
 +wLnb8t+cg7FLJO5UBUs6kQvzNV5lFYuHDJjhEu1dLy3oyQ=
X-Google-Smtp-Source: ABdhPJyqqO4GmWR8KbGPwNvvfU4D0Xjz9orezcSlVXInER7rw0lEqGlS2pd1z9GfRfGBxMcn38BHRTTrPe+StQCdU3c=
X-Received: by 2002:a17:906:5203:: with SMTP id
 g3mr2645113ejm.58.1593180636936; 
 Fri, 26 Jun 2020 07:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqwDLw2BJ9Cf0kEyUW+J+rTPOOvebRPPkBSiWdD50wct5Q@mail.gmail.com>
 <CAFEAcA8mpiPcwgz9-7c0GgSWz2hujzegOBvHn5qasCBtuyG8ww@mail.gmail.com>
In-Reply-To: <CAFEAcA8mpiPcwgz9-7c0GgSWz2hujzegOBvHn5qasCBtuyG8ww@mail.gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 15:10:26 +0100
Message-ID: <CA+XhMqwyRmQ7Dtawm4tMEMRJ9EEfxep8WC6qSRCEC_WyUptG-g@mail.gmail.com>
Subject: Re: [PATCH 1/3] haiku build fix second batch
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=devnexen@gmail.com; helo=mail-ej1-x643.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I sent again minux the ones already approved.

On Fri, 26 Jun 2020 at 14:39, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 26 Jun 2020 at 14:02, David CARLIER <devnexen@gmail.com> wrote:
> >
> > From 95ef79ddff73eebd1f1bec6673c2c68209fab107 Mon Sep 17 00:00:00 2001
> > From: David Carlier <devnexen@gmail.com>
> > Date: Fri, 26 Jun 2020 13:56:14 +0000
> > Subject: [PATCH 1/3] Include endian.h for Haiku to solve bswap* macros build
> >  failure.
> >
> > Signed-off-by: David Carlier <devnexen@gmail.com>
>
> I'm afraid I'm now confused about which is the right version
> of the various patches you've sent to the list. Our
> https://wiki.qemu.org/Contribute/SubmitAPatch
> documentation asks:
>  * Include a meaningful cover letter
>  * When resending patches add a version tag
>  * even if you only change one patch, you resend the entire series
>    and mark it as "v2"
>
> Please could you send the whole set of patches you'd like
> applied, with the subject header including "[PATCH v2]" and
> with a cover letter email that describes the whole series?
>
> thanks
> -- PMM

