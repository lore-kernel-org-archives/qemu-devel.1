Received: from eggs.gnu.org ([2001:4830:134:3::10]:33520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eLsvF-0005ce-IC
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:44:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eLsvC-0001Ss-9W
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:44:45 -0500
Date: Mon, 4 Dec 2017 23:44:36 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171204154436.GC10628@lemon>
References: <1512254273-7567-1-git-send-email-shravan2x@utexas.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1512254273-7567-1-git-send-email-shravan2x@utexas.edu>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Fixed grammatical error in
 dump_human_image_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shravan Rajinikanth <shravan2x@utexas.edu>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Sat, 12/02 14:37, Shravan Rajinikanth wrote:
> Signed-off-by: Shravan Rajinikanth <shravan2x@utexas.edu>
> ---
>  qemu-img.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 68b375f..bea9268 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -580,7 +580,7 @@ static void dump_human_image_check(ImageCheck *check, bool quiet)
>          if (check->leaks) {
>              qprintf(quiet,
>                      "\n%" PRId64 " leaked clusters were found on the image.\n"
> -                    "This means waste of disk space, but no harm to data.\n",
> +                    "This means disk space is wasted, but data is safe.\n",

To me both versions seem fine, could you explain the grammatical error in the
old message?

Fam

>                      check->leaks);
>          }
>  
> -- 
> 2.7.4
> 
> 
