Received: from eggs.gnu.org ([2001:4830:134:3::10]:51260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffArX-0006EE-Gc
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffArS-0000tp-JP
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:16:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ffArS-0000tQ-CY
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:16:50 -0400
Date: Mon, 16 Jul 2018 18:16:47 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180716211647.GQ914@localhost.localdomain>
References: <20180714123000.11326-1-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180714123000.11326-1-viktor.prutyanov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v3] dump: add kernel_gs_base to QEMU CPU
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rkagan@virtuozzo.com, rth@twiddle.net

On Sat, Jul 14, 2018 at 03:30:00PM +0300, Viktor Prutyanov wrote:
> This patch adds field with content of KERNEL_GS_BASE MSR to QEMU note in
> ELF dump.
> 
> On Windows, if all vCPUs are running usermode tasks at the time the dump is
> created, this can be helpful in the discovery of guest system structures
> during conversion ELF dump to MEMORY.DMP dump.
> 
> Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>

Queued for 3.1, thanks.

-- 
Eduardo
