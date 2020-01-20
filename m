Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C3EC33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:01:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C09642073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cegzxV6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09642073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itSvj-0000CX-0C
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 04:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itStp-0006P0-Ca
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:59:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itStl-0005xe-El
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:59:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37812
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itStl-0005xU-B1
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579510744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QLeGA6rwLKeN0qWzMM8AQK49imPE+u48qjNNGf/QAj8=;
 b=cegzxV6dtvcr635v5PK/LCgx+pRItewW4GbSYJc6FUFj0YcQSWEVGshByiPwzp5Ihf/Oun
 k/pXkPxsVIXKXiRJBZnnn1v0vKKOnWMgSG2bjMCZVidxCd4U3kPJJMfbYal5tFU1O/lOLb
 qRE3RB58yp7lLjbd+WRKUzRpI/tzHak=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-w3cE2gpWMp2uA3_0ROEosA-1; Mon, 20 Jan 2020 03:59:03 -0500
Received: by mail-wr1-f69.google.com with SMTP id t3so13784672wrm.23
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 00:59:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FTfvdK8YO79ORnrLytoohB4ixzO6XV1lNmJU6O2VSv8=;
 b=VDZkEHktYsKTOM178jekG3f8g8ZHdtUpOwr77TBADuK/I4gNCBKRAJFnCoxDIrqHqT
 sXAtmLKN6vGm9MRS07uVGg50sQ/AVcCvB0xlEd/I+B8RZxAsHUV++6mUbH3BSYXI+g4+
 yRluUajGb/fbgHPmKQ6olt0KHDP58bBvf1cHnrRcftZL5hEngzxthoxYKzUxBq8XZugq
 kyXu2aaGTSFfX7k8/laWu0//1nv+btFXlf1jAQoiOlZPdeb3+FxjEuP/vQHoRi3OZdSb
 58vk58RC33gCuo/TbRXFFjjZHfH3QFsrz3jCIdZ22w+HoRF7MAmoUvoDSCJxN+Ndu73y
 muvQ==
X-Gm-Message-State: APjAAAXJxyJon2zhNvzEE6d0Ir8kuBQNKOW0Q7C3rhS5VNpVFLiMP9aU
 XmEVpJG3rSvYlM3BKZay7un0RSJcbe+6wxPyH8pEN1fu+W6/6Tpm69tnbF8aZyPGO5b4f8ybszV
 kfG892920dDiXbS0=
X-Received: by 2002:adf:dfc2:: with SMTP id q2mr17678196wrn.251.1579510741168; 
 Mon, 20 Jan 2020 00:59:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxpLqKcKhfaHDcy4uNqF+kXQRnw3Zw75P6nH6WkiuC8+LuinJEo4RnCavg+HWDcnFhv7EHObA==
X-Received: by 2002:adf:dfc2:: with SMTP id q2mr17678173wrn.251.1579510740802; 
 Mon, 20 Jan 2020 00:59:00 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id u22sm48849373wru.30.2020.01.20.00.59.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2020 00:59:00 -0800 (PST)
Subject: Re: [PATCH 5/9] cputlb: Hoist tlb portions in
 tlb_flush_one_mmuidx_locked
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200109024907.2730-1-richard.henderson@linaro.org>
 <20200109024907.2730-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2e3b9df8-f225-48b3-75b1-c01b24f489ec@redhat.com>
Date: Mon, 20 Jan 2020 09:58:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109024907.2730-6-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: w3cE2gpWMp2uA3_0ROEosA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/9/20 3:49 AM, Richard Henderson wrote:
> No functional change, but the smaller expressions make
> the code easier to read.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   accel/tcg/cputlb.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index c7dc1dc85a..eff427f137 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -230,15 +230,16 @@ static void tlb_mmu_resize_locked(CPUTLBDesc *desc,=
 CPUTLBDescFast *fast)
>  =20
>   static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
>   {
> -    tlb_mmu_resize_locked(&env_tlb(env)->d[mmu_idx], &env_tlb(env)->f[mm=
u_idx]);
> -    env_tlb(env)->d[mmu_idx].n_used_entries =3D 0;
> -    env_tlb(env)->d[mmu_idx].large_page_addr =3D -1;
> -    env_tlb(env)->d[mmu_idx].large_page_mask =3D -1;
> -    env_tlb(env)->d[mmu_idx].vindex =3D 0;
> -    memset(env_tlb(env)->f[mmu_idx].table, -1,
> -           sizeof_tlb(&env_tlb(env)->f[mmu_idx]));
> -    memset(env_tlb(env)->d[mmu_idx].vtable, -1,
> -           sizeof(env_tlb(env)->d[0].vtable));
> +    CPUTLBDesc *desc =3D &env_tlb(env)->d[mmu_idx];
> +    CPUTLBDescFast *fast =3D &env_tlb(env)->f[mmu_idx];
> +
> +    tlb_mmu_resize_locked(desc, fast);
> +    desc->n_used_entries =3D 0;
> +    desc->large_page_addr =3D -1;
> +    desc->large_page_mask =3D -1;
> +    desc->vindex =3D 0;
> +    memset(fast->table, -1, sizeof_tlb(fast));
> +    memset(desc->vtable, -1, sizeof(desc->vtable));
>   }
>  =20
>   static inline void tlb_n_used_entries_inc(CPUArchState *env, uintptr_t =
mmu_idx)
>=20


