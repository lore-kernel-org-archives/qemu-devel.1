Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8E5CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:55:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3477120679
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cTCuLg7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3477120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMXDR-0005HU-3S
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 08:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMXCN-0003qX-St
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:54:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMXCL-000630-Rs
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:54:11 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39495)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMXCL-00062u-Ko
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:54:09 -0400
Received: by mail-ot1-x342.google.com with SMTP id s22so10855301otr.6
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 05:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BceuJu5mXNW7pA+/iBG57/OCZpSiyNzDdzDKpZemPPQ=;
 b=cTCuLg7ZWfXXhYGrOw7OlC3hE5pgT3Mv0Vn8TR368mHzYtjpt2tQnDht43LmU9Jkup
 fYC1ZtB2mR7TXQrQacg93ehECpZx2tTRA5tKhWYUnrsQIhuuBm+3zQsyl04jQSFBrI1R
 zaIoyNSURjWYV7aBZHz1IEC9gpPDxYKdTajCF3iZ4IC4HrZIuTl7ZEOT864sjovzpnkI
 rtGg96ufKfA22TBmttdeRGTIKU5ueJZjsXY3Gb+PRktX6K1YE7GvkKLcAWOSias80HTF
 SB5xQiZ6i1Jk+uOFA+HfwqMCX6WYd2bPIk2kyKQxm9DjSbYBSiP8sL7uk0Y83JclB3MT
 bGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BceuJu5mXNW7pA+/iBG57/OCZpSiyNzDdzDKpZemPPQ=;
 b=Dwibr9rr14rRT1viIN/UDtfFrJR0by5fA/bH9kFtx+otkm7PbrNKdzt+njQcDSzuZc
 Nyux8jHHqy3jv1nfSAFL2E2xkMdd9xLZ+R4rEkwlzJN4tpjPd4QGpEfEZxnYzBK7pbEX
 15vKHPoO6tWECTwRCrIPMbrRHDSL3chr1LXUbkfKjf5zpmKTlZaA8IGg2bG35U1grOWw
 2Qgv1O3kAbP58+DHrcVvv5eXRR+ehJjNHXngCnYOf6hKimRi9oiRCLlahJ+yzh6HA23R
 ruUe8GL2ckZQ7VxEz37rMwxxkHw8VyMKq2NLFgsqg0Cke3/cO6R1T5/OtHrNG1Mip7Ul
 2PXg==
X-Gm-Message-State: APjAAAWmXrQ1bpcK28mZo/EpTXVnSH2Z0PSGAIagoqdfaBNgjHqW2GJl
 /XBb5qRMTZOtgwHSfKjk2GOW/2n9Jrf+y2ePNdjw1w==
X-Google-Smtp-Source: APXvYqyl/W9n4U70RDfw6qZe/65zUiJYvtyoEYuVl1B0Cw/kmDHLp3aOU2XYgiz07p4l9CVTMkDDdEDl3lPTQL73vsw=
X-Received: by 2002:a9d:30c1:: with SMTP id r1mr18885460otg.91.1571662448840; 
 Mon, 21 Oct 2019 05:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191018202040.30349-1-jfreimann@redhat.com>
 <20191018202040.30349-2-jfreimann@redhat.com>
In-Reply-To: <20191018202040.30349-2-jfreimann@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2019 13:53:58 +0100
Message-ID: <CAFEAcA-wE1vt_dWsa-k+VK8T0YyRKiPhXUYNYdYVk98nekg=zw@mail.gmail.com>
Subject: Re: [PATCH 01/11] qdev/qbus: add hidden device support
To: Jens Freimann <jfreimann@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Peter Krempa <pkrempa@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 aadam@redhat.com, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Laine Stump <laine@redhat.com>,
 Amnon Ilan <ailan@redhat.com>, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 at 21:22, Jens Freimann <jfreimann@redhat.com> wrote:
>
> This adds support for hiding a device to the qbus and qdev APIs.  The
> first user of this will be the virtio-net failover feature but the API
> introduced with this patch could be used to implement other features as
> well, for example hiding pci devices when a pci bus is powered off.

In what sense is a hidden device hidden? Is it hidden from
the guest (in what way) ? Is it hidden from the QMP/HMP monitor
commands? Is it hidden from QEMU functions that iterate through
the qbus, or that walk the QOM tree ? What does a hidden device
have to do to be successfully hidden ? Is it completely disconnected
from the rest of the simulation, or does it itself have to avoid
doing things like asserting IRQ lines ?

Expanding the DeviceClass doc comment might be a good place to answer
questions like the above and generally describe the 'hidden device'
mechanism.

>  };
>
> @@ -451,4 +457,6 @@ static inline bool qbus_is_hotpluggable(BusState *bus)
>  void device_listener_register(DeviceListener *listener);
>  void device_listener_unregister(DeviceListener *listener);
>
> +bool qdev_should_hide_device(QemuOpts *opts);

New globally visible functions should always have doc-comment
format documentation comments, please.

thanks
-- PMM

