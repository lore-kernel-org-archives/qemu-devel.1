Received: from eggs.gnu.org ([208.118.235.92]:52210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fs4Ti-0000Ys-MV
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fs4Om-0001M8-6g
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:00:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47462 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fs4Om-0001L0-0A
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:00:32 -0400
References: <1534798644-13587-1-git-send-email-minyard@acm.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dddaf613-f968-4d9e-41be-e3afb1ae3fff@redhat.com>
Date: Tue, 21 Aug 2018 13:00:23 +0200
MIME-Version: 1.0
In-Reply-To: <1534798644-13587-1-git-send-email-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] ipmi: Use proper struct reference for
 BT vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

On 20/08/2018 22:57, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> The vmstate for isa_ipmi_bt was referencing into the bt structure,
> instead create a bt structure separate and use that.
> 
> The version 1 of the BT transfer was fairly broken, if a migration
> occured during an IPMI operation, it is likely the migration would
> be corrupted because I misunderstood the VMSTATE_VBUFFER_UINT32()
> handling, I thought it handled transferring the length field,
> too.  So I just remove support for that.  I doubt anyone is using
> it at this point.
> 
> This also removes the transfer of use_irq, since that should come
> from configuration.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Queued, thanks.

Paolo
