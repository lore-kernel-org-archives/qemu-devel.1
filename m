Received: from eggs.gnu.org ([2001:4830:134:3::10]:42015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1erL4r-0003wa-NW
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:04:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1erL4m-0003nM-QU
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:04:41 -0500
References: <1519760121-24594-1-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <64c99aeb-65ef-d21b-8a11-c1e467b3be39@redhat.com>
Date: Thu, 1 Mar 2018 11:04:24 +0100
MIME-Version: 1.0
In-Reply-To: <1519760121-24594-1-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2] s390/ipl: only print boot
 menu error if -boot menu=on was specified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, mihajlov@linux.vnet.ibm.com

On 27.02.2018 20:35, Collin L. Walling wrote:
> It is possible that certain QEMU configurations may not
> create an IPLB (such as when -kernel is provided). In
> this case, a misleading error message will be printed
> stating that the "boot menu is not supported for this
> device type".
> 
> To amend this, only print this message iff boot menu=on
> was provided on the commandline. Otherwise, return silently.
> 
> While we're at it, remove trailing periods from error
> messages.
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
>  hw/s390x/ipl.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
