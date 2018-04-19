Received: from eggs.gnu.org ([2001:4830:134:3::10]:55415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f986i-0001mW-Mm
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f986e-00065d-NS
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:52:08 -0400
Date: Thu, 19 Apr 2018 13:51:50 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180419135150.7bbc667d.cohuck@redhat.com>
In-Reply-To: <1523819244-29954-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1523819244-29954-1-git-send-email-akrowiak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/5] s390x: vfio-ap: guest dedicated
 crypto adapters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On Sun, 15 Apr 2018 15:07:19 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

>  default-configs/s390x-softmmu.mak |    1 +
>  docs/vfio-ap.txt                  |  649 +++++++++++++++++++++++++++++++++++++
>  hw/s390x/Makefile.objs            |    1 +
>  hw/s390x/ap-device.c              |   39 +++
>  hw/vfio/Makefile.objs             |    1 +
>  hw/vfio/ap.c                      |  191 +++++++++++
>  include/hw/s390x/ap-device.h      |   38 +++
>  include/hw/vfio/vfio-common.h     |    1 +
>  linux-headers/asm-s390/kvm.h      |    2 +
>  linux-headers/linux/vfio.h        |    2 +
>  target/s390x/cpu_features.c       |    3 +
>  target/s390x/cpu_features_def.h   |    3 +
>  target/s390x/cpu_models.c         |    2 +
>  target/s390x/gen-features.c       |    3 +
>  target/s390x/kvm.c                |    1 +
>  ui/keycodemapdb                   |    2 +-
>  16 files changed, 938 insertions(+), 1 deletions(-)
>  create mode 100644 docs/vfio-ap.txt
>  create mode 100644 hw/s390x/ap-device.c
>  create mode 100644 hw/vfio/ap.c
>  create mode 100644 include/hw/s390x/ap-device.h

Can we please get a MAINTAINERS entry for ap? While I'm obviously happy
to take things through the s390x tree, ap is not something I can easily
review (or even test), so I'd like to see an entry with dedicated (IBM)
maintainers.

Also, hw/vfio/ap.c and docs/vfio-ap.c should be added to the generic
s390 section.
