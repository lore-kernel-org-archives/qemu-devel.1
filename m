Received: from eggs.gnu.org ([2001:4830:134:3::10]:50147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fXN7p-0007RE-WE
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 04:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fXN7l-0003Ma-To
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 04:45:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32942 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fXN7l-0003LI-Mj
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 04:45:25 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180622190936.177827-2-mst@redhat.com> (Michael S. Tsirkin's
	message of "Fri, 22 Jun 2018 22:09:42 +0300")
References: <20180622190936.177827-1-mst@redhat.com>
	<20180622190936.177827-2-mst@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 25 Jun 2018 10:48:47 +0200
Message-ID: <87wounjlow.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 1/2] kvm: support -overcommit
 cpu-pm=on|off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

"Michael S. Tsirkin" <mst@redhat.com> wrote:
> With this flag, kvm allows guest to control host CPU power state.  This
> increases latency for other processes using same host CPU in an
> unpredictable way, but if decreases idle entry/exit times for the
> running VCPU, so to use it QEMU needs a hint about whether host CPU is
> overcommitted, hence the flag name.
>
> Follow-up patches will expose this capability to guest
> (using mwait leaf).
>
> Based on a patch by Wanpeng Li <kernellwp@gmail.com> .
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

[...]

> diff --git a/migration/migration.c b/migration/migration.c
> index 1e99ec9b7e..e468b50c4f 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -45,6 +45,7 @@
>  #include "migration/colo.h"
>  #include "hw/boards.h"
>  #include "monitor/monitor.h"
> +#include "qemu/ptr_ring.h"
>  
>  #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
>  

Why is this chuck needed?  I can't see a reason.


Thanks, Juan.
