Received: from eggs.gnu.org ([2001:4830:134:3::10]:34820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTCUq-00026t-CF
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 16:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTCUn-0006EG-9I
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 16:36:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fTCUn-0006DJ-3B
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 16:35:57 -0400
Date: Wed, 13 Jun 2018 17:35:52 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180613203552.GO7451@localhost.localdomain>
References: <20180612184616.90838-1-mst@redhat.com>
	<20180612184616.90838-2-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612184616.90838-2-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] kvm: support -realtime cpu-pm=on|off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard Henderson <rth@twiddle.net>, kvm@vger.kernel.org

On Tue, Jun 12, 2018 at 09:47:11PM +0300, Michael S. Tsirkin wrote:
> With this flag, kvm allows guest to control host CPU power state.  This
> increases latency for other processes using same host CPU in an
> unpredictable way, but if decreases idle entry/exit times for the
> running VCPU.
> 
> Follow-up patches will expose this capability to guest
> (using mwait leaf).
> 
> Based on a patch by Wanpeng Li <kernellwp@gmail.com> .
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

The interface makes sense to me, but:

> +extern bool enable_cpu_pm;

Why do we need a global variable if initialization code can call
qemu_opt_get_bool() directly?

-- 
Eduardo
