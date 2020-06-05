Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494F4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 13:30:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15BD120663
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 13:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="irCiZYGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BD120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhCQX-0001u4-6s
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 09:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhCPh-0001D1-SJ
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 09:29:37 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45058)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhCPg-00057n-SY
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 09:29:37 -0400
Received: by mail-ot1-x343.google.com with SMTP id m2so7565967otr.12
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 06:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MjBx5mbcnQFgKZnmd+gPc0Sz7vAMpyCVxxcFHrl1+vA=;
 b=irCiZYGwlllOeb6+VEa8m03LTwSiYd5ydYRors8B/kb0ReMA5drC8vBLvJJunGEYIU
 TM9gauJg/OIaEWaGLRukEb6jybUSrgIB9PgnzkrWkREUkE8TMPAyBaFUeHj0Z/SEcMEI
 LwP8CPMLdwnBJtQtc2nExy8vUrlfqfc13MTlvGxRDsTVyJBpwmgAS0z105GqxzlMnjBW
 piol1QUGWgibpz63eEhPU5rrFkB36k/W832DYi3M81tsFsEClMna0epGdmFeFVL87mLQ
 yS+cfAP7Jdxe5XRpOqMcf2L8Q8Doh1BhKThn04U8u6sbTrxwC/TEzbNX95tO7QMPZHyo
 1s6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MjBx5mbcnQFgKZnmd+gPc0Sz7vAMpyCVxxcFHrl1+vA=;
 b=n0IMAHOpmk5D1mB3kdB1+3HXQ3BJnHDJQuxqYNJXexaaFLBX3VeHCI5PHxavXj6T+e
 xQehFITBVeLvbHRgRtNNkavhBxLSOnPP85GDwJqKEB4A2iOiFQ6u1WazCm2WRgmzNrrf
 RcTnnBRmbjoR6L0QRKD90Aa0n+MHEYb9v/c8PVUERojgAkiOKspHD9EzKbWP+bHKNDGC
 +8Ct1WA0HkORyVe5Kvfm/X6JWZiMBKU8gZ71ZDd3+18V+2+ess75cZT1hN/8V9j4ZODO
 y/q0DQqGZboHuOpmYWAkm5Gtq72qZlGLQnE6JyxA8X82Mh/uCxtcLDf7VP9O+zrYwpNa
 yjbQ==
X-Gm-Message-State: AOAM531lecdTGjgM06iFjloKWtIqBlFOhUdUz1p5jV+Jc3hcs5XCc/8U
 LpLzjR1B9QYeEFz8eDQwtpSgfXNGVFD+vdT8/6JBig==
X-Google-Smtp-Source: ABdhPJyEoglVWqZSwsHTkP0EWdHkvs8OEXCpE1E62uXongN86V6iQAdKayr+FFCaQHhNm4lfUW261qRbBXFVZLLmzjk=
X-Received: by 2002:a9d:b82:: with SMTP id 2mr7256440oth.221.1591363775642;
 Fri, 05 Jun 2020 06:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200603055915.17678-1-f4bug@amsat.org>
In-Reply-To: <20200603055915.17678-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jun 2020 14:29:24 +0100
Message-ID: <CAFEAcA_SZ=Byk8_-GURDEWP+WuaJXwYF9rz1b+4XwPi8GSf9wA@mail.gmail.com>
Subject: Re: [PATCH v3] hw/adc/stm32f2xx_adc: Correct memory region size and
 access size
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, Seth Kintigh <skintigh@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 at 06:59, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> The ADC region size is 256B, split as:
>  - [0x00 - 0x4f] defined
>  - [0x50 - 0xff] reserved
>
> All registers are 32-bit (thus when the datasheet mentions the
> last defined register is 0x4c, it means its address range is
> 0x4c .. 0x4f.
>
> This model implementation is also 32-bit. Set MemoryRegionOps
> 'impl' fields.
>
> See:
>   'RM0033 Reference manual Rev 8', Table 10.13.18 "ADC register map".
>
> Reported-by: Seth Kintigh <skintigh@gmail.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>



Applied to target-arm.next, thanks.

-- PMM

