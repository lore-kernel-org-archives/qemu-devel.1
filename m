Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EA9C388F9
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 14:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E094206DD
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 14:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sBlAeQgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E094206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYsIS-0006eM-HW
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 10:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYsHe-00067z-NH
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 10:55:10 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534]:46198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYsHc-0004L2-GF
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 10:55:10 -0400
Received: by mail-ed1-x534.google.com with SMTP id t11so9609737edj.13
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2020 07:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Npv/0mAaLi6Pe4LWT9ZNMhfpch68nueGIFjKVQr3v20=;
 b=sBlAeQgqi7FbvyMUhuZ7SAIMz0wnGesnvrr5FW7lEamdOU4Hyv4ACKTIGl0+0PqPr4
 57H6Uq1IUGnJ4HSYQYirZHs5Z+UmRZOIu+aTaEQtb9lWVpS1NamzbJMTLXzWz6fMkdOa
 UnRJh3t4uTiWVkxk/ax18DFcjZythtHBgmsgkEWShogW6DErcTtPcI/Dx07dssrRx9Iq
 Iyy2MfMkdLfOlXEkUWVpLGpPByWYSG71fCQT7VoJ59VGWlM/V0LvUafHTYqheVvWR9iA
 /OhxlG53MhEkxFkYZEFoqkI0Za9NsRlCTljFJTCxLPEqlexqgMwTWC4ttBq4TO3wIrVl
 oTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Npv/0mAaLi6Pe4LWT9ZNMhfpch68nueGIFjKVQr3v20=;
 b=AxtNBBg+iNv9HMbJ1eodCRVt5luCJ476sITcrFcHlpqmefEChziGbWR50E8RpNHlkd
 AoEDhxqIuUNsVBQLc2pL9WwYjwE4utJz7epRQxVc8kTYVAIOKHkqZFFPa8AzomO6LIb4
 RV8wSoIx414d5PPZ+0OD62NjJRKmRdMvDPqCoQmDCmGpdAkg4iyeHz27JvHzqcBN39KC
 g4ZQvMFDCbPSrYNkoQHwcQeX9aIDXJD6dR9CS+iDoO9MtewPp35woOfy1VBYZrggmLYp
 DUu1Ag+xi2h6njYfnaisF15HYvovs423DUWPNkf3RLNt5/SRsu2XOHmk/HOzrmDz1Wzd
 25xw==
X-Gm-Message-State: AOAM5320Lte4GCxnjqYwtp6Thy6Y/lIQVTnZ27CuDILCg6B+LBxFsU0c
 rdHqWmcD8SbT7e6VxKyM49XXmSz+hvctj8gPQNxQCA==
X-Google-Smtp-Source: ABdhPJz+fF4qxplEj6w6MM4jYsBolSW3QzcJTBnk7j5h/JeIEf7MU180XnmeHwWrNruo7Va+SR8aBqjD5tmhlopqQ9Q=
X-Received: by 2002:a50:f41a:: with SMTP id r26mr7704239edm.251.1604156105419; 
 Sat, 31 Oct 2020 07:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <160390309510.12234.8858324597971641979.stgit@gimli.home>
In-Reply-To: <160390309510.12234.8858324597971641979.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 31 Oct 2020 14:54:54 +0000
Message-ID: <CAFEAcA-z32b81E6u0gsnFnW-QqvM4dheF6ornTAp1g7YadGeYQ@mail.gmail.com>
Subject: Re: [PULL v2 00/32] VFIO updates 2020-10-28 (for QEMU 5.2 soft-freeze)
To: Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Artem Polyakov <artemp@nvidia.com>, Zhengui li <lizhengui@huawei.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Neo Jia <cjia@nvidia.com>,
 Amey Narkhede <ameynarkhede03@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 28 Oct 2020 at 16:42, Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> The following changes since commit 33dc9914eac581dea9bdea35dcda4d542531d66a:
>
>   Revert series: virtiofsd: Announce submounts to the guest (2020-10-28 13:17:32 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20201028.0
>
> for you to fetch changes up to 83d64f2efe383f1f70e180cf1579d3bbe2fbcdf5:
>
>   vfio: fix incorrect print type (2020-10-28 10:30:37 -0600)
>
> ----------------------------------------------------------------
> VFIO update 2020-10-28
>
>  * Migration support (Kirti Wankhede)
>  * s390 DMA limiting (Matthew Rosato)
>  * zPCI hardware info (Matthew Rosato)
>  * Lock guard (Amey Narkhede)
>  * Print fixes (Zhengui li)
>  * Warning/build fixes
>

Hi; this fails to build on OSX and the BSDs:

../../hw/s390x/s390-pci-vfio.c:13:10: fatal error: 'linux/vfio.h' file not found
#include <linux/vfio.h>
         ^~~~~~~~~~~~~~

fails differently but on the same file on windows builds:

../../hw/s390x/s390-pci-vfio.c:12:23: fatal error: sys/ioctl.h: No
such file or directory

and has this error on 32-bit hosts:

../../hw/vfio/common.c: In function 'vfio_dma_unmap_bitmap':
../../hw/vfio/common.c:414:48: error: passing argument 1 of
'cpu_physical_memory_set_dirty_lebitmap' from incompatible pointer
type [-Werror=incompatible-pointer-types]
         cpu_physical_memory_set_dirty_lebitmap((uint64_t *)bitmap->data,
                                                ^
In file included from ../../hw/vfio/common.c:32:0:
/home/peter.maydell/qemu/include/exec/ram_addr.h:337:20: note:
expected 'long unsigned int *' but argument is of type 'uint64_t *
{aka long long unsigned int *}'
 static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned
long *bitmap,
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../../hw/vfio/common.c: In function 'vfio_get_dirty_bitmap':
../../hw/vfio/common.c:1008:44: error: passing argument 1 of
'cpu_physical_memory_set_dirty_lebitmap' from incompatible pointer
type [-Werror=incompatible-pointer-types]
     cpu_physical_memory_set_dirty_lebitmap((uint64_t *)range->bitmap.data,
                                            ^
In file included from ../../hw/vfio/common.c:32:0:
/home/peter.maydell/qemu/include/exec/ram_addr.h:337:20: note:
expected 'long unsigned int *' but argument is of type 'uint64_t *
{aka long long unsigned int *}'
 static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned
long *bitmap,
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

thanks
-- PMM

