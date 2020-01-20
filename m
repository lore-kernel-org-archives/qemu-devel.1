Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE80C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79952087E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXsbZiHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79952087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itXKH-0000cn-Dy
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 08:42:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1itXJ2-0007Ii-24
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:41:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1itXJ0-0001iH-U2
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:41:27 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53352)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1itXJ0-0001hW-Nl
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:41:26 -0500
Received: by mail-wm1-x344.google.com with SMTP id m24so14529686wmc.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 05:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=NGvJ4z0tkGo0PoZn/vkElFS3NCud6M7cPdAply088jk=;
 b=BXsbZiHMbJVQR7yOl+0bGfEudqFFpLg85yP6Ydo4Ju92dihTlxkYvRUsLIfwOQgdzC
 hGmGp06VfJWn1DyDJxYl9ZV9pZMySvEdNN3hxrK5ogcfU32enOxrCMbE4oq7R7mO9bJQ
 fjbTXE8Hn894rQQy5/0NMr/RrZRX/mPPFXEB9RPhK4nTW4Pw9bvz9qKRxropgcAZpj6X
 /W36FPN4qaOkObLD2efME0qryN1Bw/tPBhuf72C1pBTz4rP83ffGH/uBifEhaykSPtDp
 Nz2VlcM3VHimkA6Z6abd3D5OvDHJG7RAySBqeruxanfz04YlOpAxfqP7kMvohrjRezWk
 TpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=NGvJ4z0tkGo0PoZn/vkElFS3NCud6M7cPdAply088jk=;
 b=pCrPgIhEswsw0K1yaKiW0fE+mk2OSZm5lZrN7tl8Wz/dLfb48oJ9ObWTe/FT4gwmP2
 d7E7CgTKlyP9kTpFbln5ena9IGeHRL+Amq60anr6fWvHF/ao8yRF7S6s9k8AidxI3XZD
 J2QmkkaE81TyhEh1inwJjKWw+G/GpofrfCHndncWV4yDQHK+E2mbfy00c8H6Rjdh1WrH
 VI5a6EEhM6YRAPxHM5IBm35h2mgxcNhwVpiaUqG1738+8gJIz6z1bjqC7qKVF7P2rX03
 vFpNAz2sPofdx5zoewT9K7L5AFW+7DeybgLmpJhdAt9JYKWCrnLdLxXpmCI2MJRyWAzb
 T7zA==
X-Gm-Message-State: APjAAAXsJqF91KJd42hp2Ju2++CxSxRuuhwoCH0Wiwj9QlvaKPAGnhft
 uEHDStcUnEAOTvx3uA4IiPpa7w==
X-Google-Smtp-Source: APXvYqzWkOOu3zDvGR/V/3h+iRs2ovl9oRUZOPUJC1DIGFjHv3IkzRLhZE1uCccS/ZkPKFBGVu2JDA==
X-Received: by 2002:a05:600c:21c5:: with SMTP id
 x5mr19274522wmj.72.1579527685567; 
 Mon, 20 Jan 2020 05:41:25 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z8sm46852417wrq.22.2020.01.20.05.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 05:41:24 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DE0261FF87;
 Mon, 20 Jan 2020 13:41:23 +0000 (GMT)
References: <20200109024907.2730-1-richard.henderson@linaro.org>
 <20200109024907.2730-6-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 5/9] cputlb: Hoist tlb portions in
 tlb_flush_one_mmuidx_locked
In-reply-to: <20200109024907.2730-6-richard.henderson@linaro.org>
Date: Mon, 20 Jan 2020 13:41:23 +0000
Message-ID: <87blqy2qkc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: alistair.francis@wdc.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> No functional change, but the smaller expressions make
> the code easier to read.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/cputlb.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index c7dc1dc85a..eff427f137 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -230,15 +230,16 @@ static void tlb_mmu_resize_locked(CPUTLBDesc *desc,=
 CPUTLBDescFast *fast)
>=20=20
>  static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
>  {
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
>  }
>=20=20
>  static inline void tlb_n_used_entries_inc(CPUArchState *env, uintptr_t m=
mu_idx)


--=20
Alex Benn=C3=A9e

