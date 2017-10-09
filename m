Received: from eggs.gnu.org ([2001:4830:134:3::10]:60297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e1UMg-0001hA-26
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 05:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e1UMc-0005XB-Vp
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 05:28:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e1UMc-0005Wy-Py
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 05:28:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D6E84C0587D7
	for <qemu-devel@nongnu.org>; Mon,  9 Oct 2017 09:28:41 +0000 (UTC)
Date: Mon, 9 Oct 2017 17:28:38 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171009092838.GG2196@pxdev.xzpeter.org>
References: <20171004104636.7963-1-quintela@redhat.com>
	<20171004104636.7963-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171004104636.7963-3-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v9 02/12] migration: Improve migration
 thread error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Wed, Oct 04, 2017 at 12:46:26PM +0200, Juan Quintela wrote:

[...]

> diff --git a/migration/tls.c b/migration/tls.c
> index 596e8790bd..026a008667 100644
> --- a/migration/tls.c
> +++ b/migration/tls.c
> @@ -119,7 +119,6 @@ static void migration_tls_outgoing_handshake(QIOTask *task,
>      if (qio_task_propagate_error(task, &err)) {
>          trace_migration_tls_outgoing_handshake_error(error_get_pretty(err));
>          migrate_fd_error(s, err);
> -        error_free(err);

Would err be leaked if this line is removed?

>      } else {
>          trace_migration_tls_outgoing_handshake_complete();
>          migration_channel_connect(s, ioc, NULL);
> -- 
> 2.13.5
> 

-- 
Peter Xu
