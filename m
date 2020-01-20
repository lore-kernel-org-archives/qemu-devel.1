Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6C2C33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A23821835
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wBJwumtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A23821835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itXA5-0006rS-6M
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 08:32:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1itX7H-00046C-N2
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:29:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1itX7G-0001Ka-NI
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:29:19 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:47043)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1itX7G-0001K5-JS
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:29:18 -0500
Received: by mail-ot1-x342.google.com with SMTP id r9so28657961otp.13
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 05:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pRyNxs5Q9NG5xWtBvdkgzxPmO9+oLzgDCyhLAiXYDqA=;
 b=wBJwumtgCHfmeh02DYqzEVAZRy4IEavqYPEJGpjhIXXkz6J7Un/lBLVgKC3mJrDk2Z
 6hZf89DMTs6svWTyopNM8LeX0qzT0EfXz9qEDeS6D0eXxul5HWGVQCfIHtf5j6Des1O1
 roxyRAOQo3i63cMFpjdcs+Qhqvo/bWZR/Qo8lMnP+vMryBYHhYMbgGxtv1bNVwEQ2Tuw
 d3NgBkGP7iImOwooI5vdWwLwF0SbpM4uZ4m8uq6JhhFYgq36KpXB4Q/yn4Rowg+SYD5Z
 0c5oiKjD5tQ7kHMmpyWaZ9FZ8WFjUBqXeUX+mYu0ta55l/xzUnIX5ZgB4wGsNfQX9Af0
 3yQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pRyNxs5Q9NG5xWtBvdkgzxPmO9+oLzgDCyhLAiXYDqA=;
 b=GlpsvuWDmBFb+qfqV19w8ZdDp4ByaaO7epjU+f+9XXFlW/rlGJhmwPAL//fd5fT0Cn
 WwHAdpxsQf9aQXizLX008AuepVOkBoxPtdmDS+D/cHotRRpR61ZRq72Strjt3Ikd/Cys
 C5UhtCTqWUoFD4BqAE83dTJ/iDyuBsK6r4zLwa1tRM2HuCc0uO9h2CLbqLwtxh68R98N
 +n+9X+qFfDtW5+GdYLpYGLvqrMOMrijU1keKpmzr93sdsru6DeuDROQ9uv8bj9qlTvVR
 jeUXNgk5qpboZwrGWwkZDNfKMVkRMmFh/joKRDRHaClVYs85rbEnfWpaxtz3Ux/w8peh
 txOg==
X-Gm-Message-State: APjAAAX0tioEkkr1Rowp0h/iIpDdXXtH0RTJ8vUC4DXtOA1Mofx9DtwH
 2TtxKA2zMlLCRzkuA/HPieG5T0NMuqwlzGG+iDd0/Q==
X-Google-Smtp-Source: APXvYqz7SqJvQ5WtOAMz2F6ElsPX9jzDsxFqLLrl7RaEMsoGy2oDqU3Vz20NugtQUfM85c6bnne/2+OWb8V1Kkfbt/U=
X-Received: by 2002:a05:6830:1586:: with SMTP id
 i6mr15239259otr.221.1579526957951; 
 Mon, 20 Jan 2020 05:29:17 -0800 (PST)
MIME-Version: 1.0
References: <20200118164229.22539-1-linux@roeck-us.net>
 <20200118164229.22539-5-linux@roeck-us.net>
In-Reply-To: <20200118164229.22539-5-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jan 2020 13:29:06 +0000
Message-ID: <CAFEAcA8RYhLfYhq3UH6qVz=of0kBcsL9bHfAparH6UYKx3UgXA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] hw/char/exynos4210_uart: Implement post_load
 function
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 18 Jan 2020 at 16:42, Guenter Roeck <linux@roeck-us.net> wrote:
>
> After restoring a VM, serial parameters need to be updated to reflect
> restored register values. Implement a post_load function to handle this
> situation.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

