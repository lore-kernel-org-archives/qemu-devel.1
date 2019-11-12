Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BE5C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:14:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5BB6214E0
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E5DwSDnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BB6214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUTCJ-0004hH-0M
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 05:14:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iUTBZ-0004Ep-JH
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:14:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iUTBY-0008IH-IF
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:14:09 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iUTBY-0008Hj-Cw
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:14:08 -0500
Received: by mail-oi1-x244.google.com with SMTP id l202so14301725oig.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 02:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wm43u0jf0oCeAS8ZP7PJ21XO1JfIpRn6ORwg5al3DqA=;
 b=E5DwSDnnUh/tDhHXeQe3vGbImJgode9bTafg6r4DgHgnL8vLoyb0Q6AOEFG9SA9d92
 OGpl2EW8BPTSPyhJJy6OqwbxwP074MfyvPyJhwPImr2jEhrv+V+djpIKsu5220r9VcU0
 saee5OO2QYZ6V0hIFR7C6QcGWZhaL1bIbEgIcB40uIcEbMRDxR/RFG7uUPtvVGFuWjx4
 QQk2uJcsToh7M4LbHhKlL2fryIuN3qA+z2NLv7OTyxN+LPKWgVU4+hQqa/8a2Cs3uNLN
 gHO5naEJgLybpbuv8fmM0DUBJ2LVOsIkR6LVK+M/LP2xSs511Ry5HYUqFxgsPnajqb0N
 4oYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wm43u0jf0oCeAS8ZP7PJ21XO1JfIpRn6ORwg5al3DqA=;
 b=IRBoF320vM1uM7SSW0e7b7MGeFwcVRjgN/Dutbwwj/yWcYue1pETGYqGkflST/xrxt
 RYD6fVBJLc5PbPIzzbaS8JtR4O1epZvstCCxXLISmuDN1+0Yw8gpImMsUvKquqQS5grD
 pyr18iQljG8KFvNij3SeXs0evSVRJWnN3K91l3R9TTNroQggCRhI0mr4h+C2uv2g5d+l
 0TvBpXGxUMdIHb5hnD+COdu9SBMFvvUXDongUIaZxuPJBKlPgUopqXXIkTREXaKyIT5w
 NFAU+jNV84trg6i5NVmWOdXDb+vYLmT9CWwQLkc3Yx7n4BZ131Uoqw7VB11DVjybZxRf
 z5Ew==
X-Gm-Message-State: APjAAAVkw7kDh72TG8VF5yvWTS+Cmh8tt6J2jw0sj5pw+MAjsOMqEP/k
 akODsbGt5C7Lt78+PMVsMpI5EbKdufolhATwzDiOzQ==
X-Google-Smtp-Source: APXvYqx+bWE9Uz5NjNoUz+wUApKzy4omL1QeJ8U8i7/BRYr8UcsWm2SGlfBA/qKJYcXZMxiSEVgLPqSivN/GF3W52JI=
X-Received: by 2002:a05:6808:b04:: with SMTP id
 s4mr3363737oij.163.1573553647455; 
 Tue, 12 Nov 2019 02:14:07 -0800 (PST)
MIME-Version: 1.0
References: <20191029225932.14585-1-mst@redhat.com>
 <20191029225932.14585-12-mst@redhat.com>
In-Reply-To: <20191029225932.14585-12-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Nov 2019 10:13:56 +0000
Message-ID: <CAFEAcA8z9Guw1JdnDTuanuANB4a05GK5S7PSsB5UETNA0reB6A@mail.gmail.com>
Subject: Re: [PULL 11/14] vfio: unplug failover primary device before migration
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 29 Oct 2019 at 23:01, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Jens Freimann <jfreimann@redhat.com>
>
> As usual block all vfio-pci devices from being migrated, but make an
> exception for failover primary devices. This is achieved by setting
> unmigratable to 0 but also add a migration blocker for all vfio-pci
> devices except failover primary devices. These will be unplugged before
> migration happens by the migration handler of the corresponding
> virtio-net standby device.

Hi; Coverity reports a 'value written to variable but never used'
issue here (CID 1407219):


> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 12fac39804..e6569a7968 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -40,6 +40,7 @@
>  #include "pci.h"
>  #include "trace.h"
>  #include "qapi/error.h"
> +#include "migration/blocker.h"
>
>  #define TYPE_VFIO_PCI "vfio-pci"
>  #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
> @@ -2732,6 +2733,17 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          return;
>      }
>
> +    if (!pdev->failover_pair_id) {
> +        error_setg(&vdev->migration_blocker,
> +                "VFIO device doesn't support migration");
> +        ret = migrate_add_blocker(vdev->migration_blocker, &err);

Here we assign to 'ret', but we never use it on the 'if (err)'
path, and on the success case we don't look at it either; it's
just overwritten by the later 'ret = vfio_get_device(...)'.

> +        if (err) {
> +            error_propagate(errp, err);
> +            error_free(vdev->migration_blocker);
> +            return;
> +        }
> +    }

thanks
-- PMM

