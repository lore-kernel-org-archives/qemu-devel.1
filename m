Received: from eggs.gnu.org ([2001:4830:134:3::10]:52286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eokEW-0008Gf-Ab
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 01:19:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eokES-0004OT-AP
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 01:19:56 -0500
References: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
	<1519241752-28083-12-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <147f3c25-486c-44d8-adf6-93487d3dda5f@redhat.com>
Date: Thu, 22 Feb 2018 07:19:29 +0100
MIME-Version: 1.0
In-Reply-To: <1519241752-28083-12-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v8 11/13] s390-ccw: set
 cp_receive mask only when needed and consume pending service irqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, mihajlov@linux.vnet.ibm.com, borntraeger@de.ibm.com, eblake@redhat.com

On 21.02.2018 20:35, Collin L. Walling wrote:
> It is possible while waiting for multiple types of external
> interrupts that we might have pending irqs remaining between
> irq consumption and irq-type disabling. Those interrupts
> could potentially propagate to the guest after IPL completes
> and cause unwanted behavior.
> 
> As it is today, the SCLP will only recognize write events that
> are enabled by the control program's send and receive masks. To
> limit the window for, and prevent further irqs from, ASCII
> console events (specifically keystrokes), we should only enable
> the control program's receive mask when we need it.
> 
> While we're at it, remove assignment of the (non control program)
> send and receive masks, as those are actually set by the SCLP.
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/menu.c     |  5 +++++
>  pc-bios/s390-ccw/s390-ccw.h |  1 +
>  pc-bios/s390-ccw/sclp.c     | 10 ++++------
>  3 files changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
