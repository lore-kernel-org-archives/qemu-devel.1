Received: from eggs.gnu.org ([2001:4830:134:3::10]:58045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fxxgn-00042y-Fz
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 13:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fxxgm-0007QS-Bo
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 13:03:29 -0400
Date: Thu, 6 Sep 2018 13:03:08 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180906170308.GM22117@localhost.localdomain>
References: <20180906130225.5118-1-jsnow@redhat.com>
	<20180906130225.5118-16-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906130225.5118-16-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 15/16] block/backup: qapi documentation
 fixup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>

On Thu, Sep 06, 2018 at 09:02:24AM -0400, John Snow wrote:
> Fix documentation to match the other jobs amended for 3.1.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  qapi/block-core.json | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index f877e9e414..c0b3d33dbb 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1272,13 +1272,14 @@
>  #                   a different block device than @device).
>  #
>  # @auto-finalize: When false, this job will wait in a PENDING state after it has
> -#                 finished its work, waiting for @block-job-finalize.
> -#                 When true, this job will automatically perform its abort or
> -#                 commit actions.
> +#                 finished its work, waiting for @block-job-finalize before
> +#                 making any block graph changes.
> +#                 When true, this job will automatically
> +#                 perform its abort or commit actions.
>  #                 Defaults to true. (Since 2.12)
>  #
>  # @auto-dismiss: When false, this job will wait in a CONCLUDED state after it
> -#                has completed ceased all work, and wait for @block-job-dismiss.
> +#                has completely ceased all work, and awaits @block-job-dismiss.
>  #                When true, this job will automatically disappear from the query
>  #                list without user intervention.
>  #                Defaults to true. (Since 2.12)
> @@ -1327,13 +1328,14 @@
>  #                   a different block device than @device).
>  #
>  # @auto-finalize: When false, this job will wait in a PENDING state after it has
> -#                 finished its work, waiting for @block-job-finalize.
> -#                 When true, this job will automatically perform its abort or
> -#                 commit actions.
> +#                 finished its work, waiting for @block-job-finalize before
> +#                 making any block graph changes.
> +#                 When true, this job will automatically
> +#                 perform its abort or commit actions.
>  #                 Defaults to true. (Since 2.12)
>  #
>  # @auto-dismiss: When false, this job will wait in a CONCLUDED state after it
> -#                has completed ceased all work, and wait for @block-job-dismiss.
> +#                has completely ceased all work, and awaits @block-job-dismiss.
>  #                When true, this job will automatically disappear from the query
>  #                list without user intervention.
>  #                Defaults to true. (Since 2.12)
> -- 
> 2.14.4
> 
