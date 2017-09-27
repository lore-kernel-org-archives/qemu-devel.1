Received: from eggs.gnu.org ([2001:4830:134:3::10]:41479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dxGHv-0001cP-Ij
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 13:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dxGHu-0005X4-Qq
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 13:38:23 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:52138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dxGHu-0005WP-Jj
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 13:38:22 -0400
Received: by mail-wr0-x22f.google.com with SMTP id z39so17786497wrb.8
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 10:38:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504286483-23327-2-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
	<1504286483-23327-2-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 27 Sep 2017 10:38:00 -0700
Message-ID: <CAFEAcA8k4nAjqJ_Mu5ZZ8ygMMJikX17BCB3M0ZkbQBsKVLt5TQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 01/20] hw/arm/smmu-common: smmu base
 device and datatypes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, Radha Mohan <mohun106@gmail.com>, Trey Cain <tcain@qti.qualcomm.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>, jean-philippe.brucker@arm.com, robin.murphy@arm.com, Peter Xu <peterx@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, wtownsen@redhat.com

On 1 September 2017 at 10:21, Eric Auger <eric.auger@redhat.com> wrote:
> The patch introduces the smmu base device and class for the ARM
> smmu. Devices for specific versions will be derived from this
> base device.
>
> We also introduce some important datatypes.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>

> +/*
> + * Copyright (C) 2014-2016 Broadcom Corporation
> + * Copyright (c) 2017 Red Hat, Inc.
> + * Written by Prem Mallappa, Eric Auger
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

Really GPL-2-only ?

Unless there's a good reason, you should probably fix this (including
getting an ack from Prem/Broadcom where it applies to code that came
from him).

thanks
-- PMM
