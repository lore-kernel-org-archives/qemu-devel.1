Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A65AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB2E20720
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nsMY3/Zm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB2E20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joR8B-0004yI-El
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 08:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joR7P-00041j-UP
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:36:39 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35834)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joR7N-0003yj-0k
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:36:39 -0400
Received: by mail-ot1-x341.google.com with SMTP id d4so5090049otk.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 05:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wqcLQrWZ7SyktUfW4P6/egZn3mCAH7O1SGQqHv9zPyg=;
 b=nsMY3/Zm+/6JePqUDI+v2cJS/KS7+bjRcq514KB8TbwJZ1r9sxuwoDyhYN4rZflwhh
 lMepueDpg44MhILUdaxSd5DU7VZAAhq3LgoM6T3vT7NUpfUnZSUkmYtjSsL5W09TjUq6
 KmisHYiQQcsMxj9/54f6ttt3LR/B0g7pVqENmcZBxmy+dEBMNN26H5FITgKwtGY2leoh
 de5vtlmlsHA8hfMf6DIq3THjsMApwnSuhleTyR+xEnizM4kozlLq4/VMKOEgHIwA1Sha
 zJwSwh2wOaj7naVsegspOOS69LfWj4zrk9lrisqbpak1bNHL9dL6qLBTKJD6ji54y70e
 gAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wqcLQrWZ7SyktUfW4P6/egZn3mCAH7O1SGQqHv9zPyg=;
 b=aoD/vVw6GOLjJN2lYZ/Ftlnvh7AUb/ODJzZYggAfld8d9qOLOAosb3Fr0fhGvVQPah
 cRu4O2faka/KWpZJ0WiKYslGkbgWldfBDs1d3wnY58y1aEmi6qqpZ+gAzwA7Pp33mM60
 bcE9ViPaMlM+bVVWa7j72ttN/xN2sExlYoIKAHESPnNI7tQiSL1gv3T7sX9g4f5fPvdO
 7Wan58VCT1X6yKdjkzlAsTwAP1kS5CSJqwJYt6ZDSaZZde+tTypO4wgU8lUzEoj6cg3Y
 TR5yXvxMzDq7sTrq54pRto/9ntXl0NoZ7K5wF2E2ZKirkUHwHzIgAWoGbBv+j1QJFsfC
 mzEQ==
X-Gm-Message-State: AOAM533lU5chT3eyBpssrPdViOO22abNqOlQI6gTfG0hxj0BQ5EEXFx1
 rMirfc1SpnfiFvI0QyiRwgeKie6y87th+7ZZMo9XTA==
X-Google-Smtp-Source: ABdhPJyV6kPkw8Mpeena+qtLNd9vV5AJqrJWZTiJ4uCqTcHXZeasQ/5Adfpjv8R/WeuuCnm4Y71+M9AxrCdhxDBailU=
X-Received: by 2002:a4a:2f15:: with SMTP id p21mr16194452oop.20.1593088595692; 
 Thu, 25 Jun 2020 05:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200623193658.623279-1-richard.henderson@linaro.org>
 <20200623193658.623279-34-richard.henderson@linaro.org>
In-Reply-To: <20200623193658.623279-34-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 13:36:24 +0100
Message-ID: <CAFEAcA9j9_1kONhpRCX=RAQnp3HWVFRRfGOD4WWA3sTC5bbx7A@mail.gmail.com>
Subject: Re: [PATCH v8 33/45] target/arm: Add mte helpers for sve scalar + int
 loads
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: david.spickett@linaro.org, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020 at 20:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Because the elements are sequential, we can eliminate many tests all
> at once when the tag hits TCMA, or if the page(s) are not Tagged.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h           |   1 +
>  target/arm/helper-sve.h    |  58 ++++++++++
>  target/arm/internals.h     |   6 +
>  target/arm/sve_helper.c    | 218 ++++++++++++++++++++++++++++++-------
>  target/arm/translate-sve.c | 186 ++++++++++++++++++++++---------
>  5 files changed, 378 insertions(+), 91 deletions(-)
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

