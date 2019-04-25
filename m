Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4926FC10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 12:23:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C966218B0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 12:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C966218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56400 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJdPp-0007wc-8Y
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 08:23:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJdOi-0007KN-4r
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJdOg-0000yW-W6
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:22:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hJdOg-0000xx-Nz; Thu, 25 Apr 2019 08:22:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DFDC73199364;
	Thu, 25 Apr 2019 12:22:37 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F30335D9C5;
	Thu, 25 Apr 2019 12:22:36 +0000 (UTC)
Date: Thu, 25 Apr 2019 14:22:35 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190425142235.1db03b17.cohuck@redhat.com>
In-Reply-To: <20190412122523.24111-1-thuth@redhat.com>
References: <20190412122523.24111-1-thuth@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 25 Apr 2019 12:22:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL SUBSYSTEM s390-ccw-bios 00/17] vfio-ccw dasd
 ipl support
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
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425122235.zUOl8GW0edOTEZia3x-FNquMHSqKu_42W95uJVgSsaA@z>

On Fri, 12 Apr 2019 14:25:06 +0200
Thomas Huth <thuth@redhat.com> wrote:

> This pull request is not for master.
> 
>  Hi Cornelia,
> 
> the following changes since commit 532cc6da74ec25b5ba6893b5757c977d54582949:
> 
>   Update version for v4.0.0-rc3 release (2019-04-10 15:38:59 +0100)
> 
> are available in the Git repository at:
> 
>   https://gitlab.com/huth/qemu.git tags/s390-ccw-bios-2019-04-12
> 
> for you to fetch changes up to 4a33fac54665558b7f7a68135c4a4c602eceb72f:
> 
>   pc-bios/s390: Update firmware images (2019-04-12 12:40:35 +0200)
> 
> ----------------------------------------------------------------
> Support for booting from a vfio-ccw passthrough dasd device
> ----------------------------------------------------------------
> 
> Jason J. Herne (16):
>       s390 vfio-ccw: Add bootindex property and IPLB data
>       s390-bios: decouple cio setup from virtio
>       s390-bios: decouple common boot logic from virtio
>       s390-bios: Clean up cio.h
>       s390-bios: Decouple channel i/o logic from virtio
>       s390-bios: Map low core memory
>       s390-bios: ptr2u32 and u32toptr
>       s390-bios: Support for running format-0/1 channel programs
>       s390-bios: cio error handling
>       s390-bios: Extend find_dev() for non-virtio devices
>       s390-bios: Factor finding boot device out of virtio code path
>       s390-bios: Refactor virtio to run channel programs via cio
>       s390-bios: Use control unit type to determine boot method
>       s390-bios: Add channel command codes/structs needed for dasd-ipl
>       s390-bios: Support booting from real dasd device
>       s390-bios: Use control unit type to find bootable devices
> 
> Thomas Huth (1):
>       pc-bios/s390: Update firmware images
> 
>  MAINTAINERS                  |   2 +
>  docs/devel/s390-dasd-ipl.txt | 133 ++++++++++++++
>  hw/s390x/ipl.c               |  61 +++++--
>  hw/s390x/s390-ccw.c          |   9 +
>  hw/vfio/ccw.c                |   6 +-
>  include/hw/s390x/s390-ccw.h  |   1 +
>  include/hw/s390x/vfio-ccw.h  |  28 +++
>  pc-bios/s390-ccw.img         | Bin 34568 -> 42608 bytes
>  pc-bios/s390-ccw/Makefile    |   2 +-
>  pc-bios/s390-ccw/cio.c       | 423 +++++++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/cio.h       | 270 +++++++++++++++++++++------
>  pc-bios/s390-ccw/dasd-ipl.c  | 235 ++++++++++++++++++++++++
>  pc-bios/s390-ccw/dasd-ipl.h  |  16 ++
>  pc-bios/s390-ccw/helper.h    |  31 ++++
>  pc-bios/s390-ccw/libc.h      |  11 ++
>  pc-bios/s390-ccw/main.c      | 190 +++++++++++++------
>  pc-bios/s390-ccw/netboot.mak |   2 +-
>  pc-bios/s390-ccw/netmain.c   |   2 +
>  pc-bios/s390-ccw/s390-arch.h | 103 +++++++++++
>  pc-bios/s390-ccw/s390-ccw.h  |  10 +-
>  pc-bios/s390-ccw/start.S     |  29 +++
>  pc-bios/s390-ccw/virtio.c    |  81 +++------
>  pc-bios/s390-netboot.img     | Bin 54944 -> 67232 bytes
>  tests/boot-serial-test.c     |   2 +-
>  24 files changed, 1446 insertions(+), 201 deletions(-)
>  create mode 100644 docs/devel/s390-dasd-ipl.txt
>  create mode 100644 include/hw/s390x/vfio-ccw.h
>  create mode 100644 pc-bios/s390-ccw/cio.c
>  create mode 100644 pc-bios/s390-ccw/dasd-ipl.c
>  create mode 100644 pc-bios/s390-ccw/dasd-ipl.h
>  create mode 100644 pc-bios/s390-ccw/helper.h
>  create mode 100644 pc-bios/s390-ccw/s390-arch.h

Thanks, pulled.

