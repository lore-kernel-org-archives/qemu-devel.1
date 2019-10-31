Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C562CA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 12:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 672992080F
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 12:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tpN/96uH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672992080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQA13-0004Aq-T8
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 08:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iQ9Zo-0007QS-UW
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 08:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iQ9Zn-0001Eu-FW
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 08:29:20 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iQ9Zn-0001EK-8Y
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 08:29:19 -0400
Received: by mail-ot1-x341.google.com with SMTP id 77so761792oti.12
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 05:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0PB7bjJNTZA9Tv9NxwyA99UpWZGWWRf+ge5lUD8IH/Y=;
 b=tpN/96uHdZBEv/mTVkFY26L1NDo2thj/nVd6cYoy/fj/t6TM72Yy3hp8phyhVJ44Z/
 STHCMcUTeBjUNoEy2L7xvenVqDA457gyx71m6C83QyUBOPXhyX+jxrnBamiuzDf/pk/p
 /A/2c48VlBiO6R4RHTeFNtIv4DjAKBvcRJ4MyEcktCkfdR5VyhR98el0Nyg196wChZMw
 p6MnvnXZl4ma71SwwE5pRbtmnx8BXFIsSZcVSeDceqtc3Lk/r/G6rUoSzbL9BULD2/wv
 MZEsdLJekNPzgj/fL7H0melwuFbJM8TKJDl9E5dehoRE951+ERLkuF4bfWtDabqTuSY7
 qGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0PB7bjJNTZA9Tv9NxwyA99UpWZGWWRf+ge5lUD8IH/Y=;
 b=ufLq57K0zo0ec+hIJNzM9xXtQ3y/P8IfK5QYFbEUvmI47jpy9h3G2/Ep0YZ1tmvQZC
 H8qhwilJpmA3gAuo2s69h7sbvuJgbGuteQI/xzIigb2OgCRIzgaZF1iqDiHPHkoPmiPH
 fJNPuAr5Qu2sfE6J4bc9bBfEKbchQqG4qVdoiNwwTSeGMCk8sM70+3fjwjx79D1BOSAe
 uWG+S9JW1Q8zHoTDQqG6Ka+/gV+RG1s0AdFZtT2MFDGE7idVPsPXBLMFfpZZpl0O+mAm
 tu0G3nE/Z7txy4+wNqyLtrkqeQoGlptlXO3bTBzyseYgsx2RF/qKIfRAZvQuwnr1qIEB
 cfAg==
X-Gm-Message-State: APjAAAU1ZzxwN2pLRazDQuR5I9AXfWF6fBB6Hz5/Xtg4JJzhEwie3b6A
 ujd2bjFTX+LSutwCXoXxFLEv1zQoqLXSEZxP/hh5nA==
X-Google-Smtp-Source: APXvYqzc+f0346OKdcavP5/uKFRNPLCLTlHn3Hm9zpHHXY0LmgjRMFocm9RsrmeQrct4+tgjZtyXD4hWfi+XDnBB7YY=
X-Received: by 2002:a9d:7385:: with SMTP id j5mr4361071otk.135.1572524957876; 
 Thu, 31 Oct 2019 05:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161008.17140-1-thuth@redhat.com>
 <751b0f88-2004-bca9-09d4-f43284ca8784@redhat.com>
In-Reply-To: <751b0f88-2004-bca9-09d4-f43284ca8784@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Oct 2019 12:29:05 +0000
Message-ID: <CAFEAcA8R4pqNaxi-y5DgDvjYLQdUc1jDuwopLFKDp9VtFVqn5A@mail.gmail.com>
Subject: Re: [PATCH] iotests: Remove 130 from the "auto" group
To: Max Reitz <mreitz@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 29 Oct 2019 at 14:05, Max Reitz <mreitz@redhat.com> wrote:
>
> On 18.10.19 18:10, Thomas Huth wrote:
> > Peter hit a "Could not open 'TEST_DIR/t.IMGFMT': Failed to get shared
> > 'write' lock - Is another process using the image [TEST_DIR/t.IMGFMT]?"
> > error with 130 already twice. Looks like this test is a little bit
> > shaky, and currently nobody has a real clue what could be causing this
> > issue, so for the time being, let's disable it from the "auto" group so
> > that it does not gate the pull requests.
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  tests/qemu-iotests/group | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Thanks, applied to my block branch:
>
> https://github.com/XanClic/qemu/commits/block

I ran into this intermittent-on-s390 again this morning, so
I've applied it to master in an attempt to improve the
reliabliity of my merge testing. (The other current culprit
for intermittent failures seems to be the various BSD
builds for non-iotest reasons.)

thanks
-- PMM

