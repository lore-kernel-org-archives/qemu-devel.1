Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1386FC74A23
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 13:37:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8777A20651
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 13:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vQBazE6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8777A20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlCnF-0004wO-Dk
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 09:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53918)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hlClg-0003ya-TZ
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 09:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hlClW-0004Fn-JP
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 09:36:14 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835]:46677)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lucienmp.qemu@gmail.com>)
 id 1hlClP-00049p-7A
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 09:36:03 -0400
Received: by mail-qt1-x835.google.com with SMTP id h21so2361375qtn.13
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 06:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iUI2fj75GdJHT1G2kfr8d5nR6QcA8HCMuKyEQSpXsBg=;
 b=vQBazE6M/Vrcr1Hl4TF1etj8FolHSDGbALqAKi3eFMtv4QEJhPK9NEfEbvZnNXmqRs
 BD+xfa27LLAbtiSEm7L/OD/wOJqppERtT67Kj0WPzzeEB8IdVhFGZy2JdV7GX95IDI7j
 ZTBhPW0quZHYZLbWa4NMtYb6LHb080MVS/hijS0zXiVQ1CiqI3bjVJ1UHf5K6h4Yjf+h
 Kt5jjRMUxTJ34Cf8kiwpJevLkerChGWIro6XbuqzZVGc4MrtpHh63LHWT2P2cn1SIlXj
 WSaXW4w3ZtVGvjmgBaI5cm7uGdJsNQf+KUiFGfrdmCLdCtDDc0V6XXDB4eTprSLpTPx2
 RVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iUI2fj75GdJHT1G2kfr8d5nR6QcA8HCMuKyEQSpXsBg=;
 b=VKJ1+s5VCMsBDh3Lazl2oBT2Hvq/bk5wLPChsabRE4N5p/cvHSHKLUPU5bz4WonYR+
 9oqw7YuGA+37QhLZhvTu/7VCkO8jelHc5kEXL+DGvZSKXZ5mxdwDlnWHQvgmJnoy9Np0
 cfc/OwkDOJQJ5K7jImIJdMdl8kQe7k1KfFuvHCRYBkeVEDBYWURbE9MJFWkj2Y01LQ4J
 Ga99WOFNTu75ccZbUwS9ePvws0ai2PoUXGlEZ+q+h5YT2rH7IDQ/W/jSX6nLH5k5gS+v
 MfWvw96D44qrFqbkX0A/D0VbkR/W9N0JMrJBBWh5Ec0UYW4bb3gbPeHqGgzeBDqec3w1
 Cxuw==
X-Gm-Message-State: APjAAAUTwIVB1tnsweA929etr3RgzpidlkDDFXJtgrgUylUkSnH3OP+z
 SAJhyxHOWsSalMcj9Ke7lBs/RtD6sst3Df+4kkM=
X-Google-Smtp-Source: APXvYqyHK1a8R3Ho7VtgUa8KWUEDV/TPUndyCA/8TtlEDNSrgEcYe4I3jtT5pbyYdzaKiKLozpridMFZqtjtxgUJM6w=
X-Received: by 2002:a0c:d1e2:: with SMTP id k31mr25095340qvh.173.1562765762558; 
 Wed, 10 Jul 2019 06:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <2136180936.260219.1561641583358.ref@mail.yahoo.com>
 <2136180936.260219.1561641583358@mail.yahoo.com>
 <1079763171.281101.1561641752988@mail.yahoo.com>
 <e4c1fbc4-3e43-5df4-a17c-527d98d9763c@linaro.org>
 <20190628002713.GA19257@localhost.localdomain>
 <eadb57ae-256d-0bb7-5988-f493662a5caf@linaro.org>
 <20190628155030.GA34320@localhost.localdomain>
 <ea16a81c-5b94-8dd0-8339-2bd82733aed2@linaro.org>
 <20190629163621.GA111724@localhost.localdomain>
 <CAFEAcA9sfNisAz-zAZAx=ZNFmsEpP0Ec2DeRedtZSd9KQ4fvNA@mail.gmail.com>
 <1399218244.1210557.1561982640362@mail.yahoo.com>
 <CAFEAcA-0vGg_1nfkbq+o6JwoDsRyP=6mnv6ADi-atV0ROX269Q@mail.gmail.com>
 <CALvKS=GvAkNr3OKZzjGoTGG_Eys76zjcjodiN4hKXjFM5B0a4A@mail.gmail.com>
 <d9e5602c-bb33-1812-ebc2-b533e9dd5f25@linaro.org>
In-Reply-To: <d9e5602c-bb33-1812-ebc2-b533e9dd5f25@linaro.org>
From: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Date: Wed, 10 Jul 2019 22:35:51 +0900
Message-ID: <CALvKS=ED7t8F=ennNRHpY4K9ZGi2y5KPOSmj3p6DLru5i1JmPQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::835
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] RFC: Why does target/m68k RTE insn. use
 gen_exception
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Lucien Anti-Spam <lucienmp_antispam@yahoo.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard,

I am so sorry, I was too naive when you suggested this and I misunderstood
the meaning of what you were telling me.

After spending most nights digging through the RTE/Exception process for
the M68000 I now actually get what you
were trying to tell me and its simply genius  - I hope it serves others
well too when they need to do something similar.

I still dont have all the tools in my chest to understand what I have, but
I will keep digging.

Many thanks,
Luc


On Wed, Jul 10, 2019 at 4:04 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 7/9/19 6:58 PM, Lucien Murray-Pitts wrote:
> > Any suggestions on how to obtain pc_next from the "m68k_cpu_do_interrupt(
> > CPUState *cs)" ?
>
> I did have a suggestion.  It was fairly detailed.
>
> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06522.html
>
>
> r~
>
