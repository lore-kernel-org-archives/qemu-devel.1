Received: from eggs.gnu.org ([2001:4830:134:3::10]:35114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eKF4d-0007R0-5p
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 21:59:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eKF4c-0001Gs-F8
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 21:59:39 -0500
Date: Thu, 30 Nov 2017 10:59:26 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171130025926.GJ16237@lemon>
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123020832.8165-6-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171123020832.8165-6-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/17] iotests: Fix _img_info for
 backslashes
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
> read without -r eats backslashes.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/common.rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index dbae7d74ba..6fa0495e10 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -338,7 +338,7 @@ _img_info()
>              -e "s#$IMGFMT#IMGFMT#g" \
>              -e "/^disk size:/ D" \
>              -e "/actual-size/ D" | \
> -        while IFS='' read line; do
> +        while IFS='' read -r line; do
>              if [[ $format_specific == 1 ]]; then
>                  discard=0
>              elif [[ $line == "Format specific information:" ]]; then
> -- 
> 2.13.6
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
