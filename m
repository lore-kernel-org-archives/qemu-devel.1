Received: from eggs.gnu.org ([2001:4830:134:3::10]:36249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fe4SO-0000QJ-7s
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 16:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fe4SK-00038T-9M
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 16:14:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fe4SK-00037s-2w
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 16:14:20 -0400
Date: Fri, 13 Jul 2018 17:14:17 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180713201417.GP31657@localhost.localdomain>
References: <1531416567-13558-1-git-send-email-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531416567-13558-1-git-send-email-viktor.prutyanov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2] dump: add kernel_gs_base to QEMU CPU
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, rkagan@virtuozzo.com

On Thu, Jul 12, 2018 at 08:29:27PM +0300, Viktor Prutyanov wrote:
> This patch adds field with content of KERNEL_GS_BASE MSR to QEMU note in
> ELF dump.
> 
> On Windows, if all vCPUs are running usermode tasks at the time the dump is
> created, this can be helpful in the discovery of guest system structures
> during conversion ELF dump to MEMORY.DMP dump.
> 
> Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Queued for 3.1, thanks.

-- 
Eduardo
