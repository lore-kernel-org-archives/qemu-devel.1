Received: from eggs.gnu.org ([2001:4830:134:3::10]:58136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eoiXL-0005Og-2F
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 23:31:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eoiXH-0007rz-V8
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 23:31:15 -0500
References: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
	<1519241752-28083-5-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7f359122-94d9-dc41-6cba-eef756df2c82@redhat.com>
Date: Thu, 22 Feb 2018 05:30:58 +0100
MIME-Version: 1.0
In-Reply-To: <1519241752-28083-5-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v8 04/13] s390-ccw: update libc
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
> Moved:
>   memcmp from bootmap.h to libc.h (renamed from _memcmp)
>   strlen from sclp.c to libc.h (renamed from _strlen)
> 
> Added C standard functions:
>   isdigit
> 
> Added non C-standard function:
>   uitoa
>   atoui
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/Makefile  |  2 +-
>  pc-bios/s390-ccw/bootmap.c |  4 +--
>  pc-bios/s390-ccw/bootmap.h | 16 +--------
>  pc-bios/s390-ccw/libc.c    | 88 ++++++++++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/libc.h    | 37 +++++++++++++++++--
>  pc-bios/s390-ccw/main.c    | 17 +--------
>  pc-bios/s390-ccw/sclp.c    | 10 +-----
>  7 files changed, 129 insertions(+), 45 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/libc.c

Reviewed-by: Thomas Huth <thuth@redhat.com>
