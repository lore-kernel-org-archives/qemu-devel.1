Received: from eggs.gnu.org ([2001:4830:134:3::10]:46713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e3zUM-0004UN-OM
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 03:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e3zUJ-0005E2-Kv
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 03:07:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e3zUJ-0005DV-FC
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 03:06:59 -0400
Date: Mon, 16 Oct 2017 15:06:52 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171016070652.GA4166@pxdev.xzpeter.org>
References: <20171016065216.18162-1-peterx@redhat.com>
	<20171016065216.18162-32-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171016065216.18162-32-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 31/32] migration,
 qmp: new command "migrate-pause"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Andrea Arcangeli <aarcange@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Oct 16, 2017 at 02:52:15PM +0800, Peter Xu wrote:

[...]

> +# @migrate-pause:
> +#
> +# Pause an migration.  Currently it can only pause a postcopy
> +# migration.  Pausing a precopy migration is not supported yet.
> +#
> +# It is mostly used as a manual way to trigger the postcopy paused
> +# state when the network sockets hang due to some reason, so that we
> +# can try a recovery afterward.
> +#
> +# Returns: nothing on success
> +#
> +# Since: 2.10

Ouch! I believe this should be for 2.11.

-- 
Peter Xu
