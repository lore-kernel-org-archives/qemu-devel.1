Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9F4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8559B21835
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tS6Q7vjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8559B21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itX3v-00086K-LU
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 08:25:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1itX2r-0007KK-B2
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:24:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1itX2p-00075k-F9
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:24:44 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45108)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1itX2o-00073v-R1
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:24:43 -0500
Received: by mail-oi1-x244.google.com with SMTP id n16so28458433oie.12
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 05:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nU83IvydLOPIDIRoS9ZEaKODalDM0u+xy1KT+DRWQpo=;
 b=tS6Q7vjsZCZc+Ndf4jt4SNSnGEokBow9VFD3xJ7x3qjFtBP0s8yJO3/oDSd+29zst4
 tKhsJM6YFr+moYQ4spuQocN9wQg/qnF8r0jPcdvpHtfYQd3wpsiHaa7CpxwcCbXT52xR
 Xj/sTwG2oiwZ042E7m+Y/6fD/vizUBA4jzIjVjZdUdnGoIB7IFnehwvfviJMjsCUJ+qM
 O74AFcq3RSLgPKYO6xskd0gHhisCual/GE8zkflFrCgDrRcqVi9USL5tmsJxbRcXQT1Y
 3owm5jLoX2yc5ddrjKJyu2GkUvwfzLHmjKrwERlrGznZft06I7MikEQY2ePggAxW7TNA
 etgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nU83IvydLOPIDIRoS9ZEaKODalDM0u+xy1KT+DRWQpo=;
 b=CGVhUdwsqqvMsTy+ZBTHCm69+SSW7U3d4ScyTU89/regvACFBD/r347wbmVKAfPPba
 4NH5EppiFvzHUZVdK+Q/WSyiP8bMXorZ0Lmwkq6Q0Xcn5j17JkuYt0Nsi+hDZnYmKDfp
 W6MK5GdafmX64Oe7Wr5Nqpr6YKOxZ4jd6OEdK9ecthiFerya9I7XrxL4GPCGHYylZTV6
 Q8BEfBygwLo40T1OXqdBP4Ly4nDPHk61dCh5s1EnbRbx/Mi16ZKrY88TaxhNjaeDShS9
 5ArOvKf7iubl2ujOmxRRXsNALh2WCtqwFWld2uhYYg6NNCbeY42uuh40g8lDHbSUbbRf
 KxKg==
X-Gm-Message-State: APjAAAWz+ESXcjbYXRHDrzsjRHarKUttJ18UzGrgxZI4kbIKKSYLVV6w
 1SZx/ZazyFs3uCu5x1g2OacI0hCrVeCd5kK/BrWH2g==
X-Google-Smtp-Source: APXvYqzOiRBY3RYV1+UuhmbrDGPO+z3B1xdQHRUHqvh1pAzB2cSrI/9x4FBXufoCiLzh38zPnYJIfuXhEH65Zc3gQyM=
X-Received: by 2002:aca:f484:: with SMTP id s126mr12325580oih.48.1579526681367; 
 Mon, 20 Jan 2020 05:24:41 -0800 (PST)
MIME-Version: 1.0
References: <20200118085509.30182-1-philmd@redhat.com>
 <20200118085509.30182-3-philmd@redhat.com>
In-Reply-To: <20200118085509.30182-3-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jan 2020 13:24:30 +0000
Message-ID: <CAFEAcA92AOY1m9yUew4WtwKfJ63kSF-xwnaYNjmxY33rJEhzJg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] MAINTAINERS: Move the OMAP section inside the ARM
 Machines one
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 18 Jan 2020 at 08:55, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Add the Siemens SX1 (OMAP310) machines with the other ARM machines.

> +OMAP
> +M: Peter Maydell <peter.maydell@linaro.org>
> +L: qemu-arm@nongnu.org
> +S: Maintained
> +F: hw/*/omap*
> +F: include/hw/arm/omap.h

This is the block that covers the various devices
and SoC objects for all the OMAP boards. I'm not clear
why the commit message calls out the SX1 in particular ?

thanks
-- PMM

