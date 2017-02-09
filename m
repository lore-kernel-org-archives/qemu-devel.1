Received: from eggs.gnu.org ([2001:4830:134:3::10]:59937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cbpkB-0002cf-50
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:30:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cbpk7-0006cA-3K
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:30:43 -0500
Date: Thu, 9 Feb 2017 09:30:31 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170209143031.GK27752@localhost.localdomain>
References: <1486642218-18520-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1486642218-18520-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-options: Fix broken sheepdog URL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-block@nongnu.org, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Thu, Feb 09, 2017 at 01:10:18PM +0100, Thomas Huth wrote:
> The sheepdog URL is broken twice: First it uses a duplicated
> http:// prefix, second the website seems to have moved to
> https://sheepdog.github.io/sheepdog/ instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-options.hx | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index ad2f8fc..38113b9 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2583,7 +2583,7 @@ Example
>  qemu-system-i386 --drive file=sheepdog://192.0.2.1:30000/MyVirtualMachine
>  @end example
>  
> -See also @url{http://http://www.osrg.net/sheepdog/}.
> +See also @url{https://sheepdog.github.io/sheepdog/}.
>  
>  @item GlusterFS
>  GlusterFS is a user space distributed file system.
> -- 
> 1.8.3.1
> 

Thanks,

Applied to my block branch:

git://github.com/codyprime/qemu-kvm-jtc.git block

-Jeff
