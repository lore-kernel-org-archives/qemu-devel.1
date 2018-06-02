Received: from eggs.gnu.org ([2001:4830:134:3::10]:58861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOuPG-0007LQ-TH
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 20:28:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOuPG-0005nA-4i
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 20:28:30 -0400
References: <20180417153945.20737-1-pbonzini@redhat.com>
	<20180417153945.20737-5-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <1967c506-7271-31f9-9789-3303026a1837@redhat.com>
Date: Fri, 1 Jun 2018 20:28:24 -0400
MIME-Version: 1.0
In-Reply-To: <20180417153945.20737-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/6] ide: make ide_transfer_stop idempotent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org



On 04/17/2018 11:39 AM, Paolo Bonzini wrote:
> There is code checking s->end_transfer_func and it was not taught about
> ide_transfer_cancel.  We can just use ide_transfer_stop because
> s->end_transfer_func is only ever called in the DRQ phase.
> 
> ide_transfer_cancel can then be removed, since it would just be
> calling ide_transfer_halt.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>
