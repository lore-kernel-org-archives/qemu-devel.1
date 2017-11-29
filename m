Received: from eggs.gnu.org ([2001:4830:134:3::10]:34963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eKAa2-0001Nv-1d
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 17:11:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eKAa1-0000L0-8j
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 17:11:46 -0500
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123020832.8165-13-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d0bd44fd-80d1-1fd1-1606-1ad72efdf31e@redhat.com>
Date: Wed, 29 Nov 2017 17:11:34 -0500
MIME-Version: 1.0
In-Reply-To: <20171123020832.8165-13-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/17] iotests: Fix 059's reference output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org



On 11/22/2017 09:08 PM, Max Reitz wrote:
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
> 

I have the same patch in my local repo, so:

Reviewed-by: John Snow <jsnow@redhat.com>
