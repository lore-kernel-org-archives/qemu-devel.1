Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D41C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:09:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB5023B06
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lTH3PFoN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB5023B06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpsbZ-0006CK-41
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 08:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpsa7-0004Mu-42
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 08:08:15 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpsa2-0001Cf-S3
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 08:08:14 -0400
Received: by mail-ot1-x343.google.com with SMTP id 72so15235225otc.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 05:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VcYrc9BM+14ubllFN6lBohIFrdUgNpRBpa4HQ3+JCxM=;
 b=lTH3PFoNVpMih1c2lz7VBIGfmCCrKfXTHLpjAryejkW/yoG8Qcd0Gzr25XLujboc8H
 +Y0lrD7+BxyQ2UmGH/1+/RxXhHIuXrPmVLHtUYKQHr4rdxUuej2Fn7ADLfL0ZjfDGwi9
 +EF4k/oUe6Cth1LbzQQc1eDwkNUMFNIHjzP8/mSV7WXDI9uHApp24SUuFhWwT0JVd0Rm
 0MnyFmIVCLk2bKXL5ZQnqBzETpD5hYoM0htpLZ6PcIWBRgm7byZHFvuW1uYSAGezIvBP
 iqA80QXypQmWLJjiKyl0F04W278yjRMPOjJ4iEHM9lwT2lfoMZz4i76OgJOt7b3ZXQv2
 S5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VcYrc9BM+14ubllFN6lBohIFrdUgNpRBpa4HQ3+JCxM=;
 b=m4E4KnPtGhfPV004EVAnTVgMb30TuxwGNi6nLYRsy2Ut7shXfDLQyahSsavBAViqmq
 NvoTFnwKYQUVBY4gjhzju7IAat/2uoD0PTM2war4YofcBLRkfWRCNh58ESRmDs1feIVo
 qhg+4CwiY278km3+1oMlzhogf4AlThxH86VihEKxPhtBBbQAgXv8l7fYApjt0TSSrvYv
 sT98fR139xeGgszbjE0TFcLZK4IQZhVevGLXF9Fj8Wa6p1bR/dtZztAxbyghwhxAknHY
 AVlOElg3PuIvjrRF5+TZUq1QrmFTwGCRpAHE/x3HEsts7mznwEq75XRFPjke4fkRX7pb
 r/CA==
X-Gm-Message-State: AOAM533IwrcHTnSoVamhzd/A4FopI6p+EPGUsnx9EdAC9TA9+NzbGylp
 TaMkgW04QFdQY7kZXtkP2rBYaFbh49jpOGbHXbVQOw==
X-Google-Smtp-Source: ABdhPJz3lhE3Glj8UqfRdIy2dGRkoJgtD/vM7oRA7Xm4/B/86/rJC0N+2uSl2IGTaqGu50CcrJT5eeWX/6meTC6DCEw=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr10425650ota.91.1593432488810; 
 Mon, 29 Jun 2020 05:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-12-peter.maydell@linaro.org>
 <b1a56ac5-f2a7-ec88-0191-5324821f4916@amsat.org>
In-Reply-To: <b1a56ac5-f2a7-ec88-0191-5324821f4916@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jun 2020 13:07:57 +0100
Message-ID: <CAFEAcA83LqH0dUZfk-yjmdEX_o4VNuDqAgSxe2hj9nGmAxs9Xw@mail.gmail.com>
Subject: Re: [PATCH 11/17] hw/misc/max111x: Create header file for
 documentation, TYPE_ macros
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jun 2020 at 09:29, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> On 6/28/20 4:24 PM, Peter Maydell wrote:
> > Create a header file for the hw/misc/max111x device, in the
> > usual modern style for QOM devices:
> >  * definition of the TYPE_ constants and macros
> >  * definition of the device's state struct so that it can
> >    be embedded in other structs if desired
> >  * documentation of the interface
> >
> > This allows us to use TYPE_MAX_1111 in the spitz.c code rather
> > than the string "max1111".
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---

> Nitpick, we can keep MAX_111X() + MAX111xState in "hw/misc/max111x.c"
> until we get a consumer.

This is deliberate, as noted in the commit message.

thanks
-- PMM

