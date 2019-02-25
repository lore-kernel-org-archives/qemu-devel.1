Received: from eggs.gnu.org ([209.51.188.92]:60338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gyFbH-0004f0-RG
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:43:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gyFbG-0006R3-JT
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:43:15 -0500
Date: Mon, 25 Feb 2019 13:42:38 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190225134238.4ad9b951.cohuck@redhat.com>
In-Reply-To: <1550519397-25359-1-git-send-email-akrowiak@linux.ibm.com>
References: <1550519397-25359-1-git-send-email-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/2] s390x/vfio-ap: hot plug/unplug
 vfio-ap device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com, david@redhat.com, pmorel@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, fiuczy@linux.ibm.com

On Mon, 18 Feb 2019 14:49:55 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> This patch series introduces hot plug/unplug of a vfio-ap device.
> 
> To hot plug a vfio-ap device, the QEMU device_add function may be used:
> 
>    (qemu) device_add vfio-ap,sysfsdev=$path-to-mdev
> 
>    Where $path-to-mdev is the absolute path to the mediated matrix device
>    to which AP resources to be used by the guest have been assigned.
> 
>    A vfio-ap device can be hot plugged only if:
> 
>    1. A vfio-ap device has not been attached to the ap-bus (only one is
>       allowed per guest) either via the QEMU command line or a prior hot
>       plug action.
> 
>    2. The guest was started with the CPU model feature for AP enabled
>       (e.g., -cpu host,ap=on).
> 
> To hot unplug a vfio-ap device, the QEMU device-del function may be used:
> 
>    (qemu) device_del vfio-ap,sysfsdev=$path-to-mdev
> 
>    Where $path-to-mdev is the absolute path to the mediated matrix device
>    specified when the vfio-ap device was attached to the virtual machine's
>    ap-bus.
> 
>    A vfio-ap device can be hot unplugged only if:
> 
>    1. A vfio-ap device has been attached to the virtual machine's ap-abus
>       either via the QEMU command line or a prior hot plug action. 
> 
>    2. The guest was started with the CPU model feature for AP enabled
>       (e.g., -cpu host,ap=on).
> 
> Tony Krowiak (2):
>   s390x/vfio-ap: Implement hot plug/unplug of vfio-ap device
>   s390x/vfio-ap: document hot plug/unplug of vfio-ap device
> 
>  docs/vfio-ap.txt     | 58 +++++++++++++++++++++++++++++++++++++++++++++++-----
>  hw/s390x/ap-bridge.c | 12 ++++++++++-
>  hw/vfio/ap.c         |  2 +-
>  3 files changed, 65 insertions(+), 7 deletions(-)
> 

In the meantime, the signature of qbus_set_hotplug_handler() has
changed to take an Object instead of a DeviceState, but I just went
ahead and did that trivial change myself.

Thanks, applied.
