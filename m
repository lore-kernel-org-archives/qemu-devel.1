Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD539C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7512C206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KaklORHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7512C206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUt1-0004Ed-HF
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 12:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joUsN-0003ZU-Uh
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:37:23 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joUsM-0005yc-9l
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:37:23 -0400
Received: by mail-ot1-x342.google.com with SMTP id 72so5861485otc.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 09:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g4UX4UfNRLpswpEvtDKEP0JEsYCSxcqTTFcXbCTIZfI=;
 b=KaklORHmalJpP4ZdDTzGrTh3nqHuI5Svel9kDsR5ReCsHV+LWbvyIqoVYu2+bRdh4W
 VLTB1UF9vlepQ/OM/mb+VyjGQJO1uvQIW+3mkSzLVLiYB5fovHNjtC4lDU0at/CRa83N
 9JZLbD5Iyl7pRwsYjw+mEKItLbzy7NcWf6octxzt72plSzV+3DWw6quuWzxNkAnpFiHh
 e1tYglVLqvZqL5YvS1b2aONR8gaJxJwssUhwCqA4x5r4TN9PzaB48/hk9DfXNn+wP3G8
 lISSCDUXGGPSTMHv72r8ObhPrJN4DPS6wP7KOwQjjoEBjBqs44XJmJtUf7p6PDD34cJz
 ztXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g4UX4UfNRLpswpEvtDKEP0JEsYCSxcqTTFcXbCTIZfI=;
 b=P9Nv3znXtgRtywW5TKfrRoQ3CVsOdmdnvVUnsx4OQW3xlsgp3ojuijBKafV6Fiw/YB
 ZpIm8PWRiyaOz9QnYx+D6He3S8fnw6zHBAwqDwBuhIjx9X1woTT1FSkG3dKN8kXLxcZj
 VUcK11q0CJcrvbm0no34/hzaOAunOmX1GeHsgRIboXoQtS7Hpx9gbZ1xR0aKijDQCsGS
 4tfJuyLVv8sPJByK/FzvdyJZUJ0t9Gv7ibJ1SDd95l/GIrb1/emwgsi9XoklYHh3BaPC
 gqJpJH5isrIRjNlpHyJcSJ6/yT3OrefgYMP2o7BwMT6MWn2qsffhXGQ4Roy9rr3iiX18
 hk7Q==
X-Gm-Message-State: AOAM531c6wjt0zt5x4xRV01SuktUdcHj9Oq37/j8f5ba1TxJlZ4OISJY
 chMyEj7DxbG5o4+8SABzDw8U3LY7x+/uX1NQKdiDpw==
X-Google-Smtp-Source: ABdhPJy3t4dCJodOqfxbTRSyxQE+YhNBaalZN32YqppJ13XIrqNbAwZw7d8DK6v4Ucd7isu0GiDoCuQCvQloZwy1iLo=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr26330242otn.221.1593103041110; 
 Thu, 25 Jun 2020 09:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200605041733.415188-1-richard.henderson@linaro.org>
 <20200605041733.415188-8-richard.henderson@linaro.org>
In-Reply-To: <20200605041733.415188-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 17:37:10 +0100
Message-ID: <CAFEAcA97vFoBSwmFkD6bpObD9P6W8J2iowKhk7mT32+xjte-4w@mail.gmail.com>
Subject: Re: [PATCH v2 07/17] linux-user: Fix guest_addr_valid vs reserved_va
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jun 2020 at 05:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We must always use GUEST_ADDR_MAX, because even 32-bit hosts can
> use -R <reserved_va> to restrict the memory address of the guest.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu_ldst.h | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Doesn't this run into trouble with the arm32 commpage?
The reserved_va is set there to 0xffff0000 (stopping
at the commpage), but the addresses within the commpage
themselves are still valid guest addresses.

thanks
-- PMM

