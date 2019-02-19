Received: from eggs.gnu.org ([209.51.188.92]:40294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw46g-0007bB-Gs
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:02:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw46e-0006gf-Ny
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:02:38 -0500
References: <20190219115937.21587-1-stefanha@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2598979f-d8b5-4324-3ca4-f87802d4a9d1@redhat.com>
Date: Tue, 19 Feb 2019 13:02:24 +0100
MIME-Version: 1.0
In-Reply-To: <20190219115937.21587-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] iotests: drop unnecessary accel=kvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On 19/02/2019 12.59, Stefan Hajnoczi wrote:
> Tests 235 and 238 do not require the kvm accelerator.  TCG works fine.
> 
> Use the default accelerator instead of requiring kvm.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/235 | 1 -
>  tests/qemu-iotests/238 | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
> index d6edd97ab4..329da8f0c2 100755
> --- a/tests/qemu-iotests/235
> +++ b/tests/qemu-iotests/235
> @@ -49,7 +49,6 @@ qemu_img_create('-f', iotests.imgfmt, '-o', 'preallocation=metadata', disk,
>                  str(size))
>  
>  vm = QEMUMachine(iotests.qemu_prog)
> -vm.add_args('-machine', 'accel=kvm')

According to the initial commit log of 235:

 "iotests: simple mirror test with kvm on 1G image"

... so I assume KVM was used on purpose here?

 Thomas
