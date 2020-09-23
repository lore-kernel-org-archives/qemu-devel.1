Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D66C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:48:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13ABD20725
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ILVWfaU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13ABD20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL1O9-0008PR-1N
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kL1Mq-0006nG-Gj
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:47:16 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:43873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kL1Mo-0007WQ-2V
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:47:16 -0400
Received: by mail-ej1-x644.google.com with SMTP id o8so26842262ejb.10
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 02:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8zBVHQ658sQFRqbSWvv5mS8gJaDut0pFnzYX/oWVWaQ=;
 b=ILVWfaU5MTYPQmohVn4damaWJKUdm/bfLRxAXsKtEg0HC44625GSawxgx3gqUNN1Sw
 HU66hIJ7+27A5XGbz3S+QhhsD4nuV4mfTsvOBskfNbEmb9ozoyDDJHZVN2ARsP7gXcwl
 3jAMNMZQlpGvbHKuXv/kg7sg3jvlcd6/8IdwHx/V7n5hSnk34xnPUnCKFHtfnir3z9sJ
 /wCKXHje2lFQgeeQGDIr5goBsqcLhLanRCFrmfiM/MZws2xj0Eh1WSbCQlMuUagfsifl
 4LKYPN3Sdl/Y67cl9Tw4yTFtwq1KDeF3tuGHgtlfHHaXnOOgDYgiPlYeIvfIMfrHgek6
 ZtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8zBVHQ658sQFRqbSWvv5mS8gJaDut0pFnzYX/oWVWaQ=;
 b=OW/WopayvsVHt6x/tRH1oUDNfQKyEqtCKJHobTlJqpDY7IBBY7hj2a55EuXiGZvmSE
 0y8bCq3XWH8KezowFKXWFb24VTv6uHruonyfa/2rmPAunoKtNqsFBjIFf113R7VjFku9
 bpXEjkZRaiyYiUBZ0Myc46Jy+uYBcsZ1ZO7A6SxvLt/jsc6uZTqQrzcYN/KiV0j8ZF7D
 hC03WNsLnFrMWz32ZWGt3YS78DYji+gU5E0MBYZn8KYnS8gtEnnvHsXdCI1n+cfEMcmq
 OFcBRKZLi1i5S8FnfJy5FIJYzbuYxcUfeUEDoT/5id5C0YztC0kd787tFu7Ico6hCBuv
 wpBg==
X-Gm-Message-State: AOAM531xXNb8ec5he7R5I7KGpwuGSxUrkBsFYRvMbBcHGeiTEytP5YMw
 nZ0gs4+MxIPpfp95wdUcrypLH+2K/ODWmF5dDm3s4w==
X-Google-Smtp-Source: ABdhPJwqEUTTKC38+PgCKAJL9AsJ+M4h3PQvPOT34D2IPncJ2sAOAd2T4HwN4B13LCuSeB/bM9SHJZ39vajoooW7h9o=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr9112382ejk.407.1600854432477; 
 Wed, 23 Sep 2020 02:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200827113259.25064-1-peter.maydell@linaro.org>
 <a1dda44f-e521-ef82-f5bc-7435c81fe888@redhat.com>
In-Reply-To: <a1dda44f-e521-ef82-f5bc-7435c81fe888@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 Sep 2020 10:47:01 +0100
Message-ID: <CAFEAcA_zg123DgnyDzeQXe3eXGPOTrybhaL__qu+mAQqSgEr=w@mail.gmail.com>
Subject: Re: [PATCH] Deprecate lm32 port
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Michael Walle <michael@walle.cc>, "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 23 Sep 2020 at 08:55, Thomas Huth <thuth@redhat.com> wrote:
>
> On 27/08/2020 13.32, Peter Maydell wrote:
> > @@ -416,6 +416,14 @@ The above, converted to the current supported format::
> >  linux-user mode CPUs
> >  --------------------
> >
> > +``lm32`` CPUs (since 5.2.0)
> > +'''''''''''''''''''''''''''
> > +
> > +The ``lm32`` guest CPU support is deprecated and will be removed in
> > +a future version of QEMU. The only public user of this architecture
> > +was the milkymist project, which has been dead for years; there was
> > +never an upstream Linux port.
>
> I was just looking at the current version of deprecated.rst (which has
> this patch included), and could it be that it ended up in the wrong
> section here? "lm32" is rather a softmmu target, not a linux-user mode CPU?

Yes, I think I just put it in the wrong place by mistake (ie next
to the other target deprecation notices), not noticing the top-level
section it was in.

thanks
-- PMM

