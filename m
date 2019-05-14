Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5E7C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 17:14:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A415521473
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 17:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A415521473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51455 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQb0j-00073q-Ra
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 13:14:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hQauI-0001Ke-4o
	for qemu-devel@nongnu.org; Tue, 14 May 2019 13:08:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hQafy-0008Ot-UR
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:53:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hQafy-0008Md-ON
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:53:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA17C7E9C0;
	Tue, 14 May 2019 16:53:13 +0000 (UTC)
Received: from [10.40.205.6] (unknown [10.40.205.6])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9A3E560BCF;
	Tue, 14 May 2019 16:53:09 +0000 (UTC)
To: qemu-devel@nongnu.org
References: <20190514162744.30398-1-lvivier@redhat.com>
	<20190514162744.30398-4-lvivier@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <640fa2ef-c9dd-dfaa-868c-03429ef59259@redhat.com>
Date: Tue, 14 May 2019 18:53:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190514162744.30398-4-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Tue, 14 May 2019 16:53:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 3/4] virtio-rng: Keep the default
 backend out of VirtIORNGConf
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "=?UTF-8?Q?Daniel_P_._Berrang=c3=a9?=" <berrange@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Kashyap Chamarthy <kchamart@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	"Richard W . M . Jones" <rjones@redhat.com>, Amit Shah <amit@kernel.org>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/05/2019 18:27, Laurent Vivier wrote:
> From: Markus Armbruster <armbru@redhat.com>
> 
> The default backend is only used within virtio_rng_device_realize().
> Replace VirtIORNGConf member default_backend by a local variable.
> Adjust its type to reduce conversions.
> 
> While there, pass &error_abort instead of NULL when failure would be a
> programming error.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   hw/virtio/virtio-rng.c         | 20 +++++++++-----------
>   include/hw/virtio/virtio-rng.h |  2 --
>   2 files changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
> index 30493a258622..73ffb476e030 100644
> --- a/hw/virtio/virtio-rng.c
> +++ b/hw/virtio/virtio-rng.c
> @@ -16,6 +16,7 @@
>   #include "hw/virtio/virtio.h"
>   #include "hw/virtio/virtio-rng.h"
>   #include "sysemu/rng.h"
> +#include "sysemu/rng-random.h"

I forgot to remove this line in PATCH 4... I will in v6...

Thanks,
Laurent

