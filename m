Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64C9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:15:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EFAA20729
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XVmv4kMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EFAA20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k09XB-0007xN-UZ
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 16:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k09Vw-00076I-N1
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:14:24 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40373)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k09Vv-000814-6J
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:14:24 -0400
Received: by mail-ot1-x341.google.com with SMTP id c25so13247591otf.7
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 13:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gig5v4EvPwwJpOcA/EcTK3Y6WwfxszotycNdjHL9/oA=;
 b=XVmv4kMUVsGV1q4f7t7hrUzqan2KVruEobKSW9RAMbJbncRzSRYaihWas5CvHRUqVt
 t0HYZzA6CbjMNmaw79bQa1SVem5o6Aqq8jCY2j+B4hkv2gm2kaNytJUvVFQEA1zTe4RK
 pFEdv5jIjqrw4u2NwKiAo7Tar3JUWGC2E+IugtsE/yXYg2wMiz4O5pEZYNyyFIHCDid2
 3R1yetssj3+fVnqKjYojG+l222+S0WpXdUT+rQ+mkz1yMzQXvDKXU8qV7eZhzIfSeKOs
 V8dEVMbxWZn1e18mpSjm0PBZ729fnaZChVvatNIkBscwD37iN37swGapXVif+FETi/qd
 U55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gig5v4EvPwwJpOcA/EcTK3Y6WwfxszotycNdjHL9/oA=;
 b=D5vkB7Sh/UmSBB+6FV9rBP5FLrZzSWLo20aF2esnzlinVLCNC2XFVqpJYYbHF4plpQ
 iyhegxWzp597YWIjVYbQWsl1tUI47H+SgT5ItH1IId3rpRm09dkU3olt7/fWzl65cev+
 L72Val6mWoLEHl+oX1BtyK3T2UYW/uQTNS1sWMBOZqIugm44CTdthYvk0QlTgGWEmXug
 5VxLmiSncnT/kDrXRkN2JtTxIbqM7k9/2yIMRJZG1VqinCNcV2gOUBl+HPJFfotvTeDj
 WUA6k12Mq8jWcMrpy3gy78BlzsRm/YQuHdB5nrgMqQtXbnue6ttJH7F7/aTpvVJqA6WD
 dklw==
X-Gm-Message-State: AOAM531GpkErlL1S56eDiJPhoDn2vRusarhYpXGONSekOWYLdyE6vvhy
 HlG0D9mZ0XvbMZPgPI7MRwFDrrAybAVvCrlaRF5rCQ==
X-Google-Smtp-Source: ABdhPJx2TNZk2z2eH7HmZNHfi1/Xi1en8im/d6vnOpeKAr8SYBWQWJYpp09hYUjhqEI+umwlGxlFp6MJv3Brs3BYDYM=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr20788554otk.221.1595880861854; 
 Mon, 27 Jul 2020 13:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200714162659.1017432-1-berrange@redhat.com>
 <87blk257eg.fsf@igel.home>
 <94143f30-d646-763d-5b10-ef0ca8b246ca@redhat.com>
In-Reply-To: <94143f30-d646-763d-5b10-ef0ca8b246ca@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jul 2020 21:14:10 +0100
Message-ID: <CAFEAcA8GyXLkt439aYTbNSO_CSoh_Fq0HJeMzYuAkB6RBOfdoQ@mail.gmail.com>
Subject: Re: [PATCH for 5.1] docs: fix trace docs build with sphinx 3.1.1
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Andreas Schwab <schwab@linux-m68k.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jul 2020 at 20:52, John Snow <jsnow@redhat.com> wrote:
> ... Should we say goodbye to Sphinx 1.7.x, or is there a workaround that
> keeps support from 1.6.1 through to 3.1.1?

I think we need to keep 1.7.x because it's the Sphinx shipped
by some LTS distros we support, don't we?

I do feel we probably need to defend our Sphinx-version-support
more actively by having oldest-supported and bleeding-edge
both tested in the CI setup...

thanks
-- PMM

