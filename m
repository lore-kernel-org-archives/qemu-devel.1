Received: from eggs.gnu.org ([2001:4830:134:3::10]:59795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eiwJZ-0001ca-0H
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 01:01:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eiwJV-0007Sk-RS
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 01:01:09 -0500
References: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
	<1517864246-11101-3-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2f26dc90-50b0-6317-a55d-abec5904abde@redhat.com>
Date: Tue, 6 Feb 2018 07:00:56 +0100
MIME-Version: 1.0
In-Reply-To: <1517864246-11101-3-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5 02/12] s390-ccw: refactor
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

On 05.02.2018 21:57, Collin L. Walling wrote:
> Add new cylinder/head/sector struct. Use it to calculate
> eckd block numbers instead of a BootMapPointer (which used
> eckd chs anyway).
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/bootmap.c | 28 ++++++++++++++--------------
>  pc-bios/s390-ccw/bootmap.h |  8 ++++++--
>  2 files changed, 20 insertions(+), 16 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
