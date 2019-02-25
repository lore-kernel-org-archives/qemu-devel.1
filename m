Received: from eggs.gnu.org ([209.51.188.92]:56204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gyJ2J-0000tY-02
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:23:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gyJ2G-0002Bu-QD
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:23:22 -0500
References: <20190225161831.20103-1-stefanha@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <abc1fa78-0d97-6252-4c7e-11415644fbed@redhat.com>
Date: Mon, 25 Feb 2019 17:23:12 +0100
MIME-Version: 1.0
In-Reply-To: <20190225161831.20103-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] iotests: use -M accel=qtest in 238
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

On 25/02/2019 17.18, Stefan Hajnoczi wrote:
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
>  
>  log(vm.qmp('blockdev-add', node_name='hd0', driver='null-co'))
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
