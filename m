Received: from eggs.gnu.org ([2001:4830:134:3::10]:45987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdCHq-0001zx-CC
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 06:23:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdCHp-0001Vd-Hk
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 06:23:54 -0400
Date: Wed, 11 Jul 2018 12:23:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180711102344.GD4266@localhost.localdomain>
References: <20180711064046.10989-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711064046.10989-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] iotests: nbd: Stop qemu-nbd before
 remaking image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 11.07.2018 um 08:40 hat Fam Zheng geschrieben:
> 197 is one example where _make_test_img is used twice without stopping
> the NBD server in between. An error will occur like this:
> 
>     @@ -26,9 +26,13 @@
> 
>      === Partial final cluster ===
> 
>     +qemu-img: TEST_DIR/t.IMGFMT: Failed to get "resize" lock
>     +Is another process using the image?
>      Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1024
>     +Failed to find an available port: Address already in use
>      read 1024/1024 bytes at offset 0
> 
> Patch _make_test_img to stop the old qemu-nbd before starting a new one,
> which fixes this problem, and similarly 215.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Thanks, applied to the block branch.

Kevin
