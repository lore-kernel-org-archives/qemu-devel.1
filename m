Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D02C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 15:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD8A2070D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 15:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dEiJfDx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD8A2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv1ML-0003AE-MV
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 11:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52495)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hv1H5-0001bm-2G
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 11:21:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hv1H4-0000TJ-3k
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 11:21:18 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34767)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hv1H3-0000Sj-Te
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 11:21:18 -0400
Received: by mail-ot1-x343.google.com with SMTP id n5so93480467otk.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 08:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WxjTc2EKFvHZKfI2OePpAvvlRjl1puN/NiojgS9o48s=;
 b=dEiJfDx8aidM4i7wTTN6Nt5WhA9Sbx1QPm/OPXskk9U+43+v+IpwBPPmTbzpiU/ds9
 vkBmlf61vtoMQPoebcVcT4RoZr3cCyQpTdODpyh9MhxftkU7uwtWF/7atvwqueQh69J1
 fyH6GrW1BsZsUMC9MTC7NcdZKcES8MZMUdtN03GhqMXMhmCjDKs5M/psy8APWHbi57Gp
 mxXg5kZQYmkV71C/1NexHoX3W7HGCB4nurxTPY6vhFWm9OFA/7g4xgLstzT3RfxEs7+p
 85B+SGeUjDmpyDoVkWRssbNwUS53Caur+oKW15pLochrsbyf4sviixjY3gkMmJhdRQ79
 sDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WxjTc2EKFvHZKfI2OePpAvvlRjl1puN/NiojgS9o48s=;
 b=kHAr3xbLzS8QWWsGXg73yXqI20LNOFvebNrsACH6e2RwUfMSHIm6j/hjEftK0nEHKv
 ZECZNPuDbHbQvwaHdmCjVowr++0MdumJ/enqdfkX9EP5jeKXYNekg+edkvTylQBMa9N6
 g+91z9JANP25ggCcNHXXx2v8dggL1kbTtdWaAh9zNMhGSEdUzJPt/FQCjYeCiISjwzHT
 V2uiJkF4E6nPzcUkIBmh6BpacnFnoKxtvVNEZqussCWp0l04hHNjLj0r3/ROWvi+ypRX
 6FT1m5as5eGCDJqJ/MWDbR+6rQNhoxMMFe7B21rzrhtsn+w1LDN04ncZxQmZnmuwi2LU
 p0Cw==
X-Gm-Message-State: APjAAAUfrtLccuuukz8H6PwbU0js2IflBlIZ8KCT/7E/Do04RnGN8TeQ
 B69n4tKdE3+mbKsjgxYou1u3MRH2FC5Nx97h1daPEA==
X-Google-Smtp-Source: APXvYqw9PEwJ8131L+jftg088JWaP4/h4dplNATFRSjOkPtwTRmVEsQAr4UXEXgNFd3UZdsz46lhMKuLidQK8TXg+t0=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr3886322otn.135.1565104876928; 
 Tue, 06 Aug 2019 08:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-7-richard.henderson@linaro.org>
 <CAFEAcA_kmuX6bxR50eU_3nTdRcjON2nVTqVWiRamSRe6jui3ig@mail.gmail.com>
 <09b930e2-0a92-25a3-4e26-8bea1f437039@linaro.org>
 <CAFEAcA9yQQSYnwEeSNbx4P94deuG5v5fKs7gW4VgG7LFzBX03w@mail.gmail.com>
 <92a7e54e-678e-cf4e-fadc-373e1bd6a41b@linaro.org>
In-Reply-To: <92a7e54e-678e-cf4e-fadc-373e1bd6a41b@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Aug 2019 16:21:06 +0100
Message-ID: <CAFEAcA_oy067xK9p51cKwRDcCVTaj2JuqE+11jLS5L_gFFyzrQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 06/67] target/arm: Introduce pc_read
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 6 Aug 2019 at 16:04, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/6/19 3:00 AM, Peter Maydell wrote:
> > Renaming pc_next would be a cross-target change, so let's put that
> > on the shelf for the moment. Maybe just put a TODO comment to the
> > effect that we could consider renaming in future ?
>
> I wasn't suggesting renaming the cross-target variable.
>
> I was suggesting shuffling around the current names, and using "pc_next" for
> what it sounds like -- the pc of the next insn.

Oh, I see, so incrementing base->pc_next after we load
the insn? Yeah, that would work too. Though it seems a bit
odd to me to have the target-specific code modifying
a field in the base struct -- that seems like it ought to
be purely for the generic TCG code to use.

thanks
-- PMM

