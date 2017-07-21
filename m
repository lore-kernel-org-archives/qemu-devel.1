Received: from eggs.gnu.org ([2001:4830:134:3::10]:46995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dYbLu-0001Mt-E2
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 13:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dYbLq-0000Jx-G7
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 13:04:34 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:59410)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dYbLq-0000H7-3y
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 13:04:30 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <20170721143149.43721-1-vsementsov@virtuozzo.com>
Date: Fri, 21 Jul 2017 20:04:17 +0300
In-Reply-To: <20170721143149.43721-1-vsementsov@virtuozzo.com> (Vladimir
	Sementsov-Ogievskiy's message of "Fri, 21 Jul 2017 17:31:47 +0300")
Message-ID: <87a83xlo1a.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/2] improve tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, den@openvz.org, dgilbert@redhat.com, stefanha@redhat.com, armbru@redhat.com

Vladimir Sementsov-Ogievskiy writes:

> Current trace system have a drawback: parameters of trace functions
> are calculated even if corresponding tracepoint is disabled. Also, it
> looks like trace function are not actually inlined by compiler (at
> least for me).

> Here is a fix proposal: move from function call to macros. Patch 02
> is an example, of how to reduce extra calculations with help of
> patch 01.

The tracing functions *were* inlined last time I checked, although things
changed quite a lot since then. Not sure that will make a lot of difference in
terms of overall performance (needs measuring).

As for arguments, each trace event has a define TRACE_{NAME}_ENABLED that you
can use for that purpose. If this is not explained in tracing.txt, that is a
documentation bug.


Thanks,
  Lluis
