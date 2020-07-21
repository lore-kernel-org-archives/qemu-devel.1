Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9F5C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D91206E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e714iGm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D91206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxtKS-0001yu-Vn
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 10:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxtJi-0001T7-Ty
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:32:27 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxtJf-00059M-5l
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:32:26 -0400
Received: by mail-oi1-x241.google.com with SMTP id w17so17375649oie.6
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 07:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=i0ob6jc9ugEIZAWS/Uz3YIjBW+go2x50zCkeOmTU/gY=;
 b=e714iGm72hOC0VCtXmx1W7lAWRLH8OSknDkWiWCk5iqJ1qcvdvo4VYx9+ZDf2Univa
 TkTZ+RNep+Lah+X4eVIjeLrUM8/jNXy56BSI++whUBRbtq4NUtbgAIBeZ/Vi+AfMJsZd
 RrnWUwtIoTEP/3ZAK5fWzjz9y9E4CVooqEGQ4TfDtRyvP8LwaT5rIW6tv+qgW3ob8QpV
 d05VQEsdZdbHYHCrI8IZEI1dE241C8ezp/384hePSTRT4bjaVQo0DkeyBgXCoVXlQ7Z6
 ovKwIeqshwqPdUhxhd8lvSwvUV4kwEggsCawo2KGURHASr1kfVOyMSTdzbfKAvNwtmxB
 Ye9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=i0ob6jc9ugEIZAWS/Uz3YIjBW+go2x50zCkeOmTU/gY=;
 b=EPSdG6k5DncNugCClnk1yACYEiNBVoYtv3NFGJuOUpVDQORXcszPM9x02c/yONTYuQ
 rZmfSr/OrO6BjXiZhskyZ3RkEuwX5oBS+HGe69wFI+BgXfJlVbeBm291tSn0x+Xfogd6
 ZchVgLaHlsws+kkJg9NAFIDj09NA4lIvgYWtWsbQ1c2yLPU60tfGXpC30GNvJYyWpEIJ
 YnW/He813lbsULOBL69ptaoLOE5B6xfiE0Zso8SNgXRhUri0J/caJrGm7bxENJNIH0ye
 4KkqIE0xsszBkCWWfo96Jf84cLd67nn6zeOI2iqX5OtbyZk/OBmcmuMaNYADS0xdDt8t
 4/8w==
X-Gm-Message-State: AOAM532z43oX/teR/7zr64mxCQWsYvBvytpmLfb1BerXpOzwXy26R3br
 Tz5KeLFngowZmBXT1IIml7zwfjyEbafiZTgoTU+LoA==
X-Google-Smtp-Source: ABdhPJyRhRNjDA0oKJF5Wo65+fq56BNsnTU8+EAbLg4qUUXQo6XA4GCgC7ZX72UNq62kvMvJfnn1fabnm5GNXFP2iVg=
X-Received: by 2002:aca:2819:: with SMTP id 25mr3032925oix.48.1595341941702;
 Tue, 21 Jul 2020 07:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200721123154.5302-1-f4bug@amsat.org>
 <20200721123154.5302-2-f4bug@amsat.org>
 <CAFEAcA_C1C-5oSrEZgJoufCc_91TdC3vv5+SUSBHHnWDGVyOCg@mail.gmail.com>
 <1e60f58f-b4b1-3490-5485-d51f4584caf4@amsat.org>
 <CAFEAcA_bDSqH=JHWJDYAehov8p1VHS8rjMFWp27-DPi2Nu8nxQ@mail.gmail.com>
 <0c235275-7cbb-7f50-2ff6-4d4ffe6a086f@amsat.org>
In-Reply-To: <0c235275-7cbb-7f50-2ff6-4d4ffe6a086f@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2020 15:32:10 +0100
Message-ID: <CAFEAcA8-1b6UQ2TLh4nRGJuo2kGK31J_UWJi1fH26tjpF5gvLA@mail.gmail.com>
Subject: Re: [RFC PATCH-for-5.1? v3 1/2] memory: Allow monkey-patching
 MemoryRegion access sizes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jul 2020 at 15:23, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> On 7/21/20 2:49 PM, Peter Maydell wrote:
> > On Tue, 21 Jul 2020 at 13:39, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
> >>
> >> On 7/21/20 2:33 PM, Peter Maydell wrote:
> >>> On Tue, 21 Jul 2020 at 13:31, Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org> wrote:
> >>> Don't you now need to g_memfree() mr->ops somewhere? Otherwise
> >>> you've leaked it if the device which owned this MemoryRegion
> >>> is hot-unplugged, I think.
> >>
> >> I haven't thinking of hot-unplug. I went with the simplest fix
> >> considering we are in freeze, and fixing the bug was more
> >> important that a leak at this point.
> >> I'll have a look at freeing this memory, hoping it is still less
> >> disruptive than a proper architectural change to fix this problem.
> >
> > Instead of g_memdup()ing the ops struct here, you could maybe
> > do it in isa_register_ioport() instead. Then you don't need to
> > worry about leaks because we know all ISA devices are not
> > hotpluggable, and the ugliness is also a bit more constrained
> > to the ISA code. (Coverity probably still thinks it's a leak though.)
>
> I tried that first but got:
>
> memory.c: In function =E2=80=98memory_region_initfn=E2=80=99:
> memory.c:1221:13: error: assignment discards =E2=80=98const=E2=80=99 qual=
ifier from
> pointer target type [-Werror=3Ddiscarded-qualifiers]
>  1221 |     mr->ops =3D &unassigned_mem_ops;
>       |             ^
> memory.c: In function =E2=80=98memory_region_init_io=E2=80=99:
> memory.c:1488:13: error: assignment discards =E2=80=98const=E2=80=99 qual=
ifier from
> pointer target type [-Werror=3Ddiscarded-qualifiers]
>  1488 |     mr->ops =3D ops ? ops : &unassigned_mem_ops;
>       |             ^
> memory.c: In function =E2=80=98memory_region_init_ram_device_ptr=E2=80=99=
:
> memory.c:1625:13: error: assignment discards =E2=80=98const=E2=80=99 qual=
ifier from
> pointer target type [-Werror=3Ddiscarded-qualifiers]
>  1625 |     mr->ops =3D &ram_device_mem_ops;
>       |             ^
> memory.c: In function =E2=80=98memory_region_init_rom_device_nomigrate=E2=
=80=99:
> memory.c:1667:13: error: assignment discards =E2=80=98const=E2=80=99 qual=
ifier from
> pointer target type [-Werror=3Ddiscarded-qualifiers]
>  1667 |     mr->ops =3D ops;
>       |             ^

I don't think you should need to change MemoryRegion::ops to
non-const for this approach. Since you allocate the memory for the
new ops struct in isa_register_ioport() you can set it
up there before assigning it to mr->ops -- you're not trying
to modify-in-place the mr->ops that's already there.

thanks
-- PMM

