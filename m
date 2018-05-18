Received: from eggs.gnu.org ([2001:4830:134:3::10]:42113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fJjTE-0007uI-JC
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fJjTD-0003Sv-Ka
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:47:12 -0400
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-3-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <5d5d25cc-432f-5418-defe-2c365db1afe2@redhat.com>
Date: Fri, 18 May 2018 13:47:03 -0400
MIME-Version: 1.0
In-Reply-To: <20180518132114.4070-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/40] blockjob: Improve
 BlockJobInfo.offset/len documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jcody@redhat.com, armbru@redhat.com, mreitz@redhat.com



On 05/18/2018 09:20 AM, Kevin Wolf wrote:
> Clarify that len is just an estimation of the end value of offset, and
> that offset increases monotonically while len can change arbitrarily.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index d32ec95666..0e29abf099 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1148,7 +1148,12 @@
>  # @device: The job identifier. Originally the device name but other
>  #          values are allowed since QEMU 2.7
>  #
> -# @len: the maximum progress value
> +# @len: Estimated @offset value at the completion of the job. This value can
> +#       arbitrarily change while the job is running, in both directions.
> +#
> +# @offset: Progress made until now. The unit is arbitrary and the value can
> +#          only meaningfully be used for the ratio of @offset to @len. The
> +#          value is monotonically increasing.
>  #
>  # @busy: false if the job is known to be in a quiescent state, with
>  #        no pending I/O.  Since 1.3.
> @@ -1156,8 +1161,6 @@
>  # @paused: whether the job is paused or, if @busy is true, will
>  #          pause itself as soon as possible.  Since 1.3.
>  #
> -# @offset: the current progress value
> -#
>  # @speed: the rate limit, bytes per second
>  #
>  # @io-status: the status of the job (since 1.3)
> 

It matches current actual behavior, so it's probably a good update. It
feels like a change in behavior, but it's rather just codifying the
existing reality.

OK.

Reviewed-by: John Snow <jsnow@redhat.com>
