Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1FBC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 19:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D1E206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 19:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JkGGruRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D1E206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgvwA-0001fv-Fs
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 15:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgvv9-0000SS-8e
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 15:52:59 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38915)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgvv8-0008Pz-Au
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 15:52:58 -0400
Received: by mail-ot1-x341.google.com with SMTP id g5so5742463otg.6
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 12:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KH6ADcPKXKA2d40NUGSV5oTMcZeafMLVxcrkizVeF4w=;
 b=JkGGruRXskcq7ZBwPioGQOSUS4NOKlwdPhkqGFpkF+khQ9WUWVk7IOvcTrIH5QR6gN
 lUCBclELLWYhcgyjL5fBD3pBmky0/8Z5OCGvOlKbMIXK3/zmmmxD61mc07nddhbEMLNL
 m7ymdNwbm2SbUtxODgm3BWpSeUL8IC9SAmmFfs1m6rGZtJW6w4I/ZZF6Kd8lvKnqyyxV
 MHUFT68KDoSlLgj62lTAsJq/xJa6hQExdEYrNK6up6dH/7yaq5gRnZei2tBJ1789nq2D
 a4CGzOdrmlUlE7KiBfmoypGWVbCHZnlZ4C6tERuIMA8thaws0AlRLC5Zf8VKnPrxMXxj
 gE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KH6ADcPKXKA2d40NUGSV5oTMcZeafMLVxcrkizVeF4w=;
 b=m4+cc24NpiiOZMMAdecK0qQTJ+weCfyDqyEgPHtm3Tj/Rd0dbK0rtO9lZgnAUYtQIg
 wNzjq2V7D+tYQFm3/vuy+EqNReQxn2Zt0OX/3H28fF/o66wK6VMJhxYbcSb8TIYlZZcz
 3T7MQz+a5v2mX1XuXIzMGXpnpLOtgZC3WyMTcA6q+tGBLuAxpUGT6HIHP90tV/g07Epe
 Sd4GRSWh/+3T2tLkKdpcdJ9Tnf5Sq9tDxs32nQ/Cig/9w7eZzdBCDD/WTIo5qELuPYT6
 UTW2CB8IfX2O6TtO2rGmlm2IgI9Xynxg6ACx6FopQXBotzzUqyLXLpy490VzbUS2r/BZ
 uizg==
X-Gm-Message-State: AOAM532ii7phZWpvbbVR4ZmXHvRlu5RXtQnKnrsbVqiKvafBFcn9QVAR
 OnaiuKm5gEzFQBVqmgB9CgEyCY+3riiDi75HVjEumg==
X-Google-Smtp-Source: ABdhPJxeAkahiCHf9Pwb79RHh3gZqSgD2X9DWzemeWmJ2H453u8S2o/gJo/CE/9QSANOE7eUC4g5w8KXyVay24SsPoo=
X-Received: by 2002:a9d:b82:: with SMTP id 2mr4722356oth.221.1591300376950;
 Thu, 04 Jun 2020 12:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200602053614.54745-1-mst@redhat.com>
 <b03eaa8c-fb1d-523a-6e41-c1d4ceaafd53@redhat.com>
 <20200604150734-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200604150734-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jun 2020 20:52:45 +0100
Message-ID: <CAFEAcA8r31UiQ-a=DfDNrw=Fex-m8X6ezF7XJsRFyPg4eVV=cw@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: reversed logic with acpi test checks
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 4 Jun 2020 at 20:09, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Jun 04, 2020 at 08:45:15PM +0200, Paolo Bonzini wrote:
> > On 02/06/20 07:36, Michael S. Tsirkin wrote:

> > > +   } elsif (not $name =~ m#^tests/qtest/bios-tables-test-allowed-diff.h$#) {
> > >             $$acpi_nontestexpected = $name;
> > >     }
> > >     if (defined $$acpi_testexpected and defined $$acpi_nontestexpected) {
> > >
> >
> > Queued with "!~" to achieve the logical not.
> >
> > Paolo
>
> Hmm perl manual says "not" is the logical not. Weird.
> What's !~? My perl is a bit rusty :)

man perlop says:
# Binary "!~" is just like "=~" except the return value is negated in
the logical sense.

So it's more idiomatic to use it directly rather than using =~ and then
doing a logical negation separately.

thanks
-- PMM

