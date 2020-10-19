Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B559C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 19:26:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08F122260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 19:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OPIzwdmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08F122260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUao4-0006wi-R4
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 15:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUanW-0006XB-3k
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 15:26:22 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:45042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUanT-0004AX-Mn
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 15:26:21 -0400
Received: by mail-ej1-x641.google.com with SMTP id a3so625023ejy.11
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 12:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gyEAa38WmX96R4CszrV4PJgX/mtpJ+oczqXJpHvInXs=;
 b=OPIzwdmrPLMCHqu9pDQ1BlPyzMa9THZysvFtvR72XvPTwv9TS/8g9KMkeBJvtl+5/2
 s9xmCHs1KUX5KcuO2BniujGHL/g7NuRGUmvsUYL5PHUUXhQYQl8VuQELISv0ptAWGV6s
 jgxRoIywc/AZSrl7iykqrE45G1cT4d0P0ZT/4t8pDEUJYjjGTCf6VTu5pMdb3VxqXfRh
 MFgO7Dl2TpW+UKZAzRZzYlQbcFkAuEJyz+Ql2Q94OCCsnRrJu5e+/WwV0FoD1njP6Yp3
 tMk/jjr9tG2ZIkOu5MhbXYGY9NErZm5J+/yCNiCcg3VFHK9osrJVpWJ1cAmwCbbz/lbD
 oOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gyEAa38WmX96R4CszrV4PJgX/mtpJ+oczqXJpHvInXs=;
 b=RP/gbnHpEuv6glAuOivJzRZ8ZPHm6Iy//xk/aabkoeW9HEVCw2BiuUDep9nHZmXxC9
 Mt/ygWGnMvJ/LDbiKup8CiHqo6zXFQvk25g9O40mOTStEt0BCDiclgpqZwGrvZH1xye2
 PzUvfMl/olVnlTNiuq8OvYL4wBbO5Ke+EkClmK7ErK00RETsTMIclK+Zgl3lJwhnKdy/
 5BlTRKyWCStrR3JAwH4yVlcwtj50H+cWa+6Y6GVB3/O/4q3OoqinF4Sc9PRtF/busTnP
 7LsXs9m7IM7LcbCRTRPa599ZpprGudnbly5mZeqKu8GcDBLZkjuM2HR0TAfHP/DSulcr
 G1fg==
X-Gm-Message-State: AOAM533hh0b+cMkojfXfcYsTTaBY+LjQN8XP1sDIZFxK2mfRKayRhPrn
 SrE3hKQx36KmJSw+p64s31twPONehTiOS+JaoA+POg==
X-Google-Smtp-Source: ABdhPJyxjXBErdTikupKyOf4g6Ar1joyN7UGRfPsVK/NfL0p014e29Y7HysZjQRghoYnO1t/JW7VKA1p+ucWbxFY4cY=
X-Received: by 2002:a17:906:ad87:: with SMTP id
 la7mr1403224ejb.85.1603135577263; 
 Mon, 19 Oct 2020 12:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201014193355.53074-1-dgilbert@redhat.com>
In-Reply-To: <20201014193355.53074-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2020 20:26:05 +0100
Message-ID: <CAFEAcA8CYt-rkovgj_5kMtygsPNm3C4F6yi4s3cb0bduz7+NaA@mail.gmail.com>
Subject: Re: [PATCH] arm/trace: Fix hex printing
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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
Cc: Eric Auger <eric.auger@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 14 Oct 2020 at 20:36, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Use of 0x%d - make up our mind as 0x%x
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/arm/trace-events | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index c8a4d80f6b..a335ee891d 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -41,7 +41,7 @@ smmuv3_get_cd(uint64_t addr) "CD addr: 0x%"PRIx64
>  smmuv3_decode_cd(uint32_t oas) "oas=%d"
>  smmuv3_decode_cd_tt(int i, uint32_t tsz, uint64_t ttb, uint32_t granule_sz, bool had) "TT[%d]:tsz:%d ttb:0x%"PRIx64" granule_sz:%d had:%d"
>  smmuv3_cmdq_cfgi_ste(int streamid) "streamid =%d"
> -smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%d - end=0x%d"
> +smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%x - end=0x%x"

Ah, I missed that you'd sent this patch before.

Eric, do we want to use hex here, or should we go for
decimal the way we do with (almost) all the other
tracing of stream IDs (eg mmuv3_cmdq_cfgi_ste in the line before)?

The other odd-one-out is smmuv3_find_ste which prints a hex
SID; I think the other tracing of SIDs is always decimal.

thanks
-- PMM

