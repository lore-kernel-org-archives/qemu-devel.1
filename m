Received: from eggs.gnu.org ([209.51.188.92]:59365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gpGxG-0002Df-5S
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:20:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gpGxF-0007r3-DC
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:20:50 -0500
Date: Thu, 31 Jan 2019 19:20:42 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190131192042.7d964a92.cohuck@redhat.com>
In-Reply-To: <1548768562-20007-2-git-send-email-jjherne@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-2-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/15] s390 vfio-ccw: Add bootindex
 property and IPLB data
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

On Tue, 29 Jan 2019 08:29:08 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> Add bootindex property and iplb data for vfio-ccw devices. This allows us to
> forward boot information into the bios for vfio-ccw devices.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/ipl.c              | 14 ++++++++++++++
>  hw/s390x/s390-ccw.c         |  9 +++++++++
>  hw/vfio/ccw.c               | 13 +------------
>  include/hw/s390x/s390-ccw.h |  1 +
>  include/hw/s390x/vfio-ccw.h | 38 ++++++++++++++++++++++++++++++++++++++

This split-out file should probably go into the vfio-ccw section in
MAINTAINERS as well.

>  5 files changed, 63 insertions(+), 12 deletions(-)
>  create mode 100644 include/hw/s390x/vfio-ccw.h
