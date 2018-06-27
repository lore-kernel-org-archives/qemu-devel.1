Received: from eggs.gnu.org ([2001:4830:134:3::10]:52686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYAE6-0005HW-G1
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:11:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYAE5-00016d-Np
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:11:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35234 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYAE5-00015v-Gf
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:11:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6E1724001389
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 13:11:12 +0000 (UTC)
References: <20171229073104.3810-1-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1d6f848e-1727-21cb-8792-bf4b3f1c1bfd@redhat.com>
Date: Wed, 27 Jun 2018 15:11:10 +0200
MIME-Version: 1.0
In-Reply-To: <20171229073104.3810-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] ioapic: support
 TYPE_INTERRUPT_STATS_PROVIDER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>

On 29/12/2017 08:30, Peter Xu wrote:
> Let ioapic join the big family.  At last, I obsoleted "info ioapic",
> kept the interface but telling people to start use "info pic".  We can
> fully remove it after some releases.
> 
> Please review, thanks.
> 
> Peter Xu (5):
>   doc: another fix to "info pic"
>   ioapic: support "info pic"
>   ioapic: some proper indents when dump info
>   ioapic: support "info irq"
>   hmp: obsolete "info ioapic"
> 
>  hmp-commands-info.hx              |  2 +-
>  hw/i386/kvm/ioapic.c              | 11 ++-------
>  hw/intc/ioapic.c                  | 12 +---------
>  hw/intc/ioapic_common.c           | 47 +++++++++++++++++++++++++++++++++++----
>  include/hw/i386/ioapic_internal.h |  3 +++
>  include/hw/i386/pc.h              |  3 ---
>  target/i386/monitor.c             |  8 ++-----
>  7 files changed, 52 insertions(+), 34 deletions(-)
> 

Queued, better late than never.

Paolo
