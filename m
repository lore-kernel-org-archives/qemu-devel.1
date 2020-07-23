Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D04C433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:37:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E5B20737
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QddjX2qG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E5B20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyYbs-0006II-Ty
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 06:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyYb0-0005XK-M4
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:37:02 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42893)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyYay-0005wa-W5
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:37:02 -0400
Received: by mail-ot1-x343.google.com with SMTP id g37so3966745otb.9
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 03:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zyHjPIYICRayhrMjA68vhu/gFv6SyoPs+BwJD8Nzv7Y=;
 b=QddjX2qG1C/k5IF1I+cFjtNg8SdS9ySbgi4iQ7+F3ivXUDvIw7wGf6dw6/zxiIvSNb
 MwUR7MxFiSfubOebhOGLfmlhU7V6WLJiBu/S8UECS2Qt9ssq+ztz7khV4QmOhTBVD90c
 TQkgNTo9zvQOKSi++aAW0BzTT6O6ffHBzlrcdN+JT4fcxWnmB5i9e9O2qIM84JpR/I93
 /7OkhKuF9kpoU2NrGfQ42VQsBxWP1zInY/mfcI1qq+frg1LyBFN6vK+J+j4c8nugREjS
 5shYfEMFSr8WMCtZnslMHV6ZC2ReXQ9FhZWu0rjNXZLdj8PNq12nb/v8BlK62LplxHgH
 Vt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zyHjPIYICRayhrMjA68vhu/gFv6SyoPs+BwJD8Nzv7Y=;
 b=CLbeJZnhiXHB9JB5+ITFs2j/Llm8DFsxA0aqTVqYQin6pyy5JOvPYh0eAKNx4UrqYf
 4cH9KPqR89RO76hhyibmi8HX4GV76J+zaz9zKzhcf52ZxTtJP7ecC3owrO+VRM/TSqKy
 +kbMgCn092RXurkp7TDEW/1ZliaPFabUq8OskjU+g6wl6UwOKS4aHEG3uTTqQ168rLT/
 C+gSaiQHnZN8Uc1+WI+g78ChzPy7sy9d13b6RgRLiGnXm3F9fcfl17bzoWRZi2CgpT7K
 zIUuNXiLbe/Gn3kYP98icjUyQj6Yzr4J1Oj4xcrdCzkP4JsxdmcMPwqSKyMolVNQ5hg9
 GMwA==
X-Gm-Message-State: AOAM531J6CoTshnkqP9RHNMrMoTozEPJpoZ8pVPG394er3aC7nS2vpKe
 wIjbW/BL+4VfM0r+3PGx690xrm6SaFS1aQgNH063Jw==
X-Google-Smtp-Source: ABdhPJyAxit6dLPQrW3hoqj+Tmy4Lj8spJIGjs0ZUK/2Z1jTN9veMEbYc+glsIn1kqr7d1vzF+EouAPyqIj+D2Vwnk4=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr3378233otk.221.1595500618127; 
 Thu, 23 Jul 2020 03:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200722085747.6514-1-jasowang@redhat.com>
 <20200722085747.6514-2-jasowang@redhat.com>
In-Reply-To: <20200722085747.6514-2-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jul 2020 11:36:47 +0100
Message-ID: <CAFEAcA-XHFXBeQ9qp91T_gzNqyxEEDz_caHanwMuYRjKjEocWQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] e1000e: make TX reentrant
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Li Qiang <liq3ea@163.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 Jul 2020 at 10:00, Jason Wang <jasowang@redhat.com> wrote:
>
> In loopback mode, e1000e RX can DMA into TX doorbell which requires
> TX to be reentrant. This patch make e1000e's TX routine reentrant by
> introducing a per device boolean for recording whether or not a TX
> rountine is being called and return early.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---

This feels like a sticking-plaster fix that's not really in the
right place... It stops us from calling back into
e1000e_start_xmit(), but it doesn't prevent a DMA request
from touching other device registers that update state in
the E100ECore struct that the transmit code is not expecting
to change.

thanks
-- PMM

