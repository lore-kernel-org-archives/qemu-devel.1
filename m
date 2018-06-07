Received: from eggs.gnu.org ([2001:4830:134:3::10]:52806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fQuR6-00089r-3E
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fQuR5-0004ED-BN
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:54:40 -0400
Date: Thu, 7 Jun 2018 08:54:31 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180607125431.GH6435@localhost.localdomain>
References: <20180606230257.9038-1-jsnow@redhat.com>
	<20180606230257.9038-3-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606230257.9038-3-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] jobs: fix verb references in docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

On Wed, Jun 06, 2018 at 07:02:57PM -0400, John Snow wrote:
> These point to the job versions now, not the blockjob versions which
> don't really exist anymore.
> 
> Except set-speed, which does. It sticks out like a sore thumb. This
> patch doesn't fix that, but it doesn't make it any worse, either.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  qapi/job.json | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/qapi/job.json b/qapi/job.json
> index 226443594b..9d074eb8d2 100644
> --- a/qapi/job.json
> +++ b/qapi/job.json
> @@ -76,19 +76,19 @@
>  #
>  # Represents command verbs that can be applied to a job.
>  #
> -# @cancel: see @block-job-cancel
> +# @cancel: see @job-cancel
>  #
> -# @pause: see @block-job-pause
> +# @pause: see @job-pause
>  #
> -# @resume: see @block-job-resume
> +# @resume: see @job-resume
>  #
>  # @set-speed: see @block-job-set-speed
>  #
> -# @complete: see @block-job-complete
> +# @complete: see @job-complete
>  #
> -# @dismiss: see @block-job-dismiss
> +# @dismiss: see @job-dismiss
>  #
> -# @finalize: see @block-job-finalize
> +# @finalize: see @job-finalize
>  #
>  # Since: 2.12
>  ##
> -- 
> 2.14.3
> 
