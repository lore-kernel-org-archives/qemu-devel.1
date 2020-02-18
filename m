Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19849C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 21:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D283524125
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 21:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a6T318Aj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D283524125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4AEv-0000q3-2Y
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 16:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4AE6-0000A5-ML
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 16:16:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4AE4-0003Vd-PH
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 16:16:17 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33382)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4AE4-0003Ro-Ht
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 16:16:16 -0500
Received: by mail-oi1-x243.google.com with SMTP id q81so21668678oig.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 13:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DwdjqiT5xXCeSH8GCvUUaCh6zKIsE26WZkiISaavmQQ=;
 b=a6T318AjZJCVcGDnrUMn8RKbfOm+BFwooWt9yUepjSdd4A5pJMTOU/BshW+Ob55ghk
 mcyXNHf8ArDkRNAqM+Q6uvYH0VPnWXxn6HZSCMRQIHjolVPqf0cCA5ic2Ds7KG9yvGnN
 vA/XrmVj0S9Otk6Xxi8nxvrrMPfe+UNSTJ+qmaUVfMmITt6zK9UMH3+EE8zOUQ+UUYTz
 nyen9dGsw7xjnocG0RaVWlGXnkr8heRm7pNrum5OfW5at7bagjdQm+7CbVLBO71e6oXB
 FSWhRVRHrKxOspkKWpzof8gIfAPROqR4zbFejvjwog6eS0A0rwzXGXPFWy74WLh8Hz1z
 3PbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DwdjqiT5xXCeSH8GCvUUaCh6zKIsE26WZkiISaavmQQ=;
 b=PxpKOai7+bXi27Gaku0RJe/OKNL0amBeL41BINpfia3B+/fxIbFlbag4U36Jz1mvwu
 c90GWWro/1AxL3Ln3v4huFXDz6FYOa3dig7idk5MfIbCzFl/pOgiU0VrZoQyS9Ek6XxD
 oOof8b8jVf/ad97CispmWX6oBhaFlXgL5wrvyArteghHz31ENMxqHWUbg8BRHa+kqicZ
 6HsLCDtf6sB7ks05+ZTr9QNBVMeBl3MbTLGBzNVmo/jXQCpt1Du6k5LZ5EjF1vTAX0lc
 gifmkjZgUNy6QktxxYIDMFlwbj6vYvNdPyvZQWLo71vjxSXBgM2cH5CtLPT8kV4JVG/w
 drhg==
X-Gm-Message-State: APjAAAXnkZBWSm1hqWge5jaYYInx5LGQkUoe2RQHN840QAy7H19jbQDB
 oehiDy7aZjyXX2P18Js7ftNS82/D77qChgp5IK5QeQ==
X-Google-Smtp-Source: APXvYqxDi0XYyUG/YqOdpuG8+VgzvHc9lVbXhZda2YRalmLRWwVVd/k5iVtAXCHf31koxL1zRhS/pM1ddtGbI7EBv34=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr2452185oie.146.1582060575413; 
 Tue, 18 Feb 2020 13:16:15 -0800 (PST)
MIME-Version: 1.0
References: <20200218132023.22936-1-philmd@redhat.com>
 <87e06de3-179b-54a1-3451-39a0a30b65f0@weilnetz.de>
 <CAFEAcA9Jr2Yi1K8_9MGUJYt8C=OcKbWDh1UJjTQG1EspLux3JQ@mail.gmail.com>
 <af34169f-fccc-da44-7b8e-1b38da4a203c@redhat.com>
In-Reply-To: <af34169f-fccc-da44-7b8e-1b38da4a203c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Feb 2020 21:16:03 +0000
Message-ID: <CAFEAcA-qQpa8mmK+GRx7_kFxdwbULb5edh3RH7dT+3pz66jDkw@mail.gmail.com>
Subject: Re: [PATCH] Avoid cpu_physical_memory_rw() with a constant is_write
 argument
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 Stefan Weil <sw@weilnetz.de>, QEMU Developers <qemu-devel@nongnu.org>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Feb 2020 at 20:07, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> I don't understand well cpu_physical_memory*(). Aren't these obsolete?
> They confuse me when using multi-core CPUs.

They sort of are, but there is no simple mechanical replacement
for them -- you need to look at the individual use to see what
address space it should really be using. For instance the cases
in hw/dma/ probably would require the device to be updated to
the new pattern where it takes a MemoryRegion defining what
it should be doing DMA to, and then it can create an AddressSpace
and use that with address_space_*. But that's a bunch of work
on older devices which mostly people don't care very much about.

In theory we could do a textual replacement of cpu_physical_memory*
with address_space_rw(&address_space_memory,...)
but that's usually not the right address space, so I'm not
sure that churn is worthwhile.

thanks
-- PMM

