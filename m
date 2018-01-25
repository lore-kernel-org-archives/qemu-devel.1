Received: from eggs.gnu.org ([2001:4830:134:3::10]:51655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eejPZ-0006k7-23
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:25:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eejPW-0007QE-EJ
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:25:57 -0500
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516732013-18272-8-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6d81c288-2b93-35b4-fb27-24276342089d@redhat.com>
Date: Thu, 25 Jan 2018 16:25:06 +0100
MIME-Version: 1.0
In-Reply-To: <1516732013-18272-8-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 07/10] s390-ccw: read stage2 boot loader
 data to find menu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com

On 23.01.2018 19:26, Collin L. Walling wrote:
> Read the stage2 boot loader data block-by-block. We scan the
> current block for the string "zIPL" to detect the start of the
> boot menu banner. We then load the adjacent blocks (previous
> block and next block) to account for the possibility of menu
> data spanning multiple blocks.
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/bootmap.c | 94 +++++++++++++++++++++++++++++++++++++++++++---
>  pc-bios/s390-ccw/bootmap.h |  1 +
>  pc-bios/s390-ccw/menu.c    |  5 +++
>  pc-bios/s390-ccw/menu.h    |  1 +
>  4 files changed, 96 insertions(+), 5 deletions(-)

Looks good to me now!

Reviewed-by: Thomas Huth <thuth@redhat.com>
