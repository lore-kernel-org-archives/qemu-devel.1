Received: from eggs.gnu.org ([209.51.188.92]:50190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hCHpO-00080t-Uj
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 01:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hCHp0-0000cZ-PU
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 01:55:27 -0400
References: <1554388475-18329-1-git-send-email-jjherne@linux.ibm.com>
	<1554388475-18329-17-git-send-email-jjherne@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <15d1851a-be5c-b816-56f3-cd31fb42f992@redhat.com>
Date: Fri, 5 Apr 2019 07:55:22 +0200
MIME-Version: 1.0
In-Reply-To: <1554388475-18329-17-git-send-email-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 16/16] s390-bios: Use control unit type
 to find bootable devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 04/04/2019 16.34, Jason J. Herne wrote:
> When the user does not specify which device to boot from then we end
> up guessing. Instead of simply grabbing the first available device let's
> be a little bit smarter and only choose devices that might be bootable
> like disk, and not console devices.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/main.c | 38 ++++++++++++++++++++++++++++----------
>  1 file changed, 28 insertions(+), 10 deletions(-)

Thanks for adding this patch, the problem with -device x-terminal3270 is
fixed now, indeed.

Reviewed-by: Thomas Huth <thuth@redhat.com>
