Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F19BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 14:04:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5828C23D5A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 14:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rfeWayyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5828C23D5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpuOW-0002qr-Kt
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 10:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpuNm-0002FQ-Ba
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 10:03:38 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpuNk-0003hf-8Q
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 10:03:38 -0400
Received: by mail-ot1-x342.google.com with SMTP id q21so8056195otc.7
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 07:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MIJJlagxHPmOgfuISOsEBqz+aj54Iz3tGWYgmF5TVnU=;
 b=rfeWayypfFKzvw8ffYQ3rszSXtsjiKBvvarrdvhJJgrgRFty3bBVt6G1IZLVTyE21Z
 XolgXYv/OPQylx3nBXwjf2LB4i7llCJpwt7ktlDJFeR7mmB5MOd5Hf1/FKHt4g+JcdRL
 DXWH1yFBOsvQIln/haDrkLZn5XnjZ32LNcbwu5GeCzbcEaQ3l0UVXSNiupqoiI8bAloU
 y2cIAO0XDdEuxSn1FJt8OLrqrlUqy9ziKr/pla2mctHsVJM+5YTi60JcQdzSjJRYWvzm
 Mh/8uPKf1YZW3Yw0P4Febj+EcdGPMcz9iiLoWZvO6LBQPQvrRTwnjYKBFZJGEqvOe3E5
 ZTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MIJJlagxHPmOgfuISOsEBqz+aj54Iz3tGWYgmF5TVnU=;
 b=DdjrEyKzJSB2diXm+7mVEpvNl7o+Sb0HpuAT5rr9NV+93kVOswsbuCsRmSzfPSc/00
 cAzD1a74fHjuZXMV73vkHeWr1+9eV7yfR7gnepxxRzLnl/ZJPuX+eXDWypOlZ9AmreT4
 WxzF6O9Of1WLsm6rrAFIgRki5UxHmoQrqS3iChsVFPAL+gEXz3s6RtCFcrUH3NhJLVE4
 78rFGHxhMrgnez8P18MDnxB18Bg2SZWlTZZ1CeSjrtvV598YNaxjF+/cwYT14nPRg5IN
 IwL47bLPm0RODwPTAq4pzcPLiBBAtldvuxuePco4k7JlbI7z/5IbZDi+d11Im2Rl04p/
 Zkiw==
X-Gm-Message-State: AOAM531wHPtYgsgT0UnwpLNNmsymZd0SS+2A6DysXmAiNGxSa14wJ/+E
 V7ERM/Hjnoo5X4dpqkF8YZc//AL0REyOVRfOceuKGw==
X-Google-Smtp-Source: ABdhPJyONp1OosxmeT7MDdrAIgbLjhVoYKGSxH0+C3lJ3709B5H/JG5u9NRh1FtHEEfrHFmV657YvEzTHvT3s15Zji4=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr7681518otk.221.1593439402966; 
 Mon, 29 Jun 2020 07:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-3-peter.maydell@linaro.org>
 <115c9299-8694-469d-e787-d03f12dc417c@amsat.org>
In-Reply-To: <115c9299-8694-469d-e787-d03f12dc417c@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jun 2020 15:03:12 +0100
Message-ID: <CAFEAcA9sC6QgidJ833X6-5cp5mCNkTyBcwxQPbAk0csJatMKiA@mail.gmail.com>
Subject: Re: [PATCH 02/17] hw/arm/spitz: Create SpitzMachineClass abstract
 base class
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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

On Mon, 29 Jun 2020 at 09:55, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> On 6/28/20 4:24 PM, Peter Maydell wrote:
> > For the four Spitz-family machines (akita, borzoi, spitz, terrier)
> > create a proper abstract class SpitzMachineClass which encapsulates
> > the common behaviour, rather than having them all derive directly
> > from TYPE_MACHINE:
> >  * instead of each machine class setting mc->init to a wrapper
> >    function which calls spitz_common_init() with parameters,
> >    put that data in the SpitzMachineClass and make spitz_common_init
> >    the SpitzMachineClass machine-init function
> >  * move the settings of mc->block_default_type and
> >    mc->ignore_memory_transaction_failures into the SpitzMachineClass
> >    class init rather than repeating them in each machine's class init
> >
> > (The motivation is that we're going to want to keep some state in
> > the SpitzMachineState so we can connect GPIOs between devices created
> > in one sub-function of the machine init to devices created in a
> > different sub-function.)
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  hw/arm/spitz.c | 91 ++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 55 insertions(+), 36 deletions(-)
> >
> > diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
> > index 9eaedab79b5..c70e912a33d 100644
> > --- a/hw/arm/spitz.c
> > +++ b/hw/arm/spitz.c
> > @@ -33,6 +33,26 @@
> >  #include "exec/address-spaces.h"
> >  #include "cpu.h"
> >
> > +enum spitz_model_e { spitz, akita, borzoi, terrier };
> > +
> > +typedef struct {
> > +    MachineClass parent;
> > +    enum spitz_model_e model;
>
> Nitpick, I'd drop the not very useful typedef and use
> directly ...:
>
>        enum { spitz, akita, borzoi, terrier } model

This is just code motion, I didn't want to mess with the
existing way this enum was defined.


> > -static void spitz_common_init(MachineState *machine,
> > -                              enum spitz_model_e model, int arm_id)
> > +static void spitz_common_init(MachineState *machine)
> >  {
> > +    SpitzMachineClass *smc =3D SPITZ_MACHINE_GET_CLASS(machine);
> > +    enum spitz_model_e model =3D smc->model;
>
> ... and use 'smc->model' in place.

Similarly here I used smc->arm_id in-place because there
was only one user, but went for model =3D smc->model because
there were multiple users and it would have put extra
changed lines into the patch that I didn't think were
necessary.

thanks
-- PMM

