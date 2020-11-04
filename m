Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD8DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:59:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6B320639
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="umPGdLgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6B320639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaN3z-0006Lb-W3
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 12:59:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaN2j-0005Vt-Qv
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:57:57 -0500
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:41843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaN2i-0003oW-71
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:57:57 -0500
Received: by mail-ed1-x544.google.com with SMTP id l24so23345345edj.8
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 09:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jKqnLeZ/soRP6JFVfVPo1dIj3et6wA0vrOMOsss4RRY=;
 b=umPGdLgIickMRNQC6uGq5q8ilGMPvj1OPXYT1re+FFoZkpIRrQLZVEYdfCNLbs6zeN
 anpsmpujcA7ZDNU2rPEqAWSEyxNfR08B6Blm68sWjZPsdJIQTT5VTJKUQfR4BV+4k5D4
 5BFzISDjSuvH6y2bWsHv9Ewyyy/s/eM6Z4oof0croVRfKuRueAinkRqf/Sh+Z/wp+QBo
 Q3W3CkKfkzUP1cxLKUWFV46W/tsY9HBRN7US/HO4T7ymG+Zg4REfccg1ZY8I9bhz1Q6y
 EtJRxDX2QEEm/XCHe18NHqmwvcmB6nRl1dCZgAw39NYu/xsjvFVJ0FA270OSsUWLU0gM
 rWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jKqnLeZ/soRP6JFVfVPo1dIj3et6wA0vrOMOsss4RRY=;
 b=Nukb+pnUvPCIZZND3ouisW42/E0oJN1g73mw70Jd4P75R9ETwSqRmgQWTmQQApdXZb
 9D0q2d6e4KvFmmLAcJ1TYUDOfTyuATYK4q4GT5IW52z9VWIU4djl4ejVMMBWMny49Ws7
 1JqBbUs2oJ9/FovmAoHl+VSPPtYGkrBSr1JVN+YJHUZ8632pC9p0YO7i/sX9Sks+QVyn
 jHh2+BnTpxWo9MiS0Nb13SVRu1PUv+mtOzKQ9Dm/AAdCzg2WIxtsjiw60nbzaNlaZsFW
 ywFmzMmbTbZLgXbzjx20IJ5sqs254xTOmZ0xojVBEV/7Lyvfj3siQnRBVYXX9RYC7NZZ
 1I0A==
X-Gm-Message-State: AOAM532f+ce1fkjEh1fa1VbVwny0sQZuUc51t0hPLFRiv7/d0soTRwHn
 hp96opzz1+MYzcEeaEVZMCinc5UijAEP3NmSuLd1zQ==
X-Google-Smtp-Source: ABdhPJz2uoXLcBU0HRpT+Tbq8w2OeKKPtHoesQtaRVRJv++aU96prNm7rxmeS18DDNDYwhWTd4hRr7rnzNSufBgRl4I=
X-Received: by 2002:a05:6402:4c6:: with SMTP id
 n6mr28823057edw.204.1604512674444; 
 Wed, 04 Nov 2020 09:57:54 -0800 (PST)
MIME-Version: 1.0
References: <20201104103343.30392-1-drjones@redhat.com>
 <612eaae4-6e05-568e-01cc-a191bbb7c835@redhat.com>
In-Reply-To: <612eaae4-6e05-568e-01cc-a191bbb7c835@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Nov 2020 17:57:43 +0000
Message-ID: <CAFEAcA93GCoVTSxW_64W_Fmut2O74UXZJGej4FE7g_atGa0VDw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/Kconfig: ARM_V7M depends on PTIMER
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Andrew Jones <drjones@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Nov 2020 at 10:35, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> On 11/4/20 11:33 AM, Andrew Jones wrote:
> > commit 32bd322a0134 ("hw/timer/armv7m_systick: Rewrite to use ptimers")
> > changed armv7m_systick to build on ptimers. Make sure we have ptimers
> > in the build when building armv7m_systick.
> >
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > ---
> >  hw/arm/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>



Applied to target-arm.next, thanks.

-- PMM

