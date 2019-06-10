Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9108FC31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 17:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC35207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 17:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U7ux2Nxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC35207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48490 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haNvg-0001eh-IC
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 13:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51418)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haNs1-0008Q4-22
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 13:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haNqH-0008Pf-IA
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 13:12:22 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39891)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haNqH-0008Oz-Bp
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 13:12:21 -0400
Received: by mail-ot1-x343.google.com with SMTP id r21so9030785otq.6
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 10:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p/z1W1Ia8JivqEoVP3WBX7u7oTn3bQRsvUkNdqY2whE=;
 b=U7ux2NxttjgIEBAcHisLb4IDhyBtNgfcyec6WzEjb+XtbOV3TnEm8ApIKEBFaS8QF5
 TOafRa7YCElp+moTlszhSX1NFNiyKeYZ3x85+8RSkaz4u+pdHwoBSYJsbrqD7fMGF+Ub
 AK8UuiE7sXdel8xA87e0BRPg8d8UktiTbPwhh8C9jt4dEqiyHXYnO3NRdnDlKROOyrh0
 mP5WuSitZ4sIBJvL6vaoe4CkkMmeL5icbB9jXKq/Y8FsN/Y7h1VJ5t+8aPSAbbAf4Hjg
 yU1N/+J7ndfXGqzIsTBAe3ueGwU8bOfUil7opG3rYR54OxISZhrHg9LhGSHuZtGh/Cxf
 SXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p/z1W1Ia8JivqEoVP3WBX7u7oTn3bQRsvUkNdqY2whE=;
 b=AB7Esdpa0wHSJREBJ8ulJ1Ms9nQT5GVORkG4EHEP4vOiDOlLfPv0w2aHRSwowGGoI0
 tvNrNvcqm098GLXbFi+OKkHHTmtOxGvTh6a/xtFJlsUBt1yNpSUfXQwQ6vAX+QVjErZv
 LD1hlAwJLjvGTdf6P3255+KHvXhGJ/wF4irpYCbvluYyKJ1ZdZeAdV47CVmayLGem/7r
 5JaxzIxU9iJAVYWWz3btDB4ZoJ7m1Q8BfYp36EoOr7MLXwOYur+5GwWuedUPuni2NM3c
 XnAJ4cDLbMGVDpUc3X1uT2VsEig/yRmz8JkOM6c3dls8HNlvkTVJ7VW21/mYQgj59m0J
 XsBA==
X-Gm-Message-State: APjAAAWXTbs8eQgsPRmbrDTHoeNH+zufpXWcFhRcYkvJaygWK6K+Q/hK
 LlRV8g0t7EvSTeSNZ3KHqD/5tx9Rc+THSCzuedQl/A==
X-Google-Smtp-Source: APXvYqxV0fRRzYaXYMRv7s4G4BINQXGvpAwT49z346wra7t/YHyjixQmTnnmKJVIB3AZRvNCjaw6LLUzsSxGI40tyt4=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr31498596otk.232.1560186740245; 
 Mon, 10 Jun 2019 10:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-29-peter.maydell@linaro.org>
 <da80c3ea-5a33-e7e0-209e-89a8413c8f06@linaro.org>
In-Reply-To: <da80c3ea-5a33-e7e0-209e-89a8413c8f06@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jun 2019 18:12:09 +0100
Message-ID: <CAFEAcA8etr7_rmQsQcUY+cPHZEZna-An+r5TPJtMb4OQO-6Dsg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 28/42] target/arm: Convert VMOV (imm) to
 decodetree
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 8 Jun 2019 at 20:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/6/19 12:45 PM, Peter Maydell wrote:
> > +    n = (a->imm4h << 28) & 0x80000000;
> > +    i = ((a->imm4h << 4) & 0x70) | a->imm4l;
> > +    if (i & 0x40) {
> > +        i |= 0x780;
> > +    } else {
> > +        i |= 0x800;
> > +    }
> > +    n |= i << 19;
>
> Can we reuse vfp_expand_imm here?  Given that you don't have pure code motion
> from the old code (due to field extraction) it doesn't feel wrong to go ahead
> and fix this wart now.

I dunno, I'd kind of prefer to do it later. We're already
drifting away from the old code as you say, and going
straight to vfp_expand_imm() makes it even less clear that
we're doing the same thing the old code was...

thanks
-- PMM

