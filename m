Received: from eggs.gnu.org ([2001:4830:134:3::10]:35381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAY4i-000480-Iu
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:43:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAY4f-0001Ch-AR
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:43:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dAY4f-0001CQ-45
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:43:21 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170515214114.15442-1-eblake@redhat.com>
	<20170515214114.15442-4-eblake@redhat.com>
Date: Tue, 16 May 2017 10:43:17 +0200
In-Reply-To: <20170515214114.15442-4-eblake@redhat.com> (Eric Blake's message
	of "Mon, 15 May 2017 16:41:12 -0500")
Message-ID: <8737c5gpju.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 3/5] shutdown: Preserve shutdown cause
 through replay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, alistair.francis@xilinx.com

Eric Blake <eblake@redhat.com> writes:

> With the recent addition of ShutdownCause, we want to be able to pass
> a cause through any shutdown request, and then faithfully replay that
> cause when later replaying the same sequence.  The easiest way is to
> expand the reply event mechanism to track a series of values for
> EVENT_SHUTDOWN, one corresponding to each value of ShutdownCause.
>
> We are free to change the replay stream as needed, since there are
> already no guarantees about being able to use a replay stream by
> any other version of qemu than the one that generated it.
>
> The cause is not actually fed back until the next patch changes the
> signature for requesting a shutdown; a TODO marks that upcoming change.
>
> Yes, this uses the gcc/clang extension of a ranged case label,
> but this is not the first time we've used non-C99 constructs.

Not even *this* construct, as git-grep shows.

> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
