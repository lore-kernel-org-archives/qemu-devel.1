Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62149C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 18:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DFF7206DB
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 18:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hrhnWNWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFF7206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5D2o-0005UQ-Cc
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 13:28:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j5D2F-00052e-ER
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:28:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j5D2E-0002qK-Fk
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:28:23 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:38394)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j5D2E-0002mJ-Ar
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:28:22 -0500
Received: by mail-ot1-x32d.google.com with SMTP id z9so2871206oth.5
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 10:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ccch3C9CoeBg2kqC0behFIWOUbyYINtkb/TzzkM3lK0=;
 b=hrhnWNWjq/k8qj0MAcEnahZ2u6sEud/pGeezde/b3M6DrENw18xu93x63w3PqK52Mj
 JjiJMsiQ5ZLwv9U/F2Y4ASN0o/kjGKfKEdLpVJzWXpewYOGGyBBOLQLMOdoYsk6r0lDp
 umfuZfpPVAEIoOGRGA6XSvv96/dc3+5oDge103AgJX8r2CGLM9hn29BkjpDb4ug/dwEK
 +06ltszR0WPnekmY3cWYIV9Ctk5wozx05GIc6C/GVh0eorF+54jziV+CL8j4JEfArzn/
 VW6kALp1mtQIV8wFnO2CFiLpFHiPmcSxJxwAV1mpyvYMwrRmJb+ge2gF69FHILedkDGR
 NMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ccch3C9CoeBg2kqC0behFIWOUbyYINtkb/TzzkM3lK0=;
 b=hnmXJJK7zy9KOCY/UhecIGrgQkwqBq/pr3g90t/RcgCPJ3bsNltqeBKPf8YzmnZExp
 WVg3ukHOuH+GqjON/1bSnXKE29aV0nmYpcCiC/fh5ZxH/W+A0pHOoSngoe5Ah8YC1wl8
 LAAUJcG/aeBGAF57FmebCwaBwIkSkpL5P93y4R7yHh3ZKJmqd3VIVd0mdOTUTYhXv3MX
 qwBq1MwxkOz+GaE8evSTAYYzdHTivthlLMZFLSr/C29uWxTdwejcAint/WjJnsbW5oOn
 8/alUToLs5+CBds8pekI4EZOejtwRLW41ng7/oaU8hvfCHetoQGBlqAqJZklzXLNMeLY
 YsLg==
X-Gm-Message-State: APjAAAVuDFYEInA2Q9C8xEcooG3CwiVQmsP7FlOdGKUxAXKPSB/Z9dEG
 KF4oJuaiDhNxHe2iDBq43gCLsnlrewCT8Wf8B2phYiU5
X-Google-Smtp-Source: APXvYqyfOsFQeDR7J4+wZdc43H7LeKIiZP5FvxeT2mPsEIr03AQWd8WUuoQm/GjTVQUDKd5KhrU5VthJBOaeWcFi2Qk=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr29609672ota.232.1582309700539; 
 Fri, 21 Feb 2020 10:28:20 -0800 (PST)
MIME-Version: 1.0
References: <CAL1e-=gKNaF80c2mKc+4ftPjiUayvOGbb=ZsqsCrVRh5E8-B6g@mail.gmail.com>
In-Reply-To: <CAL1e-=gKNaF80c2mKc+4ftPjiUayvOGbb=ZsqsCrVRh5E8-B6g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 18:28:09 +0000
Message-ID: <CAFEAcA8wEULjSUoVPLf1RLpC2VEmzgxhJP17j9cYQwdaxg8jEA@mail.gmail.com>
Subject: Re: [QUESTION] Clang as QEMU compiler - two questions
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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

On Fri, 21 Feb 2020 at 18:09, Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
> 1) Is ./configure --cc=clang the correct way to enable clang
> compilation of QEMU? Any other gotchas?

You'll also want "--cxx=clang++", so the (few) C++ parts of
QEMU get compiled with the same toolchain.

It should just work -- clang is our default compiler for OSX
and is included in the CI and pre-merge tests on Linux.

thanks
-- PMM

