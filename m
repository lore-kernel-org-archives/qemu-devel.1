Received: from eggs.gnu.org ([2001:4830:134:3::10]:38136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds8dS-00029d-7G
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:27:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds8dR-0000IU-Cm
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:27:26 -0400
Date: Wed, 13 Sep 2017 16:27:09 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170913162709.3933352d.cohuck@redhat.com>
In-Reply-To: <20170913142036.2469-4-lvivier@redhat.com>
References: <20170913142036.2469-1-lvivier@redhat.com>
	<20170913142036.2469-4-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

On Wed, 13 Sep 2017 16:20:35 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> From: Cornelia Huck <cohuck@redhat.com>
> 
> It does not really make sense to dump memory that is not there.
> 
> Moreover, that fixes a segmentation fault when calling dump-guest-memory
> with no filter for a machine with no memory defined.
> 
> New behaviour is:
> 
> (qemu) dump-guest-memory /dev/null
> dump: no guest memory to dump
> (qemu) dump-guest-memory /dev/null 0 4096
> dump: no guest memory to dump
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> Tested-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  dump.c | 6 ++++++
>  1 file changed, 6 insertions(+)

You need to supply your s-o-b as well, no?
