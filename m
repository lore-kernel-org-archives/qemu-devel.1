Received: from eggs.gnu.org ([2001:4830:134:3::10]:47265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhfm7-0000Bu-8J
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 14:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhfm3-0005s6-Cb
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 14:41:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36284 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fhfm3-0005rm-6K
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 14:41:35 -0400
References: <20180722193350.6028-1-zhangckid@gmail.com>
	<20180722193350.6028-11-zhangckid@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0f358f05-46c7-cb77-c9fd-1d6673493df4@redhat.com>
Date: Mon, 23 Jul 2018 13:41:33 -0500
MIME-Version: 1.0
In-Reply-To: <20180722193350.6028-11-zhangckid@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V10 10/20] qmp event: Add COLO_EXIT event
 to notify users while exited COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

On 07/22/2018 02:33 PM, Zhang Chen wrote:
> From: zhanghailiang <zhang.zhanghailiang@huawei.com>
> 
> If some errors happen during VM's COLO FT stage, it's important to
> notify the users of this event. Together with 'x-colo-lost-heartbeat',
> Users can intervene in COLO's failover work immediately.
> If users don't want to get involved in COLO's failover verdict,
> it is still necessary to notify users that we exited COLO mode.
> 
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>   migration/colo.c    | 31 +++++++++++++++++++++++++++++++
>   qapi/migration.json | 38 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 69 insertions(+)

At this point in the release cycle, this series feels like enough of a 
new feature (rather than a bug fix) that it is probably not appropriate 
for 3.0, which means...


> +++ b/qapi/migration.json
> @@ -900,6 +900,44 @@
>   { 'enum': 'FailoverStatus',
>     'data': [ 'none', 'require', 'active', 'completed', 'relaunch' ] }
>   
> +##
> +# @COLO_EXIT:
> +#
> +# Emitted when VM finishes COLO mode due to some errors happening or
> +# at the request of users.
> +#
> +# @mode: report COLO mode when COLO exited.
> +#
> +# @reason: describes the reason for the COLO exit.
> +#
> +# Since: 3.0

...this and other references should be updated to 3.1.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
