Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6011C74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D47A2084B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zVNe892c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D47A2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlYVC-0008GP-Nw
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 08:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57830)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hlYTV-0007Vg-CJ
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:47:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hlYTU-0001o5-BC
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:47:01 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36542)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hlYTS-0001m7-Ha
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:46:59 -0400
Received: by mail-ot1-x343.google.com with SMTP id r6so5704113oti.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 05:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p97YX3IoJy94wJq9tTL1wuf0ASRWpNpZgfBlTY7Zy78=;
 b=zVNe892cf8T64t9Poweuxia2hTaNBG0dcRus7B/4/adsYiq/mJlZJEIP8XCxKc+Apr
 cf4OCyI3HspQ/SphiawqlaKfVKSnaZ3kK8pFSy7mLWLCsjOzo3K5RBH7jnvUkUapQtHa
 FDwONXmh7vTfQg0+w47JjfR6OSgQpg297Q9HLjcujrw3yogd+vwF8vEiRKuAXL9dTHer
 8R3GTxfIDZykwX7Zm8ck0EGnfhtZJ/foiNF0563FfDgmx+r4/zepfvEyC8BanR3kzCE3
 inpXIz3lXAnMPBhZDQCamCypBTdw+zQAwiAFHgwCZQY8iUkPvM4cPh806C7LLQ86TcwK
 q9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p97YX3IoJy94wJq9tTL1wuf0ASRWpNpZgfBlTY7Zy78=;
 b=CIerfnHo4+COe7ja4qviNbKamXbtoC5qJYg6RpFoVRIyea0tFMQ8ZMCC35UrVKxlPh
 UQtnkySzxjp/0XoLBgh3YfuKbK4qFPaqHby8Wjqa47QqZHndFnkdvWP76kj7xiKWxpbe
 xSZnNXQg9QyyWygXsnjphE8dsPFfot/OPPtvyeo8IwvT50eAA1dQvZ8iauXlM1L/ZRKR
 zqvAPBHZtLd6hYbGFAw4lacWgioA0GnHMmbaPcQYvDz29nlUtiu3+GYgslZOZSr+JEFn
 BlK2f98oAChaAogkT2C056Ol68gwUsn+yH0hqONRVMykrylVIXix0su5T/SPn8nUVTVo
 Duyw==
X-Gm-Message-State: APjAAAWxF+4DokHXxAc6Mj8j6Vjh+mq6HCWyTBoOtZf1IiH43m+1846N
 R1c1ugxrvYIvmHI2I4Qt7M4cLi6e0yBBndo4H+BkIw==
X-Google-Smtp-Source: APXvYqwIuUVnErABgjVY5ASG37fqqVeG7zVNobq/ht3B+tVjL4E39+AYZKLw3JJnxAF+WuLWHzw+0OYnhSHhW96cPVU=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr3036913otj.97.1562849217964; 
 Thu, 11 Jul 2019 05:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190711121231.3601-1-peter.maydell@linaro.org>
 <21ffce4e-72cf-2c5f-71b1-cb53367dccda@linaro.org>
In-Reply-To: <21ffce4e-72cf-2c5f-71b1-cb53367dccda@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jul 2019 13:46:47 +0100
Message-ID: <CAFEAcA_3RMV1vMk5CQf1Wjk1SJUjhEFxaevn6hupp9+ZjDktAQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH for-4.1] target/arm: Set VFP-related MVFR0
 fields for arm926 and arm1026
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
Cc: Christophe Lyon <christophe.lyon@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 11 Jul 2019 at 13:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/11/19 2:12 PM, Peter Maydell wrote:
> > @@ -1713,6 +1719,12 @@ static void arm1026_initfn(Object *obj)
> >          };
> >          define_one_arm_cp_reg(cpu, &ifar);
> >      }
> > +    /*
> > +     * Similarly, we need to set MVFR0 fields to enable double precision
> > +     * and short vector support even though ARMv5 doesn't have this register.
> > +     */
> > +    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
> > +    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPDP, 1);
> >  }
>
> I would have placed this immediately after the Jazelle isar setup, so that the
> "Similarly" comment had the proper referent.  But, no biggie.

Yes, I'll move it. I'd misread the chunk of code that sets the custom
IFAR as "ISAR" and assumed it was all of a piece with the Jazelle ISAR
setup.

thanks
-- PMM

