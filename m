Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D196C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6789823B1D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPasSw2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6789823B1D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jprzF-0007lO-Jo
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 07:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jpryV-0007Jw-Mz
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:29:23 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jpryT-0003Ht-Rm
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:29:23 -0400
Received: by mail-ot1-x341.google.com with SMTP id t18so2320432otq.5
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 04:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uFFEcaI48VLIrx/8geVvn4XNNeo0j4Nt3nFE9nXxT68=;
 b=mPasSw2gxvmQMqAUe3weAc/U8E9p+zICEHJXPlMvrBkxOMS40yjc/i21neTBSk0gsv
 ALr722yrKOQpTkzjNUfRzUSUClopN3x4ruYc8/KP7/ilJzTLLEoUlSaLqgvMA+1/34bH
 pXsNn8pqkgFN9RDgtXDvr9Z9IxhK+zMxsQ/z//2KllUswJRhSEcBXYVvKyOe3dDPOlzP
 qVPXRdrI3H5AgClIDIxQ9j6w8KKAi5fwqetCGxwmG6kM4wIBLvqDdioDmuu6c9abko8x
 51dKCRevVlmhH9bytykXUc0aHKWItVM35mryVQA/mI2iMogysaH0jBdRwqE/wcguvuaM
 YH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uFFEcaI48VLIrx/8geVvn4XNNeo0j4Nt3nFE9nXxT68=;
 b=VkXx0+5pFVt2eSXfAymhYowPx1+tSFDIjtUvlq5hLeoc4QXxqyrOboCruXpQvd2DX2
 TYXU9QRg5bnueqSguvegFTXNVHqOu2zZiv9/Ecgcw8Or8Om/CXEyuboYFMrVQmpbcXUI
 P9DrLrh/u9vIGeSSOoeWwKsI0y5ngFSm7GD1Ch+o/Q46VGshT4eNS1zAHMcB/4d2hWOz
 VjHm9xskAh7/9uxey+ra6Gy6pLqqSRyGi1Df/J1/CFsrbMelO3lDV9/NWVKSDmEze/YO
 vLZ2nMz4AnzGweqm4bGOycrmE47RWOw5NHO0VojHujCKGTMHInLjvOgNRPjcWKVsT06E
 IisA==
X-Gm-Message-State: AOAM5322VBGC0PY4y6TQU4zczV/R1TYc/8ADPPd7wJBeaT0J3q1SqyH3
 BOvLrvH8fMrTnnAAo8D++g1gmRl5iRm8iU9wPdk=
X-Google-Smtp-Source: ABdhPJzQZ+TuR+zHog2sBw7iEo1S0UqRn/+pRWDeISQ3NWV7xbovbCNBzriGsf7+Cko+XolwF8EvKKNQLy+VtUJprvM=
X-Received: by 2002:a05:6830:1ad5:: with SMTP id
 r21mr9308715otc.181.1593430160681; 
 Mon, 29 Jun 2020 04:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200624185523.762240-1-ppandit@redhat.com>
 <20200624185523.762240-10-ppandit@redhat.com>
In-Reply-To: <20200624185523.762240-10-ppandit@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 29 Jun 2020 19:28:44 +0800
Message-ID: <CAKXe6SJHVSaEB1jfYwsiw1WjR7S7R61jkRZ4cHPXg_jfkz1FMQ@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] memory: assert MemoryRegionOps callbacks are
 defined
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

P J P <ppandit@redhat.com> =E4=BA=8E2020=E5=B9=B46=E6=9C=8825=E6=97=A5=E5=
=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=883:00=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> When registering a MemoryRegionOps object, assert that its
> read/write callback methods are defined. This avoids potential
> guest crash via a NULL pointer dereference.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  memory.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> Update v2: assert read/write_with_attrs methods
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg05717.html
>
> diff --git a/memory.c b/memory.c
> index 2f15a4b250..3d635a1bca 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1496,7 +1496,13 @@ void memory_region_init_io(MemoryRegion *mr,
>                             uint64_t size)
>  {
>      memory_region_init(mr, owner, name, size);
> -    mr->ops =3D ops ? ops : &unassigned_mem_ops;
> +    if (ops) {
> +        assert(ops->read || ops->read_with_attrs);
> +        assert(ops->write || ops->write_with_attrs);
> +        mr->ops =3D ops;
> +    } else {
> +        mr->ops =3D &unassigned_mem_ops;
> +    }
>      mr->opaque =3D opaque;
>      mr->terminates =3D true;
>  }
> @@ -1674,6 +1680,8 @@ void memory_region_init_rom_device_nomigrate(Memory=
Region *mr,
>  {
>      Error *err =3D NULL;
>      assert(ops);
> +    assert(ops->read || ops->read_with_attrs);

Though here is not 100% right as the ROM device can has no read callback.
However the device can change between ROMD mode or MMIO mode.
So I think it's ok the developer can provide a null read callback even if t=
hey
don't need it.

Reviewed-by: Li Qiang <liq3ea@gmail.com>


> +    assert(ops->write || ops->write_with_attrs);
>      memory_region_init(mr, owner, name, size);
>      mr->ops =3D ops;
>      mr->opaque =3D opaque;
> --
> 2.26.2
>

