Received: from eggs.gnu.org ([2001:4830:134:3::10]:37798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fWQu4-0000OZ-VI
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 14:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fWQu1-00028m-H8
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 14:35:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fWQu1-00028E-Au
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 14:35:21 -0400
Date: Fri, 22 Jun 2018 15:35:16 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180622183516.GC7451@localhost.localdomain>
References: <20180622003140.164613-1-mst@redhat.com>
	<20180622003140.164613-3-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622003140.164613-3-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/2] i386/cpu: make -cpu host support
 monitor/mwait
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org

On Fri, Jun 22, 2018 at 03:31:48AM +0300, Michael S. Tsirkin wrote:
> When guest CPU PM is enabled, and with -cpu host, expose the host CPU
> MWAIT leaf in the CPUID so guest can make good PM decisions.
> 
> Note: the result is 100% CPU utilization reported by host as host
> no longer knows that the CPU is halted.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
