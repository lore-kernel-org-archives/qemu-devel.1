Received: from eggs.gnu.org ([2001:4830:134:3::10]:40282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eRCkp-0004cf-K6
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 02:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eRCkm-0006GC-5x
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 02:55:59 -0500
References: <20171219020921.23887-1-maozy.fnst@cn.fujitsu.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0f40be05-5e06-fae5-a82f-4ce17d29ce13@redhat.com>
Date: Tue, 19 Dec 2017 08:55:50 +0100
MIME-Version: 1.0
In-Reply-To: <20171219020921.23887-1-maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RESEND PATCH] build: Fix error script name in
 git-submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>

On 19.12.2017 03:09, Mao Zhongyi wrote:
> When I follow the command line prompts to run
> "$ scripts/git-sbumodule.sh update  ui/keycodemapdb dtc capstone"
> 
> this is what I got:
> -bash: ./scripts/git-sbumodule.sh: No such file or directory
> 
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Fixes: f62bbee55d503f639ee9498878ebf42ff4f4299a
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>  scripts/git-submodule.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
> index bc7224a..807ca0b 100755
> --- a/scripts/git-submodule.sh
> +++ b/scripts/git-submodule.sh
> @@ -28,7 +28,7 @@ error() {
>      echo
>      echo "and then manually update submodules prior to running make, with:"
>      echo
> -    echo " $ scripts/git-sbumodule.sh update $modules"
> +    echo " $ scripts/git-submodule.sh update $modules"
>      echo
>      exit 1
>  }
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
