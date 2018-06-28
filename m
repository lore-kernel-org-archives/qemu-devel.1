Received: from eggs.gnu.org ([2001:4830:134:3::10]:56801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYeK6-0005tg-7m
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:19:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYeK2-00020r-1E
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:19:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38352 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fYeK1-0001yv-Sh
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:19:21 -0400
References: <20180627204136.4177-1-zhangckid@gmail.com>
	<20180627204136.4177-12-zhangckid@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3464fd15-6b1c-b524-0445-58fb352c1b42@redhat.com>
Date: Thu, 28 Jun 2018 16:19:18 -0500
MIME-Version: 1.0
In-Reply-To: <20180627204136.4177-12-zhangckid@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V9 11/20] qapi/migration.json: Rename COLO
 unknown mode to none mode.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <chen.zhang@intel.com>

On 06/27/2018 03:41 PM, Zhang Chen wrote:
> From: Zhang Chen <chen.zhang@intel.com>
> 
> Suggested by Markus Armbruster rename COLO unknown mode to none mode.
> 
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>   migration/colo-failover.c |  2 +-
>   migration/colo.c          |  2 +-
>   qapi/migration.json       | 10 +++++-----
>   3 files changed, 7 insertions(+), 7 deletions(-)

>   # Since: 2.8
>   ##
>   { 'enum': 'COLOMode',
> -  'data': [ 'unknown', 'primary', 'secondary'] }
> +  'data': [ 'none', 'primary', 'secondary'] }

The deletion of 'unknown' could potentially be a user-visible regression 
visible if COLOMode were in a QMP command; but thankfully the generated 
qapi/qapi-introspect.c does not seem to cover this enum, so it just 
affects internal code for now.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
