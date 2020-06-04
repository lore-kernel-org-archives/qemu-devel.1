Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DB5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 15:33:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8DD6207D8
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 15:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Prjrtt9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DD6207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgrri-000882-1c
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 11:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgrpo-0007I0-CC
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 11:31:12 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:34337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgrpn-0004gw-0f
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 11:31:11 -0400
Received: by mail-oo1-xc41.google.com with SMTP id v3so1327106oot.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 08:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+y36E62SyDZ9W75ttOnnjGopAlSJZVn+lWGew0UZ3T8=;
 b=Prjrtt9ecp493en9B4ps3YpQHRtwQU0diHrk2clBXXWjuJP4egNNQs36MComWooZf5
 4IeyaBOzMTOEfLR+l9+oAuk7fXl0G1+cmmUXjvYw85NTgW+EC+yc7h8DIXuw2XLSSY5/
 IwHRDCPkkn84YJCjDYlPQR0xR6JMHVD41UqOw+JNW78cv7bHMqGntplACnCqAfPxsF+b
 04lZT8eVrwfxFRT1N7qKbiJpDShsVbMIhDJXKjJOPfFy5eOg4Su7sn58xGprqA7hrjyg
 shOse1/Pso1GM5CdbS9dAo7GhsSnnha1mBBn3bWyqyikdTbJ/4X9i6JeExVIu86s+jP0
 TClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+y36E62SyDZ9W75ttOnnjGopAlSJZVn+lWGew0UZ3T8=;
 b=mRjMYtvHxjdwiDjrXFJHT3zIGFNr9213Sy/WJm/XX8OF3ekqlmGuIZNqW3J2D9/Q5x
 vRqD93+kL5q1VMZJA/4u/Zfp46WHehcfyB69/YICtEnozI+AdUkep4jK+0/TYdvTEPR7
 4EnKWUrM2EYVM2Oz/ui0DGLx4MwYIwgDP/nJH3jRDGDBM2SO8Yr3aFJJO3uEGppBbSeL
 eK9yk1dgpN9jw1fd7bX/F4OcZg2WmbNlLB+Gud2BwLhzpmefHItbl/elv0ly2OVkVwYb
 D/1F6kGiK/sCYeTvwHvp7J4qdcTtVHB2ac/hon15g2ShPwnPe3Q1nXamzQVVCr9v3fNK
 oOMg==
X-Gm-Message-State: AOAM532hwVmk2+eodPY5p4Dem2T5mbaQFR1L+aTfi77we5n3/sWKt1nA
 3cZuzOKSCws3D+W7hPqGkp9mKNA1VS1+K1WdslLzpw==
X-Google-Smtp-Source: ABdhPJwwj8l6OuPXc+9SkXZWpdB5hU74BSekqXNQZN0OwHupZ3fYiPrtCeAYYn8MwQOCwIlTMQ1u3qjMLyHYHKsAIYo=
X-Received: by 2002:a4a:a20b:: with SMTP id m11mr4145036ool.20.1591284667207; 
 Thu, 04 Jun 2020 08:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200525155826.11333-1-philmd@redhat.com>
 <CAFEAcA8UGjx5S+zVHX_Oon-ELaCRuLpXEDrjs0VoAwqJ7uPn3g@mail.gmail.com>
 <5dbecc86-f9df-249d-7439-36c358dc5aba@redhat.com>
In-Reply-To: <5dbecc86-f9df-249d-7439-36c358dc5aba@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jun 2020 16:30:55 +0100
Message-ID: <CAFEAcA9qVBdLZMO4e+oSaL6kwpF9WS+RdeL3DxBNKVMPwnQ=TQ@mail.gmail.com>
Subject: Re: [PATCH] hw/block/pflash_cfi01: Limit maximum flash size to 256 MiB
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc41.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Hongbo Zhang <hongbo.zhang@linaro.org>,
 Tanmay Jagdale <tanmay.jagdale@linaro.org>, Qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Radoslaw Biernacki <radoslaw.biernacki@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Leif Lindholm <leif@nuviainc.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 4 Jun 2020 at 16:16, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> On 5/25/20 10:59 PM, Peter Maydell wrote:
> > What problem is this check solving? Is there some implementation
> > imposed limitation or a limit within the flash header format
> > that means larger sizes don't work? If so, what's the restriction?
>
> I am not confident maintaining virtual device with no specifications.

This isn't a virtual device, is it? The CFI spec exists and defines
what these flash devices behave like.

> If someone come with a datasheet for a pflash > 256MB then we can add
> another commit to relax this restriction.
> If someone is forced to use a >256MB and such hardware does not exist,
> I'd rather have a document in docs/specs/pflash_cfi01.rst describing the
> CFI fields.
>
> IOW this is not a hardware limitation, but a maintenance protection.
>
> I am worried with the recent EDK2 activity with the SBSA-ref, and I
> don't want to give false hope to developers that they can create any
> kind of pflash with the current device model.
>
> If I reword this better in the commit description, is my argument
> acceptable?

Not really; I think we should know what we're limiting against.
Currently you're checking total_len, but this is just sector_len * nb_blocs=
,
so if there's a problem with silly large values then it's probably
actually a problem with one of those being over-sized which would
still show up even if the total_len was less than 256MB.
(I suspect the underlying limit here is what the cfi_table entries
0x2D..0x30 impose on blocks_per_device and sector_len_per_device.)

thanks
-- PMM

