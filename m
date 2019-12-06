Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEC9C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B4A2173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OLjERoQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B4A2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idIIi-00009S-4O
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idHv0-0007hS-9F
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:01:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idHuw-0001J1-9k
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:01:28 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43049)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idHus-0001FW-C6
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:01:24 -0500
Received: by mail-ot1-x341.google.com with SMTP id p8so6519919oth.10
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 10:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DNj5MMlD1GeIbgVK7u3xIhxDZ092D2ms+Vksapfj4IE=;
 b=OLjERoQJU91pfeB5bmNm1i5MpzsRlLMZghJKf09wHhHrYlznj+4J9pdfLX3cfcJsTr
 O2QQf+++Uo6MN88LuKMb94ZT13YfRMdqGrl01sUnWfjW86Dl6IMpzrb5RE670bh+IGNE
 EHhiNlJDoRT69R0OlA3b2shBConct7xwbQMAbA1JI1FLuIfTHdbkG5xHL6Ges4smkyon
 n13LUk7hmHmryOcaPKYA8gRuP1cmK4TBTtqNFP/r7yRjdyETpho8dWU+n4LwsmPZPg5a
 yeKKyuG6UX0OeTmQwyoFFkTjZZNHHQq+cSjA+jBPGXI70r1fHZSSvesdI/geCVv5DJfr
 J1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DNj5MMlD1GeIbgVK7u3xIhxDZ092D2ms+Vksapfj4IE=;
 b=GvRvdoMWKUjfKQ2mb7vCLVnwOqavSuLYRCRiCGVAXIrZQ+2vtV4o3AisnJCt4iH9IK
 XCNAiXyNSnUDqVEmkP9CROsPtbiQzs6uiBKL/kYfbiaOqTEabopEzJM5ChZUiff/5pIw
 wXRed8jYMlPulplxlaAm3/EkCyckprwhi0QQJDUDjcajbkbCZmQRY+qHh5OOG/zK2U0n
 4H8A/3vrPcJqOSFcge+9q+UqGNw54WkXR5iDwRyvWc+/EDXJywGetlzw/eXVVddM2lBd
 T/4CUulkZCICsMSEnAtsstTPrBO/Qqc/PP+Dk+eqmT1loXIehdUqh+v2kDmW2KDeO699
 lYKA==
X-Gm-Message-State: APjAAAXrbJCCZ000NEb8KeeGT6dkC2c/fs27grhYxUu5Q6ijyg5MhaCR
 eoWdZUxXZOaUfsW85lGd6MMXF9bxlwSrbbabxZobPg==
X-Google-Smtp-Source: APXvYqweNBBmKdwRKwMiAH2IB89pPiu7t1y4X57jKmhWDvRkOR9xbe8I3rktKKKk7vZ+rycP0kTFXg0i62gL/x6jIww=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr12496828otg.232.1575655281310; 
 Fri, 06 Dec 2019 10:01:21 -0800 (PST)
MIME-Version: 1.0
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-9-richard.henderson@linaro.org>
 <CAFEAcA9Bf1F0CcbsqASemuu+CxPSEUHBWzyR1Qo1QUTE9hBkKA@mail.gmail.com>
 <95e1ce50-e98e-d7d2-8af6-d5f315b8fa95@linaro.org>
In-Reply-To: <95e1ce50-e98e-d7d2-8af6-d5f315b8fa95@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 18:01:10 +0000
Message-ID: <CAFEAcA8YKXnqNGmpcsnffynyBH+k48OWZ5PXe8Y3AV6x+=K+ww@mail.gmail.com>
Subject: Re: [PATCH v4 08/40] target/arm: Rename ARMMMUIdx*_S12NSE* to
 ARMMMUIdx*_E10_*
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Dec 2019 at 18:00, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/6/19 7:45 AM, Peter Maydell wrote:
> > On Tue, 3 Dec 2019 at 02:29, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> This is part of a reorganization to the set of mmu_idx.
> >> This emphasizes that they apply to the EL1&0 regime.
> >
> > It loses the important point that they are stage 1&2
> > translations rather than stage 1 or stage 2, though,
> > and also now they're out of line with the naming convention
> > that all the other indexes use :-(
>
> It won't be out of line once all of the other renamings are done.

I think it might be easier to review if I could see
the intended final set of names in one place (eg in
the commit message to this patch), rather than getting
them a bit at a time (though that is definitely the right
way to structure the code changes themselves).

thanks
-- PMM

