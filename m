Received: from eggs.gnu.org ([2001:4830:134:3::10]:51576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1TjX-0005V0-UC
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1TjX-0005TM-2b
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:16:03 -0400
Date: Fri, 21 Apr 2017 16:15:55 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170421081555.GB8342@lemon.lan>
References: <1492761662-5644-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1492761662-5644-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu_iotests: Remove _readlink()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

On Fri, 04/21 10:01, Kevin Wolf wrote:
> It is unused.
> 
> Suggestetd-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/common.config | 18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common.config
> index 1222e43..66f4e0b 100644
> --- a/tests/qemu-iotests/common.config
> +++ b/tests/qemu-iotests/common.config
> @@ -204,23 +204,5 @@ fi
>  
>  export SAMPLE_IMG_DIR
>  
> -_readlink()
> -{
> -    if [ $# -ne 1 ]; then
> -        echo "Usage: _readlink filename" 1>&2
> -        exit 1
> -    fi
> -
> -    perl -e "\$in=\"$1\";" -e '
> -    $lnk = readlink($in);
> -    if ($lnk =~ m!^/.*!) {
> -        print "$lnk\n";
> -    }
> -    else {
> -        chomp($dir = `dirname $in`);
> -        print "$dir/$lnk\n";
> -    }'
> -}
> -
>  # make sure this script returns success
>  true
> -- 
> 1.8.3.1
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
