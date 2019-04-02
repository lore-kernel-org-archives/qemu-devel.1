Received: from eggs.gnu.org ([209.51.188.92]:34568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBM7s-0007Yy-Rc
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBM7r-0006W1-WB
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:19:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19867)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1hBM7r-0006UV-NU
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:19:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3FC3D5947B
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 16:19:02 +0000 (UTC)
Date: Tue, 2 Apr 2019 18:18:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190402161853.GE5352@localhost.localdomain>
References: <20190326131822.GD15011@stefanha-x1.localdomain>
	<55751c00-0854-ea4d-75b5-ab82b4eeb70d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55751c00-0854-ea4d-75b5-ab82b4eeb70d@redhat.com>
Subject: Re: [Qemu-devel] QEMU event loop optimizations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org

Am 26.03.2019 um 15:11 hat Paolo Bonzini geschrieben:
> - but actually (and a precursor to using IOCB_CMD_POLL) it should be
> possible to have just one LinuxAioState per AioContext, and then
> it can simply share the AioContext's EventNotifier.  This removes
> the need to do the event_notifier_test_and_clear in linux-aio.c.

Isn't having only one LinuxAioState per AioContext what we already do?
See aio_get_linux_aio().

Kevin
