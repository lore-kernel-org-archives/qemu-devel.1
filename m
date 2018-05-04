Received: from eggs.gnu.org ([2001:4830:134:3::10]:58858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEUrF-0000QF-LA
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEUrB-0007Fs-Rp
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:10:21 -0400
Date: Fri, 4 May 2018 09:10:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180504091007.55405a6a.cohuck@redhat.com>
In-Reply-To: <1525376963-79623-61-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-61-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 60/67] hw/s390x: add include directory
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org

On Thu, 3 May 2018 22:51:40 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> This way they are easier to find using standard rules.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/hw/s390x/ccw-device.h        | 1 +
>  include/hw/s390x/ipl.h               | 1 +
>  include/hw/s390x/s390-pci-bus.h      | 1 +
>  include/hw/s390x/s390-pci-inst.h     | 1 +
>  include/hw/s390x/s390-virtio-hcall.h | 1 +
>  include/hw/s390x/virtio-ccw.h        | 1 +
>  6 files changed, 6 insertions(+)
>  create mode 100644 include/hw/s390x/ccw-device.h
>  create mode 100644 include/hw/s390x/ipl.h
>  create mode 100644 include/hw/s390x/s390-pci-bus.h
>  create mode 100644 include/hw/s390x/s390-pci-inst.h
>  create mode 100644 include/hw/s390x/s390-virtio-hcall.h
>  create mode 100644 include/hw/s390x/virtio-ccw.h
> 
> diff --git a/include/hw/s390x/ccw-device.h b/include/hw/s390x/ccw-device.h
> new file mode 100644
> index 0000000..ab761b3
> --- /dev/null
> +++ b/include/hw/s390x/ccw-device.h
> @@ -0,0 +1 @@
> +#include_next "../hw/s390x/ccw-device.h"

Eww. I find this very ugly.

[Goes to find cover letter to figure out what this is all about.
*Please*, cc: people on the cover letter so they can see immediately
what this is trying to do!]

After reading the cover letter, I still don't like this. If you want to
move headers under include/ (which I don't have a problem with), please
move them and do not introduce these weird constructs.

[Also, that might need a MAINTAINERS update :)]
