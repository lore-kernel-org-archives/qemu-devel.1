Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715A2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:16:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 395EA23B23
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tkRr1fBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395EA23B23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpsiR-0001BM-Ge
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 08:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpsga-0008AI-2T
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 08:14:56 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42303)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpsgW-0002Y1-16
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 08:14:55 -0400
Received: by mail-ot1-x344.google.com with SMTP id 76so813474otu.9
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 05:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hW7yJXdhX/RvTJ5BItP5eRGZZ96HIYQvPLkD9KDjX3M=;
 b=tkRr1fBGDeuePD3eNQxMULwrOxOuDeoeB2o6LC4Mlsv0dhDXWv/u7fYm5bf6lyif/G
 PVTup3xkx7HM6OPTVue+MWMOvzU6OcQpVs6ZopL6GMAtj4UxAo+YhRjs3jogqdf/z6qw
 qZmCZ8ebn4CPnUGVMpFpO5n6WwqVf/cVrbEpxqR2rPTDJeLRoxPr/nEwBK1WwamhCf3M
 VENHwoaDh8rUPglx+4pgXO346GK/frrApsD28ONT4j1uGbA2NOukielXQFZoGOc/oUzM
 QfxWGWP+jCufaiqIRNqwl3ODHYshaHfBEB+l0o24fMwGHiGXhX7c4uroca1u4APp47Ul
 XUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hW7yJXdhX/RvTJ5BItP5eRGZZ96HIYQvPLkD9KDjX3M=;
 b=cxKXNjVBGlenDwi9kSrmze1TbZKf2LaU+L1Hy7uhRc2WnJYbOFBieQh7N3GZm93abP
 Qdfs/rMi8vuZMylZ91nocRLteX4342+I5hCbUqSKM/abseuNPKa4BbrFVOkGVLrbH0+k
 mNsKqe0k47+txGctFFG0yCOGMe0XB4zezM2ha4D+vtdTIq0Bj7+pe4cGSK+56F2JYNGN
 B7S/QBfna1UTbOGQoNZNguerv/xPRtN5k6uAe5aBvAGLBrLuqgGsWXFyJRPW0Ta30Gt0
 90zQ22aEoa8lJZ2HSJZtNgpzBJ0MCTxPZvttAxRjQAzYatgCtWS240Jhh1O+o/jA+bL1
 O1yA==
X-Gm-Message-State: AOAM530p6ZJK+efMkE5mOxIoL362v2Q+Lf6FXtG5Jovs+F65ZCCbSmG2
 reTY35ZRkwAEC9tE2gEFB8mQnpcb0WN+PIpwHA4LTw==
X-Google-Smtp-Source: ABdhPJw4byIb72KCeF2z0Bnxc5hvm2/yMr+8E+L+hL68w+CCTuYDGzAtPYt54jCayZzfqC0zpzg6WZpve9FwSWPDQ1A=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr10451838ota.91.1593432890691; 
 Mon, 29 Jun 2020 05:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200628203748.14250-1-peter.maydell@linaro.org>
 <20200628203748.14250-3-peter.maydell@linaro.org>
 <bdc37753-de8e-eba4-75e0-32eada401b24@amsat.org>
In-Reply-To: <bdc37753-de8e-eba4-75e0-32eada401b24@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jun 2020 13:14:39 +0100
Message-ID: <CAFEAcA-qwjBwxF61NWuDhQACkvGa3TkjWWEbnMX+Uu+J7orzZg@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/arm/tosa: Encapsulate misc GPIO handling in a
 device
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jun 2020 at 10:39, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Hi Peter,
>
> On 6/28/20 10:37 PM, Peter Maydell wrote:
> > Currently we have a free-floating set of IRQs and a function
> > tosa_out_switch() which handle the GPIO lines on the tosa board which
> > connect to LEDs, and another free-floating IRQ and tosa_reset()
> > function to handle the GPIO line that resets the system.  Encapsulate
> > this behaviour in a simple QOM device.
> >
> > This commit fixes Coverity issue CID 1421929 (which pointed out that
> > the 'outsignals' in tosa_gpio_setup() were leaked), because it
> > removes the use of the qemu_allocate_irqs() API from this code
> > entirely.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > This is simpler than the spitz changes because the new device
> > doesn't need to refer to any of the other devices on the board.
> > ---

> > +#define TYPE_TOSA_MISC_GPIO "tosa-misc-gpio"
> > +#define TOSA_MISC_GPIO(obj) \
> > +    OBJECT_CHECK(TosaMiscGPIOState, (obj), TYPE_TOSA_MISC_GPIO)
> > +
> > +typedef struct TosaMiscGPIOState {
> > +    SysBusDevice parent_obj;
> > +} TosaMiscGPIOState;
>
> Since we don't really use this type, can we avoid declaring it?

I prefer to be consistent. QOM's implementation allows this kind
of shortcut where you don't provide everything that a typical
leaf class provides if you don't need all of it, but then it
gets confusing if later on somebody wants to add something
to that leaf class. I think it's less confusing to have
just two standard patterns:
 * leaf class, no subclasses
 * a class that will be subclassed
and then always provide the same set of TYPE_*, cast macros,
structs, etc for whichever of the patterns you're following,
even if it happens that these aren't all needed.
(https://wiki.qemu.org/Documentation/QOMConventions
does a reasonable job of saying what the standard pattern
is for the subclassed-class case, but is a bit less clear
on the leaf-class case.)


> > +static void tosa_misc_gpio_init(Object *obj)
> > +{
> > +    DeviceState *dev =3D DEVICE(obj);
> > +
>
> Ah, MachineClass does not inherit from DeviceClass, so we can use
> it to create GPIOs.
>
> Something is bugging me here, similar with the LEDs series I sent
> recently.
>
> GPIOs are not specific to a bus. I see ResettableClass takes Object
> arguments.
>
> We should be able to wire GPIO lines to generic Objects like LEDs.
> Parents don't have to be qdev.

Yes, this is awkward. You pretty much have to inherit from
SysBusDevice assuming you want to get reset (the few cases
we have which directly inherit from Device like CPUs then
end up needing special handling).

> Having to create a container to wire GPIOs or hold a reference
> to a MemoryRegion sounds wrong.

I agree that it would be nicer if MachineState inherited from
Device (and if Device got reset properly). But that's a huge
amount of rework. For this series I'm just trying to improve
the setup for the spitz board, and "logic that's more than
just wiring up devices to each other needs to live inside some
device, and can't be in the board itself" is the system we have today.

thanks
-- PMM

