Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F7FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 09:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0A9F206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 09:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WNP/9K0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A9F206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jayE3-0007n0-5d
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 05:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jayD4-0007Dv-7Y
 for qemu-devel@nongnu.org; Tue, 19 May 2020 05:06:50 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jayD3-0000Tt-75
 for qemu-devel@nongnu.org; Tue, 19 May 2020 05:06:49 -0400
Received: by mail-wm1-x343.google.com with SMTP id f13so2217165wmc.5
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 02:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=68GdHJc5Ut0H5XO7fQQ+OP5ZG5QdGwnwdK0iXDGdOC8=;
 b=WNP/9K0vcXpO72yblX28+WAb8i2+OOYlMKpWkZmeN1cMuXQ7bfg3ZFFOgroLn+LT0R
 Tl9DRnjYnBW/GsukP/fTS7OgNFn25AKqLYEDve4a2xidD4YTZCy8s/LOdNo5mytn9ePa
 J4YyNHhREbzMPQ8tO2DqhPyITrEH/Xy82N1sFbeeo6z22PB/WJuheYqw4qA9GvZ5CJ6d
 HHxvltI+GcDFIdTM38rSbKqnEiwWaPDl8gANsNSzVM0cnNOZq5MMh9qkfkIHc3+LBY5R
 po/X5GkNusMc2jAwDzYJj2Tw9HZX7wphB4hccR6AfcwVEy3seBB4pn69gyVYOX2zCwi3
 lbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=68GdHJc5Ut0H5XO7fQQ+OP5ZG5QdGwnwdK0iXDGdOC8=;
 b=B/R0XsZ4MgOt4hsxmF7M9qPP+UpYT5hbvIwzWXydTBtss6G8ejwhFQWqaw5iR0D9Bf
 7yxYAC9A8zVBCV7uE0Wz4Ujk/jgQQH9VXF+Og/729HmRKOWTTPtVE6pAG6+2xpG30csF
 I0HjxLKz7Hyi3KpPXPBlEdV4Wd52i/DCn1KONnmgyIECsf3AKQZvDAu4siABm+moVFUn
 sOgHTLUHquHJ6lYOonCoO7drmOwAm3UrQTS6UDoycZduUNrIydpGtv9592H5lAveAm5X
 NuGbR/j/gHkQjGhQsM97uRJUbcihbECuWHaSmGjrF88dMxCeopZVp97q7Besw6orctg7
 F+CQ==
X-Gm-Message-State: AOAM533wkVdMTm/tfnuoWxgHsv/2CrnJUxKs+RzNKMTL9BH+tvnAd4eP
 /utsH6UkgYTYHWUFJGZT5BxkPQ==
X-Google-Smtp-Source: ABdhPJztMPiCut6fitK9FODLceBJuc2J3111dx9lNDOLLgnAjihJCHz38ZfYQev50UhJaT/BK4o3Dw==
X-Received: by 2002:a1c:56c1:: with SMTP id k184mr4026781wmb.183.1589879207604; 
 Tue, 19 May 2020 02:06:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o24sm2843698wmm.33.2020.05.19.02.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 02:06:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 444921FF7E;
 Tue, 19 May 2020 10:06:45 +0100 (BST)
References: <20200515190153.6017-1-richard.henderson@linaro.org>
 <20200515190153.6017-5-richard.henderson@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 04/10] softfloat: Name rounding mode enum
In-reply-to: <20200515190153.6017-5-richard.henderson@linaro.org>
Date: Tue, 19 May 2020 10:06:45 +0100
Message-ID: <871rngjntm.fsf@linaro.org>
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Give the previously unnamed enum a typedef name.  Use the packed
> attribute so that we do not affect the layout of the float_status
> struct.  Use it in the prototypes of relevant functions.
>
> Adjust switch statements as necessary to avoid compiler warnings.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

