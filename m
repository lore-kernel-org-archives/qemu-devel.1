Received: from eggs.gnu.org ([209.51.188.92]:45215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyYRK-0005Aw-I3
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 03:50:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyYRI-0000F0-FD
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 03:50:14 -0500
Date: Tue, 26 Feb 2019 09:49:59 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190226084959.GA4598@linux.fritz.box>
References: <20190225161831.20103-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225161831.20103-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] iotests: use -M accel=qtest in 238
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>

Am 25.02.2019 um 17:18 hat Stefan Hajnoczi geschrieben:
> Test 238 does not require the kvm accelerator.  tcg and qtest work too.
> 
> Use qtest since it's always built in while kvm and tcg are not.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/238 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/238 b/tests/qemu-iotests/238
> index f81ee1112f..c7f8d9422b 100755
> --- a/tests/qemu-iotests/238
> +++ b/tests/qemu-iotests/238
> @@ -33,7 +33,7 @@ else:
>      virtio_scsi_device = 'virtio-scsi-pci'
>  
>  vm = QEMUMachine(iotests.qemu_prog)
> -vm.add_args('-machine', 'accel=kvm')
> +vm.add_args('-machine', 'accel=qtest')
>  vm.launch()

Why not use iotests.VM? This would be a qtest machine automatically.

Kevin
