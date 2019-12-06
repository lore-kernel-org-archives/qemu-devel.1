Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFB0C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:43:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE3F220706
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L5jOzS15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3F220706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idEpA-0004L6-Cw
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:43:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idEQv-000497-SG
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:18:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idEQu-00056u-SM
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:18:13 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42302)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idEQu-00055c-Mc
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:18:12 -0500
Received: by mail-ot1-x344.google.com with SMTP id 66so5893020otd.9
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 06:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O5nsFOtjimTarn9GS+btDv87kUC1vCLmzpNDta2HK4s=;
 b=L5jOzS155bNCJ4UXbeMy8WfpGFnhylLmy6JTayxrFtoocFrgo2Aw2oRJ0YZKjnn0VJ
 xeiluYE6eu0Mv5RqFmD/QLeJll5t92+PRB6GFtg3BkX5T8lEjjabwqm4c/ndwt/6kvdt
 ZmKCfFPgkxQga/F5ExQsqnaobyvDIOUsKBnLYyIHrw2nAfZsaIU0/mqQNaEtKJJ+SE/J
 pgDUhrpbYxMWfqMx4V4mVn/Su15wtVPPM6S47Gb7VBZJBU0TiCXT5RCB+57+jYoz/Ttp
 7j9PmUFQrKXEa1ncKT59cbS5ETBu1HGkIjurDbwzdpb1BdKB9FzKBW00a1zzL7ur9gGE
 Vghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O5nsFOtjimTarn9GS+btDv87kUC1vCLmzpNDta2HK4s=;
 b=IC3V5SZbadM1bHCcEpOUwtRB18spW2Cu+Kpigw4I8aWP6IetchiloB99TBXeifdibj
 jm+ZQESQbvswlWQ0IdEZ9jZQS5B0ms4k9Id3LGulXZKuIRk8sc7WOpU6J3dDpRl7EgXN
 K4GfcC3gMgoV/Jj4vu1XCD5/NhD4GYSkJOUpWc8+8SHLD96CyRbgYpTG2ofCLvffmYtU
 vGsPTe/rjUs3Mc52KXw8D5JAFtAaj7TwqcgM3x3ADIzttzSCk5BzB3RWLaDc8RAiTUxQ
 jnDH+K8ZS3QGL8eDBFrEt1FpEm3j8fV6nieF9pz4crQDgffNCOl9gKRaSxXUEXdq5WMM
 8LAg==
X-Gm-Message-State: APjAAAV1csxDItmrGoa9N9EFfNdjanRRn9dwOXabqrzO1Yf/bdr55DQo
 YyLzQZBakFCa34OqkI7J/DmF6gcd41CrjBAxDAMNxAQZ
X-Google-Smtp-Source: APXvYqx0mgH1eZdXMJbTSz8/uk5lM8qaVRisD8J7Oy2Nvm8QuC/mlP7MyfC9Gfh/qiuuQgPFvQ56xF0sGkG+97F67Cs=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr10680515otg.232.1575625923512; 
 Fri, 06 Dec 2019 01:52:03 -0800 (PST)
MIME-Version: 1.0
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-21-richard.henderson@linaro.org>
 <CAFEAcA93AX9nikuqq9M1jZOxv1a7QJZpiocHnn=n-gSbsGBS7w@mail.gmail.com>
 <bcc3ff61-e737-2af2-5c0d-a6062cbaf083@linaro.org>
In-Reply-To: <bcc3ff61-e737-2af2-5c0d-a6062cbaf083@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 09:51:52 +0000
Message-ID: <CAFEAcA-pB5k6P5RS+BoFghrvGarPAB+OcAN38NouDhu_uEhepQ@mail.gmail.com>
Subject: Re: [PATCH v5 20/22] target/arm: Create tagged ram when MTE is enabled
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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

On Thu, 5 Dec 2019 at 19:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/5/19 10:40 AM, Peter Maydell wrote:
> > Are there really separate S and NS tag RAMs?
>
> Implementation defined, I believe.  As with everything about tag storage, it
> would seem.  But since there are separate S and NS normal RAMS, I create
> separate tag spaces to match.

Yeah, it seems like the obvious design. I just couldn't find anything
in the spec that said it was possible. I'm probably missing the
relevant paragraph.

-- PMM

