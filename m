Received: from eggs.gnu.org ([2001:4830:134:3::10]:55085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZixT-0003Bm-0V
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:51:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZixP-00040u-UO
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:51:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cZixP-00040k-O6
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:51:39 -0500
References: <1486106298-3699-1-git-send-email-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <701dced8-f44b-1170-55f3-34cb9e193940@redhat.com>
Date: Fri, 3 Feb 2017 10:51:33 -0800
MIME-Version: 1.0
In-Reply-To: <1486106298-3699-1-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] kvm/ioapic: some tiny tweaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>



On 02/02/2017 23:18, Peter Xu wrote:
> This series fixes the issue pointed out by PMM in thread:
> 
>   https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg06323.html
> 
> Along with other two patches to make the version more accurate. Thanks,
> 
> Peter Xu (3):
>   kvm/ioapic: dump real object instead of a fake one
>   ioapic: fix error report value of def version
>   kvm/ioapic: correct kvm ioapic version
> 
>  hw/i386/kvm/ioapic.c | 13 +++++++++----
>  hw/intc/ioapic.c     |  6 ++++--
>  2 files changed, 13 insertions(+), 6 deletions(-)
> 

Queued, thanks.

Paolo
