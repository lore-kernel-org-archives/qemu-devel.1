Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C2BC742A5
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 07:24:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C8CF20863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 07:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C8CF20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlpui-0005hu-7w
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 03:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36167)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hlpuX-0005Dd-F3
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 03:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hlpuW-0008TC-Am
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 03:24:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50402)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hlpuT-0008RF-QK; Fri, 12 Jul 2019 03:24:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 31A5B1556B;
 Fri, 12 Jul 2019 07:23:59 +0000 (UTC)
Received: from [10.36.116.46] (ovpn-116-46.ams2.redhat.com [10.36.116.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 66EC95DDA2;
 Fri, 12 Jul 2019 07:23:49 +0000 (UTC)
To: qemu-devel@nongnu.org
References: <156288396475.12463.8495950257512135187@c4a48874b076>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b0d9cfea-0060-7c44-59e1-fc109784f501@redhat.com>
Date: Fri, 12 Jul 2019 09:23:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <156288396475.12463.8495950257512135187@c4a48874b076>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 12 Jul 2019 07:23:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v5 00/29] vSMMUv3/pSMMUv3 2 stage VFIO
 integration
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, yi.l.liu@intel.com,
 mst@redhat.com, jean-philippe.brucker@arm.com, zhangfei.gao@foxmail.com,
 peterx@redhat.com, alex.williamson@redhat.com, qemu-arm@nongnu.org,
 vincent.stehle@arm.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 7/12/19 12:26 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190711173933.31203-1-eric.auger@redhat.com/
> 
> 
> 
> Hi,
> 
> This series failed build test on s390x host. Please find the details below.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> # Testing script will be invoked under the git checkout with
> # HEAD pointing to a commit that has the patches applied on top of "base"
> # branch
> set -e
> 
> echo
> echo "=== ENV ==="
> env
> 
> echo
> echo "=== PACKAGES ==="
> rpm -qa
> 
> echo
> echo "=== UNAME ==="
> uname -a
> 
> CC=$HOME/bin/cc
> INSTALL=$PWD/install
> BUILD=$PWD/build
> mkdir -p $BUILD $INSTALL
> SRC=$PWD
> cd $BUILD
> $SRC/configure --cc=$CC --prefix=$INSTALL
> make -j4
> # XXX: we need reliable clean up
> # make check -j4 V=1
> make install
> === TEST SCRIPT END ===
> 
>   CC      i386-softmmu/hw/virtio/virtio-crypto.o
>   CC      i386-softmmu/hw/virtio/virtio-crypto-pci.o
>   CC      i386-softmmu/hw/virtio/virtio-pmem.o
> /var/tmp/patchew-tester-tmp-u52ljjk0/src/hw/virtio/virtio-pmem.c:21:10: fatal error: standard-headers/linux/virtio_pmem.h: No such file or directory
>    21 | #include "standard-headers/linux/virtio_pmem.h"
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
In the kernel branch I used along with ./scripts/update-linux-headers.sh
the header was not yet there. As a consequence the
standard-headers/linux/virtio_pmem.h was removed. I will fix that soon.

Does not block testing on ARM where the VIRTIO_PMEM device is not
configured.

Thanks

Eric
> 
> 
> The full log is available at
> http://patchew.org/logs/20190711173933.31203-1-eric.auger@redhat.com/testing.s390x/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 

