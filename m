Received: from eggs.gnu.org ([2001:4830:134:3::10]:59316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eKEwY-0004En-1J
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 21:51:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eKEwX-00049B-7j
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 21:51:18 -0500
Date: Thu, 30 Nov 2017 10:51:07 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171130025107.GG16237@lemon>
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171129192411.6637-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129192411.6637-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 18/17] iotests: Make 059 pass on machines
 with little RAM
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

On Wed, 11/29 20:24, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> Based-on: <20171123020832.8165-1-mreitz@redhat.com>
> 
> (Depends on patch 12 of this series; I'll merge both if I have to
>  respin.)
> ---
>  tests/qemu-iotests/059 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
> index a1c34eeb7c..40f89eae18 100755
> --- a/tests/qemu-iotests/059
> +++ b/tests/qemu-iotests/059
> @@ -152,7 +152,9 @@ done
>  echo
>  echo "=== Testing afl image with a very large capacity ==="
>  _use_sample_img afl9.vmdk.bz2
> -_img_info
> +# The sed makes this test pass on machines with little RAM
> +# (and also with 32 bit builds)
> +_img_info | sed -e 's/Cannot allocate memory/Invalid argument/'
>  _cleanup_test_img
>  
>  # success, all done
> -- 
> 2.13.6
> 


Reviewed-by: Fam Zheng <famz@redhat.com>
