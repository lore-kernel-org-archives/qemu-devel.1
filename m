Received: from eggs.gnu.org ([209.51.188.92]:60194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gpGzd-0004AY-0a
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:23:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gpGzb-0000sB-Ov
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:23:16 -0500
Date: Thu, 31 Jan 2019 19:23:09 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190131192309.35caa736.cohuck@redhat.com>
In-Reply-To: <1548768562-20007-16-git-send-email-jjherne@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-16-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/15] s390-bios: Support booting from real
 dasd device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On Tue, 29 Jan 2019 08:29:22 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> Allows guest to boot from a vfio configured real dasd device.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  docs/devel/s390-dasd-ipl.txt | 132 +++++++++++++++++++++++
>  pc-bios/s390-ccw/Makefile    |   2 +-
>  pc-bios/s390-ccw/dasd-ipl.c  | 249 +++++++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/dasd-ipl.h  |  16 +++
>  pc-bios/s390-ccw/main.c      |   4 +
>  pc-bios/s390-ccw/s390-arch.h |  13 +++
>  6 files changed, 415 insertions(+), 1 deletion(-)
>  create mode 100644 docs/devel/s390-dasd-ipl.txt

This file should probably be added to the s390-ccw boot section in
MAINTAINERS (the other new files are already covered.)

>  create mode 100644 pc-bios/s390-ccw/dasd-ipl.c
>  create mode 100644 pc-bios/s390-ccw/dasd-ipl.h
