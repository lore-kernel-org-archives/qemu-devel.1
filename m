Received: from eggs.gnu.org ([2001:4830:134:3::10]:60738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWiB3-00074G-Gd
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:29:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWiB2-0005sO-NM
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:29:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWiB2-0005rq-H3
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:29:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A262F356E7
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 12:29:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180103122017.14794-13-peterx@redhat.com> (Peter Xu's message
	of "Wed, 3 Jan 2018 20:20:16 +0800")
References: <20180103122017.14794-1-peterx@redhat.com>
	<20180103122017.14794-13-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 03 Jan 2018 13:29:41 +0100
Message-ID: <87608jyvka.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 12/13] migration: remove some
 block_cleanup_parameters()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> Keep the one in migrate_fd_cancel() would be enough.  Removing the other

                          ^^^^^^^

s/cancel/cleanup/

> two.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

No need to respin for this one.  I can just change it when pulling.

Later, Juan.
