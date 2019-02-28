Received: from eggs.gnu.org ([209.51.188.92]:58751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzP7P-0001wK-LE
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:05:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzP7O-00031y-Na
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:05:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gzP7O-00031F-GY
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:05:10 -0500
References: <20190228165508.21594-1-chen.zhang@intel.com>
	<20190228165508.21594-5-chen.zhang@intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8b4f2327-fc03-4cda-4b18-876c77339b5b@redhat.com>
Date: Thu, 28 Feb 2019 11:05:08 -0600
MIME-Version: 1.0
In-Reply-To: <20190228165508.21594-5-chen.zhang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2 4/7] Migration/colo.c: Add new
 COLOExitReason to handle all failover state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, qemu-dev <qemu-devel@nongnu.org>

On 2/28/19 10:55 AM, Zhang Chen wrote:
> From: Zhang Chen <chen.zhang@intel.com>
> 
> In this patch we add the processing state for COLOExitReason,
> because we have to identify COLO in the failover processing state or
> failover error state. In the way, we can handle all the failover state.
> We have improved the description of the COLOExitReason by the way.
> 
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  migration/colo.c    | 24 +++++++++++++-----------
>  qapi/migration.json | 15 +++++++++------
>  2 files changed, 22 insertions(+), 17 deletions(-)
> 

> +++ b/qapi/migration.json
> @@ -983,19 +983,22 @@
>  ##
>  # @COLOExitReason:
>  #
> -# The reason for a COLO exit
> +# Describe the reason for COLO exit.
>  #
> -# @none: no failover has ever happened. This can't occur in the
> -# COLO_EXIT event, only in the result of query-colo-status.
> +# @none: failover has never happened. This state does not occurred
> +# in the COLO_EXIT event, only happened in the result of
> +# query-colo-status.

Grammar suggestion:

This state does not occur in the COLO_EXIT event, and is only visible in
the result of query-colo-status.

>  #
> -# @request: COLO exit is due to an external request
> +# @request: COLO exit caused by an external request.
>  #
> -# @error: COLO exit is due to an internal error
> +# @error: COLO exit caused by an internal error.
> +#
> +# @processing: COLO in failover handling state.

Missing a (since 4.0) tag.  Maybe:

@processing: COLO is currently handling a failover (since 4.0).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
