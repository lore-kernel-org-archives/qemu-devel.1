Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C39AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB759206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIi/WQi/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB759206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsiFx-0001n2-0O
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erik.lucas.smit@gmail.com>)
 id 1jsiFM-0001HQ-RH; Tue, 07 Jul 2020 03:42:32 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <erik.lucas.smit@gmail.com>)
 id 1jsiFL-00013n-Ak; Tue, 07 Jul 2020 03:42:32 -0400
Received: by mail-ot1-x342.google.com with SMTP id 5so31626021oty.11;
 Tue, 07 Jul 2020 00:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zgfF/l/rk7YSQrdjF2U4TIyp5uPO4bxgVF3D6F9XBR4=;
 b=ZIi/WQi/kJgOTXwWCqw/uXrnv5NumG6M8oBE1ogTVeQjXHAsrO6/9hCEieP+byHPfi
 X2zkzqd9HX3xwhapVHKZzAzLqCx366na34Nf/F9zdnetGpGAdKCVCC9pjbPDCslnSo4f
 xQsfvQqvDoPKtMa8yvVPiBtEAETz6HmPxNszwz6H4yi8Ta1iiPhHWkoRG1lnSs07WACH
 Y9tbUE7f5RHkl38W+kSMziCRLIXWi7zDta8jAr430yLBOQ2EAnB1/r+NBcaUlc+NasKK
 qE4piQYO69bibqSD+tF8MeQEORZuVKhw2eTGBuvEDTbRN1trNn3GNjtyI+ykGx1P2L0e
 rnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zgfF/l/rk7YSQrdjF2U4TIyp5uPO4bxgVF3D6F9XBR4=;
 b=Rr4YuoJA/r4pvwVBxclZ/mcsxMEb0Y9qWnJbV1ojTDGj5M7ncgUelSXl8Y+y/YsQxi
 tGj0g2oZ1i1tHUWKDG6OmCDOoPfQh3dPupQG+A0rTaNqYMv5o8EneTpzcISngpK7GXvN
 yc+/sfxt0Re24L6JJcSrWatO/Y48rcJS5OzkJ5iqXzTCudzpB6GqOeg4FfJx/WPuJfln
 Q8iHTqYfR5T4ZZNfAPW0AzIAZgjwFRfpWyqoV93a3IcbTRkTFKBstX830ITZ+LzU8kcp
 vNyHjg0Ds0olEEFhCaYPqwlZxttw8ZsvQm4JuGA5GRKQGm4iiM9eT/sAgzz+lrRtyL3U
 bn3Q==
X-Gm-Message-State: AOAM530qvpfoauCgnI40eJgw8qKJGApWiB7GJDgefI68OggTJS4uRpmE
 xZcjyn+7NxqpZUjyQN3eJWCtgETAPfqEyUsVCCo=
X-Google-Smtp-Source: ABdhPJwBBGF682mmkBu2emF+mB0gnY/1DcW6mnmBqWnTL74MU8Mo55rYKZ5HyzarorCg9MnNDwDu6e4KhZJajo8OUio=
X-Received: by 2002:a9d:2067:: with SMTP id n94mr47106651ota.78.1594107748832; 
 Tue, 07 Jul 2020 00:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200628142658.29264-1-erik.lucas.smit@gmail.com>
 <df64d8de-9d7f-474b-8b72-5d2e6c7df1f4@www.fastmail.com>
In-Reply-To: <df64d8de-9d7f-474b-8b72-5d2e6c7df1f4@www.fastmail.com>
From: Erik Smit <erik.lucas.smit@gmail.com>
Date: Tue, 7 Jul 2020 09:42:19 +0200
Message-ID: <CA+MHfovCuasf4RrfZrJwfHx4VOeRNfQ=MTMaFG4=Df8cELZ=EA@mail.gmail.com>
Subject: Re: [PATCH v2] ftgmac100: fix dblac write test
To: Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=erik.lucas.smit@gmail.com; helo=mail-ot1-x342.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Cameron Esfahani via <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Andrew,

On Mon, 6 Jul 2020 at 03:59, Andrew Jeffery <andrew@aj.id.au> wrote:
> On Sun, 28 Jun 2020, at 23:56, erik-smit wrote:
> > The test of the write of the dblac register was testing the old value
> > instead of the new value. This would accept the write of an invalid value
> > but subsequently refuse any following valid writes.
> >
> > Signed-off-by: erik-smit <erik.lucas.smit@gmail.com>
> > ---
> > Changes since v1:
> >
> > Changed %ld to HWADDR_PRIx to fix building on mingw
>
> Bit of a nitpick, but the type of the value argument is uint64_t, so shouldn't
> the result of the expression captured by FTGMAC100_DBLAC_TXDES_SIZE() and
> FTGMAC100_DBLAC_RXDES_SIZE() be printed with a straight PRIx64 rather than
> HWADDR_PRIx?

You are correct. I didn't understand the meaning of the PRI macros and
just grabbed the other PRI macro I saw getting used in the file.

-- 
Best regards,

Erik Smit

