Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6106C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8308F20772
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gM5jz38Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8308F20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtK63-00034A-Oh
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 20:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jtK5K-0002US-3n
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:06:42 -0400
Received: from mail-vk1-xa41.google.com ([2607:f8b0:4864:20::a41]:43809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jtK5I-0005q4-JN
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:06:41 -0400
Received: by mail-vk1-xa41.google.com with SMTP id e10so42400vkm.10
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 17:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0QjbGbfdZrC4ER9Op5TZkuMTIqOSXOzGsj5W0a7/Z28=;
 b=gM5jz38ZhokgtSHk4gJ9CoFWqhE8Yryxdl/eXz6y+qXpmVJuVPgiaw6V0GMdPdyohj
 9rKup83NjrvQvlQEbk74BZHVMwHTbxVKgaH/s0cd+5ExSHws4fYgbwRoRHuiwVXIAwcb
 6se59hrOYyPbwe3sXL9iON1mg3jsEgA3YTmdNiMBy383N0MRTeYObfPgOHO4nDUAgEda
 wXvOstpgcH0dxJwPoPzYBTY6AkvJozkEk5mWRd8uM4Nc3VxbF0oI1i/C5Sn1hrcDllun
 lSxoTiY8HhxUSoDXIEumVBumS064WlBwx6gv/dmqvCdGu0JPg9eWZ1r8ifLAQr8kNlmU
 pZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0QjbGbfdZrC4ER9Op5TZkuMTIqOSXOzGsj5W0a7/Z28=;
 b=pRVDpJUiUtiVHhOpHJ1oRkAyr3NnZEwhUVyEr5kIkZwhhgwmbzhB70akftn+gCgJXZ
 O+zMk+j4wA+nOxaQafz9HCFgTaWGNrUniuMn5Qx4w1Z7/lx8Ut+XfD5Dyfn5hC34RfO3
 XOtNl9ueKhMhav93IIb9YwryGcJ8NYhQcJhl56/8pfgqpBjTa27ims7lyNefHQ2gHd0L
 aXXksgh+1AYmB51QlYF/rQut41iaVyKbDxM+u8o+P2FvX/sYiZve2nIxuBYuyK5NrXb/
 QCEYWPoH2BwdZ8vg6lNZkoUWapvKcyPpizAqNTzfhWDpWzW2Bo6GcGd+l8LRUKI8xZA0
 Y0Kw==
X-Gm-Message-State: AOAM533LiR8xFX9nOHuf6PGbnUSc2XF3U2nIiMv9mQrw/+zhAixqooYV
 cUDe/D8AMVjN7g8/eNMdWmrDocUbisrVJTMH5kb2lw==
X-Google-Smtp-Source: ABdhPJzi8caXorcntwgygNhgvgvmG03Pnd+qvUuFfbv04ZiNn9Wlqd+gPkNwBtyqZSyRZmPYMK2zpoc18bPvuuj+60k=
X-Received: by 2002:a05:6122:130b:: with SMTP id
 e11mr12160252vkp.20.1594253199000; 
 Wed, 08 Jul 2020 17:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200707184730.3047754-1-hskinnemoen@google.com>
 <20200707184730.3047754-6-hskinnemoen@google.com>
 <4b7130f2-032c-3067-b2b6-876a2b17b707@amsat.org>
 <CAFQmdRYi5QFHbcWQH-bWqAsSCidzYMedC8n+mib1DPpJuEy-Rw@mail.gmail.com>
In-Reply-To: <CAFQmdRYi5QFHbcWQH-bWqAsSCidzYMedC8n+mib1DPpJuEy-Rw@mail.gmail.com>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Wed, 8 Jul 2020 17:06:27 -0700
Message-ID: <CAFQmdRZdUKvmi_eKdtCnR8uP63sRP9X0Z7oxZES56mtSz_=7FA@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] hw/arm: Add NPCM730 and NPCM750 SoC models
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a41;
 envelope-from=hskinnemoen@google.com; helo=mail-vk1-xa41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Wed, Jul 8, 2020 at 11:13 AM Havard Skinnemoen
<hskinnemoen@google.com> wrote:
> On Wed, Jul 8, 2020 at 10:31 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
> > On 7/7/20 8:47 PM, Havard Skinnemoen wrote:
> > > +typedef struct NPCM7xxClass {
> > > +    DeviceClass         parent;
> >
> > Similar comment that elsewhere on this series, if NPCM7xxClass not used
> > outside of npcm7xx.c, keep it local.
>
> OK, will do.

Turns out it is used in npcm7xx_boards.c, so it has to stay where it is.

Havard

