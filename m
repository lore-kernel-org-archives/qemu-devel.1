Received: from eggs.gnu.org ([2001:4830:134:3::10]:53236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e7dGS-0007Yx-2R
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e7dGQ-0004Kp-R3
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:11:44 -0400
Date: Thu, 26 Oct 2017 04:11:34 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171026081134.GA28110@localhost.localdomain>
References: <20171026075947.9597-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171026075947.9597-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-img.1: Image
 invalidation on qemu-img commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Thu, Oct 26, 2017 at 09:59:47AM +0200, Max Reitz wrote:
> qemu-img commit invalidates all images between base and top.  This
> should be mentioned in the man page.
> 
> Suggested-by: Ping Li <pingl@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qemu-img.texi | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/qemu-img.texi b/qemu-img.texi
> index ee5c5940d3..fdcf120f36 100644
> --- a/qemu-img.texi
> +++ b/qemu-img.texi
> @@ -274,11 +274,10 @@ If the backing chain of the given image file @var{filename} has more than one
>  layer, the backing file into which the changes will be committed may be
>  specified as @var{base} (which has to be part of @var{filename}'s backing
>  chain). If @var{base} is not specified, the immediate backing file of the top
> -image (which is @var{filename}) will be used. For reasons of consistency,
> -explicitly specifying @var{base} will always imply @code{-d} (since emptying an
> -image after committing to an indirect backing file would lead to different data
> -being read from the image due to content in the intermediate backing chain
> -overruling the commit target).
> +image (which is @var{filename}) will be used. Note that after a commit operation
> +all images between @var{base} and the top image will be invalid and may return
> +garbage data when read. For this reason, @code{-b} implies @code{-d} (so that
> +the top image stays valid).
>  
>  @item compare [-f @var{fmt}] [-F @var{fmt}] [-T @var{src_cache}] [-p] [-s] [-q] @var{filename1} @var{filename2}
>  
> -- 
> 2.13.6
> 
>

Reviewed-by: Jeff Cody <jcody@redhat.com>
