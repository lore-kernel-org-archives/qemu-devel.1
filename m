Received: from eggs.gnu.org ([209.51.188.92]:39828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMUan-0000SA-H1
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMUam-0003EH-KS
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:34:57 -0400
References: <1556543381-12671-1-git-send-email-jjherne@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2913f865-2119-f6cf-b2f8-b22d351fcca1@redhat.com>
Date: Fri, 3 May 2019 11:34:49 +0200
MIME-Version: 1.0
In-Reply-To: <1556543381-12671-1-git-send-email-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390-bios: Skip bootmap signature entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 29/04/2019 15.09, Jason J. Herne wrote:
> Newer versions of zipl have the ability to write signature entries to the boot
> script for secure boot. We don't yet support secure boot, but we need to skip
> over signature entries while reading the boot script in order to maintain our
> ability to boot guest operating systems that have a secure bootloader.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/bootmap.c | 19 +++++++++++++++++--
>  pc-bios/s390-ccw/bootmap.h | 10 ++++++----
>  2 files changed, 23 insertions(+), 6 deletions(-)

Acked-by: Thomas Huth <thuth@redhat.com>

Jason, Christian, do you have any other changes to the s390-ccw firmware
currently pending that you plan to send out within the next week? If so,
I'll wait a little bit longer with building a new binary for the
repository ... if not, I'll pick this patch up next week.

 Thomas
