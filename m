Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C72C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:33:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 941E92243F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L0TsPE5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941E92243F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXNIc-0001kb-Fr
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 05:33:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iXNHM-0000ms-1c
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:32:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iXNHJ-0002Xo-Uc
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:32:06 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45949)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iXNHH-0002Lk-Nn
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:32:05 -0500
Received: by mail-oi1-x241.google.com with SMTP id 14so22000520oir.12
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 02:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MyULrr8n1VFQYQPL12Jw2hqL20N+48hCyExX/wzvy9g=;
 b=L0TsPE5LEkZjg/SNpJEInZPax4kluEZFgr+NUmNbsJSCe90jvr8pVBkYXAymlE/SuR
 GhTaZGdk8xgdpenMNUj2Wh331hpUkfqsNLsym+/VYcybu2vXyQUZbfOBiw1cJDTMrv6z
 PbR3+q9dgf7UsqbbyOQIL3S0c+10s0Wp+YqD4VmTdQtc14+Bb8V3OV0J/52VAG0jyzae
 qWdVVKH8QBRHkBxhQ20kDrGhxMdkj1Iwsa2Xj4bH669FhEvDgN8e4Bca2PxFLkmOye6U
 l4H7bLEKuWzdh9KaiLbc13D26BQok5exYyhWHr6UB6bTRRGGREBT4NLeiPZR8pnza6CG
 WRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MyULrr8n1VFQYQPL12Jw2hqL20N+48hCyExX/wzvy9g=;
 b=GmYujVPtUqWGypOg7jDkC7LoHd86kRojRdMJ/vRdHt4RKYYNNW4hsQP1xLQm+O6iF8
 OkEH0ubarKjslxkQIeSwaH8xhUSzeBTAQneA+0sgb2pHo53U3W0PTJwA2ZOLYzRMaF11
 YWVKp91P/ACvm5ZUtuqtM6CT2NYZG57QE/2ZohSuEPBA9v+Sxfic3Dn/CcSwXHmFbpIp
 HZM/MnUyZKPeqjYypMoBJIKUwy8KjG9Rl1M7qIxrOu4DSMIgy69IcNeYMBjfPH/60pWX
 Ntm00LcQS/bKA4sEDBX9EkyOQ//S7fD6qxbCf7HEkNz042xIgLMav0ASKEBC6DdZtpDX
 jLBQ==
X-Gm-Message-State: APjAAAVs7oNEozwjv49XcbsgmiA2qckMcOPvv/leN88h49T53tk95vjn
 fhL0ICcQWCo8VGQB2mYPcJIWhER88IDBDKBvSfU4CA==
X-Google-Smtp-Source: APXvYqxvdzLVL73peJgyzdgheAXGmfBxNtEqnNYXdzlL/RLIpS2tcVrl3tMjsr3HcONRujQz8IpUViWEGkYv5dtOuNo=
X-Received: by 2002:aca:4945:: with SMTP id w66mr2219891oia.98.1574245919164; 
 Wed, 20 Nov 2019 02:31:59 -0800 (PST)
MIME-Version: 1.0
References: <20191004025509.3012-1-david@gibson.dropbear.id.au>
 <CAFEAcA9soWUfyfvV5Onyy0wP842Gq698_sZ+E1xGwkmnrLHnJg@mail.gmail.com>
 <20191120052701.GJ5582@umbus.fritz.box>
In-Reply-To: <20191120052701.GJ5582@umbus.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Nov 2019 10:31:48 +0000
Message-ID: <CAFEAcA-2B=tLfc9y3ri_p9nOWBAaiDkhgRQ9r-hjdmYbpzbBiA@mail.gmail.com>
Subject: Re: [PATCH] exynos4210_gic: Suppress gcc9 format-truncation warnings
To: David Gibson <david@gibson.dropbear.id.au>
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 Nov 2019 at 05:27, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> On Mon, Oct 14, 2019 at 01:51:39PM +0100, Peter Maydell wrote:
> > If we assert() that num_cpu is always <= EXYNOS4210_NCPUS
> > is that sufficient to clue gcc in that the buffer can't overflow?
>
> Interestingly, assert(s->num_cpu <= EXYNOS$210_NCPUS) is *not*
> sufficient, but assert(i <= EXYNOS4210_NCPUS) within the loop *is*
> enough.  I've updated my patch accordingly.
>
> This isn't 4.2 material, obviously.  Should I just sit on it until 5.0
> opens, or does one of you have someplace to stage the patch in the
> meanwhile?

Easy fixes for compiler warnings aren't inherently out of scope
for 4.2. I'm also collecting stuff for 5.0 anyway so I suggest you
just send the patch.

-- PMM

