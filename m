Received: from eggs.gnu.org ([2001:4830:134:3::10]:41655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dMw5W-0001NN-Ci
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dMw5R-0002KK-Gw
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:47:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dMw5R-0002Jv-AT
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:47:21 -0400
Date: Mon, 19 Jun 2017 14:47:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170619124716.GD6113@noname.redhat.com>
References: <20170615163813.7255-1-stefanha@redhat.com>
	<20170615163813.7255-4-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170615163813.7255-4-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] qemu-iotests: 068: extract _qemu()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Pavel Butsykin <pbutsykin@virtuozzo.com>

Am 15.06.2017 um 18:38 hat Stefan Hajnoczi geschrieben:
> Avoid duplicating the QEMU command-line.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/068 | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
> index 9c1687d..653e23c 100755
> --- a/tests/qemu-iotests/068
> +++ b/tests/qemu-iotests/068
> @@ -59,14 +59,17 @@ case "$QEMU_DEFAULT_MACHINE" in
>        ;;
>  esac
>  
> -# Give qemu some time to boot before saving the VM state
> -bash -c 'sleep 1; echo -e "savevm 0\nquit"' |\
> +_qemu()
> +{
>      $QEMU $platform_parm -nographic -monitor stdio -serial none -hda "$TEST_IMG" |\

This line shouldn't end with a pipe now. The bug goes away with the next
patch anyway, so I can just remove that one character while applying the
series.

> +          "$@" |\
>      _filter_qemu | _filter_hmp
> +}

Kevin
