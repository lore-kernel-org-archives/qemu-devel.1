Received: from eggs.gnu.org ([2001:4830:134:3::10]:53035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsQlV-0006eH-1Y
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 05:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsQlU-0001uu-4o
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 05:48:57 -0400
Date: Thu, 14 Sep 2017 10:48:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170914094838.GA3982@work-vm>
References: <20170913142036.2469-1-lvivier@redhat.com>
	<20170913142036.2469-4-lvivier@redhat.com>
	<20170913162709.3933352d.cohuck@redhat.com>
	<32c345ab-ce02-fe29-1587-db863fb21209@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32c345ab-ce02-fe29-1587-db863fb21209@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/4] dump: do not dump non-existent
 guest memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

* Laurent Vivier (lvivier@redhat.com) wrote:
> On 13/09/2017 16:27, Cornelia Huck wrote:
> > On Wed, 13 Sep 2017 16:20:35 +0200
> > Laurent Vivier <lvivier@redhat.com> wrote:
> > 
> >> From: Cornelia Huck <cohuck@redhat.com>
> >>
> >> It does not really make sense to dump memory that is not there.
> >>
> >> Moreover, that fixes a segmentation fault when calling dump-guest-memory
> >> with no filter for a machine with no memory defined.
> >>
> >> New behaviour is:
> >>
> >> (qemu) dump-guest-memory /dev/null
> >> dump: no guest memory to dump
> >> (qemu) dump-guest-memory /dev/null 0 4096
> >> dump: no guest memory to dump
> >>
> >> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >> Tested-by: Laurent Vivier <lvivier@redhat.com>
> >> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> >> Reviewed-by: Greg Kurz <groug@kaod.org>
> >> Reviewed-by: Peter Xu <peterx@redhat.com>
> >> ---
> >>  dump.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> > 
> > You need to supply your s-o-b as well, no?
> > 
> 
> I was wondering... theoretically, yes, so:
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Thanks.

Dave

> Thanks,
> Laurent
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
