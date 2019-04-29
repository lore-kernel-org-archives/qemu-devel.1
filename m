Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7BAC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:15:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A18020675
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KArqM+TB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A18020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58239 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL749-0008Da-99
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 10:15:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL72a-00072j-DN
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL72Z-0002Ti-K6
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:13:56 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL72Z-0002TK-EM
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:13:55 -0400
Received: by mail-oi1-x244.google.com with SMTP id k9so5361621oig.9
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=CwUbu3pmuLd7Cbd+V64UDuNuap4gg/rDz7w+tnOeO5U=;
	b=KArqM+TBvJObt9NHJ0DBvsz9W4U/wTXInqV0f6cKDbm29Ywq476sjvayGxmbJmJlcR
	ls1Asg4gXT1FFXZ0SJt1Qwc12DlriGlC96bdHBk5TweTOifajisoRuLMl05PI+UX7Cq3
	4/1uT2W+vvm4Zweqh3Q2farq0qCGeL8wsK95FTt90SupiFuA1qBnXKw0wkk1+bivPDFJ
	fYAk36KYXO0KEFD/fhiqwXmZlF4o8h6xf5r/Znq16SMdye2g/0mKRfL4u6BGuN/EYmKn
	8uzwcr8wCQx+rMmSr12l2K0mGPG2h28UXGSHnTBol6/7au8uVoxbbdROatlrAqKm8mT4
	PD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=CwUbu3pmuLd7Cbd+V64UDuNuap4gg/rDz7w+tnOeO5U=;
	b=RkTPJZW/u+lXAVHALEJ3/JYoeDp7swry+I1Hwak3XUAsulVjHG0sAoM+H6cHTS03WI
	KfzcGTZnWep8UboantRPr64WIgd8/uXAGGv1/bCUsHNGqQHr4uL0znSoIjo7kwkLYz8U
	iwy/Oyo4i8hz3VmZB5ZFr11Of7KT1zER9HOL5HPMjSDe+LaYs6chFDUQLed2/gPHEgb9
	hWu1snGYPb5NSLxfTv16UG601HnHhJ7fwxAKvYfzCsFZYSNiqKs+WSvc0z57ij0//KWi
	YkCXtkPGyMVkI9krBB3u67mDaRqjT2NXbzdyH9cM3L9uSvgDyGKYeo3jRil+qII41PX0
	iZqQ==
X-Gm-Message-State: APjAAAUpg0VKAOQ0VgywAtmh4d0XxeFYOpcp/+6bro8eqZWLJEx8kSds
	HMux6Don8IerIrnb/6fa1fFxaIKX/SNXgK4pNGZ0xQ==
X-Google-Smtp-Source: APXvYqwrSgNiSeVAijjrJT/S8BVRBp+zBR0J2GvONNFC4Y5ZtoJqGsv7QGdRDLjzE18NVd8SiCLfugQ7yGwTw1ivp40=
X-Received: by 2002:aca:ab12:: with SMTP id u18mr3775505oie.48.1556547234793; 
	Mon, 29 Apr 2019 07:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-14-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:13:43 +0100
Message-ID:
 <CAFEAcA9nhXHsWLQPB-fXRXCzweGdQCXsy2q1VJewbK075cWX+Q@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 13/36] target/lm32: Use env_cpu,
 env_archcpu
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429141343.ot5F6j5bu30WEpLCKesa7Qufm-VrHz2wj0DcDsksjjA@z>

On Thu, 28 Mar 2019 at 23:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/lm32/cpu.h       |  5 -----
>  target/lm32/helper.c    | 19 ++++++-------------
>  target/lm32/op_helper.c |  6 +++---
>  target/lm32/translate.c |  2 +-
>  4 files changed, 10 insertions(+), 22 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

