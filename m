Received: from eggs.gnu.org ([2001:4830:134:3::10]:37373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e5Lnp-0006ja-Oe
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 21:08:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e5Lnm-0003fz-JI
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 21:08:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1e5Lnm-0003el-Bm
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 21:08:42 -0400
Date: Fri, 20 Oct 2017 09:08:38 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171020010838.GC29815@lemon>
References: <20171018073841.30062-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171018073841.30062-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] docker: Fix PATH for ccache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Wed, 10/18 15:38, Fam Zheng wrote:
> Before bcd7f06f57fb6f780a3e2f7a46c22b6f6c8238aa we source /etc/profile
> so the PATH included the right paths to ccache binaries. Now we need to
> update $PATH explicitly from run script.
> 
> Keep the old /usr/lib around just so that in the future, ccache from 32
> bit images will just work.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/docker/run | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/docker/run b/tests/docker/run
> index 642084bcb8..9dd362bb98 100755
> --- a/tests/docker/run
> +++ b/tests/docker/run
> @@ -18,7 +18,7 @@ fi
>  BASE="$(dirname $(readlink -e $0))"
>  
>  # Prepare the environment
> -export PATH=/usr/lib/ccache:$PATH
> +export PATH=/usr/lib/ccache:/usr/lib64/ccache:$PATH
>  
>  if test -n "$J"; then
>      export MAKEFLAGS="$MAKEFLAGS -j$J"
> -- 
> 2.13.5
> 

Queued, thanks!

Fam
