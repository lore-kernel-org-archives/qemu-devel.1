Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646D1C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 17:25:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A5B20989
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 17:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ICKSsP0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A5B20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiMXP-0003wS-F6
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 13:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42530)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiLAk-0005XX-8E
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:58:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiLAg-0005Mm-LC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:58:20 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:40527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiLAd-0005KG-OH
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:58:16 -0400
Received: by mail-oi1-x22f.google.com with SMTP id w196so13446332oie.7
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 08:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i5CFcSOBl3zSPfSEQpHWQnAZs0QnOiOb4RIFgbQcGy4=;
 b=ICKSsP0catHNia/xFPkb/Sk8zc1B18mp7ZNlGsRuDQUgGiOxb+G6ClD5YNC4Jn8M3E
 GK+x+2YKINOhksaL18GwE/IjronzFq1bFHY7io+6FGOLaZGkfGN4Cs9YFLdlr5ooGXub
 wjdTe6E/H7ETu4e2lcRQ3At2OgknaUoou1HhYTfYBLUj3fIKJyxveUHoZtWBv2Z63c4f
 OvtNE7njVeUXKbpK8LycCBqSsNbN8QWd/Y0ymA6/yG87LM5V5KQtWG2e+KNa0IMFBGeR
 /YCy6LHbKBwunW5owFK9hH7gIydtRJjfyTA2kFe9mVXkTKZ14xoch7E5C7B0/fdgHqqU
 9rJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i5CFcSOBl3zSPfSEQpHWQnAZs0QnOiOb4RIFgbQcGy4=;
 b=NxrHVbKL5S1siOadHsSR6lS4SA11P6LIUvZMGccU47zdTZK9iX1agDEc2a8zw7T1MP
 YuZo8tLHk+4W4RDGBv7eoO6T5CgsptzOjotjqtzedZyLBchp6efCB6rveUjZrv57J6Ux
 MZhHiCwoRtloWVzntjVBQNgVVCCV4tZO1gKgX5AtRpb/b1jl82YO+KxxOM8n2QKtC5UJ
 W8eyC6Iy1AAeVzseuB8jQyUz8Slel6p6b4o3triNYUg8X8GaoquFmmHMBpVKLZw4j4uC
 g2PlzDVsoonbSkJ95c+i1CQwAkU0oD0wnJGyeXqj52bxu4ZnydBX0qs0gsa9iFgBwsZK
 t1Eg==
X-Gm-Message-State: APjAAAVby260mv2JT8LwqngN59pSTvbY779SWQKBUMtn+/OWUYuf6fW1
 N20jI60wU5ZINBWEE3HD5x781UEZkaMJ7rKkumRJZA==
X-Google-Smtp-Source: APXvYqw4/Uo7dhKLhb/t2zQXV8BcUVPx2eYCEULoTkPI0lU2exhZiWkwanjUX9GajCB4Yio+rOBOmqIusSQAALbh8Ug=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr3559202oic.170.1562083093607; 
 Tue, 02 Jul 2019 08:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <156046151566.26543.17274661862206856605.stgit@gimli.home>
 <156046164094.26543.10016703921328261988.stgit@gimli.home>
 <CAFEAcA_nGMfUYpSiaw7xhRjacZQhY1U780ehA0UR0StyBwammg@mail.gmail.com>
 <63a37329-f892-ed5f-4929-e40dac25b64d@redhat.com>
 <20190702095546.11842fec@x1.home>
In-Reply-To: <20190702095546.11842fec@x1.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2019 16:58:02 +0100
Message-ID: <CAFEAcA-KuwMqTdw9Co+KRJTD=gvQ9qwU9QF3xsScLyZzPzaK2A@mail.gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22f
Subject: Re: [Qemu-devel] [PULL 3/3] vfio/common: Introduce
 vfio_set_irq_signaling helper
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
Cc: Auger Eric <eric.auger@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jul 2019 at 16:56, Alex Williamson <alex.williamson@redhat.com> wrote:
> When we're emulating writes to the MSI-X vector table we have no
> failure path up to the guest.  Real hardware cannot fail to enable a
> vector that's available in hardware, thus we can either log the issue,
> ignore the issue, or fault.  I guess Coverity is simply noting that
> other cases are tested while this is not, therefore we should either
> explicitly ignore the return value with a cast to void or take this as
> an opportunity to log the fault, which might be useful in debugging a
> device that isn't working properly.  Thanks,

Yeah, Coverity's check here is purely a heuristic ("did we seem
to check returns from this function in other places?") so it's
wrong sometimes. If you want me to mark this as a false positive
in the coverity UI I can do that.

thanks
-- PMM

