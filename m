Received: from eggs.gnu.org ([2001:4830:134:3::10]:51438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXC16-0006eb-NK
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 15:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXC15-0007mF-Mk
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 15:49:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dXC15-0007lt-GN
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 15:49:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 71B02C057EC9
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 19:49:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170717110936.23314-3-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Mon, 17 Jul 2017 12:09:32 +0100")
References: <20170717110936.23314-1-dgilbert@redhat.com>
	<20170717110936.23314-3-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 17 Jul 2017 21:49:14 +0200
Message-ID: <878tjmn8sl.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 2/6] migration: Close file on failed
 migration load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Closing the file before exit on a failure allows
> the source to cleanup better, especially with RDMA.
>
> Partial fix for https://bugs.launchpad.net/qemu/+bug/1545052
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Also to this version.
