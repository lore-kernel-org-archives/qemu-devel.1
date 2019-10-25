Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18292CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8DFB2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m3rAsljL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DFB2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNuMo-00086o-LZ
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNu5n-0000a8-BU
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNu5m-0007A1-FC
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:33:03 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34632)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNu5m-00079q-AY
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:33:02 -0400
Received: by mail-oi1-x243.google.com with SMTP id 83so925275oii.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 00:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UXyQc7byCHorjpzleeV+yeF/hdiNcv/oDoPPY+Q7sQI=;
 b=m3rAsljLHdab5KrQtvU9MX6ASKZWvB7Icd28i8vlmEG/Vw9l6BiQuLu2sfzhu55vU/
 EBWlOOCNlsvbMBACibc6rexqaGkv7qH1vfxSmaqYNbbtjb5g8DNzlRSk+rd6+b/9q3DB
 F/HiEKN8FPbhbj9MCr6qqeoBQ5Vddz374JdVwWYL5bxFOEgvU6MynWf52ji4muNnM4qU
 OMWThZJ2x2ZKHGNllt+USkgzsZwwiUq6qNI3lk3Zz3c3KSkqgjFTWGkCu5unjI6PFsjA
 o6X+DOBsKK+MYH7LDYb2169WmhjgLn+p3fbJLzf/5d81oPoq3G8JJccZ8JoLAa92cNdn
 Q/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UXyQc7byCHorjpzleeV+yeF/hdiNcv/oDoPPY+Q7sQI=;
 b=rGyYX8AobewCEx8IS06HGsgtbBF1977UIQNd/e/8QxUWhr5YYEln3TsJxMEP9oi2h6
 frs6UoERn7kW1zWMHreVoNckzEV2NcHAgmUFvygDlQGo3LHMAlW8B/T576dndKr0jCyx
 sI4am7BRb+8LuvEjhWb0A4ZeoEdDKbrxj6xKsOTIZwI68aEXWar6y4b2ss5gHuX/2lQW
 tOYnEL3cER7nBv0ESVfT+arrTnig9I+P0cygi8etu8IgIAGl5x5DGK2F5u2QxFRHxzeB
 Ysu2tkQvghO3nH/SxpPQioOBuIYqvNpVpULkBiaBpqFHEZ/d7mWSX3ymi1O8ws/TGnSt
 3uzA==
X-Gm-Message-State: APjAAAWc/n/WOepfRB5Z/AbK25ZhGb8HxiQ9NuK0e4VYjrbuocn+OP7a
 eLkD7h6xUcPzj4+uwlHoK5rV5AT95/O52WaLoUdygA==
X-Google-Smtp-Source: APXvYqyJeIStp0YcJGGfqRdvvmNWyB/u3aPCa++Jl4bGws/lb11HyKWGb6I78tsYCXvm/GhtqwCVSgZTTFKZ4ASdXm4=
X-Received: by 2002:aca:3b41:: with SMTP id i62mr1672054oia.48.1571988781416; 
 Fri, 25 Oct 2019 00:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191021134357.14266-1-peter.maydell@linaro.org>
 <CAFEAcA8d6xXp+bCJCSWwD47Omfrenh4C=4NC3cFm4pEAHhkGmQ@mail.gmail.com>
 <9b2f59f2-5a99-41be-0a57-dd73f72dc547@ilande.co.uk>
In-Reply-To: <9b2f59f2-5a99-41be-0a57-dd73f72dc547@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Oct 2019 08:32:50 +0100
Message-ID: <CAFEAcA-X_dfYbE2geXr2cZ4qUkH9kfH5N_NapXtPDTQ8zjP-7Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Convert sparc devices to new ptimer API
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 24 Oct 2019 at 19:10, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 24/10/2019 13:19, Peter Maydell wrote:
> > I'm going to apply these to target-arm.next; I know they haven't
> > been on list long but the change since v1 is only minor and
> > they've all been reviewed.
>
> Thanks Peter! Not sure if you saw my Tested-by tag last week for the slavio (sun4m)
> parts, but there were no obvious regressions that I could see under qemu-system-sparc.

Yeah, I saw that, thanks for the testing. I decided that since
I'd added patch 1 I didn't quite feel comfortable carrying the
tested-by tag across.

thanks
-- PMM

