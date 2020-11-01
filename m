Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0497DC4741F
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 20:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1BA2225C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 20:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bt2wF3nY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1BA2225C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZKG5-0006tI-74
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 15:47:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZKFS-0006Cs-Cd
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 15:46:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZKFP-0003lD-IE
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 15:46:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604263601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y6MpFSdZ/5BgRhQWo5A57kOGYS5mIdpmUQ24WCbvYM0=;
 b=Bt2wF3nYzqjHwWQCdrWKOaZFB3L/HpQI0gubU5/N76T1lb4vsD8LmZ5FVt1lkaQui6Zbx4
 PKqovMNZ1LJj3SErYRXyieKCBTqfKK6Vi82fIG+Pdvn0m1AH5zMxPx1BAp1F2G+/KPUwSB
 JNvcMM6H6ZM8zTOPPbv3E2YcLZfPlIY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-EVu_h9OoPemHbZys8ZFnjw-1; Sun, 01 Nov 2020 15:46:39 -0500
X-MC-Unique: EVu_h9OoPemHbZys8ZFnjw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53E3D425F2;
 Sun,  1 Nov 2020 20:46:37 +0000 (UTC)
Received: from x1.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CFFD5C1A3;
 Sun,  1 Nov 2020 20:46:32 +0000 (UTC)
Date: Sun, 1 Nov 2020 13:46:00 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v2 00/32] VFIO updates 2020-10-28 (for QEMU 5.2 soft-freeze)
Message-ID: <20201101134600.4784ebfc@x1.home>
In-Reply-To: <CAFEAcA-z32b81E6u0gsnFnW-QqvM4dheF6ornTAp1g7YadGeYQ@mail.gmail.com>
References: <160390309510.12234.8858324597971641979.stgit@gimli.home>
 <CAFEAcA-z32b81E6u0gsnFnW-QqvM4dheF6ornTAp1g7YadGeYQ@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 15:46:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Neo Jia <cjia@nvidia.com>, Amey Narkhede <ameynarkhede03@gmail.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 31 Oct 2020 14:54:54 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Wed, 28 Oct 2020 at 16:42, Alex Williamson
> <alex.williamson@redhat.com> wrote:
> >
> > The following changes since commit 33dc9914eac581dea9bdea35dcda4d542531d66a:
> >
> >   Revert series: virtiofsd: Announce submounts to the guest (2020-10-28 13:17:32 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20201028.0
> >
> > for you to fetch changes up to 83d64f2efe383f1f70e180cf1579d3bbe2fbcdf5:
> >
> >   vfio: fix incorrect print type (2020-10-28 10:30:37 -0600)
> >
> > ----------------------------------------------------------------
> > VFIO update 2020-10-28
> >
> >  * Migration support (Kirti Wankhede)
> >  * s390 DMA limiting (Matthew Rosato)
> >  * zPCI hardware info (Matthew Rosato)
> >  * Lock guard (Amey Narkhede)
> >  * Print fixes (Zhengui li)
> >  * Warning/build fixes
> >  
> 
> Hi; this fails to build on OSX and the BSDs:
> 
> ../../hw/s390x/s390-pci-vfio.c:13:10: fatal error: 'linux/vfio.h' file not found
> #include <linux/vfio.h>
>          ^~~~~~~~~~~~~~
> 
> fails differently but on the same file on windows builds:
> 
> ../../hw/s390x/s390-pci-vfio.c:12:23: fatal error: sys/ioctl.h: No
> such file or directory

I think this can be solved by making s390-pci-vfio.c only compiled
under CONFIG_LINUX and stubbing the functions with static inlines in
the header.  It seems to resolve the windows warning in a mingw build.

> and has this error on 32-bit hosts:
> 
> ../../hw/vfio/common.c: In function 'vfio_dma_unmap_bitmap':
> ../../hw/vfio/common.c:414:48: error: passing argument 1 of
> 'cpu_physical_memory_set_dirty_lebitmap' from incompatible pointer
> type [-Werror=incompatible-pointer-types]
>          cpu_physical_memory_set_dirty_lebitmap((uint64_t *)bitmap->data,
>                                                 ^
> In file included from ../../hw/vfio/common.c:32:0:
> /home/peter.maydell/qemu/include/exec/ram_addr.h:337:20: note:
> expected 'long unsigned int *' but argument is of type 'uint64_t *
> {aka long long unsigned int *}'
>  static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned
> long *bitmap,
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../../hw/vfio/common.c: In function 'vfio_get_dirty_bitmap':
> ../../hw/vfio/common.c:1008:44: error: passing argument 1 of
> 'cpu_physical_memory_set_dirty_lebitmap' from incompatible pointer
> type [-Werror=incompatible-pointer-types]
>      cpu_physical_memory_set_dirty_lebitmap((uint64_t *)range->bitmap.data,
>                                             ^
> In file included from ../../hw/vfio/common.c:32:0:
> /home/peter.maydell/qemu/include/exec/ram_addr.h:337:20: note:
> expected 'long unsigned int *' but argument is of type 'uint64_t *
> {aka long long unsigned int *}'
>  static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned
> long *bitmap,
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Seems that our bitmap in just being incorrectly cast as a uint64_t*
rather than an unsigned long*.

Both fixes being rolled into the next pull request, which I've build 32
and 64 bit and with mingw.  Thanks,

Alex


