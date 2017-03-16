Received: from eggs.gnu.org ([2001:4830:134:3::10]:53783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1coK7W-0003Xn-Bc
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 21:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1coK7S-0000aR-D7
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 21:22:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1coK7S-0000a8-7A
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 21:22:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51F1A883B1
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 01:22:22 +0000 (UTC)
Date: Thu, 16 Mar 2017 09:22:19 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170316012219.GA21865@lemon.lan>
References: <20170314153626.16989-1-famz@redhat.com>
	<20170314153626.16989-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170314153626.16989-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] virtio-scsi: Fix acquire/release in
 dataplane handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On Tue, 03/14 23:36, Fam Zheng wrote:
> After the AioContext lock push down, there is a race between
> virtio_scsi_dataplane_start and those "assert(s->ctx &&
> s->dataplane_started)", because the latter doesn't isn't wrapped in

s/doesn't//

> aio_context_acquire.
