Received: from eggs.gnu.org ([2001:4830:134:3::10]:52494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ct9ZA-0007VX-N3
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 05:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ct9Z5-0002hb-PA
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 05:06:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ct9Z5-0002hT-Jk
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 05:06:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F4C580469
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 09:06:50 +0000 (UTC)
Date: Wed, 29 Mar 2017 17:06:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170329090644.GG3152@pxdev.xzpeter.org>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-32-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170323204544.12015-32-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 31/51] ram: Create ram_dirty_sync_count()
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

On Thu, Mar 23, 2017 at 09:45:24PM +0100, Juan Quintela wrote:
> This is a ram field that was inside MigrationState.  Move it to
> RAMState and make it the same that the other ram stats.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- peterx
