Received: from eggs.gnu.org ([2001:4830:134:3::10]:56559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dS4aL-00071U-8S
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dS4aI-000254-7T
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:52:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dS4aI-00023o-0q
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:52:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E97207CE05
	for <qemu-devel@nongnu.org>; Mon,  3 Jul 2017 16:52:24 +0000 (UTC)
Date: Mon, 3 Jul 2017 13:52:18 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170703165218.GM12152@localhost.localdomain>
References: <1499049848-18012-1-git-send-email-peterx@redhat.com>
	<1499049848-18012-2-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499049848-18012-2-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] migration: fix handling for
 --only-migratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Jul 03, 2017 at 10:44:05AM +0800, Peter Xu wrote:
> MigrateState object is not ready at that time, so we'll get an
> assertion. Use qemu_global_option() instead.
> 
> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Fixes: 3df663e ("migration: move only_migratable to MigrationState")
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
