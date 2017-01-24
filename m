Received: from eggs.gnu.org ([2001:4830:134:3::10]:45535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cVw1I-00085W-Qt
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 03:00:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cVw1I-0002UJ-2X
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 03:00:00 -0500
Date: Tue, 24 Jan 2017 15:59:49 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170124075949.GD27126@lemon.Home>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-9-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1482503344-6424-9-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 08/21] backup: skip unallocated clusters
 for full mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com, jcody@redhat.com

On Fri, 12/23 17:28, Vladimir Sementsov-Ogievskiy wrote:
> diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
> index 1d3fd04..388b7b2 100755
> --- a/tests/qemu-iotests/055
> +++ b/tests/qemu-iotests/055
> @@ -30,6 +30,7 @@ target_img = os.path.join(iotests.test_dir, 'target.img')
>  blockdev_target_img = os.path.join(iotests.test_dir, 'blockdev-target.img')
>  
>  image_len = 64 * 1024 * 1024 # MB
> +pause_write = '3M'
>  
>  def setUpModule():
>      qemu_img('create', '-f', iotests.imgfmt, test_img, str(image_len))
> @@ -39,6 +40,7 @@ def setUpModule():
>      qemu_io('-f', iotests.imgfmt, '-c', 'write -P0xd5 1M 32k', test_img)
>      qemu_io('-f', iotests.imgfmt, '-c', 'write -P0xdc 32M 124k', test_img)
>      qemu_io('-f', iotests.imgfmt, '-c', 'write -P0x33 67043328 64k', test_img)
> +    qemu_io('-f', iotests.imgfmt, '-c', 'write -P0xdc 40M ' + pause_write, test_img)

What does this iotest change do?

Fam

>  
>  def tearDownModule():
>      os.remove(test_img)
> -- 
> 1.8.3.1
> 
