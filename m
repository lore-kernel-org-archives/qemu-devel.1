Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CE8CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A5E9205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VZlE8BBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5E9205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMacd-0002qQ-45
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 12:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMaaM-0001Kj-2G
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMaaL-000276-2Z
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:31:09 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43164)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMaaK-00026u-Sl
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:31:09 -0400
Received: by mail-oi1-x241.google.com with SMTP id t84so11545035oih.10
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UYD7x2+9J/ZoCrbTYxaljKCzU/uai45t8VEeD8F7Fxs=;
 b=VZlE8BBNIYh6LmGeoR7dagYY9eLizFmEzEcHtSVqua/iSdqP+Hcp/4YI5lhRqdrhcv
 g/LMiDpj5Od8FXgzqgmoCghnd67TGm7retjVPvWOITa4tZwpAFD2El9yZMzAMdgyo1DR
 LzCOF4J6MSqbXKR9P7e6FDLQwM7xXXn727Nw8Bk9Ktl6a2rvBCXddql6tl4PLPz+b3Zz
 ApPsMXmACDTqoMyfoZYfKRYI4UrZVX2vepVM2u4ITCIjaBwuNb/EBZXwPHad7TkCqpxb
 aNikbmNci6IIJ3txFzJE1fMO0tlGjwOzqqok9eTUJqi6V8eclBYCJGfwvaWsUWIdV97l
 JbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UYD7x2+9J/ZoCrbTYxaljKCzU/uai45t8VEeD8F7Fxs=;
 b=KJB7D55HY1V7bSDnw06wdhXYdEyKAbIb3DBSo9MrItwEQtX8wR7//L0aPl2KYOEaJP
 Zz1soNH3zEadHWQ0sjjNHPCZ1bXBlTTaxSkVeumspqtySgxs3cMDotyxJTT9E8cWu/Rq
 JodT1dx7d3rLDxot+HyToGkGp4NJZk25TV69X2KZUzoHFG1otXpHHy6Y7zbK1exD+eBd
 x+i7P9YH+eOKJz4QhADWkrD0pJ4f1aiV5XBz7vwtLcIY/VtxK/mXTAmBVWftnUBQbWrl
 k64RMJGSTvX57uInt5v+4lrYfF/Q20R2adeO5D7rhhgCAs2/g1dwxkpPyqOo6k5NXVdD
 G7gg==
X-Gm-Message-State: APjAAAXIRqvnxUx0nej3+xv8X8uoZQbrKDob3yB3cGvJ6TQjRul+Jo+9
 4eUsegxUb02aK4A1AzRM/mqEqSc0fqYg15kD6ZHdNg==
X-Google-Smtp-Source: APXvYqw9v+rwbctUi/mChOV23wKz19KEKza8Hm9HRkp4a69B548l4E0JbM16o8rtC02wFXjHF4UoIN4EbWCf1zRAAZU=
X-Received: by 2002:aca:49c2:: with SMTP id
 w185mr20174969oia.163.1571675467958; 
 Mon, 21 Oct 2019 09:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191021145839.12684-1-peter.maydell@linaro.org>
 <06e15851-0b4e-63c3-001d-dd7ea5855872@linaro.org>
 <155991c2-523f-0721-c7a8-4fbe4986387c@linaro.org>
 <CAFEAcA9trXJ_g=HtqFrvXvCH+WMtJ8w3x7xX7=8jNm1PdxbMbA@mail.gmail.com>
In-Reply-To: <CAFEAcA9trXJ_g=HtqFrvXvCH+WMtJ8w3x7xX7=8jNm1PdxbMbA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2019 17:30:57 +0100
Message-ID: <CAFEAcA9E4AVxRTiq1Qe_zRK+-8cc-2ChvWHjnQ9qMi22jDy33g@mail.gmail.com>
Subject: Re: [PATCH] tcg/LICENSE: Remove no-longer-true statement that TCG is
 BSD-licensed
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Oct 2019 at 17:27, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 21 Oct 2019 at 17:26, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> > Queued to tcg-next, as I think there's a couple of other things pending.
>
> As a licensing issue, I think it would be better to have it on-list
> for review/comment by interested people for a bit longer
> than that -- it's not like it really needs to get in before
> the softfreeze.

It's been pointed out to me also that tcg/*/tcg-target.opc.h
are missing a licence/copyright boilerplate header. Since
we're removing the "tcg/ is all BSD" note we should add
"this file is BSD" to those files at this point.

thanks
-- PMM

