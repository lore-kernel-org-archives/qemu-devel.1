Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDAEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59187206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aXLXvXDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59187206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkq0G-0006EY-Kh
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 10:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkpzL-0004vQ-6P
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:21:27 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:40082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkpzJ-0004xA-9G
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:21:26 -0400
Received: by mail-oo1-xc44.google.com with SMTP id v26so3387329oof.7
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 07:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UNLmVU9/tKgHfE+6X5EXk/g8GcwZfNcSwp3dTWtTh0k=;
 b=aXLXvXDiPoUZGwY/AzqcHTYtCB3HxhQs0rtvoclHRpB/1U7Bn7Rpm1kDQvgdRiGHWA
 3gxXegVJCX9gCPE8pxaDHo0o1UxvC7kMWkDklGG8JaeJTztk/2RKM52ZOvHJYEGgafsX
 SiabRUQhVQMBB1dRyEq4vSYOiHL2xrKHJ3AEUjw3jOKXAw/bexbr0Rci6mrSRYH8uYMS
 0uji6p0y7xuaEhZx9yRSfiZQIC/OQey3DSX0f0wQJxnRFDoy1gtJtQB6V1UhLrg3ko5d
 397r6L1ThVKTWp7V2/mUe65cmJ5tk2WQT8rFnZ+qlpFH18KlgiTd+/HEAx+44aLR4prk
 hbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UNLmVU9/tKgHfE+6X5EXk/g8GcwZfNcSwp3dTWtTh0k=;
 b=ha03Dv52A/MajtFoszciVk+F4eXKUcNZgwBf9O90K7EX257/xKTaJl9F3LZoZhXrCK
 XgPeuLmw+X7nfK5XNOFQMNogOxnm6eyQqbbhQf75F5C5OTyGT04jrrevwHIdxSOFEWXc
 CB6OtFYZCFuiSbPNkPdwiYMiK0VEwN3Me9NBdUA7DWIuyG3HwP57rF7D7YSMj9PPyvoZ
 wR4ElMzPNbwBlhVPClvtGpoxsOB5qCu1qeh8teE3bzZ3gP5BdImMkGxwEQPno/j7Cgpc
 EipTIPfi0yORYqVAt9apXpGiAlaPzrCWvhH5ziVJTa8HvIRnTpMPhHqlNbdEWPRIuVXA
 Tpew==
X-Gm-Message-State: AOAM532O1B1HytRpjpMx/aVbMnQ5BsHAlrmEcoXPINjbHineDNqKCjDe
 9Vp9n+Dva6udJ5wwzI3D/p7VDV6uUf/KtrkaUiK03Q==
X-Google-Smtp-Source: ABdhPJwuQpDWLMb93D6tCC80t48d8b4kl3oR9Mc16M1GMcy8w2t1ofLzYsdKqJZsTSx8s8DcSlKhjFloEI/AYOTkIkU=
X-Received: by 2002:a4a:9528:: with SMTP id m37mr21238379ooi.85.1592230884015; 
 Mon, 15 Jun 2020 07:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200605102230.21493-1-philmd@redhat.com>
 <20200605102230.21493-11-philmd@redhat.com>
In-Reply-To: <20200605102230.21493-11-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 15:21:13 +0100
Message-ID: <CAFEAcA_TS-Q+xMgFMeh9JmA1MUvxxBcbROtdTc_hDokDNRqKXw@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] hw/sd/sdcard: Display offset in
 read/write_data() trace events
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc44.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jun 2020 at 11:32, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Having 'base address' and 'relative offset' displayed
> separately is more helpful than the absolute address.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

