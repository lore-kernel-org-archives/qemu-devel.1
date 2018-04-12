Received: from eggs.gnu.org ([2001:4830:134:3::10]:57615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6h3c-0004Gt-F2
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 14:34:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6h3Z-0006td-Bs
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 14:34:52 -0400
References: <1523372486-13190-1-git-send-email-walling@linux.ibm.com>
	<1523372486-13190-2-git-send-email-walling@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <aabf8550-46a7-a528-4bac-fa6f66be0520@redhat.com>
Date: Thu, 12 Apr 2018 20:34:31 +0200
MIME-Version: 1.0
In-Reply-To: <1523372486-13190-2-git-send-email-walling@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] pc-bios/s390-ccw: rename
 MAX_TABLE_ENTRIES to MAX_BOOT_ENTRIES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, borntraeger@de.ibm.com
Cc: gor@linux.ibm.com, frankja@linux.ibm.com

On 10.04.2018 17:01, Collin Walling wrote:
> The MAX_TABLE_ENTRIES constant has a name that is too generic. As we
> want to declare a limit for boot menu entries, let's rename it to a more
> fitting MAX_BOOT_ENTRIES and set its value to 31 (30 boot entries and
> 1 default entry). Also we move it from bootmap.h to s390-ccw.h to make
> it available for menu.c in a later patch.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/bootmap.c  | 6 +++---
>  pc-bios/s390-ccw/bootmap.h  | 2 --
>  pc-bios/s390-ccw/s390-ccw.h | 2 ++
>  3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
