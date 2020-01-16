Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BACC33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:05:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C2D12469F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gOekvbUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2D12469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is9W9-0001vJ-E9
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 13:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1is9V0-000137-CM
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:04:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1is9Uz-0005Zy-D2
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:04:06 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35030)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1is9Uz-0005ZP-7A
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:04:05 -0500
Received: by mail-ot1-x343.google.com with SMTP id i15so20220176oto.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 10:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yRA7wz5NRRjS6oPC39LgwC/mStA7rG3T1ZcYLU8etI0=;
 b=gOekvbUIGrG5y4LcrTMcaDUL2I6iSaIHkC8hVtDTkn0sYAZcPy/VEqVH1B3/g+2YL3
 yBeB3jNfoHJLh8evrVYcZxX0VPC4dXw08BvC390BAz2ATaxP4cRNwbm0N7kupsqnpmkj
 z2GdUJ5gTLRsfXlueNeGwdESN5cUKt9pXhYpMa6XQKhgM7mgHa68b7GqDWL3DlJv4AoT
 J7o/q7XJVpZLTpAJ+eQx+uAw6YJW1tknwHRwPS9YfQDO/LXHVTtOn+EYRNXVKMRZN9GH
 Afy4RUFliBh1Op4Ip+YEDFbhIYPMP8PUD4J2tEgnlPqmPFVks2ZfYmIGnTs/pn07hU7V
 SBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yRA7wz5NRRjS6oPC39LgwC/mStA7rG3T1ZcYLU8etI0=;
 b=Ujk99I4hnQ7+tLpQrL16CRUaW5P+Gh+OK8GZB2eaQqEn6NA7WUTAJP7QgdXdepuWgN
 5v9WnfhSkF/Hc/PxCuV5XSO3ORK7j2ggmAsvswXuaKMT1o2b9ujPVxBdWHC7FrBWLy5R
 4tzZE1fyQpzKI1UIFMwmeIOhmVX5i97FyT95cvyeBszhUUmbxgxgZ2D5yyYofiNSogdX
 ihro7yyp1xbQOj9b7XhvFzr5uphDAChaOVA0W+vdWSiexfh2uie6TPqMMFQUM3p1IewZ
 s2Q+AK4laZIh5+Bpj51WCmwcKyPcIYUAEy/fFiMUq7Ef4813SMMv85Ur2GzSMx7MyKRo
 yRGg==
X-Gm-Message-State: APjAAAUHDhyYbSj97lwdYQS33PX2eWQYlM6eSlySMq7na5vwuDn/Sl+0
 7bTgzb0hOIiuA9+4JuqIfcjn3r+xDlkuLj8vEKFrvg==
X-Google-Smtp-Source: APXvYqzLf97Nf+8cq2DgesmDashH2NKK/NKj2n2yx9zshoAdYyfeoX1+Mji6XK3gGJNIgFqQXOt+9R7SRxX8wwKp8Pw=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr3014621otq.135.1579197844448; 
 Thu, 16 Jan 2020 10:04:04 -0800 (PST)
MIME-Version: 1.0
References: <20200113154607.97032-1-jeff.kubascik@dornerworks.com>
In-Reply-To: <20200113154607.97032-1-jeff.kubascik@dornerworks.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jan 2020 18:03:53 +0000
Message-ID: <CAFEAcA-Y5EL5ty_9b1E8OwKEncxsZnyh24stnYVOnUQrrdjsSQ@mail.gmail.com>
Subject: Re: [PATCH] arm/gicv3: update virtual irq state after IAR register
 read
To: Jeff Kubascik <jeff.kubascik@dornerworks.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Stewart Hildebrand <Stewart.Hildebrand@dornerworks.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Jarvis Roach <Jarvis.Roach@dornerworks.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jan 2020 at 15:46, Jeff Kubascik
<jeff.kubascik@dornerworks.com> wrote:
>
> The IAR0/IAR1 register is used to acknowledge an interrupt - a read of the
> register activates the highest priority pending interrupt and provides its
> interrupt ID. Activating an interrupt can change the CPU's virtual interrupt
> state - this change makes sure the virtual irq state is updated.
>
> Signed-off-by: Jeff Kubascik <jeff.kubascik@dornerworks.com>
> ---



Applied to target-arm.next, thanks.

-- PMM

