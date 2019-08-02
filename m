Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE59C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:39:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 240DD2087E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k1e5doCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240DD2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htaaP-000183-FH
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 12:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39800)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1htaZm-0000YR-Os
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:38:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1htaZl-00011s-Qi
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:38:42 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46802)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1htaZl-00011g-Kq
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:38:41 -0400
Received: by mail-ot1-x344.google.com with SMTP id z23so50404638ote.13
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 09:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xFI2+7XPTOv3b7japO9eQFMtUcdolV/Yk2OxnwsKfZk=;
 b=k1e5doCMkVCCaFON4eNc9BukwQMWmq00YRXBVHoQl7u3Eo0CeK7lv9ZKCXV1lbyWKN
 JtrB044h1FD3AdBxGmyyWlY1O5UQLv44oHPv1qR2pGZ7IzcBoShSgKnXnKLvuQcPJKXX
 uJVzqfr5SDRkFB7FjAeWo+QNXF+G23LRJk+OHeGuKHVJ30LC6vEv+7kOd4tGDjnA9IV7
 NtxC6rBQkDr2nA+b9BVrxlW9PBb66q4oANKz17Cud6nW3MpM2p/pW6FQxiClWP24QK/N
 Q+YOZq+ee4d8fTebwhMfGbkUpBhLvBTPFrd8i8qfw+tUYCUAAD2W496Wl9zlgBNBLTyQ
 xXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xFI2+7XPTOv3b7japO9eQFMtUcdolV/Yk2OxnwsKfZk=;
 b=tdWW61ttZrxx1/HR/0Glc8fIcm2q7kZ3beHm2+HyPCO1d4L5H8AdIcUvKiXDkm+B4y
 PGoHCHJ3VLdr4O8JpgiG9c1UE5p3n8w/MsaGGzd8N+8wph+XjTSnoHslbgemlceVPzSm
 XWIf2QGbmQZUC7BboCsEZ0An3unq5avk662uYigaAd97OxmvJjtekofXkggnve7Rww+0
 DTWiJkPqQLzXIociDv3Uoqf6BiOo26SkPbSFFFRnP2PL1W+Hp738nlkiTDGVejjq3n+W
 GBY5LIWzmEK48431hbByTDngASpDOk4rqkpzYeZSQ7H2psW/98d5QbhDioCFy+flEgrM
 0a5Q==
X-Gm-Message-State: APjAAAX9yNoSnjCwCMo2jz3paMzH2klUVmMuadFIt/n2ouN99bI4GmW0
 CzuYKnt8LYQwKwL+PbzcSqQGE5kZhppe9q+cTuMAvQ==
X-Google-Smtp-Source: APXvYqwGrBgdTE4EDZg8pEKWRd0mwZy5xLCn9LpS+go97X1sgzBsJB9faApnTbQTYDpmeXOmlNurDiDkREaojyLcDCc=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr43437299oti.91.1564763920712; 
 Fri, 02 Aug 2019 09:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190801105742.20036-1-peter.maydell@linaro.org>
 <af347b17-b524-1075-d462-2b0e6eef41a5@greensocs.com>
 <CAFEAcA87XdDJH5TO-AiDfSqudmwzuY0yoa0H60objxXp3Bh9LA@mail.gmail.com>
 <569b96b1-e11a-59c5-4f67-1da2d592b8fc@greensocs.com>
In-Reply-To: <569b96b1-e11a-59c5-4f67-1da2d592b8fc@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Aug 2019 17:38:30 +0100
Message-ID: <CAFEAcA_K3v_XXHh-eTpdrb39cVGu9Co95TaLQG+zAU1qa8MXKw@mail.gmail.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH for-4.1] target/arm: Avoid bogus NSACR
 traps on M-profile without Security Extension
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
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2 Aug 2019 at 08:51, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
>
> On 8/1/19 4:38 PM, Peter Maydell wrote:
> > On Thu, 1 Aug 2019 at 15:20, Damien Hedde <damien.hedde@greensocs.com> wrote:
> >>
> >>
> >> On 8/1/19 12:57 PM, Peter Maydell wrote:
> >>> In Arm v8.0 M-profile CPUs without the Security Extension and also in
> >>> v7M CPUs, there is no NSACR register. However, the code we have to handle
> >>> the FPU does not always check whether the ARM_FEATURE_M_SECURITY bit
> >>> is set before testing whether env->v7m.nsacr permits access to the
> >>> FPU. This means that for a CPU with an FPU but without the Security
> >>> Extension we would always take a bogus fault when trying to stack
> >>> the FPU registers on an exception entry.
> >>>
> >>> We could fix this by adding extra feature bit checks for all uses,
> >>> but it is simpler to just make the internal value of nsacr 0x3ff
> >>
> >> s/0x3ff/0xcff/ I think, given you put 0xcff after and in the code
> >
> > Yes, 0xcff is correct and the commit message is wrong. (Bits 8 and 9
> > of the NSACR are RES0 in all situations.)
> >
>
> Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>

Thanks; since we need an rc4 anyway I have pushed this to master,
with the commit message typo fixed.

-- PMM

