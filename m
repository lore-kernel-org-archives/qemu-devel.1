Received: from eggs.gnu.org ([209.51.188.92]:53249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1goarA-0007sd-By
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:23:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1goar9-0006B2-I7
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:23:44 -0500
References: <20190123144610.8842-1-mreitz@redhat.com>
	<20190123144610.8842-3-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <545b40f9-a388-a2c2-d279-7f267b48a55a@redhat.com>
Date: Tue, 29 Jan 2019 16:23:38 -0500
MIME-Version: 1.0
In-Reply-To: <20190123144610.8842-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/9] iotests: Remove superfluous rm from 232
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org



On 1/23/19 9:46 AM, Max Reitz wrote:
> This test creates no such file.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

(+1 to Eric's suggestion of reviving Jeff's patches. Maybe I'll take a
look once I get my downstream queue under control...)

> ---
>  tests/qemu-iotests/232 | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/232 b/tests/qemu-iotests/232
> index 0708b8b155..93e5d641a3 100755
> --- a/tests/qemu-iotests/232
> +++ b/tests/qemu-iotests/232
> @@ -29,7 +29,6 @@ status=1	# failure is the default!
>  _cleanup()
>  {
>      _cleanup_test_img
> -    rm -f $TEST_IMG.snap
>  }
>  trap "_cleanup; exit \$status" 0 1 2 3 15
>  
> 
