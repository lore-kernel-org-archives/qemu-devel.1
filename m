Received: from eggs.gnu.org ([209.51.188.92]:57110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gob7f-0006Zr-S1
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:40:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gob7e-0007Yh-7E
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:40:47 -0500
References: <20190123144610.8842-1-mreitz@redhat.com>
	<20190123144610.8842-9-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f9b3e17c-c3e2-6af8-c412-c525681012b1@redhat.com>
Date: Tue, 29 Jan 2019 16:40:25 -0500
MIME-Version: 1.0
In-Reply-To: <20190123144610.8842-9-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 8/9] iotests: Filter SSH paths
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
> 8908b253c4ad5f8874c8d13abec169c696a5cd32 has implemented filtering of
> remote paths for NFS, but forgot SSH.  This patch takes care of that.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/common.rc | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index e15e7a7c8e..09a27f02d0 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -145,6 +145,7 @@ else
>          TEST_IMG="nbd:127.0.0.1:10810"
>      elif [ "$IMGPROTO" = "ssh" ]; then
>          TEST_IMG_FILE=$TEST_DIR/t.$IMGFMT
> +        REMOTE_TEST_DIR="ssh://127.0.0.1$TEST_DIR"
>          TEST_IMG="ssh://127.0.0.1$TEST_IMG_FILE"
>      elif [ "$IMGPROTO" = "nfs" ]; then
>          TEST_IMG_FILE=$TEST_DIR/t.$IMGFMT
> 

Reviewed-by: John Snow <jsnow@redhat.com>
