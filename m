Received: from eggs.gnu.org ([2001:4830:134:3::10]:49717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fk8Sw-0006hq-0s
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:44:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fk8Ss-00019l-TC
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:44:02 -0400
Date: Mon, 30 Jul 2018 15:43:43 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180730154343.4f7f5938.cohuck@redhat.com>
In-Reply-To: <20180724092413.5770-1-cohuck@redhat.com>
References: <20180724092413.5770-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: qemu-s390x@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Xiao Feng Ren <renxiaof@linux.ibm.com>, qemu-devel@nongnu.org, libvir-list@redhat.com

On Tue, 24 Jul 2018 11:24:13 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

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

Queued to s390-next.
