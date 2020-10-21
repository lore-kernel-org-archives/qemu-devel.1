Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD16C55179
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81A7F2080A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GtYx431V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A7F2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVEEN-0006gZ-1y
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 09:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVEB4-00032S-5c
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 09:29:18 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVEB1-0004Pe-4J
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 09:29:17 -0400
Received: by mail-wm1-x342.google.com with SMTP id d78so2210202wmd.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 06:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Fcw20/vqy27vm36joKNYVny4BgkPZ7tAybECxUoAUtc=;
 b=GtYx431VsykDs1UxibC9IVNn+IhHpxf/Ua/fhZb8FkFBrp+4Za3kIKHT6+6RbDWAF6
 TTB08HZRKheif9PMaPQzb0RMsHFUmM5e6AI5YjcBBSijpz+Eqh4yCNP8QM5wT0le5JAd
 KulKWhnMDzY3sxLTI2YymeZeL8zffWrL9MRZTl8L9BqCNNjHGnL9MZJfDlTFQBsqTsUs
 xwTEMuE9/oUlOdHMhQUHvncpp7DuFR4tki625pQPwGFpL6SeaY3E9p22KesL97C+NzBb
 kCyu43xa75OslkpRueD3BjqmOvAaN0yRqOf7KWMQlWDr3J2rM/kor06TYB/A/XRzO+Fq
 QajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Fcw20/vqy27vm36joKNYVny4BgkPZ7tAybECxUoAUtc=;
 b=Nf+WLFfLGOrus/hZhzo/JWkbbLODqZoyUTqnrqZbxsBQ3RrQ1YRhxQez62QuWYBDE6
 9dnjgeTOdY6HbTsfZLkcq8vRKwNDysmhg6VlJ01TmHxRCaKgBI/Co2z9QnTY8SZjpgjK
 z0sNq6RcWVpNWDH6WfgYTWYWgLQm4bxWXiKeD+skewNLP6L3or/bduaNLiwutYItd/l/
 Hna3J25UCM+xLvbGyQP7A6SbUKJOyv0tuMeEcvGFj/LzF4ysgGWB32S+N5jXtem3JFFN
 fwn8ljhdbiIG2tc7IrO9zqPW41QBzvT2LEXivtlIXXWsn7zfV/QRhRtKbmn76S9Q3ljv
 cPjQ==
X-Gm-Message-State: AOAM5313YvaWh+9d+DLbjr+4eDUDX8Z4UIX5n5nnV2NdoiFw5AIVEU03
 yUH6Gp8yJQsGfiTJje56t12moA==
X-Google-Smtp-Source: ABdhPJxseCc7FQwcFH8BjPDSnvnJXSQki/d77vriqK06tWOaVSm7MjBfWl05L8wxcXIcEgZYpB22jw==
X-Received: by 2002:a7b:c741:: with SMTP id w1mr3676701wmk.67.1603286953255;
 Wed, 21 Oct 2020 06:29:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v6sm3982425wrp.69.2020.10.21.06.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 06:29:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B78E31FF7E;
 Wed, 21 Oct 2020 14:29:10 +0100 (BST)
References: <20201013222330.173525-1-richard.henderson@linaro.org>
 <20201013222330.173525-2-richard.henderson@linaro.org>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/2] tcg: Do not kill globals at conditional branches
In-reply-to: <20201013222330.173525-2-richard.henderson@linaro.org>
Date: Wed, 21 Oct 2020 14:29:10 +0100
Message-ID: <87blgvwvvd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> We can easily register allocate the entire extended basic block
> (in this case, the set of blocks connected by fallthru), simply
> by not discarding the register state at the branch.
>
> This does not help blocks starting with a label, as they are
> reached via a taken branch, and that would require saving the
> complete register state at the branch.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg-opc.h |  7 +++---
>  include/tcg/tcg.h     |  4 +++-
>  tcg/tcg.c             | 55 +++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 60 insertions(+), 6 deletions(-)
>
<snip>
>=20=20
> +/*
> + * liveness analysis: conditional branch: all temps are dead,
> + * globals and local temps should be synced.
> + */
> +static void la_bb_sync(TCGContext *s, int ng, int nt)
> +{
> +    la_global_sync(s, ng);
> +
> +    for (int i =3D ng; i < nt; ++i) {
> +        if (s->temps[i].temp_local) {
> +            int state =3D s->temps[i].state;
> +            s->temps[i].state =3D state | TS_MEM;
> +            if (state !=3D TS_DEAD) {
> +                continue;

It took me a few scans of this function before I realised the continue
was to avoid the la_reset_pref at the end. Not sure if it can be made
any neater though:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

