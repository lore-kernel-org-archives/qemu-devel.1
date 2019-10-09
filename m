Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AF6ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:50:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE80C20679
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jq+UaPmj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE80C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIH2o-00046i-Kn
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 14:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iICLc-0005yV-EF
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iICLb-0005CW-E4
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:49:48 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34987)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iICLb-0005CD-8N
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:49:47 -0400
Received: by mail-ot1-x341.google.com with SMTP id z6so1780612otb.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3g/D2fe1BvDimcQvKdf4hxfNjstsd/kFe/ZTYgk3oUI=;
 b=Jq+UaPmjbXBn5Ni0j4LCmWxovZeAmudgO2aIXalRNNAkR2OkiHQzCQWBncEDvsI4bK
 bnLxMkbu1vmyCm5KzL4A/L2pyRnEIpmoOA/Y53qJdTvY69WBUCw7OzQzlZitW/Eeec4a
 z66bDgEofGVAmSUaO/UW9YHUmTUxD2mf3mtn8udF61rncuSmG/tCls7+yRxYhIjKikzk
 IxlHj+ROsWNq45BNSqiVM4/74dzngweU9NHPgtCf02vjPtZD5obIrez3tagglwFfZmGw
 Ff0EtKkWvS8e0/2oyPvXLZ8lk6TFcGv3fV/15r3/zSl3GtFu4n/Yao2nfkbni/s7UMxt
 QauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3g/D2fe1BvDimcQvKdf4hxfNjstsd/kFe/ZTYgk3oUI=;
 b=E96op3fJbdWSKTKpA7VpuIWk0iEyVSSdLEIGuu4aSE8ccNBm58zBrnXrTd4Z1Ayjai
 cpAUvsHUKfXrXks7rnN3k2wtGM+3J5Hk38KeiNVexAS6KSaoFZ38qgXXPufBs4RcQ5oT
 xKuMChOaMZ/u9Ob+b8dJpg/QfIHr94adngDkLD9f/POsy1oZbu3r2cmVJY6P2NCksZrM
 FU2BY9QDE8e/h8fh+t1XjR6+RbVMQPGHboMeJyAvJ4sSTUJX3OVcEjxTmuq9B7lgi/mH
 1s7uH19Noj5WKocqEkhXOzMKmAnSD5olZqR/XVYP8xP9EcD9vXOKcY8KYv1LGI2AZ7/+
 U58Q==
X-Gm-Message-State: APjAAAVmCUvsp8PChngiVGdSb+rV6k6caydFKRk9edB6+Setf091i6Hu
 5FNqK9HQmZWemnfBnH8Jwh7PZTRwHzkN82ShQydDlw==
X-Google-Smtp-Source: APXvYqz/ZpPngJLbMT6o/mhxNZgCDpzFRlVP+ordWV1SS87DcC7CudA4xmzP/GxUGmC1rcpKGREy4wGWwIxTi1loUxY=
X-Received: by 2002:a9d:30c1:: with SMTP id r1mr2937187otg.91.1570628986270;
 Wed, 09 Oct 2019 06:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191008171740.9679-1-peter.maydell@linaro.org>
 <20191008171740.9679-12-peter.maydell@linaro.org>
 <09f5a1b0-8750-eaa4-c6a3-c395ded3167c@linaro.org>
 <4fb18f38-eef3-281b-f414-d257e3dfa2b1@linaro.org>
In-Reply-To: <4fb18f38-eef3-281b-f414-d257e3dfa2b1@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 Oct 2019 14:49:35 +0100
Message-ID: <CAFEAcA9ps-s3WEGjR2sVkVpZ=AAa-qcu+JyUhdVY1SnZqgBiUQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/21] hw/timer/exynos4210_mct.c: Switch GFRC to
 transaction-based ptimer API
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 9 Oct 2019 at 02:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/8/19 9:56 PM, Richard Henderson wrote:
> > On 10/8/19 1:17 PM, Peter Maydell wrote:
> >> @@ -945,7 +977,7 @@ static void exynos4210_mct_update_freq(Exynos4210MCTState *s)
> >>          DPRINTF("freq=%dHz\n", s->freq);
> >>
> >>          /* global timer */
> >> -        ptimer_set_freq(s->g_timer.ptimer_frc, s->freq);
> >> +        tx_ptimer_set_freq(s->g_timer.ptimer_frc, s->freq);
> >>
> >>          /* local timer */
> >>          ptimer_set_freq(s->l_timer[0].tick_timer.ptimer_tick, s->freq);
> >
> > Failed to update them all, it would appear.
>
> Ho hum.  Done in a subsequent patch.
> I didn't realize that you weren't converting the entire file at once.

Yeah, the MCT device is pretty complicated and (per the commit
message) I felt it was easier to write and debug by switching
each ptimer one at a time rather than trying to do the whole
lot at the same time.

thanks
-- PMM

