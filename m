Received: from eggs.gnu.org ([2001:4830:134:3::10]:40473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dxThm-0008GR-1z
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 03:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dxThh-0005vE-CK
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 03:57:58 -0400
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
	<1504286483-23327-2-git-send-email-eric.auger@redhat.com>
	<CAFEAcA8k4nAjqJ_Mu5ZZ8ygMMJikX17BCB3M0ZkbQBsKVLt5TQ@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <18211c39-970f-1277-e2a8-a30bb30f9050@redhat.com>
Date: Thu, 28 Sep 2017 09:57:35 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8k4nAjqJ_Mu5ZZ8ygMMJikX17BCB3M0ZkbQBsKVLt5TQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, Radha Mohan <mohun106@gmail.com>, Trey Cain <tcain@qti.qualcomm.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>, jean-philippe.brucker@arm.com, robin.murphy@arm.com, Peter Xu <peterx@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, wtownsen@redhat.com

Hi Peter,
On 27/09/2017 19:38, Peter Maydell wrote:
> On 1 September 2017 at 10:21, Eric Auger <eric.auger@redhat.com> wrote:
>> The patch introduces the smmu base device and class for the ARM
>> smmu. Devices for specific versions will be derived from this
>> base device.
>>
>> We also introduce some important datatypes.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
> 
>> +/*
>> + * Copyright (C) 2014-2016 Broadcom Corporation
>> + * Copyright (c) 2017 Red Hat, Inc.
>> + * Written by Prem Mallappa, Eric Auger
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
> 
> Really GPL-2-only ?
> 
> Unless there's a good reason, you should probably fix this (including
> getting an ack from Prem/Broadcom where it applies to code that came
> from him).
OK, thanks for the notice,  I will investigate how/if we can change the
license.

Best Regards

Eric
> 
> thanks
> -- PMM
> 
