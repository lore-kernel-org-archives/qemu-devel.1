Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7351C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:58:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B23A2206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N8ihbD0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23A2206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw7DC-0007Ec-1E
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 12:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw7Bv-0005po-NT
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:57:03 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39262)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw7Bt-0004LQ-NG
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:57:03 -0400
Received: by mail-oi1-x244.google.com with SMTP id w17so5634058oie.6
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 09:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oo8LQfPjMmPon64in8szOE8JLpnJxVt+n6NSb2Y9ic0=;
 b=N8ihbD0I01YJZ3VHo6EMA+Hn3Qx7gjvOhLg+GJ43eb6+Kyvu1904sib+JN9hAMWiZB
 udIx+TwhpXG6BITMRFLnvChoKgeH6oFAZLufsQ9qiSbVEzxX8ZiXtxacqUOl0AO8Hbbt
 jbYebMqKDhSMXiFSESi2ijBvRX2XB3CbkV9c7XVmgmOd947x1mFz0iJ/js61pozQQtQc
 kyrT0TH72iq2am/tokidheLpfMu7aY4c1sZbIzcVeiY/HbcjggMIJNpruCJpLv46y3aB
 cuDI9zWEbzc4n/Uwumd032peWPUI9hRRQflGS6UWY5QsgwLdMRCELIO0RxTCyI4cBRGt
 Ws1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oo8LQfPjMmPon64in8szOE8JLpnJxVt+n6NSb2Y9ic0=;
 b=PVvDZA3oxo+aWnkpa/iF0J4tEI1txr438lzlWK9g6IntLBKG6D8b3USQaSv/dZEPPW
 9YP15FcEpdAtEcKYV3tlvu6D0E2oPCO5uhawG65Xw5KQKvdbE0na/XqVcsCjaIHEfy2v
 t8jXcgUEbLyFDBfiX+r5LAxoQOE6VDJ7wZTY1C5pQI+kiY8qhF2dibfly11BUiQM6H94
 eAnXWlp5vCB/63A188nBEGmggKDe9zSUE96aPXqY3hVb5EivRjcCz7xrxCmTWIpQbbFz
 +111bD78QiOgM567WNC4l3xJBqXPtM1/OTLxtA/ufZB74DjecpJnM4aLr7jNywbTwP30
 PWOQ==
X-Gm-Message-State: AOAM532uJbUmuEuLDBJua3AO6wg0kHa6Buc/BwFRXZflJiSDdcu1gdSP
 nvxcKfIPy7m+4P9bQYSBsronKOp53PxbAYCiodkaLQ==
X-Google-Smtp-Source: ABdhPJyOigpefeDMt+8T9oExgK+f4t+3EjbDK11rpOfC+eHdLeNDC2BqSsMysKUuG0aY/y4oxT1YAFPRVkntjbrF7bU=
X-Received: by 2002:aca:54c9:: with SMTP id i192mr4527632oib.163.1594918620390; 
 Thu, 16 Jul 2020 09:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200630122710.1119158-1-ppandit@redhat.com>
 <20200630122710.1119158-9-ppandit@redhat.com>
 <CAFEAcA83oGZMFS40m2rcFF+b-k_B1=e5QORwPAN68e1zjhqDHQ@mail.gmail.com>
 <nycvar.YSQ.7.78.906.2007162217590.950384@xnncv>
In-Reply-To: <nycvar.YSQ.7.78.906.2007162217590.950384@xnncv>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jul 2020 17:56:49 +0100
Message-ID: <CAFEAcA9KrXR1L6kEGZ1jJcXX+_hKVyME_+d0W5sNeyNcG1ZedA@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] imx7-ccm: add digprog mmio write method
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jul 2020 at 17:55, P J P <ppandit@redhat.com> wrote:
>
> +-- On Thu, 16 Jul 2020, Peter Maydell wrote --+
> | > +static void imx7_digprog_write(void *opaque, hwaddr addr,
> | > +                                        uint64_t data, unsigned size)
> | > +{
> | > +    qemu_log_mask(LOG_UNIMP, "%s not implemented\n", __func__);
> | > +}
> |
> | This covers a single register (DIGPROG) which is read-only (it returns a
> | silicon revision number). So this is not a LOG_UNIMP, but a LOG_GUEST_ERROR:
> |
> |      qemu_log_mask(LOG_GUEST_ERROR, "Guest write to read-only
> | ANALOG_DIGPROG register\n");
>
> Should this be g_assert_not_reached() in that case?

No, because a malicious guest can write to the register
(and cause the function to be called), it is merely that
it is a bug in guest code for it to do that.

-- PMM

