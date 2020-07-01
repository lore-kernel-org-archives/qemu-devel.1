Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7063C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 01:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C46E2074D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 01:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEs0i9i0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C46E2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqRU6-0002nO-SK
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 21:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jqRTY-0002Mi-Nm
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 21:23:48 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jqRTW-0005Pj-OW
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 21:23:48 -0400
Received: by mail-ot1-x341.google.com with SMTP id 18so20150996otv.6
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 18:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Zm4yZ05PqBp5LXCkpP7pNaqq1xFxWCiEPlJKoMlI91k=;
 b=KEs0i9i07U2mf9T8b3DiFTeNwxOrnbxPw/IsM3+hfvkgDSSuVMdEGw08FzfsWzIwjX
 /F/ZSGEKSte1ijWRJvORD9ndlWqxEUmb64tDwPoIsHIpIg/7mBrjOxO0IT3IH/P+Q7cS
 XkyMeBwsJRABqI9rpptckcMkdz///7Cm2Et5ixNZumMm6aBYqzJynHikK0mgb6b+wv9K
 ZYX4Hz0c0L9cgMy5cYe1t0mB8HnpkbLff8rZryVEpbbrdfBfwuq4noMCB9Rpy4Eduumn
 SePCSr5D0dYTC8w6/+b63sMPrJteLMO9FiwcPTcy07rZfmBx8PFE5T4HKHu05DGAbjWP
 waeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Zm4yZ05PqBp5LXCkpP7pNaqq1xFxWCiEPlJKoMlI91k=;
 b=blJssZE5WPmNfQIFJU+jqHUnlw6xziaoXfM5dHcev8+smBwUvsen4VMTaFs8YUkmGi
 glBAA1kdTWl6M/E1BKlO0MZwkXDmwMkaAbDQtrRfxo0L2l79YO1zkj0V0iZrqoxoDd97
 rE18uiH1eDQSOF5iBBuy9ifNptuROJA/4fV9s+dGJ5YAGQhiof4CHjL1eKtAq6ZMcdzv
 F4Kif1+NnDIb0YVJMD7u7dY9rJuztFL1BmeIucgjKOTow5TdU2xcQ5CYb9UB2mcpQ6MZ
 FhMHMiu7AMeJdHWXZORGcidXjXY43WZYkxE2SeuXa5C1j8Kr274LYvgXNpgNsu4nD3hp
 7h4g==
X-Gm-Message-State: AOAM531pI/C3L/pTt9xYO9bJdAIdyWuWvRMdOi4W24y7kbpwWTZ4i83f
 EnVANwEC6UBb3exyAH42Z4ypzA5tC69Ug/VPioI=
X-Google-Smtp-Source: ABdhPJzWClwvA/l5qW5aFL/duE4TGAkxxyx/oAyAEkfbq/Aheom68ju+oafPGsurfVnIWs4NCbg0alyKkITgCI9wF40=
X-Received: by 2002:a05:6830:15c3:: with SMTP id
 j3mr19181648otr.353.1593566625170; 
 Tue, 30 Jun 2020 18:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200630122710.1119158-1-ppandit@redhat.com>
 <20200630122710.1119158-8-ppandit@redhat.com>
In-Reply-To: <20200630122710.1119158-8-ppandit@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 1 Jul 2020 09:23:09 +0800
Message-ID: <CAKXe6SKZVQ4HiN2d=X6inbDVDkvTiXQ9iG5f773_Qaoj8hA_FQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] tz-ppc: add dummy read/write methods
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x341.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

P J P <ppandit@redhat.com> =E4=BA=8E2020=E5=B9=B46=E6=9C=8830=E6=97=A5=E5=
=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=888:31=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Add tz-ppc-dummy mmio read/write methods to avoid assert failure
> during initialisation.
>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  hw/misc/tz-ppc.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> Update v3: use g_assert_not_reached()
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09451.html
>
> diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
> index 6431257b52..36495c68e7 100644
> --- a/hw/misc/tz-ppc.c
> +++ b/hw/misc/tz-ppc.c
> @@ -196,7 +196,21 @@ static bool tz_ppc_dummy_accepts(void *opaque, hwadd=
r addr,
>      g_assert_not_reached();
>  }
>
> +static uint64_t tz_ppc_dummy_read(void *opaque, hwaddr addr, unsigned si=
ze)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static void tz_ppc_dummy_write(void *opaque, hwaddr addr,
> +                                        uint64_t data, unsigned size)
> +{
> +    g_assert_not_reached();
> +}
> +
>  static const MemoryRegionOps tz_ppc_dummy_ops =3D {
> +    /* define r/w methods to avoid assert failure in memory_region_init_=
io */
> +    .read =3D tz_ppc_dummy_read,
> +    .write =3D tz_ppc_dummy_write,
>      .valid.accepts =3D tz_ppc_dummy_accepts,
>  };
>
> --
> 2.26.2
>

