Received: from eggs.gnu.org ([2001:4830:134:3::10]:45838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fWRu6-0006or-6c
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fWRu1-00008h-Q4
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:39:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49482 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fWRu1-00008Y-KX
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:39:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 365E368801
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 19:39:25 +0000 (UTC)
References: <20180622165159.19863-1-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <87c879ad-5278-a281-fd65-73c141f6d2dd@redhat.com>
Date: Fri, 22 Jun 2018 15:39:23 -0400
MIME-Version: 1.0
In-Reply-To: <20180622165159.19863-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] ahci: fix FIS I bit and PIO Setup FIS
 interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com



On 06/22/2018 12:51 PM, Paolo Bonzini wrote:
> The "I" bit in PIO Setup and D2H FISes is exclusively a device concept
> and the irqstatus register in the controller does not matter.  The SATA
> spec says when it should be one; for D2H FISes in practice it is always
> set, while the PIO Setup FIS has several subcases that are documented in
> the patch.
> 
> Also, the PIO Setup FIS interrupt is actually generated _after_ data
> has been received.
> 
> Someone should probably spend some time reading the SATA specification and
> figuring out the more obscure fields in the PIO Setup FIS, but this is enough
> to fix SeaBIOS booting from ATAPI CD-ROMs over an AHCI controller.
> 
> Fixes: 956556e131e35f387ac482ad7b41151576fef057
> Reported-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks, applied to my IDE tree:

https://github.com/jnsnow/qemu/commits/ide
https://github.com/jnsnow/qemu.git

--js
