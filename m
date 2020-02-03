Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF435C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 781B520658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z872ikGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 781B520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyaF9-0006i9-Mw
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 06:50:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyaEV-0006GK-8a
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:49:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyaEU-0007CO-Dm
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:49:39 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34187)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyaEU-00079y-89
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:49:38 -0500
Received: by mail-oi1-x242.google.com with SMTP id l136so14455932oig.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 03:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9ykLYSrlEqIxMWTIr5N2DIJJjHsjnBJMbLs7yqw+n8A=;
 b=z872ikGiNzdrcX2iYpsHNlBUu+LsVOEcN2ZGEQKG1IRhOucs5WkAq2yxQh2sA3FOUa
 SZU1g/fi0q9ECYJb/w5n7tVsOVYn0fvEMnocv/gPytBaT3XcnTnvA3RT+VmJr0PyVilQ
 D17ux3XjLEqseCUQEgPp863Gc2HqPxG3GaGsj93t3wU09PmkI8HLDXK6RDqOdLWs0c5c
 8cT92EroBYnAOXZTAJgyQHI0m4B7HqM/OKvBQsZBkRCo9y8E9KX76I35WAUK8vL2A6g3
 Z1XOhbu4NgPL2BHwQ93ar52wWYtVV2YltR6blQ585mRw7MkFDs4iWGFAp6TtreisRZm3
 nrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9ykLYSrlEqIxMWTIr5N2DIJJjHsjnBJMbLs7yqw+n8A=;
 b=fRrEpobW/e7c294b0xTQJGA8rGpEqiDZXhu7YddSLhQWzu12lLzXtbIP0YkE3nR493
 4u+pSkm7k2uebqKDJrhFyJtSLTo9PwU2kaM3CDVO5IQx+c6e0kHGD2jrpArI2uXpdaow
 5xQXm0Uzl8IBl06wRD1LinnXe/MbYcrcE8rJ6fpNLn+LIolMYzYhEL/gblJifPyL/8kO
 kuLzCzY2/xUA564MSSmlqhXpzxCP8m4h+JqbPGyUNzyautQ6n74xlzVC215iKvVqMSZR
 pcHZHJamseFrnmPtuwsFIjnwKOund0KZCmexloVyJ/Yeq0oS3zbpA5KZtyDeeeJ5fO5m
 wxag==
X-Gm-Message-State: APjAAAX/7uel6jTUAKa83pWue5tiKgY2m4xTgjIJBAn+BRHUsFCV0UCr
 ZA0xmyOjsgGzaAiLU9iDU8TrbM8/mxthvc2OGq9BhoES
X-Google-Smtp-Source: APXvYqwkxzEBC9lTCNfdYm/s8nhtb37X/m2Z32BCjozEyKYGzWAGrukIAXpD+AbW1U/E/UhNJOfGr0icXdk1+41F/wQ=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr6363847oiy.170.1580730577392; 
 Mon, 03 Feb 2020 03:49:37 -0800 (PST)
MIME-Version: 1.0
References: <20200201192916.31796-1-richard.henderson@linaro.org>
 <20200201192916.31796-31-richard.henderson@linaro.org>
 <CAFEAcA_0at8qwiyxqwwqath9i3URBWBEKf-9nfgWikhnOfcO6A@mail.gmail.com>
In-Reply-To: <CAFEAcA_0at8qwiyxqwwqath9i3URBWBEKf-9nfgWikhnOfcO6A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Feb 2020 11:49:26 +0000
Message-ID: <CAFEAcA8y2Zfd=qM+U0-tQB1GfC59FOy08Rx-a5AvSaqbvCnGag@mail.gmail.com>
Subject: Re: [PATCH v6 30/41] target/arm: Flush tlb for ASID changes in EL2&0
 translation regime
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

On Mon, 3 Feb 2020 at 11:36, Peter Maydell <peter.maydell@linaro.org> wrote:
> Since we don't flush TLBs when HCR_EL2.E2H changes, I'm wondering
> about this sequence:
>
>  * initially HCR_EL2.E2H == 1 and the E2&0 TLBs are populated
>  * HCR_EL2.E2H is set to 0
>  * TTBR1_EL2 is written with a different ASID from step 1,
>    but we don't flush the TLBs because HCR_EL2.E2H is 0
>  * HCR_EL2.E2H is set to 1
>  * guest will pick up wrong-ASID TLB entries from step 1
>
> Does the architecture require that the guest did some TLB
> maintenance ops somewhere along the line to avoid this?
> I haven't tried to look for them, but given the different
> ASIDs I'm not sure it does...

...HCR_EL2.E2H documents that it "is permitted to be cached
in a TLB", which means that the guest has to do *some*
TLB maintenance ops if it changes it; unclear exactly which,
though...

thanks
-- PMM

