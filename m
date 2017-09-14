Received: from eggs.gnu.org ([2001:4830:134:3::10]:53673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsQmq-0007df-Ho
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 05:50:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsQmp-0003pS-NX
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 05:50:20 -0400
Date: Thu, 14 Sep 2017 10:50:01 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170914095000.GB3982@work-vm>
References: <20170913142036.2469-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913142036.2469-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/4] hmp: fix "dump-quest-memory"
 segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, peterx@redhat.com

* Laurent Vivier (lvivier@redhat.com) wrote:
> Fix aarch64 and ppc when dump-guest-memory is
> used with none machine type and no CPU.
> 
> The other machine types don't have the problem.
> 
> Update test-hmp, to test none machine type
> with (2 MB) and without memory, and add a test
> to test dump-quest-memory without filter parameters

Queued for HMP

Dave

> 
> v4:
>   - update comment in test-hmp.c
>   - add cohuck's patch
> 
> v3:
>   - remove blank line after a comment
>   - forbid memory dump when there is no CPU
> 
> v2:
>   - add arm fix
>   - update test-hmp
> 
> Cornelia Huck (1):
>   dump: do not dump non-existent guest memory
> 
> Laurent Vivier (3):
>   hmp: fix "dump-quest-memory" segfault (ppc)
>   hmp: fix "dump-quest-memory" segfault (arm)
>   tests/hmp: test "none" machine with memory
> 
>  dump.c                 |  6 ++++++
>  target/arm/arch_dump.c | 11 +++++++++--
>  target/ppc/arch_dump.c | 11 +++++++++--
>  tests/test-hmp.c       |  4 ++++
>  4 files changed, 28 insertions(+), 4 deletions(-)
> 
> -- 
> 2.13.5
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
