Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115DDECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D51FC2089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GlagUohE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51FC2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9ud-0007XR-J7
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL9OQ-00031P-5j
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 13:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL9OO-0000YZ-Pw
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 13:16:53 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43841)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL9OO-0000YB-Kg
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 13:16:52 -0400
Received: by mail-oi1-x243.google.com with SMTP id t84so2790855oih.10
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 10:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6YhmWavSrlu1JmiNk3PYpaZv4PGpg/NSa3msm0VHYBA=;
 b=GlagUohE0Yfoi+UGzrA0t/N2WqhKlsqviIrxwRF2bDZYqV+DyH/0gdi8VWEGcQwxYz
 q+cXsS/EiKvPqAzgf2wdn6HZGQ1jbnfv9oHKwgvOwMNPflQIIToQX6tVATJIG4X/tXk9
 s/pixIc7AqtHYlCkVUjIuBMIH4q1+4pOYsV+CwjtIUEI+KTg8e6UR+BQamAUCxZGIFbj
 CUGPvbhtLxhKAjyv0YyXYTRFSaWdtHjFDsRcYu+87h1g6fUwSE5rvshlAKZc9iCRHmVZ
 VIkstnVG4ujMVINMc8xjlwZyZfNuWBSRlOgGxRguAGyPx1k29FDlaGddL7kcrxXhNt5k
 jfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6YhmWavSrlu1JmiNk3PYpaZv4PGpg/NSa3msm0VHYBA=;
 b=nCRKq8F81IvbY3aYYvVw9uOvri/n8WlbOUDMVajdsnT1u0gxJXP2nIjOrR/TM1eLaD
 YtSd2oLCmkJ8VOFDtHrfkya+9KCVVlBNDgtyR44RK7iw2BAfKzZnHOvJ5gLsre606uO7
 //dZKlaXB/vpcDKv4K5O46gHfdHMfqDj7y1ZTMsWDYRmpnyxQuNJXoH0c4JmKP9tH3z2
 e8WZRsKb8+GQY2Cw/NJY/8XunP76/wyVxvIcG3sRN43iCbHKZYicjk+bt+5VLGOFRKPm
 nsWDUGabFU5/bhiYk5gu579BpN+PaUa3LV3Qi7lrWjumKYSjOMnVy6xT0wPSjXU3GbUQ
 6YnQ==
X-Gm-Message-State: APjAAAUFYyXL5y5P7hlMfIC3AFNVUwR6hNWAySUKBmpMtdGTiZrJNalT
 8U2NMPIEA6yf4YFl27fBGXwE3+A+36wb4LVShhpRuw==
X-Google-Smtp-Source: APXvYqyS+jLkC5WpifN1f9ZyNVK47/WvFI/SezubUnihKhen0PpuR6Ou+oXXAsvyDgW1IIhZdiUB8CswF9FU85Fe7+0=
X-Received: by 2002:aca:2b08:: with SMTP id i8mr3992523oik.146.1571332611426; 
 Thu, 17 Oct 2019 10:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191013222544.3679-1-richard.henderson@linaro.org>
 <3df6b52a-45d4-5e33-437a-a57f5a17e008@linaro.org>
In-Reply-To: <3df6b52a-45d4-5e33-437a-a57f5a17e008@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2019 18:16:39 +0100
Message-ID: <CAFEAcA_yKpOG1RuJgOb=-E23vxxV1kvnNF8h9gaPp0Nv36oZZA@mail.gmail.com>
Subject: Re: [PULL 00/23] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Oct 2019 at 15:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/13/19 3:25 PM, Richard Henderson wrote:
> > The following changes since commit 9e5319ca52a5b9e84d55ad9c36e2c0b317a122bb:
> >
> >   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2019-10-04 18:32:34 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/rth7680/qemu.git tags/pull-tcg-20191013
>
>
> I have regenerated the pull with the same tag, including
> the r-b and t-b that Aleksandar requested.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

