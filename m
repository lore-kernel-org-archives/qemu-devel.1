Received: from eggs.gnu.org ([2001:4830:134:3::10]:33593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYAjZ-0005mS-G2
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYAjU-0004bU-LN
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:43:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fYAjU-0004ax-GI
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:43:40 -0400
Date: Wed, 27 Jun 2018 10:43:35 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180627134335.GC914@localhost.localdomain>
References: <20180622192148.178309-1-mst@redhat.com>
	<20180622192148.178309-2-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622192148.178309-2-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/2] kvm: support -overcommit
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, Richard Henderson <rth@twiddle.net>

On Fri, Jun 22, 2018 at 10:22:05PM +0300, Michael S. Tsirkin wrote:
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

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
