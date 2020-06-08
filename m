Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC62C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:05:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3637C2064C
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nVh0dSHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3637C2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiJLV-0001Bu-DC
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 11:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiJJs-0000Ea-RE
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:04:12 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50383)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiJJr-0004SY-Je
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:04:12 -0400
Received: by mail-wm1-x343.google.com with SMTP id l17so4472805wmj.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 08:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=nTbxffRNDA5EY+o8dBaAi3PmVWswKrNwOOdxv1+HT7M=;
 b=nVh0dSHpZNFMS+XPaRs3UFZ8tuKipLmuFlnh49Has8XQs/hl3LMqfy25r07Eosy0D2
 SJ35o55k/uzYZWs7/GnCeeWEKCmTdOcnj3E7Tr4V8cw0sARbr9QgwIwls7YZ9+gYyJBG
 a4JfwEcZd5DKavE2atS8u78nkUUiZUAuivrYo2F9F6r2uGMvK7AGCBK3b+mReEQ/Hoxy
 ALmsv0Z2dZSlWlKdaR2sfGS/gn4Kmf95hYqwfKLRVDNtALjlcwNgMAikCuoVhEpFaIxj
 JhXzPVkrabKnMk07/M7T+kUECqvF+0p/EO+Tf5mnZ0XS1JxjRXyDW3ZFuH7AZCCwN+pA
 BUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=nTbxffRNDA5EY+o8dBaAi3PmVWswKrNwOOdxv1+HT7M=;
 b=Yf006T5DsxVUOX32Rb8u2pYjgRmaL7Wv5voz00q0X0QYZ2fYE5v/nkrk1RRddg/Ns+
 Eshti75RCQ4d4CFsA1z7MjbEEabp4oDC6njDcUbICY5TkHP4QPFtbN9+MoSXnUV7NtHs
 ib0BD3e3MDcQorlcjlWkX+atP10iIiWanJpgh9NArzw++0Pf06c2qQMw0VdWYpFGjt6J
 /BCn9l2Rm0Dw2MmgyWByrJWkkHozm0N9Wh+iMonEiXM1w8deRNP+/AVtIazv9cWlZ6wR
 ktShpzTWX6Y9c6NB9vKll2+kAwd0E5/axFMasLwTYAhpPgQA4+TfyyUYsB7qo0ndb3t3
 JHAA==
X-Gm-Message-State: AOAM530aVlzOdWrLo96t9MnyQjsSgmm8kSvP9RK86rpS95Mase7gosV9
 By3KAIDpv27I+RS2RhhmmX0QmA==
X-Google-Smtp-Source: ABdhPJxRfArK1lcN69wlp66Rfu8E/8kreBpDMcA6G9X7Xi0z+vNfR7EeUE8LOUQdcPosYxb0k6/qsg==
X-Received: by 2002:a1c:4d0c:: with SMTP id o12mr17393540wmh.181.1591628649746; 
 Mon, 08 Jun 2020 08:04:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q8sm5418545wmq.1.2020.06.08.08.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 08:04:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 01BB61FF7E;
 Mon,  8 Jun 2020 16:04:07 +0100 (BST)
References: <20200605173422.1490-1-robert.foley@linaro.org>
 <20200605173422.1490-8-robert.foley@linaro.org>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v2 07/13] translate-all: call qemu_spin_destroy for
 PageDesc
In-reply-to: <20200605173422.1490-8-robert.foley@linaro.org>
Date: Mon, 08 Jun 2020 16:04:06 +0100
Message-ID: <87wo4h61ll.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: peter.puhov@linaro.org, cota@braap.org, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> From: "Emilio G. Cota" <cota@braap.org>
>
> The radix tree is append-only, but we can fail to insert
> a PageDesc if the insertion races with another thread.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  accel/tcg/translate-all.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 3708aab36b..3fb71a1503 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -547,6 +547,15 @@ static PageDesc *page_find_alloc(tb_page_addr_t inde=
x, int alloc)
>  #endif
>          existing =3D atomic_cmpxchg(lp, NULL, pd);
>          if (unlikely(existing)) {
> +#ifndef CONFIG_USER_ONLY
> +            {
> +                int i;
> +
> +                for (i =3D 0; i < V_L2_SIZE; i++) {
> +                    qemu_spin_destroy(&pd[i].lock);
> +                }
> +            }
> +#endif
>              g_free(pd);

Erg that function is starting to look a bit ugly but I guess cleaning it
up with some helpers is outside the current scope.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

