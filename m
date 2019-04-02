Received: from eggs.gnu.org ([209.51.188.92]:42076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBCoV-0001Sg-JI
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 02:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBCmj-0007gM-U7
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 02:20:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hBCmj-0007fM-MV
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 02:20:37 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190326174510.13303-1-chen.zhang@intel.com>
Date: Tue, 02 Apr 2019 08:20:29 +0200
In-Reply-To: <20190326174510.13303-1-chen.zhang@intel.com> (Zhang Chen's
	message of "Wed, 27 Mar 2019 01:45:10 +0800")
Message-ID: <87y34tgc7m.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qapi/migration.json: Fix documentation
 issue about query_colo_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <chen.zhang@intel.com>
Cc: Zhang Chen <zhangckid@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Eric Blake <eblake@redhat.com>, qemu-dev <qemu-devel@nongnu.org>

Zhang Chen <chen.zhang@intel.com > writes:

> From: Zhang Chen <chen.zhang@intel.com>
>
> The documentation with the wrong initial version number of last_mode field,
> This patch just fix this issue.
>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  qapi/migration.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index cfde29acf8..798c6ac2df 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1382,7 +1382,7 @@
>  #
>  # @last_mode: COLO last running mode. If COLO is running, this field
>  #             will return same like mode field, after failover we can
> -#             use this field to get last colo mode. (since 4.1)
> +#             use this field to get last colo mode. (since 4.0)
>  #
>  # @reason: describes the reason for the COLO exit.
>  #

What's the excuse for spelling last_mode with '_' instead of '-'?

Any objection to changing it to last-mode?
