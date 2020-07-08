Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AB6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D66520658
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="moiHIs1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D66520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtDWC-0000Fl-Jz
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 13:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jtDUr-0006mO-Jg
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 13:04:37 -0400
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44]:35643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jtDUp-0002WA-13
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 13:04:37 -0400
Received: by mail-vs1-xe44.google.com with SMTP id k7so23533520vso.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 10:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LZvm645YUPRqCMI/6A0GeNSLeLiO3QA47ljKgfkhAYM=;
 b=moiHIs1LQS/dFXJamRIz8QO0mxOQEu9S8EqNKWg3geEhz5jqJD7NXJ43FR14X7zcRq
 H6SPSnfuuB5AiJKEMQrC+Z1h01INtd8OBtQkKgOws+ZBJRPjZnyMjem0IytXrQNDLqMC
 e/yNlDWTT0ZLFix0KtTLKM3KsuRWwIVAANlOeztkSc63l3rNTCAJcsTpS/Te5oxvHzUl
 Z11a1T4rohIzQbD1Cnjb+9ZB/x6Y0QQsxgKG1GfF3P3J1jQeojWb3hSIh5bx5c33zskN
 +fYUdxuyuAqofGkDeLX+LW/1lr180GEJR7h9G65fKx3h2a409A4hK+HqwX1nh3PYyalI
 0M3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LZvm645YUPRqCMI/6A0GeNSLeLiO3QA47ljKgfkhAYM=;
 b=gLILwaCzntVMcmfDW6xGQdEwQS31GcLgZEIE/TFqFxrpig4rxCYVgzoi0yKRCoYBHG
 BBCWBkspW0GLkUvVTztXRv0sWUHrcPm/yq+RX0jrTLoGPkM94CZBy9XYt5+qdjtr666v
 dwPDS9RAYpvAmnSKRusSd0sk+3yf1UegKc4GOjUYf4kkRq8/j44BqlAIiMD4Gdi6QNxI
 lijXb8jLVSJo4pAULsWq1GgjD4PIPDdAy3hfl7at8ADhxs0ZFJPHB0KJF1q7/ldQtuDT
 nkO3aDk3dbg3Cd7tM3VEBCHvUuamh14ljmaZzdLL/gu3OOvEDw5REPaCd+5Kay/GZxwC
 6SEg==
X-Gm-Message-State: AOAM531jfaY/SSvHM3OTHN7hp8nDhNb+xYFxK3P0kik7vMv6e5BUiWTH
 8fnjjJvz+Vw9SmPXgWSAWsShNDjM1EhqnAYH9nUyxg==
X-Google-Smtp-Source: ABdhPJyhKnykmXokkh3AIm6dMyxBSo8xX8+JWqxA0I96evXJBhHGrANYROQCJbxeJFDNo2ri0DFpgHE+sfAhPLDBbDg=
X-Received: by 2002:a67:7f8e:: with SMTP id
 a136mr38634537vsd.232.1594227873588; 
 Wed, 08 Jul 2020 10:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200707184730.3047754-1-hskinnemoen@google.com>
 <20200707184730.3047754-9-hskinnemoen@google.com>
 <f303f648-91a3-b59b-390f-8f25ec7b4ff1@amsat.org>
In-Reply-To: <f303f648-91a3-b59b-390f-8f25ec7b4ff1@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Wed, 8 Jul 2020 10:04:22 -0700
Message-ID: <CAFQmdRZEgYnh-s47Pkx1w-A3n1ddv6LaVKsmk=uj6yMH6co+iw@mail.gmail.com>
Subject: Re: [PATCH v4 08/12] hw/nvram: NPCM7xx OTP device model
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e44;
 envelope-from=hskinnemoen@google.com; helo=mail-vs1-xe44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 8, 2020 at 1:54 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> On 7/7/20 8:47 PM, Havard Skinnemoen wrote:
> > +    value =3D tswap32(nc->disabled_modules);
> > +    npcm7xx_otp_array_write(&s->fuse_array, &value, 64, sizeof(value))=
;
>
> What is magic offset 64 for?

Good point. I'll add some definitions based on

https://github.com/Nuvoton-Israel/bootblock/blob/master/Src/fuse_wrapper/fu=
se_wrapper.h#L23

> > +        /* Preserve read-only and write-one-to-clear bits */
> > +        value =3D
> > +            (value & ~FST_RO_MASK) | (s->regs[NPCM7XX_OTP_FST] & FST_R=
O_MASK);
>
> Trivial to review as:
>
>            value &=3D ~FST_RO_MASK;
>            value |=3D s->regs[NPCM7XX_OTP_FST] & FST_RO_MASK;

You're right, will do.

> > +/* Each OTP module holds 8192 bits of one-time programmable storage */
> > +#define NPCM7XX_OTP_ARRAY_BITS (8192)
> > +#define NPCM7XX_OTP_ARRAY_BYTES (NPCM7XX_OTP_ARRAY_BITS / 8)
>
> You could replace 8 by BITS_PER_BYTE.

Will do.

> > +typedef struct NPCM7xxOTPClass {
> > +    SysBusDeviceClass parent;
> > +
> > +    const MemoryRegionOps *mmio_ops;
> > +} NPCM7xxOTPClass;
> > +
> > +#define NPCM7XX_OTP_CLASS(klass) \
> > +    OBJECT_CLASS_CHECK(NPCM7xxOTPClass, (klass), TYPE_NPCM7XX_OTP)
> > +#define NPCM7XX_OTP_GET_CLASS(obj) \
> > +    OBJECT_GET_CLASS(NPCM7xxOTPClass, (obj), TYPE_NPCM7XX_OTP)
>
> If nothing outside of the model implementation requires accessing
> the class fields (which is certainly the case here, no code out of
> npcm7xx_otp.c should access mmio_ops directly), then I recommend
> to keep the class definitions local to the single source file where
> it is used. This also makes this header simpler to look at.

Good idea. Will do.

> Very high code quality, so I just made nitpicking comments.
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thank you. I'll incorporate your feedback and send out a v5 series shortly.

Havard

