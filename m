Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D97C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 19:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95C7D2073F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 19:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C7D2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54127 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEfnA-0002YN-Ri
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 15:55:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEfmK-0002A5-OO
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEfmJ-0005uh-S4
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:54:32 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:45245)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hEfmH-0005tO-Jy; Thu, 11 Apr 2019 15:54:29 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1MIxBa-1hTZzh050s-00KPnA; Thu, 11 Apr 2019 21:54:23 +0200
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
References: <20190327095634.53038-1-sgarzare@redhat.com>
	<20190327095634.53038-2-sgarzare@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9e0618f0-e889-5e37-fc4c-b44ada5fe509@vivier.eu>
Date: Thu, 11 Apr 2019 21:54:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190327095634.53038-2-sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:L86bzux5iHwd/oxgyd0ppqMmW+SONEaMTpWEElljnl/DXIQo3N5
	VvIlfCWaQf83MNdwNKjmtWIOx5NiT819jfX80fHQDD4P+hsQKTmmHH5761kzA6/zCZwx1tu
	h8w3s/K4W/jyAhBYESp6bf0V2vS64Am9VJYwDud963NsfE9vbbWfb+rvONJ9+m/W68RbF3t
	XUSVx1ECiTFF/+vUO4GwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9rPttHLW6YM=:BSopeb3LTH/lMag3Mmf22E
	KD2xpEnCplNHzkB/UXuKoqGJU4yDGyjNtne91Elof+OYM7zwOp97ntKzmoYOkQOvmQONqlQSA
	GnuygxzCMKX9qFXuXKiRRjq1SdJ8N5koe+Yqhap27d0GbWoMaqYJYkQUKgydeu8I4dKJ94d1q
	M8qBwp7ud0Q3uVp9bynrQ3eBs1D83oa2Av0+Dmh59w+NlbEJyIaD5bOnbmSqOP1yQmQ2IE3h4
	fP6MRivKoZA4nz+s45LUbcnw7k6rjUdD5Li0/ENcz5alO89uBRO53nEHn665mg5teUG3DMNQk
	/i74VV/K48vwSmzaLvJnLEgwAsUOQKtjddEGBV+dGpyssBja19MhxQtZE8QhhnggvehkDKgH8
	EhtqpcgVXQFLNLDIMce1pMYVbcWHpv9G2eyZbFt6U6RrYyR2Xgdy86F6LQs9L5Bv9FE2Oj1HH
	UYiXurAXvojbnpP1H0l9pkqtS3I5SE16hnmVUSCmPLQl4nivDxgAXnXR2JPfjRNErxIRYgaVQ
	AxFZNotFjqhSlqv25lYIeako9eegjhxDL1gdfCLtpEMgLYC/6dQgph7nacse8FdCJOd/hRnCi
	RJ+z2OrW4bndqBCfwzq+N3NHoL/FHNGqMczn+HHtDpSs+wLA+iozYudFCICwZLqcxDUde/2iX
	gJvuWDA/wAG7DZLzPD7oN/LU+uvYeY1QriSdBbwOWl5I1ZAkoSk7yRBA2pYr2drLtw9Zp5A3r
	Wc1M21iDVRi/h7I+hoCRbQ+6Asi0NsG8JTkmbrN4l5MajmAp4sgfy0kG08I=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2 1/2] block/vhdx: Remove
 redundant IEC binary prefixes definition
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	qemu-trivial@nongnu.org,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	Max Reitz <mreitz@redhat.com>, Jeff Cody <codyprime@gmail.com>,
	John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411195420.8D0IL573-aiV9Y9ARs8TytlZ3DS_ZBalXCJ9ffkwggw@z>

On 27/03/2019 10:56, Stefano Garzarella wrote:
> IEC binary prefixes are already defined in "qemu/units.h",
> so we can remove redundant definitions in "block/vhdx.h".
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  block/vhdx.c | 3 ++-
>  block/vhdx.h | 6 +-----
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/block/vhdx.c b/block/vhdx.c
> index b785aef4b7..7cd1fc3731 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -1889,7 +1889,8 @@ static int coroutine_fn vhdx_co_create(BlockdevCreateOptions *opts,
>          return -EINVAL;
>      }
>      if (block_size > VHDX_BLOCK_SIZE_MAX) {
> -        error_setg(errp, "Block size must not exceed %d", VHDX_BLOCK_SIZE_MAX);
> +        error_setg(errp, "Block size must not exceed %" PRId64,
> +                   VHDX_BLOCK_SIZE_MAX);
>          return -EINVAL;
>      }
>  
> diff --git a/block/vhdx.h b/block/vhdx.h
> index 1bfb4e4f73..bf72090c8f 100644
> --- a/block/vhdx.h
> +++ b/block/vhdx.h
> @@ -17,11 +17,7 @@
>  
>  #ifndef BLOCK_VHDX_H
>  #define BLOCK_VHDX_H
> -
> -#define KiB              (1 * 1024)
> -#define MiB            (KiB * 1024)
> -#define GiB            (MiB * 1024)
> -#define TiB ((uint64_t) GiB * 1024)
> +#include "qemu/units.h"
>  
>  #define DEFAULT_LOG_SIZE 1048576 /* 1MiB */
>  /* Structures and fields present in the VHDX file */
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

