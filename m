Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8342CC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:24:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0991320CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t8iCH6Gq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0991320CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZGj-0000ur-Vw
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6YvC-0003Ki-Vl
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:02:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6YvA-0007lF-Sz
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:02:42 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:47080)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6YvA-0007i2-K0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:02:40 -0500
Received: by mail-ot1-x343.google.com with SMTP id g64so11785578otb.13
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OalDj38vAYtArGZEfUFVIwvsdCbBvjJMoAXbjYxn3eU=;
 b=t8iCH6GqFC3kuMAgqjoNXv2AGGVat1EMbI4K3BK4GeoFtaYMgGEd1DD+yrmrUqXnnd
 /KXcrUBlqwjbi7YwesROnT3j9YTnsvCu+PP2EZ7pEvweqLuo3ENskBFxWefimLt9OTpw
 9JxsOwkJDdvJfyt7uNECy/IKqN9afDzhZz7tMeIIXF/SYLYr6tYvtA9RlJjlZFVxb+v6
 S5+IkC83dOGNo20497xerN3qWJ+z2SjQ3yd1q+TTrEoSHXhysDwsSuLDsYqSV+C1ONYO
 DXwcO8yZBr3+ilQvJZD4FnM4Em3nwz4TE+1Lxsqm0vJ0+vT5XLGD06sAuq/PJCdnaqRD
 5GyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OalDj38vAYtArGZEfUFVIwvsdCbBvjJMoAXbjYxn3eU=;
 b=h2q7a/fm6Td6MGIcROvbzvGr1I9SLOhoM36P48NDMrervzY+ZWN4cpqK3qX/Eelj1S
 T/ZC3Pzzs+i95jillMVJqeHGsupAgZ7FikZ9+J/6drq9fKxGqlltExZ+4IByiHWhpZAA
 uWc5g+tp4GBqjaEW9bpjL/rre81aMci4AbNiFeMIic/PWG4+5Gl4F1006XB3s5kJltT0
 IDmUM2iZy87B3Lk2uH3OEzUfg5eEQRtZW7aP9D1CJLIfM8jkwLKA7kNzlgkjyie+S4mc
 O/uykswYbnzlsbU4BrR3Rt3brroZ86B9GCZgpONJLQXyQhwUjQWyIRX6Mv6DWtJkIIFO
 TZ6A==
X-Gm-Message-State: APjAAAVsNJydf5R5niinkBBb/IhTjX2QapQt2vD4oUyPkGrzgE8+SH99
 xjlKrxF97gTHjtfvX/rPrDDyT9BV798GvmhrFjGMXg==
X-Google-Smtp-Source: APXvYqwlR5vwE7Z2LfXeWVegK0lvEoYP1rv3WAQrrYnD7PdShTnN4/buvpJhrxxN+Lkw/MrPdtpvLNU6MFE6mNjODz4=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr42212075otq.221.1582632158436; 
 Tue, 25 Feb 2020 04:02:38 -0800 (PST)
MIME-Version: 1.0
References: <20200218190958.745-1-richard.henderson@linaro.org>
In-Reply-To: <20200218190958.745-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 12:02:27 +0000
Message-ID: <CAFEAcA8qzoWxZ7ffqBaOqZ8Kicq7Zz43jRwxkyt7gTLy7kBEiQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] target/arm: Honor more HCR_EL2 traps
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Feb 2020 at 19:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Based-on: 20200214175116.9164-1-peter.maydell@linaro.org
> ("arm: ARMv8.1- and v8.4-PMU, ID reg cleanup, [H]ACTLR2")
>
> Patch 1 is a latent error that I noticed while reviewing
> Peter's patch set.
>
> Patches 2 and 3 have already appeared separately on list,
> with patch 2 bearing a v2.  Thus this patch set is labeled v3.
>
> Patch 4 is dependant on Peter's [H]ACTLR2 fix, and the reason
> for the Based-on tag.

I've applied patch 1 to target-arm.next, but feel free
to keep it in the series if you spin a v4 before I get
round to doing the next arm pullreq. I've left review
comments on the rest.

thanks
-- PMM

