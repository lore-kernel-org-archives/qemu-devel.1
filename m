Received: from eggs.gnu.org ([2001:4830:134:3::10]:50203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fbLNY-0001xt-B2
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 03:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fbLNV-0000RM-7l
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 03:42:08 -0400
Date: Fri, 6 Jul 2018 09:42:00 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180706094200.722366d0.cohuck@redhat.com>
In-Reply-To: <1530811543-6881-9-git-send-email-jjherne@linux.ibm.com>
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-9-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 08/15] s390-bios: Map low core memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

On Thu,  5 Jul 2018 13:25:36 -0400
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
> 
> Create a new header for basic architecture specific definitions and add a
> mapping of low core memory. This mapping will be used by the real dasd boot
> process.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>

Just a common nit: You may want to change your setup (and update the
Author: field of the patches) so you don't get those weird double
signoffs.

> ---
>  pc-bios/s390-ccw/main.c      |   2 +
>  pc-bios/s390-ccw/s390-arch.h | 100 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 102 insertions(+)
>  create mode 100644 pc-bios/s390-ccw/s390-arch.h
