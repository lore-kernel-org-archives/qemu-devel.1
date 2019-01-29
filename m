Received: from eggs.gnu.org ([209.51.188.92]:44743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goQ1d-0002nB-QS
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:49:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goQ1d-0000x9-79
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:49:49 -0500
Date: Tue, 29 Jan 2019 10:49:44 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190129104944.138d4b4b.cohuck@redhat.com>
In-Reply-To: <1548754934-6031-1-git-send-email-thuth@redhat.com>
References: <20190128170819.4998232d.cohuck@redhat.com>
	<1548754934-6031-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2] s390x: express
 dependencies with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, yang.zhong@intel.com, pbonzini@redhat.com, qemu-s390x@nongnu.org

On Tue, 29 Jan 2019 10:42:14 +0100
Thomas Huth <thuth@redhat.com> wrote:

> Instead of hard-coding all config switches in the config file
> default-configs/s390x-softmmu.mak, let's use the new Kconfig files
> to express the necessary dependencies: The S390_CCW_VIRTIO config switch
> for the "s390-ccw-virtio" machine now selects all non-optional devices.
> 
> And since we already have the VIRTIO_PCI and VIRTIO_MMIO config switches
> for the other two virtio transports, this patch also introduces a new
> config switch VIRTIO_CCW for the third, s390x-specific virtio transport,
> so that all three virtio transports are now handled in the same way.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2:
>  - Use CONFIG_TERMINAL3270 for 3270-ccw.o
>  - Use CONFIG_VIRTIO_CCW for all related devices in the Makefile
> 
>  default-configs/s390x-softmmu.mak | 12 ++++++++----
>  hw/s390x/Kconfig                  |  4 ++++
>  hw/s390x/Makefile.objs            |  4 +++-
>  hw/virtio/Kconfig                 |  4 ++++
>  4 files changed, 19 insertions(+), 5 deletions(-)

Looks sane to me.

As I have not looked into the Kconfig infrastructure, I don't feel
comfortable enough to give a R-b, but have a

Acked-by: Cornelia Huck <cohuck@redhat.com>
