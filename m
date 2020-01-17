Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78178C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43B712072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yzNmLBez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B712072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isS0k-00032m-VO
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:50:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isRvS-0007DU-Vq
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:44:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isRvR-0008AZ-OU
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:44:38 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36448)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isRvR-00088e-HY
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:44:37 -0500
Received: by mail-oi1-x243.google.com with SMTP id c16so22211151oic.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 05:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1XpXY3S/iADEqZL6RCLeEGiyJcbLnU2P+ZQvjil7INA=;
 b=yzNmLBezVokaDTotMxd+upbESYDYX5QLi8r06xLA1N1Mmgvyq62xjt8Mfz28MSidC+
 B7yvwl6cviImSBTu4c0DTI2v1OJ07eraxbTlMXBJ3md1QTfJdINpjtplTdZOa7x39sF5
 PI/Np9zWYX5IE/A+FDvZ1Ark37hHwjb+JfRhAlX7xYW7/i57tYE3RXbpZa4ZTjq3G+gD
 wkngiTJhiGl3/OYw9C7OwcZ0mx9Ai6k4siqYBsqG7ODQeeeUplGgfWaE0qCUE8PX8w5M
 5En0dVuBArVkEvw/QPm0Pweg1VHx+tJJv+UU7o9T0yD347bttc4alwVd7h5rZqp4Hm36
 yKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1XpXY3S/iADEqZL6RCLeEGiyJcbLnU2P+ZQvjil7INA=;
 b=f6707EVVukpYv/H8K55sPGpY6qG2WYfhNp3CRPH93gHmJK1Y6NjxyDRgiEAtLuDkGJ
 xAQd76FuZYAxzVaIL9DkmRwClCFJ9ty244NgQufZUbXh5xdPvgUepgTCXZ8vwOJMuvoZ
 32ORzjJkykAbIpVRRhRx+IZDI8v4NwXnuFqLdiHmVHeozqclGDji6aMZP+rxdurrhxiJ
 T9QnwqNuPstvtsbz0OqmnWlNK7UyyJ38HR/Wr/xOyb7TlXX5mbHzYEU/D+1sx846hm5Z
 mqEWZKE2n8pgiibXIjvv1lz4mjoHbXd8UkSxSQrtVXRvixo5j2wVqbyaBrzbT/1v6H1S
 YtlA==
X-Gm-Message-State: APjAAAXSjv+hG60+NAtD4faET4SkUxmNSlVqwW/awIrvw8oYaLg09J4n
 inH9tqc+QXIvWo9yZyaSuzsjt7skPusYMj9n2lKRHw==
X-Google-Smtp-Source: APXvYqzXkjHcgT1eIco38VZLXyRXliTDp3wOJeJHQbq+Sb8255R+1eKpe9IojH8Vlut6g9OAV67fwu++Jym0zAERYBY=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr3457852oid.98.1579268675049;
 Fri, 17 Jan 2020 05:44:35 -0800 (PST)
MIME-Version: 1.0
References: <20200110203942.5745-1-linux@roeck-us.net>
 <20200110203942.5745-6-linux@roeck-us.net>
In-Reply-To: <20200110203942.5745-6-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jan 2020 13:44:24 +0000
Message-ID: <CAFEAcA8NX4_vy8UWgtrt1ZTw-D0GYzVYUGrkT7t6ej6V3joeVw@mail.gmail.com>
Subject: Re: [PATCH 5/6] hw/char/exynos4210_uart: Add receive DMA support
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jan 2020 at 20:39, Guenter Roeck <linux@roeck-us.net> wrote:
>
> To support receive DMA, we need to inform the DMA controller if receive data
> is available. Otherwise the DMA controller keeps requesting data, causing
> receive errors.
>
> Implement this using an interrupt line. The instantiating code then needs
> to connect the interrupt with the matching DMA controller GPIO pin.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

