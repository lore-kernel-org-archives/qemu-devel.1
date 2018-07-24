Received: from eggs.gnu.org ([2001:4830:134:3::10]:49023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fhvnZ-0003V1-7Z
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fhvnV-0005Xi-AX
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:48:13 -0400
References: <20180724092413.5770-1-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b4479f10-d34c-714b-89b3-895ca0aac3c9@redhat.com>
Date: Tue, 24 Jul 2018 13:48:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180724092413.5770-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1] s390x: remove 's390-squash-mcss'
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Xiao Feng Ren <renxiaof@linux.ibm.com>, qemu-devel@nongnu.org, libvir-list@redhat.com

On 24.07.2018 11:24, Cornelia Huck wrote:
> This option has been deprecated for two releases; remove it.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/3270-ccw.c                |  2 +-
>  hw/s390x/css-bridge.c              |  1 -
>  hw/s390x/css.c                     |  6 ++----
>  hw/s390x/s390-ccw.c                |  2 +-
>  hw/s390x/s390-virtio-ccw.c         | 37 ++-----------------------------------
>  hw/s390x/virtio-ccw.c              |  2 +-
>  include/hw/s390x/css-bridge.h      |  1 -
>  include/hw/s390x/css.h             |  9 +++------
>  include/hw/s390x/s390-virtio-ccw.h |  1 -
>  qemu-deprecated.texi               |  8 --------
>  qemu-options.hx                    | 10 ----------
>  target/s390x/cpu.c                 | 10 ----------
>  target/s390x/cpu.h                 |  1 -
>  13 files changed, 10 insertions(+), 80 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
