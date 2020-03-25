Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECFFC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F327020777
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C1Z6pNdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F327020777
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH9wQ-0006A1-75
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 13:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jH9vb-0005Ar-2Z
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jH9vZ-0005Kf-Pl
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:34:54 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jH9vZ-0005KA-Fs
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:34:53 -0400
Received: by mail-oi1-x242.google.com with SMTP id e4so2838456oig.9
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 10:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=b0OnLCWvM64m5gKXHzRMVXF5dHlaSc79FQsmbEFFsu4=;
 b=C1Z6pNdvSItTGgZeyhNyHULNYgBoDGsq02/U+/B/utTE5RUjqyejof07G2XRvecC+Q
 PkpQBvY9KF1KrS0ZzUSQU/rsc1sxnjZH2fg+zHWE/AbmWSzIBErw3fzYf1RdfCxxpMT5
 6fd29wVqKxDPsys028YFHaa6LboyVdGtIqve15nvmNwlNSH6qxyPEVZxM3g5oWBIVRDq
 X27+DXKgoimA58vwVDzbvUapJPsc7jtwbBU1McuM1TTw4tfp/7MxD9eGN9Z9LsNYMGSV
 bhzWh5TUwB7V4SboN80lXDx5RQo8ZfiSK3ussgHb4YGm1hAUq2WdOOlrXZ3AumPRM+Vs
 oXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=b0OnLCWvM64m5gKXHzRMVXF5dHlaSc79FQsmbEFFsu4=;
 b=jrp5tbp5izrcpNt0qM+TTJW9gaZB78c2bi/jumd7MVYeFIQZUVhUjnJcNJfwub8lWI
 LJdCtNwQAl/SL30yTv6+Tfyz/oJZyOhAYR8TxyWpIz2AmqB+8zWZvQANp0EXc0lZ5Xt3
 cWNL6sqWw5+ROhd4eaNxlIdCxvgljOPL3LvE9WhpQZynkPZ63JGsqE7/Mepc4pROT7fz
 yYUkgmZoEpIkXTV4+zQoU9Z+VqXt5s4RcQtNWb3Nma+A6auAVNDv7W+T3XIIo7IoKYlP
 9xzBOumz+OLk02ghM+zhxdJLdpW5FpZ9RMl0r30qVXfSntUjAgnHWBkF7H8c8ozxIxgc
 2I9A==
X-Gm-Message-State: ANhLgQ371dMqy81uyck8Kt/501AbAU5U3wksygdvxNFl8BOJroO8jWhg
 USBX+PrQm8QGoC53dfufCn0wUEpcMPNC2zMsNgybng==
X-Google-Smtp-Source: ADFU+vudVicUuCrFQeOVj1QeuZvzjkGwslmlNghFiG3X/u6eYx2lj4gCzSspwe1zwFhegXKuozD9aXIJ+uw4hNQsruo=
X-Received: by 2002:a05:6808:64c:: with SMTP id
 z12mr3181490oih.146.1585157692306; 
 Wed, 25 Mar 2020 10:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200311040923.29115-1-gshan@redhat.com>
 <4c32dbe0-7d96-5e60-addc-b1bf43e17f47@redhat.com>
 <da34a58a-0474-c46e-7bbf-cb150bddc717@redhat.com>
In-Reply-To: <da34a58a-0474-c46e-7bbf-cb150bddc717@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Mar 2020 17:34:40 +0000
Message-ID: <CAFEAcA-kbsdW5p6j6gCt48kZxXtFNM_bO8jH6_XTrFLh=QGzwQ@mail.gmail.com>
Subject: Re: [PATCH v3] hw/char/pl011: Enable TxFIFO and async transmission
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
 qemu-arm <qemu-arm@nongnu.org>, Gavin Shan <gshan@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Mar 2020 at 15:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 25/03/20 03:32, Gavin Shan wrote:
> >>
> >
> > Marc-Andr=C3=A9, ping. Could you please review when you get a chance? T=
hanks in
> > advance :)
>
> Or Peter; generally arch-specific changes (as opposed to fixes in
> chardev API usage) are generally reviewed by arch maintainers.

It's still on my to-review queue, but then so are a bunch
of other things. Stuff for 5.0 is currently taking priority.

thanks
-- PMM

