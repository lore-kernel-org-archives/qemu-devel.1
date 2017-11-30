Received: from eggs.gnu.org ([2001:4830:134:3::10]:56396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eKEpd-0000p2-5z
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 21:44:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eKEpc-0008Hc-Fd
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 21:44:09 -0500
Date: Thu, 30 Nov 2017 10:43:59 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171130024359.GE16237@lemon>
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123020832.8165-13-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171123020832.8165-13-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 12/17] iotests: Fix 059's reference output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

On Thu, 11/23 03:08, Max Reitz wrote:
> As of commit 9877860e7bd1e26ee70ab9bb5ebc34c92bf23bf5, vmdk fails
> differently when opening the sample image.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/059.out | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/059.out b/tests/qemu-iotests/059.out
> index f6dce7947c..1ac5d56233 100644
> --- a/tests/qemu-iotests/059.out
> +++ b/tests/qemu-iotests/059.out
> @@ -2358,5 +2358,5 @@ Offset          Length          Mapped to       File
>  0x140000000     0x10000         0x50000         TEST_DIR/t-s003.vmdk
>  
>  === Testing afl image with a very large capacity ===
> -qemu-img: Can't get image size 'TEST_DIR/afl9.IMGFMT': File too large
> +qemu-img: Could not open 'TEST_DIR/afl9.IMGFMT': Could not open 'TEST_DIR/afl9.IMGFMT': Invalid argument
>  *** done
> -- 
> 2.13.6
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
