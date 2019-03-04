Received: from eggs.gnu.org ([209.51.188.92]:38309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0rkk-0003gF-9s
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0rki-00047p-Oj
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:51:50 -0500
Date: Mon, 4 Mar 2019 18:51:42 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190304185142.79945476.cohuck@redhat.com>
In-Reply-To: <1551466776-29123-17-git-send-email-jjherne@linux.ibm.com>
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-17-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 16/16] s390-bios: dasd-ipl: Use control
 unit type to customize error data
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

On Fri,  1 Mar 2019 13:59:36 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> Propagate control unit type from main through the dasd ipl call chain.
> The control unit type can be used to determine if we are attempting to
> boot from a real dasd device. If something goes wrong we'll want to print
> detailed dasd sense data (for diagnostic use) but only if we're attempting
> to boot from a real dasd device.
> 
> Note: We also query and print the dasd sense data if we fail while
> attempting to determine the control unit type. In this case, we don't know
> if we're dealing with a real dasd device yet, but if we are, then the sense
> data may be useful for figuring out what went wrong. Since determining
> the control unit type is the very first thing we do with any real dasd device,
> this is our most likely point of failure.

Yeah, it probably does not hurt to print it out, even if it isn't
correct. If there's a non-dasd specific error, it's likely in the first
sense byte anyway.

> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/cio.c      | 16 ++++++++++------
>  pc-bios/s390-ccw/cio.h      |  6 ++++--
>  pc-bios/s390-ccw/dasd-ipl.c | 25 +++++++++++++------------
>  pc-bios/s390-ccw/dasd-ipl.h |  2 +-
>  pc-bios/s390-ccw/main.c     |  2 +-
>  pc-bios/s390-ccw/virtio.c   |  2 +-
>  6 files changed, 30 insertions(+), 23 deletions(-)

I think it would make sense to squash this into the patches you
mentioned in the cover letter in the next version.
