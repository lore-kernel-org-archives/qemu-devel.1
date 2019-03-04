Received: from eggs.gnu.org ([209.51.188.92]:37351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0rgC-0000Aq-7d
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:47:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0rgB-0000AO-GP
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:47:08 -0500
Date: Mon, 4 Mar 2019 18:46:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190304184659.3ca35a01.cohuck@redhat.com>
In-Reply-To: <1551466776-29123-9-git-send-email-jjherne@linux.ibm.com>
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-9-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 08/16] s390-bios: Map low core memory
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

On Fri,  1 Mar 2019 13:59:28 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> Create a new header for basic architecture specific definitions and add a
> mapping of low core memory. This mapping will be used by the real dasd boot
> process.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/main.c      |   2 +
>  pc-bios/s390-ccw/s390-arch.h | 102 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 104 insertions(+)
>  create mode 100644 pc-bios/s390-ccw/s390-arch.h

I did not check all fields, but looks sane.

Acked-by: Cornelia Huck <cohuck@redhat.com>
