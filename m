Received: from eggs.gnu.org ([2001:4830:134:3::10]:58708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dHyhh-00089U-AA
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 16:34:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dHyhg-0006Uy-FP
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 16:34:21 -0400
Date: Mon, 5 Jun 2017 16:34:13 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170605203413.GB2680@localhost.localdomain>
References: <1496682098-1540-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496682098-1540-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] block/gluster.c: Handle
 qdict_array_entries() failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Mon, Jun 05, 2017 at 06:01:38PM +0100, Peter Maydell wrote:
> In qemu_gluster_parse_json(), the call to qdict_array_entries()
> could return a negative error code, which we were ignoring
> because we assigned the result to an unsigned variable.
> Fix this by using the 'int' type instead, which matches the
> return type of qdict_array_entries() and also the type
> we use for the loop enumeration variable 'i'.
> 
> (Spotted by Coverity, CID 1360960.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  block/gluster.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/gluster.c b/block/gluster.c
> index 031596a..addceed 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -493,8 +493,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
>      Error *local_err = NULL;
>      char *str = NULL;
>      const char *ptr;
> -    size_t num_servers;
> -    int i, type;
> +    int i, type, num_servers;
>  
>      /* create opts info from runtime_json_opts list */
>      opts = qemu_opts_create(&runtime_json_opts, NULL, 0, &error_abort);
> -- 
> 2.7.4
> 

Thanks,

Reviewed-by: Jeff Cody <jcody@redhat.com>

Also - applied to my block branch:

git://github.com/codyprime/qemu-kvm-jtc block

-Jeff
