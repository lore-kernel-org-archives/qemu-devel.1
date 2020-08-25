Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B3DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A494120738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mes+yGnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A494120738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAZRl-0002uU-VV
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 09:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAZQn-0001pk-Ix
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 09:56:09 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:44751)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAZQl-0000OV-Vm
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 09:56:09 -0400
Received: by mail-ej1-x643.google.com with SMTP id bo3so16638410ejb.11
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 06:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4xxJOa8qEAs8c7q6xE7Nkd4eRO1B6fIa6psv23RE5jE=;
 b=mes+yGnRmwyBZwNJ3MSgwey9wD3Ss/942aaHYtW34lis8pbxDg8oHF3WUe+l65q2Mv
 mD8+wWBhoKDKipNXicsvLo/wU8AQLC00W+nThk0kSieGbQcOfudQ9RBArtCKj21cSj8d
 ElWPYpH9ulcd4EHFMOgjc3eIym+ZMlofxdwFQweHrH9I5xcyCzAqBQvzHJpCXQfoeVQi
 /qDHgPRJboHrMsFhuqKz1Ex+gnqke02mehhdhYInvAKfKgo1Kcj3ckY3V5+ThrwTs5EG
 Jm7+840m5DvnFdVEz8eUG3ecT1/CjWLoc2R7wxCyZqpqqg+wbIjS6WxzYyF39ThDx6ei
 a4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4xxJOa8qEAs8c7q6xE7Nkd4eRO1B6fIa6psv23RE5jE=;
 b=Du7l3P6bg2hgTMXbqJpiGs6SxFNt9tnhj1nBNMRRvqSf8XUGnM/Qqk9ZphuEz9F4w0
 F1uNz4kOBM+o+gOv8PVZ19J6I1Q717Y/RIA31OUG8Sw9nLZM94LHvhtIWqVv/CA5dldR
 OpzXlINjzACGQlxw4X5vZDE90z37RBR7bF3iuU5anBDIPWvsVK6NMFjFIwY3z+NJpn5f
 TfVR5LxXZ8d+Fk4kgjDAXqmuv6scLpaGwO5ey32IFkQL8mae24PCyRc6TEncr+b/KGGw
 MqeIIApqANfPO8AdUzbk12ue5G6xQUzPy3YQLAGt4M7Vgyl0LJG1Y6uTDFpZ7G2CM2Rf
 z9GA==
X-Gm-Message-State: AOAM531W3ty4geew8q88xDsOOl/hsB8tIvOeE0jtu5QTW9HgYA8AVd63
 Q7B0jt9XzFOaXjC+xWf3Hy/eY2nRAFNNt5aeMCO7EkL5XCgRog==
X-Google-Smtp-Source: ABdhPJxfQ+2wVdQHJzbOQXQ4uIZsgr9YCaL65D0WnUU3KeHoi3GzsolXqLeAw/AXWDIty9KX5Y2wtumEEcqjIrlxh+U=
X-Received: by 2002:a17:906:f28b:: with SMTP id
 gu11mr10345765ejb.407.1598363766540; 
 Tue, 25 Aug 2020 06:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200815013145.539409-1-richard.henderson@linaro.org>
 <20200815013145.539409-20-richard.henderson@linaro.org>
In-Reply-To: <20200815013145.539409-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 14:55:55 +0100
Message-ID: <CAFEAcA96eqx=DkwF_9Zm-9j28VaYyOpancqbRxyeZMW2Gx30HQ@mail.gmail.com>
Subject: Re: [PATCH 19/20] target/arm: Convert integer multiply-add (indexed)
 to gvec for aa64 advsimd
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 15 Aug 2020 at 02:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h        | 14 ++++++++++++++
>  target/arm/translate-a64.c | 34 ++++++++++++++++++++++++++++++++++
>  target/arm/vec_helper.c    | 25 +++++++++++++++++++++++++
>  3 files changed, 73 insertions(+)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

