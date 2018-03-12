Received: from eggs.gnu.org ([2001:4830:134:3::10]:33108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1evV2C-00031m-W0
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1evV2C-00058o-6H
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:31:08 -0400
Date: Mon, 12 Mar 2018 17:31:04 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180312213104.GF12302@localhost.localdomain>
References: <20180309214611.19122-1-kwolf@redhat.com>
	<20180309214611.19122-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309214611.19122-3-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/7] qemu-iotests: Enable write tests for
 parallels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, den@openvz.org, eblake@redhat.com, qemu-devel@nongnu.org

On Fri, Mar 09, 2018 at 10:46:06PM +0100, Kevin Wolf wrote:
> Originally we added parallels as a read-only format to qemu-iotests
> where we did just some tests with a binary image. Since then, write and
> image creation support has been added to the driver, so we can now
> enable it in _supported_fmt generic.
> 
> The driver doesn't support migration yet, though, so we need to add it
> to the list of exceptions in 181.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/181   | 2 +-
>  tests/qemu-iotests/check | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
> index 0c91e8f9de..5e767c6195 100755
> --- a/tests/qemu-iotests/181
> +++ b/tests/qemu-iotests/181
> @@ -44,7 +44,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  
>  _supported_fmt generic
>  # Formats that do not support live migration
> -_unsupported_fmt qcow vdi vhdx vmdk vpc vvfat
> +_unsupported_fmt qcow vdi vhdx vmdk vpc vvfat parallels
>  _supported_proto generic
>  _supported_os Linux
>  
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index e6b6ff7a04..469142cd58 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -284,7 +284,6 @@ testlist options
>  
>          -parallels)
>              IMGFMT=parallels
> -            IMGFMT_GENERIC=false
>              xpand=false
>              ;;
>  
> -- 
> 2.13.6
> 

Reviewed-by: Jeff Cody <jcody@redhat.com>
