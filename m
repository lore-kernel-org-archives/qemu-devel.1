Received: from eggs.gnu.org ([2001:4830:134:3::10]:47463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePXWK-0000z1-Eg
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:42:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePXWJ-0003Qr-K8
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:42:08 -0500
Date: Thu, 14 Dec 2017 18:41:57 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171214184157.21fbe3b8.cohuck@redhat.com>
In-Reply-To: <1513030760-26245-3-git-send-email-walling@linux.vnet.ibm.com>
References: <1513030760-26245-1-git-send-email-walling@linux.vnet.ibm.com>
	<1513030760-26245-3-git-send-email-walling@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] s390-ccw: ipl structs for eckd
 cdl/ldl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, thuth@redhat.com, david@redhat.com

On Mon, 11 Dec 2017 17:19:17 -0500
"Collin L. Walling" <walling@linux.vnet.ibm.com> wrote:

> ECKD DASDs have different IPL structures for CDL and LDL
> formats. The current Ipl1 and Ipl2 structs follow the CDL
> format, so we prepend "EckdCdl" to them. Boot info for LDL
> has been moved to a new struct: EckdLdlIpl1.
> 
> Also introduce structs for IPL stages 1 and 1b and for
> disk geometry.
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/bootmap.c | 24 ++++++++++----------
>  pc-bios/s390-ccw/bootmap.h | 55 +++++++++++++++++++++++++++++++++-------------
>  2 files changed, 53 insertions(+), 26 deletions(-)
> 

> +    mbr_block_nr =
> +        eckd_block_num((void *)&(ipl1->boot_info.bp.ipl.bm_ptr.eckd.bptr));

Let me nominate this as "crazy nested struct of the week".

(Just kidding, your patch certainly improves things in general :)


> +typedef struct EckdSeekarg {
> +    uint16_t pad;
> +    uint16_t cyl;
> +    uint16_t head;
> +    uint8_t sec;
> +    uint8_t pad2;
> +} __attribute__ ((packed)) EckdSeekarg;

Maybe make this EckdSeekArg?
