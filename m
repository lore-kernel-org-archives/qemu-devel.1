Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBC6C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 17:25:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA063217D4
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 17:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Opw0MLuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA063217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpc3l-0007p7-0Q
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 13:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50408)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpc3c-0007QY-1U
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 13:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpc3b-0003Ot-5A
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 13:25:03 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46935)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpc3a-0003Nf-WA
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 13:25:03 -0400
Received: by mail-ot1-x342.google.com with SMTP id z23so12703759ote.13
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 10:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Rt8CLnpQBhjvnUlx1MuEc65yr5V8moXbvakQ7hN64QI=;
 b=Opw0MLuQ9/4cmAGRj/eNF9Je7t+e4Xdy8gD+Am2IZ2ZIwgG+l8s+nX8ZJ3qGzvKJsb
 7QGKg0u4968wD1twwyaiCBERPtFb6HywpD42eNicnYu6doEEnZJXGFO++NTopLgbZeTU
 s9OnhYL60WVpcYvHNkYgFYhoSY44Lo7SpqaA5jgpXEq98A2rk+SknRD0QV7oX91w4Wzj
 ZrHHYE0bE0KNoNkmcKW9gkN1mAKmOaTAp2DWGNk3aQ0GjX51ud9JdvQyAZCfEKfSqCyf
 7eDtB1/K4pBco3Iejd3u7vIpU+NqgncvCVJiH0S+rJBZ03wFHtG79xMFyg3nv7VgR2/t
 LK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Rt8CLnpQBhjvnUlx1MuEc65yr5V8moXbvakQ7hN64QI=;
 b=Ck24FNg+LbJxUCV5V/qrQs6RRaqszYNpLt11UVEczsPthgAA2BZnz6qHE15UxgqzUe
 VUMFWtsRJcA3TyjpMIenTZ7NGhSoH6LN342CZ15VJgsZUyMBeVSBzipIdYIjR7Ic/643
 ejAMTGlN91FOJerb8dW/Wl3/ydA6WilYgte0fMBF95BM0HtB+EVKfZFFqjup/uhZPMLJ
 yNYdk1KLL3N40vCzybSwP3tT0q8F/sdGnymp7kCQC+9ZgzA0c0r8fiFJvFjPz551NPJ0
 CurSwttMFfu8FkuhFzTanlEGrPxkoX3+KdbU0RpES6ZqjxRb28ytQnrP0ocT1ctmb60E
 D63g==
X-Gm-Message-State: APjAAAWEBkwV0k0h2GHAFHHw5kUOntSq+BourwU3MuoTBC8s1Dts0Eut
 ezeYDis1x/IxgfE0L7bLWlLMhZvl2n8e1Wx+ivXltg==
X-Google-Smtp-Source: APXvYqxhZfLdbAA6HRQK/CA9hlHp6XB9gVUpIMQJ+CmZaLOUAqmFcu6cgRl0svfV0DqJpAj89Enmfl5DKdUDenONpnI=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr22437235otn.135.1563816302247; 
 Mon, 22 Jul 2019 10:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190722171828.11322-1-chen.zhang@intel.com>
In-Reply-To: <20190722171828.11322-1-chen.zhang@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jul 2019 18:24:51 +0100
Message-ID: <CAFEAcA8==zAupCx=3sZt2tNUQH4OKza7FGhkwuCyxHpguTMGTA@mail.gmail.com>
To: Zhang Chen <chen.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH V5] net/colo-compare.c: Fix memory leak and
 code style issue.
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-dev <qemu-devel@nongnu.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 22 Jul 2019 at 18:23, Zhang Chen <chen.zhang@intel.com> wrote:
>
> From: Zhang Chen <chen.zhang@intel.com>
>
> This patch to fix the origin "char *data" memory leak, code style issue
> and add necessary check here.
> Reported-by: Coverity (CID 1402785)
>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  net/colo-compare.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thanks for your patience in sending out all these versions
as we worked through the code review process.

thanks
-- PMM

