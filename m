Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303C7C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0CA420665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w+eKjdEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0CA420665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAZaK-0001op-7D
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAZZY-0001JV-Vi
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:05:13 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f]:36891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAZZX-0001Oi-AJ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:05:12 -0400
Received: by mail-ed1-x52f.google.com with SMTP id u1so1172500edi.4
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tT1vZZagAAk1XknxyqpWwFOTokxOyBo78M9Yz16bkOQ=;
 b=w+eKjdEgKMM3ULDTUipfYf5u/A6n/7kYFtqolWV8FXbxqIoT6W2Ug7Erlmb0Xx8bby
 wCsKhqW78tMf6mqouqmVapE1BlcHMqwCGFiZUWWDCI0N6Vhk/yTYi7ey1vheUWPDr4y7
 cPaMBMGpe6HFcsE4aK8ndWsJZgSuNYFpy+bz1kIOCfa3YMC6ZPWu3vE0+MHuCc32nrfz
 uwd/UgK3yevc7Ee/Ig5jlRNNTRFT2LUBUXWhhdqtAWt4FLPjKbCMops4LP5jzVlHi8So
 pxP5nxEHEG0IGq4sT6ugg7px42qqrUkvnlYsW9q1t22YzQcZR2bJd7GnhVULknUuZHlb
 QKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tT1vZZagAAk1XknxyqpWwFOTokxOyBo78M9Yz16bkOQ=;
 b=I7EjOQvOoWyJJ07C510mogrDk6/s06YYj0/TbP3JcSx1WbUoVBHkn00j6aSTekhZ/c
 blkV90r4EF60KSM787+QF8DC0DVsneOQEjS47sWT4eMmj2Asc14s4ZtImFfqEzZWlPYx
 92MjwJ2XZs2Kpw0e6hegr8zlpYagJIoOzpKq3IgDhdXL9pW7f9DaZjQlicZjN1/Wl106
 7k1TzoiwQkzQdpeksduRJK+E1UcuNx6Hy/hwJ2ud46iciRrRhxXWM9v59Rbvrd8tINUJ
 hGvIIS9/Az3nUpHvT+30EFLbNx5FL2vFhBYAl8vNFAHdlt0TC7eblomOV/aNFPptIQRF
 rWPw==
X-Gm-Message-State: AOAM530ji8IdCL6HDgDGegGVP4pX7Nkr2a+07Zdm+pru1X5X6xwfUm1j
 8GHXGcBOqMl6/o4d0VMuS2kKfnlevwzKsfCwfiumzw==
X-Google-Smtp-Source: ABdhPJy0KPq1GSb7PB9iBg6JiptDi6xjPrS9Uzyfd93s2mnGD6wlFvZGz5T+wFZjKAIR78ENtZUcQcMDL4mGMz7QhHA=
X-Received: by 2002:aa7:ca0c:: with SMTP id y12mr10161781eds.251.1598364309427; 
 Tue, 25 Aug 2020 07:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_0R9mQNFnyzdpR65YRHoDs0uPKWxmCOQUojbpAM-jP8A@mail.gmail.com>
 <CAJ+F1CL1Hp-g8gNMpdGgk2d0KCzJfBde9f_mX8TLtewe3-B48g@mail.gmail.com>
 <CAFEAcA_u_3P9MQ23zWTUH-aM8Nabbt+PVv+4qOWpEAhiuJq+cg@mail.gmail.com>
 <e9155559-9a06-ec6f-4be0-2a692364c665@redhat.com>
 <CAFEAcA919wJg00vVTyVksaZGNmD50gH1jQj6RWA1ZAafEJAbOg@mail.gmail.com>
 <ec7272ca-ffed-10b3-4176-8d2905d25772@redhat.com>
In-Reply-To: <ec7272ca-ffed-10b3-4176-8d2905d25772@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 15:04:57 +0100
Message-ID: <CAFEAcA9AMc62FhA8gn-=M2Jhe7Ahkf3AP-pWcJsYUEBLU=Jw3g@mail.gmail.com>
Subject: Re: meson.build files are missing copyright/license headers
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Aug 2020 at 14:58, Thomas Huth <thuth@redhat.com> wrote:
> On 25/08/2020 11.53, Peter Maydell wrote:
> >  * decide what our plan is for 3rd-party code (libvixl, etc)
> >    [where any SPDX line we add will be lost again next time
> >    we resync our copy of the code]
>
> For things like libvixl, I wonder why this is not a git submodule instead?

Because we only take a few files from it, not the whole thing
(which is massive and includes an assembler and a simulator).

> >  * update existing files (I think the kernel folks probably
> >    have scripted stuff for the easy parts of this; multi-license
> >    files like fpu/softfloat.c likely need by-hand conversion)
>
> Yes. I think we have to be very careful here with old files - adding the
> tags is likely ok, but e.g. removing the boilerplate text in the various
> headers at the same time could be problematic (e.g. the MIT license says
> "... this permission notice shall be included in all copies or
> substantial portions of the Software")...

Presumably the kernel folks have been down this route before us...

thanks
-- PMM

