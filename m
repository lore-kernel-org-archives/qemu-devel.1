Received: from eggs.gnu.org ([209.51.188.92]:42073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3OuX-0001jW-P5
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3OuU-0000wP-H2
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:40:23 -0400
Date: Mon, 11 Mar 2019 18:39:11 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190311183911.3f0cdef8.cohuck@redhat.com>
In-Reply-To: <1552317693-21979-8-git-send-email-jjherne@linux.ibm.com>
References: <1552317693-21979-1-git-send-email-jjherne@linux.ibm.com>
	<1552317693-21979-8-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 07/15] s390-bios: Decouple channel i/o
 logic from virtio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On Mon, 11 Mar 2019 11:21:25 -0400
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> Create a separate library for channel i/o related code. This decouples
> channel i/o operations from virtio and allows us to make use of them for
> the real dasd boot path.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/Makefile    |  2 +-
>  pc-bios/s390-ccw/cio.c       | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/cio.h       |  3 +++
>  pc-bios/s390-ccw/main.c      |  1 +
>  pc-bios/s390-ccw/netboot.mak |  2 +-
>  pc-bios/s390-ccw/netmain.c   |  1 +
>  pc-bios/s390-ccw/s390-ccw.h  |  1 -
>  pc-bios/s390-ccw/virtio.c    | 27 ++-------------------------
>  8 files changed, 53 insertions(+), 28 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/cio.c

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
