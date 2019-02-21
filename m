Received: from eggs.gnu.org ([209.51.188.92]:53326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gwlWw-00044d-UT
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 05:24:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gwlWw-0004yZ-9c
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 05:24:38 -0500
References: <20190221101139.2224-1-stefanha@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c620cfea-6f3c-f9b6-1dce-52eae2d905d7@redhat.com>
Date: Thu, 21 Feb 2019 11:24:12 +0100
MIME-Version: 1.0
In-Reply-To: <20190221101139.2224-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] iotests: drop unnecessary accel=kvm in
 238
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On 21/02/2019 11.11, Stefan Hajnoczi wrote:
> Test 238 does not require the kvm accelerator.  TCG works fine.
> 
> Use the default accelerator instead of requiring kvm.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Vladimir, I have dropped the 235 change because I don't have time to
> figure out the kvm/tcg vs qtest differences or add a skip function.
> Sorry!
> 
>  tests/qemu-iotests/238 | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/238 b/tests/qemu-iotests/238
> index f81ee1112f..e490bb4298 100755
> --- a/tests/qemu-iotests/238
> +++ b/tests/qemu-iotests/238
> @@ -33,7 +33,6 @@ else:
>      virtio_scsi_device = 'virtio-scsi-pci'
>  
>  vm = QEMUMachine(iotests.qemu_prog)
> -vm.add_args('-machine', 'accel=kvm')

Would it be feasible to change it into "accel=qtest" instead? ... then
this test would also work when QEMU has been compiled with --disable-tcg
and when KVM is not available...

 Thomas
