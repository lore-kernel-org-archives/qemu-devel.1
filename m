Received: from eggs.gnu.org ([2001:4830:134:3::10]:45117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cqx8O-0005NS-DT
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 03:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cqx8L-00070y-AR
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 03:26:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cqx8L-00070q-4Z
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 03:26:09 -0400
Date: Thu, 23 Mar 2017 15:26:04 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170323072436.GE4224@pxdev.xzpeter.org>
References: <20170322121344.5484-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170322121344.5484-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Revert "apic: save apic_delivered flag"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On Wed, Mar 22, 2017 at 01:13:44PM +0100, Paolo Bonzini wrote:
> This reverts commit 07bfa354772f2de67008dc66c201b627acff0106.
> The global variable is only read as part of a
> 
>             apic_reset_irq_delivered();
>             qemu_irq_raise(s->irq);
>             if (!apic_get_irq_delivered()) {
> 
> sequence, so the value never matters at migration time.
> 
> Reported-by: Dr. David Alan Gilbert <dglibert@redhat.com>
> Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- peterx
