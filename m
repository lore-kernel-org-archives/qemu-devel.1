Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6C3C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 11:15:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4D620836
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 11:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A674bzBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4D620836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jomKA-0006fs-Aw
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 07:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jomJG-0005hJ-Pr
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 07:14:18 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:45428)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jomJF-0007Zw-2K
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 07:14:18 -0400
Received: by mail-ot1-x329.google.com with SMTP id m2so8214144otr.12
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 04:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3AlcPefLR+FSLzD3vmty4oO9RudW8KCF22P3PphNDJU=;
 b=A674bzBaAKwY3p64/dpFMibjPBkCX/Z4rw2mJogwKf45L724fvvLhzYT80qJcFzZmY
 LXSHt/obp04CaJIw1zc/WU9H0SHJ/pNc+Tw8XdDMxnznrvsbZXHcnbhhhYImHd+ZZEI4
 Mr1dHDqAWK5bejjq6cC2zWDil10W2LNMW6qAm4xyeU34MlTqMgOqQRRwjyN5gruhWN1N
 nMml7CHt8fiam8pSeVxnyo3f9lfK4eqNyamsnjd3cVfXWs5OauWpPBl25QeuWlvKzZT9
 Iv90wAQMDQCLGNNb3MN6SFdrGN6Aum6ZeiwVmc2W2O9DwDGe+XrisOZuVknJtlT1zoR+
 E6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3AlcPefLR+FSLzD3vmty4oO9RudW8KCF22P3PphNDJU=;
 b=YrStx64RpZ3aWtqbztyFbPT5VAs0hL88oMQFhXgPwY13JxDxXMEWRBy3wdRjCA6zf3
 qNfMjjK7txVioU+CLyLqvvSJttHm56pP2X7kOA52yvdy/4s8gRyt9GS2VuifaNEftcNs
 P3pePJ7miVaG9wpe2ckCcnVA2LmdwUpj8eLxf2rU5S4S41xHIEOElkXZjs5M/FobWsKe
 +8hXAYXjCTZYSJjO+bqJYIFnpQ5MSn4oolWHKHAMskLqDZ1WAOEoJjiZW9kIuEBRzyjT
 i3u0d3uzveQ2qPKaqbf/+tpT2hyhXuqChFA7jeJR/OgqPBZ2Cx3Sz3Nt4xOaCNwyTQv1
 JCqQ==
X-Gm-Message-State: AOAM532G9vhg2RIVIZQLEyAMFW3Dq4G08PqYqu6gd0KSkl36762jneI1
 O1ShbvnkmT7QQkI9r2IftcMlzNK2vusd6D3L5WfNnmg47OQ=
X-Google-Smtp-Source: ABdhPJwtnQaGDNvveVzmJpvOseyvTfFTNYtJsvlKSU/uxDnFqadMm8C5xgUkQ9ga4u5ShA66GdwofZ4TRg87i3eOA4o=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr1923593oto.91.1593170055836; 
 Fri, 26 Jun 2020 04:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200626064024.383996-1-david@gibson.dropbear.id.au>
In-Reply-To: <20200626064024.383996-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2020 12:14:04 +0100
Message-ID: <CAFEAcA8gojqqFT1um=1cyBW5F4n++k58tF3xp0FhjE5j=bOAug@mail.gmail.com>
Subject: Re: [PULL 0/4] ppc-for-5.1 queue 20200626
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jun 2020 at 07:40, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 63d211993b73ca9ac2bc618afeb61a698e9f5198:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-06-25 16:52:42 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-5.1-20200626
>
> for you to fetch changes up to 737ef968d442cb287b1fcc7da94b53284b0ad1e9:
>
>   target/ppc: Remove TIDR from POWER10 processor (2020-06-26 09:22:30 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2020-06-26
>
> Here's another pull request for qemu-5.1.  Not very much in this one,
> just a handful of assorted minor fixes and cleanups.
>
> I'm about to go on holiday for a couple of weeks, so this will be my
> last PR before the freeze, and maybe the last for 5.1 at all.  If
> there's some super important fix we need, Greg Kurz will handle it.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

