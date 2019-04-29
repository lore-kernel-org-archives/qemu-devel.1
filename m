Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21C9C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E5D7205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f7gwRO35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5D7205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58958 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL7uu-0006sO-Rc
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 11:10:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7tX-000612-SY
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7tW-0007Gq-R5
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:08:39 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL7tW-0007GD-HY
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:08:38 -0400
Received: by mail-oi1-x243.google.com with SMTP id t70so2998782oif.5
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=oaj/Q476RPh8i4O2hmuKjzl8b61Lxp7vRWMQFhARyW4=;
	b=f7gwRO35feKzdKG6Om0eu3dX0fCtGyOGuq16nxeo89Ov3vfdOFS+F3kd9JrquVP+M+
	omFCsOsgDqlkLoOhEaX7P0komOmM2XinEKPhs9rfb15r0YcvpWgHBWWyKkKpQ0PLlqdt
	RdpQGtVk3LAwQ8mjV1j9XYSPoLIlRjTh6qvmhFSVHDajvyYxr1+A1Jg0dSc4FuxAFSG3
	PLBsKGNr9zlLqiua8WUZZjqQo9vu1x/YCcFwKhKWW345HClOChVObuJ4l03wdI75eY4x
	QEe9yZ6r1Lwg2cjf2feo6vEUiq6VCtzIKuVtNAUmdT35nouGwiStboXre/YMR033X+c5
	v3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=oaj/Q476RPh8i4O2hmuKjzl8b61Lxp7vRWMQFhARyW4=;
	b=B8F9pfdNgvTatAuzZPLhBksRKUiFEDEp/g8TaB0BgPY0vCEY8jSjrlzBdm33QCpcAb
	mS4R3OgqYqGatOx3o1RMsoleMOld4SnySCseFrWaxsHiPNL5Un7Mx0jL595N4w84ZWbC
	t2FDWSvORQnpqK4DZFVVuEfmefJ6sQlFK9nkZYBcMT+zEvZF4o4U/2/cKNJHRHTL0lh8
	1h/GPgo1odWbLlWGpwy4gddfq12PJokvzsERgzJlxr7sMuyDjE7dpQfZhiUIbPL0pyas
	uejMW2g/y9IvmBvUUvjholCsMSE6FfaEwaU8abnq1joyttAn5+O3kh7pGGgII3W05dM0
	FD3Q==
X-Gm-Message-State: APjAAAUK7dAkgVC72H/ufNEwxlIO2V4y1GEAwc1ys/ZU8Y+I5rXYT86U
	KGA/7EgeNFWBl+TMwqpYosfDd54ejLMq4SGVLeRFpQ==
X-Google-Smtp-Source: APXvYqzI7MR0cyvHb/uKyKVGFbeeTSOzZrgSoEltY7hnZkWiesr+OC3RkxWjrK24TeniBGW9yqHeHEBEiEhkLLUcqt8=
X-Received: by 2002:a05:6808:301:: with SMTP id
	i1mr13252879oie.163.1556550517368; 
	Mon, 29 Apr 2019 08:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-34-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-34-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 16:08:25 +0100
Message-ID:
 <CAFEAcA955xbF1i9E73a0GD_oJDyDbGBbLcCO+5jdUuANguR1pw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 33/36] cpu: Move the softmmu tlb
 to CPUNegativeOffsetState
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
Message-ID: <20190429150825.ZOZyMRiUz_91VpbBgewHpPxsHSxGZntezwx2nb-jELU@z>

On Thu, 28 Mar 2019 at 23:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We have for some time had code within the tcg backends to
> handle large positive offsets from env.  This move makes
> sure that need not happen.  Indeed, we are able to assert
> at build time that simple offsets suffice for all hosts.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

