Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281E9C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:28:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4FFF208C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fThQjWcy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FFF208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32929 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLr9L-00067m-6J
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 11:27:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLr8U-0005ll-O7
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:27:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLr8R-00026I-1j
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:27:06 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLr8P-00024f-64
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:27:02 -0400
Received: by mail-wm1-x341.google.com with SMTP id h11so7327107wmb.5
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 08:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:subject:in-reply-to:date:message-id
	:mime-version:content-transfer-encoding;
	bh=YkMhKUfy4+zicN3gSufR3xOnaniz8Tcu9ruNEGDsIbI=;
	b=fThQjWcy9AEyib3SQ7gyN2Xfblf8YZoQuzxS0H0noiuMHZ/WCRKhTlcVqgnYGBhXGB
	v9vqciajRV5VZ9V/m3VHurifQxv4Bifg4zubWkhmZ5gjIIUVvz8pFdlrYm4FapweNSTS
	C79KOizVzIDetA4WtLTOwRdapIh1wPh0aJ6OzszcZ6r1W0sMctTVFDn9OqSxN35n4eEu
	1TR98wOOVvHFQ0CyzQej7ml/BZqchIbKXl6p9SEAJq/FWjXhsU8NXq46MGPuU0Trecqr
	BKs0GxEg9K1lRj2wnltTgWjG2cYvavJa+ZTXOrsSB5RtEc4CCrLWwKg4Bkh6oAKI+JLQ
	fa+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=YkMhKUfy4+zicN3gSufR3xOnaniz8Tcu9ruNEGDsIbI=;
	b=GbiKOpDphCkUeI0A2M1RkWDrBlCglxaFxyB8UjngWLa0UIqyD93O39PJyhBuSF1t4F
	2ZIlE+C+7PkyxFZtb4YyPpPghjM7BPT9yNRMqfxSE1F20kUAwSk8OLUcCvHe52HE8al8
	Akk/zvYIE8NvhDYPY+nhbXjkiXLvxCEeZC8Zw1emlS5HdQg5dpF8aSMU2750jOmVsqqg
	/MHHOIhtc+dKDb/YSGtAf7c0r2YgRbMar2oh4yEpKDzoiv+1EWNgWU4+Ph9/m1SzZt7O
	cRKmwyJ8Dz2R9fM0GxaSn87AzWak3Pt8rIOmB5WxgwU5G+SOTYiSwflkDSWU6oagjjwI
	xUpA==
X-Gm-Message-State: APjAAAUHU+xLbxTAeXJ0QDRyr2gRKH4qOjStCiNyajVeM6BD18RYMT2E
	jWW4J777bTEjp0y9FtQkNfwCJXqpcpY=
X-Google-Smtp-Source: APXvYqzHAftBzK9HE4ueuazA4Ca925ZQeBmA80UIrPSnQzGtpwToqClH8uUFDgHqkOdj5mNA3jyEBQ==
X-Received: by 2002:a1c:4602:: with SMTP id t2mr6944923wma.120.1556724418896; 
	Wed, 01 May 2019 08:26:58 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	d10sm6156503wmb.15.2019.05.01.08.26.58 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 08:26:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id E31B31FF87
	for <qemu-devel@nongnu.org>; Wed,  1 May 2019 16:26:57 +0100 (BST)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-3-richard.henderson@linaro.org>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190501050536.15580-3-richard.henderson@linaro.org>
Date: Wed, 01 May 2019 16:26:57 +0100
Message-ID: <87v9yu5h6m.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v2 02/29] tcg: Do not recreate
 INDEX_op_neg_vec unless supported
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501152657.bVwjedPl1c7yhePN2uQDpKcidWDzoynumdFwKR_NjYM@z>


Richard Henderson <richard.henderson@linaro.org> writes:

> Use tcg_can_emit_vec_op instead of just TCG_TARGET_HAS_neg_vec,
> so that we check the type and vece for the actual operation.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/optimize.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 5150c38a25..24faa06260 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -734,9 +734,13 @@ void tcg_optimize(TCGContext *s)
>                  } else if (opc =3D=3D INDEX_op_sub_i64) {
>                      neg_op =3D INDEX_op_neg_i64;
>                      have_neg =3D TCG_TARGET_HAS_neg_i64;
> -                } else {
> +                } else if (TCG_TARGET_HAS_neg_vec) {
> +                    TCGType type =3D TCGOP_VECL(op) + TCG_TYPE_V64;
> +                    unsigned vece =3D TCGOP_VECE(op);
>                      neg_op =3D INDEX_op_neg_vec;
> -                    have_neg =3D TCG_TARGET_HAS_neg_vec;
> +                    have_neg =3D tcg_can_emit_vec_op(neg_op, type, vece)=
 > 0;
> +                } else {
> +                    break;
>                  }
>                  if (!have_neg) {
>                      break;


--
Alex Benn=C3=A9e

