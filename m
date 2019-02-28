Received: from eggs.gnu.org ([209.51.188.92]:59295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzP9d-0003o3-Pq
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzP9b-0004gs-Tw
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:07:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gzP9a-0004ea-0J
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:07:26 -0500
References: <20190228165508.21594-1-chen.zhang@intel.com>
	<20190228165508.21594-6-chen.zhang@intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bd6dbeb3-d22b-e432-8fd4-155141c64ef2@redhat.com>
Date: Thu, 28 Feb 2019 11:07:18 -0600
MIME-Version: 1.0
In-Reply-To: <20190228165508.21594-6-chen.zhang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2 5/7] qapi/migration.json: Remove a
 variable that doesn't exist in example
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
> Remove the "active" variable in example for query-colo-status.
> 
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  qapi/migration.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

Might be nice to mention that the doc bug has been present since the
command's introduction in commit f56c0065.

> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 48e21880a3..f4c1762dfc 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1342,7 +1342,7 @@
>  # Example:
>  #
>  # -> { "execute": "query-colo-status" }
> -# <- { "return": { "mode": "primary", "active": true, "reason": "request" } }
> +# <- { "return": { "mode": "primary", "reason": "request" } }
>  #
>  # Since: 3.1
>  ##
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
