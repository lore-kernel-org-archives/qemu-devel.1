Received: from eggs.gnu.org ([2001:4830:134:3::10]:45190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emdVb-00077S-Gc
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emdVX-0000qq-KX
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:44:51 -0500
References: <1518735273-16089-1-git-send-email-walling@linux.vnet.ibm.com>
	<1518735273-16089-3-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7b3f3c71-f987-1ccb-5e0a-beadf10f65f4@redhat.com>
Date: Fri, 16 Feb 2018 11:44:43 +0100
MIME-Version: 1.0
In-Reply-To: <1518735273-16089-3-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v6 02/12] s390-ccw: refactor
 eckd_block_num to use CHS
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

On 15.02.2018 23:54, Collin L. Walling wrote:
> Add new cylinder/head/sector struct. Use it to calculate
> eckd block numbers instead of a BootMapPointer (which used
> eckd chs anyway).
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/bootmap.c | 28 ++++++++++++++--------------
>  pc-bios/s390-ccw/bootmap.h |  8 ++++++--
>  2 files changed, 20 insertions(+), 16 deletions(-)

Still:

Reviewed-by: Thomas Huth <thuth@redhat.com>
