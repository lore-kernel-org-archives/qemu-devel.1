Received: from eggs.gnu.org ([2001:4830:134:3::10]:53062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cxtzc-0005tW-77
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 07:29:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cxtzZ-0004Iy-1L
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 07:29:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cxtzY-0004HZ-RT
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 07:29:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE165C04B941
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 11:29:47 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170406131326.2418-1-quintela@redhat.com>
	<20170406131326.2418-4-quintela@redhat.com>
Date: Tue, 11 Apr 2017 13:29:46 +0200
In-Reply-To: <20170406131326.2418-4-quintela@redhat.com> (Juan Quintela's
	message of "Thu, 6 Apr 2017 15:13:24 +0200")
Message-ID: <87a87nb2s5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/5] qdev: Move qdev_unplug() to
 qdev-monitor.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

Juan Quintela <quintela@redhat.com> writes:

> It is not used by linux-user, otherwise I need to to create one stub
> for migration_is_idle() on following patch.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/core/qdev.c | 34 ----------------------------------
>  qdev-monitor.c | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 34 deletions(-)

Makes sense because its buddy qdev_device_add() is already in
qdev-monitor.c.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
