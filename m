Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5FBC5517A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36EDE2231B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GCKpQyTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EDE2231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNv6-000633-VQ
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXMsv-0005XX-AE
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:11:25 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:37376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXMsq-0001Gp-M8
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:11:25 -0400
Received: by mail-ed1-x544.google.com with SMTP id o18so997509edq.4
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=z0Sn1/klbwmGrH4EiwRl2FFYWHdN0vE5o4xE27RcLts=;
 b=GCKpQyTAmNshAwD6cw9uZDv88lOJMqdzzXTdX/hFzeLbvbqzbVAz3r742/4JYqbnYV
 jBdDvK5mfVRDNWIUJ9pHgEzyy7NrYfMk/e8Zij75c+CkZthrNpHB6kkaUBcZ5mkloodu
 myITSCrPQ+AzcRW9cZj8rzjN2m1CXRH4I7kYrp7wxrQuCjw3gks/lUHw41zK862UBwfs
 0G7l0r/t7mfx/bCLw/F3uY9g2YUZ6xrFo+Lbe4kY+QUF6tpIefTUTGGS0b8BJ/h+az1+
 VxuHugxkghqjuO1UM6MHKBRp4Zjkw62hO46xnGXYh3I01k9/HHjIB83oS0OgZ0qC7ZnW
 7hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=z0Sn1/klbwmGrH4EiwRl2FFYWHdN0vE5o4xE27RcLts=;
 b=ZgcZ7Ln5xGeQ/mxG9SkuemODy8Vk5dDPS1cZPrW3uqk0ax+uU4GNO1P7hfY0Yb7tp5
 hJW/9AXkAsGsbB03lFQCol3mPVpXOippzC1Or/E35p7f4i2dwfr+Wl08ZtpxA3Dft4by
 SSXGgldyvdXY0g83NuIDgoq7YqD2Bswn9P0a2EhS3LL07gho7eEgkwInCnaXHCUDtVLA
 aEvwEclxI3HneyLUVlRj1g9X9hLByEllt7B2B/NvlQZZ/Y0ULDFLhWJ1+xlfOBqXez0E
 c1PTHWZenJFGE9R+mw32OkhB6YOlqEJGBEiP/LWa5qjF5UGrJP0YYNdv/l8mOVnonQUg
 VUsw==
X-Gm-Message-State: AOAM533gI3Pg48DYZF88J6EwAEaT7nHCCfIeuH/u5Q61BTkgKxaGR5Zz
 BJG7WDRQktWUJcC8syo3zoDtKnjpGL/PM0PSPlCd6w==
X-Google-Smtp-Source: ABdhPJyDCNml0cd3zWDKbxas4enfOvQcmNXJbhtrlNEdsxaAAjbPCmkPQoFct4lXuNXwvt2m7Wg0flBiFN5VSxWPa2M=
X-Received: by 2002:aa7:c683:: with SMTP id n3mr1611636edq.146.1603797078712; 
 Tue, 27 Oct 2020 04:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201010135759.437903-1-luc@lmichel.fr>
 <CAFEAcA-F5WCv6We3V=kCV8vH79ko=KGHYWKLaxNVEd9HjFES3Q@mail.gmail.com>
 <CAFEAcA9fHTO2f_KdCnFvqhEOwTzOwtMf=EhKY=9S_5twpabaCg@mail.gmail.com>
 <63d302c6-5cd8-e321-090f-7b1a5979788a@amsat.org>
In-Reply-To: <63d302c6-5cd8-e321-090f-7b1a5979788a@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Oct 2020 11:11:07 +0000
Message-ID: <CAFEAcA8whOBFTqEeOO_S9+G0O_dafQitvQxeghSfQT7ME8o-Ow@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] raspi: add the bcm2835 cprman clock manager
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Luc Michel <luc@lmichel.fr>, QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Havard Skinnemoen <hskinnemoen@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Oct 2020 at 08:55, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Hi Peter,
>
> On 10/19/20 9:31 PM, Peter Maydell wrote:
> > On Mon, 19 Oct 2020 at 16:45, Peter Maydell <peter.maydell@linaro.org> =
wrote:
> >>
> >> On Sat, 10 Oct 2020 at 14:57, Luc Michel <luc@lmichel.fr> wrote:
> >>>
> >>> v2 -> v3:
> >>>   - patch 03: moved clock_new definition to hw/core/clock.c [Phil]
> >>>   - patch 03: commit message typo [Clement]
> >>>   - patch 10: clarifications around the CM_CTL/CM_DIBV mux registers.
> >>>               reg_cm replaced with reg_ctl and reg_div. Add some
> >>>               comments for clarity. [Phil]
> >>>   - patch 10: fixed update_mux_from_cm not matching the CM_DIV offset
> >>>               correctly. [Phil]
> >>>   - patch 11: replaced manual bitfield extraction with extract32 [Phi=
l]
> >>>   - patch 11: added a visual representation of CM_DIV for clarity [Ph=
il]
> >>>   - patch 11: added a missing return in clock_mux_update.
> >>
> >>
> >>
> >> Applied to target-arm.next, thanks.
> >
> > Dropped again due to segv in 'make check' when running with
> > clang sanitizer, which I gather from irc that you're looking
> > into.
>
> The fix has been merged as commit a6e9b9123e7
> ("hw/core/qdev-clock: add a reference on aliased clocks")
> and the series also got:
> Tested-by: Guenter Roeck <linux@roeck-us.net>
>
> Hopefully it will make it for 5.2 :)



Applied to target-arm.next, thanks.

-- PMM

