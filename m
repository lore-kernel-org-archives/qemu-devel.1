Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2658EC4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 686622076C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nLZKzi76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 686622076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQASg-0004gC-2a
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 10:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQARJ-00038V-DB
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 10:29:12 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629]:34279)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQARG-0003cU-2S
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 10:29:08 -0400
Received: by mail-ej1-x629.google.com with SMTP id u8so3290035ejg.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 07:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OoFgoofjsmYL58cW4VnPw0ke8EQ+W3YO/cvn1z5iJ2k=;
 b=nLZKzi76+qawzoYR4YDzJGOyL0yrQ54C9/43BLw7dM37NckCzkY91PRZyX3pcpnFO1
 ktf01yi33TiTaRdgqGc+nrjHCPbM/wwVOa4LJDRzzloR5oBw9c+U1CUCfRuVv/gpBb5M
 zHXRV1n1xWyIC+mc5rQbD/RMfScSAesz1PJgY8TXvzd2UW7hQldPavXfuH4rGFwAjq8S
 Uw0lU/f0TXijdpim/SZlEhmaY0yoKmwOu4/VcRLbsCqJYtU2r89Gt5zk9rDN5XdG6HZS
 DrEMC835OZp+txmoGE1UhK/muwOfNnr2O3Ez/MEL4kip1wZoB+UfNTMxjMczewCqdG1G
 A10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OoFgoofjsmYL58cW4VnPw0ke8EQ+W3YO/cvn1z5iJ2k=;
 b=tPxLUxndLHnb1HmZh4/9LJc9pyahG7i7lYycnKtnpqCdh66ED91wps4aJlTYmqliBB
 JXCgdubuEIuxisKcs7qF914dO+gK5aK9X+6karklMEYhczqy/TnRHaM73Fh32BSg4pck
 QFB1xksLubNTx4yn4QL7D4hvHQkybvWbTXOmqkx7ftKpt9hGVJlEwbKNKh7cHSSo110P
 y2pdIwAhPkYXAi2dFO+kl/l2Sxj3b66NJHT2b8RCcu3YIXHS0LZDZiYJv7GB2r159VIW
 FdQPauYnyeTRE4Cb0mYXtwYkFBXgP7m1iXDFtqYnU8f4wFzMdC6al6Gu47DB+kFxk7Ol
 5fGg==
X-Gm-Message-State: AOAM532r324jiJJDzwnQe4Jz4q06PjGaoZlFAdceLAgOmhwI5ZNj1Wkx
 r38BZSDKpE+UJoJANsAG58HHfyOK+uF78zXwOJePDQ==
X-Google-Smtp-Source: ABdhPJzdwi+gszzbKUEzixu4d6GKV3f9Avex/ohrw/UVSIKM1Nv/RXhruPHL7bKsYiBC6mLUwFaFFYexVWphjXeP0Ys=
X-Received: by 2002:a17:906:ce21:: with SMTP id
 sd1mr3746064ejb.4.1602080944066; 
 Wed, 07 Oct 2020 07:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201006220647.GR7303@habkost.net>
In-Reply-To: <20201006220647.GR7303@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Oct 2020 15:28:52 +0100
Message-ID: <CAFEAcA_se7jErv9AFM2D7UdDMurB9Lb6W9aAXD6648spQ6idKg@mail.gmail.com>
Subject: Re: Purpose of QOM properties registered at realize time?
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 6 Oct 2020 at 23:06, Eduardo Habkost <ehabkost@redhat.com> wrote:
> While trying to understand how QOM properties are used in QEMU, I
> stumbled upon multiple cases where alias properties are added at
> realize time.
>
> Now, I don't understand why those properties exist.  As the
> properties are added at realize time, I assume they aren't
> supposed to be touched by the user at all.  If they are not
> supposed to be touched by the user, what exactly is the purpose
> of those QOM properties?

QOM properties are not solely provided for the benefit of the user.
We also use them a lot in board and SoC code as the interface
by which C code says "create an object, configure it, connect it".

(This was partly motivated in the original QOM design I think by the idea
being that eventually one might be able to completely define a board model
purely declaratively by specifying all the devices and properties and
wiring everything up that way. Needless to say we've never really
taken any serious steps towards actually doing that.)

> For reference, these are the cases I've found:
>
> $ git grep -nwpE 'object_property_add_alias|qdev_pass_gpios|qdev_alias_all_properties' | grep -A1 realize
> hw/arm/allwinner-a10.c=71=static void aw_a10_realize(DeviceState *dev, Error **errp)
> hw/arm/allwinner-a10.c:89:    qdev_pass_gpios(DEVICE(&s->intc), dev, NULL);

This kind of thing, and also the sd-bus cases, is where an SoC device wants
to expose some GPIO lines or an sd-bus which is actually implemented by
a device which exists inside the SoC (and which the SoC has created and
wired up). The effect is that for the user of the SoC object the gpio/sd-bus
can be used as if it was directly implemented by the SoC object, when it's
actually just being passed through to the internal device.

I'd have to look at the code to find out whether it's really necessary in all
cases to do this pass-through setup at realize rather than instance-init.

In this case:

> hw/arm/armv7m.c=149=static void armv7m_realize(DeviceState *dev, Error **errp)
> hw/arm/armv7m.c:219:    qdev_pass_gpios(DEVICE(&s->nvic), dev, NULL);

there's a comment on the immediately preceding lines which explains what
the code is doing and why it is being done in realize:

 215     /* Alias the NVIC's input and output GPIOs as our own so the board
 216      * code can wire them up. (We do this in realize because the
 217      * NVIC doesn't create the input GPIO array until realize.)
 218      */

Possibly one could move the code in the devices which creates the
GPIO array/sdbus/whatever so that it does so in instance_init
rather than in realize, and then more of these "alias a connection
through" bits of code could also move to instance_init. But there are
cases where the GPiO/etc can only be created in realize because
the number of GPIOs depends on properties of the device and so isn't
know at instance_init time.

-- PMM

