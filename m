Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBC2C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 318F62173E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318F62173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Nv6-00052I-PS
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 13:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3Nm3-0002Yd-N0
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3Nm1-0003ay-T7
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:59:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3Nm1-0003ao-Lk
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:59:49 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D9EF983F3B
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 16:59:48 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id a17so2415019wrr.10
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 09:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eEGoU+iD94WM4aSpU4Ojf6q3ar3cTDVScHm1zmN3BCA=;
 b=mfxCBRYvifQle98gg3f4Pp/Aa4sI0Ts3n1+eTBeBvtFd/USnXv7VC/xAwPkZhdOP4g
 fLy2z1JejuQHIpPyiHmIamj3rnb404ykq1SJGILtKzN4BGqpVaR2582lzWMo9Mv1HtMm
 iMkm7DnfjoXoB99y0EXJHv6Sgt9XHHcKfrFO5hIgWbGjDmGdvi6sEakGUQV3/d8Br8tf
 C6MK//dBZwlbWx5CguKNbcyqgRFQFRMtzlnxccfpRtdlP9Swgp+4BZ33jpElCU3O70Ke
 N2VqP2sNGFzUk64KClt+Hn5xqXolPfDCD5BznliTbvC0u2ymTSGhb9NbWevshvcB7rDO
 e0+Q==
X-Gm-Message-State: APjAAAVS7a6/WPDn9OtP/fox/tqdReiSuJ8AC66w9Vl/mt9lrlKI81St
 vWSIMmxnM5XcfZw5XYI3q0teE2UmyQV0PcKkY1ABz9gEG+d1JQKcC1fQ2jkrj1nUyiWC4vAPnrC
 qCHtQ+lUonkZRdM8=
X-Received: by 2002:a5d:6286:: with SMTP id k6mr2276137wru.83.1567097987420;
 Thu, 29 Aug 2019 09:59:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxpgLRB5qTDVuGA44LbwnwnJOK9qZmknctg5g2fLlSI9Bb/MK73UIOa+e3WPG+t3PXxompuvA==
X-Received: by 2002:a5d:6286:: with SMTP id k6mr2276123wru.83.1567097987269;
 Thu, 29 Aug 2019 09:59:47 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id t19sm4241543wmi.29.2019.08.29.09.59.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 09:59:46 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190828231651.17176-1-richard.henderson@linaro.org>
 <20190828231651.17176-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <63d898b8-e369-c322-13e0-33bee726af82@redhat.com>
Date: Thu, 29 Aug 2019 18:59:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190828231651.17176-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 5/8] cputlb: Fix size operand for
 tlb_fill on unaligned store
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/29/19 1:16 AM, Richard Henderson wrote:
> We are currently passing the size of the full write to
> the tlb_fill for the second page.  Instead pass the real
> size of the write to that page.
>=20
> This argument is unused within all tlb_fill, except to be
> logged via tracing, so in practice this makes no difference.
>=20
> But in a moment we'll need the value of size2 for watchpoints,
> and if we've computed the value we might as well use it.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  accel/tcg/cputlb.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index c9576bebcf..7fb67d2f05 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1504,6 +1504,8 @@ store_helper(CPUArchState *env, target_ulong addr=
, uint64_t val,
>          uintptr_t index2;
>          CPUTLBEntry *entry2;
>          target_ulong page2, tlb_addr2;
> +        size_t size2;
> +
>      do_unaligned_access:
>          /*
>           * Ensure the second page is in the TLB.  Note that the first =
page
> @@ -1511,13 +1513,14 @@ store_helper(CPUArchState *env, target_ulong ad=
dr, uint64_t val,
>           * cannot evict the first.
>           */
>          page2 =3D (addr + size) & TARGET_PAGE_MASK;
> +        size2 =3D (addr + size) & ~TARGET_PAGE_MASK;
>          index2 =3D tlb_index(env, mmu_idx, page2);
>          entry2 =3D tlb_entry(env, mmu_idx, page2);
>          tlb_addr2 =3D tlb_addr_write(entry2);
>          if (!tlb_hit_page(tlb_addr2, page2)
>              && !victim_tlb_hit(env, mmu_idx, index2, tlb_off,
>                                 page2 & TARGET_PAGE_MASK)) {
> -            tlb_fill(env_cpu(env), page2, size, MMU_DATA_STORE,
> +            tlb_fill(env_cpu(env), page2, size2, MMU_DATA_STORE,
>                       mmu_idx, retaddr);
>          }
> =20
>=20

