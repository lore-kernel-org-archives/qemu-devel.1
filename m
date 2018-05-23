Received: from eggs.gnu.org ([2001:4830:134:3::10]:58083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLQaH-0007qC-2p
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLQaB-0006bF-Dc
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:01:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40254 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1fLQaB-0006az-8Z
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:01:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3AD340122C0
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 10:01:22 +0000 (UTC)
Date: Wed, 23 May 2018 12:01:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180523100120.GD7523@localhost.localdomain>
References: <20180523091411.1073-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523091411.1073-1-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: fix exec/fd migrations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Am 23.05.2018 um 11:14 hat Juan Quintela geschrieben:
> Commit:
> 
> commit 36c2f8be2c4eb0003ac77a14910842b7ddd7337e
> Author: Juan Quintela <quintela@redhat.com>
> Date:   Wed Mar 7 08:40:52 2018 +0100
> 
>     migration: Delay start of migration main routines
> 
> Missed tcp and fd transports.  This fix its.
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>

In my first test run, qemu-iotests 169 still timed out with a message
that qemu recevied signal 6, but I haven't been able to reproduce it
since. Quite possible that that's an old, unrelated problem. Other than
that, the tests are passing again. I suppose this is enough for:

Tested-by: Kevin Wolf <kwolf@redhat.com>
