Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21308C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 16:45:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7F1D21900
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 16:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F1D21900
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53156 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG4jh-0006K9-1d
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 12:45:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hG4iQ-0005el-Oy
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hG4iP-0002lG-Kq
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:44:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hG4iP-0002kB-6J; Mon, 15 Apr 2019 12:44:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF651C0842AF;
	Mon, 15 Apr 2019 16:44:10 +0000 (UTC)
Received: from gondolin (unknown [10.40.205.58])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A5C725B680;
	Mon, 15 Apr 2019 16:44:03 +0000 (UTC)
Date: Mon, 15 Apr 2019 18:43:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <20190415184359.452613ae.cohuck@redhat.com>
In-Reply-To: <20190301093902.27799-1-cohuck@redhat.com>
References: <20190301093902.27799-1-cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Mon, 15 Apr 2019 16:44:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 0/6] vfio-ccw: support hsch/csch (kernel
 part)
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
Cc: linux-s390@vger.kernel.org, qemu-s390x@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>,
	qemu-devel@nongnu.org, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415164359.tCWxPT4Bu7AFFj60gkTfpL0YiAMWDxceVPs01diTXOw@z>

On Fri,  1 Mar 2019 10:38:56 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> [This is the Linux kernel part, git tree is available at
> https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git vfio-ccw-eagain-caps-v3
> 
> The companion QEMU patches are available at
> https://github.com/cohuck/qemu vfio-ccw-caps]
> 
> Currently, vfio-ccw only relays START SUBCHANNEL requests to the real
> device. This tends to work well for the most common 'good path' scenarios;
> however, as we emulate {HALT,CLEAR} SUBCHANNEL in QEMU, things like
> clearing pending requests at the device is currently not supported.
> This may be a problem for e.g. error recovery.
> 
> This patch series introduces capabilities (similar to what vfio-pci uses)
> and exposes a new async region for handling hsch/csch.
> 
> Lightly tested (I can interact with a dasd as before, and reserve/release
> seems to work well.) Not sure if there is a better way to test this, ideas
> welcome.
> 
> Changes v3->v4:
> - shrunk the capability offset, we don't need to accommodate as much as pci
> - make checks in patch 1 more consistent and less buggy
> - rebased on top of my current vfio-ccw branch
> 
> Changes v2->v3:
> - Unb0rked patch 1, improved scope
> - Split out the new mutex from patch 2 into new patch 3; added missing
>   locking and hopefully improved description
> - Patch 2 now reworks the state handling by splitting the BUSY state
>   into CP_PROCESSING and CP_PENDING
> - Patches 3 and 5 adapted on top of the reworked patches; hsch/csch
>   are allowed in CP_PENDING, but not in CP_PROCESSING (did not add
>   any R-b due to that)
> - Added missing free in patch 5
> - Probably some small changes I forgot to note down
> 
> Changes v1->v2:
> - New patch 1: make it safe to use the cp accessors at any time; this
>   should avoid problems with unsolicited interrupt handling
> - New patch 2: handle concurrent accesses to the io region; the idea is
>   to return -EAGAIN to userspace more often (so it can simply retry)
> - also handle concurrent accesses to the async io region
> - change VFIO_REGION_TYPE_CCW
> - merge events for halt and clear to a single async event; this turned out
>   to make the code quite a bit simpler
> - probably some small changes I forgot to note down
> 
> Cornelia Huck (6):
>   vfio-ccw: make it safe to access channel programs
>   vfio-ccw: rework ssch state handling
>   vfio-ccw: protect the I/O region
>   vfio-ccw: add capabilities chain
>   s390/cio: export hsch to modules
>   vfio-ccw: add handling for async channel instructions
> 
>  drivers/s390/cio/Makefile           |   3 +-
>  drivers/s390/cio/ioasm.c            |   1 +
>  drivers/s390/cio/vfio_ccw_async.c   |  88 ++++++++++++
>  drivers/s390/cio/vfio_ccw_cp.c      |  21 ++-
>  drivers/s390/cio/vfio_ccw_cp.h      |   2 +
>  drivers/s390/cio/vfio_ccw_drv.c     |  57 ++++++--
>  drivers/s390/cio/vfio_ccw_fsm.c     | 143 +++++++++++++++++-
>  drivers/s390/cio/vfio_ccw_ops.c     | 215 +++++++++++++++++++++++-----
>  drivers/s390/cio/vfio_ccw_private.h |  48 ++++++-
>  include/uapi/linux/vfio.h           |   4 +
>  include/uapi/linux/vfio_ccw.h       |  12 ++
>  11 files changed, 537 insertions(+), 57 deletions(-)
>  create mode 100644 drivers/s390/cio/vfio_ccw_async.c
> 

Queued (with the touchups discussed in the thread) to the vfio-ccw
branch on kernel.org.

