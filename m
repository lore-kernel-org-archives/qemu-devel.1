Received: from eggs.gnu.org ([2001:4830:134:3::10]:52726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYvqq-0004de-1H
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 12:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYvqm-00047x-VG
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 12:02:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49288 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fYvqm-00045S-Qo
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 12:02:20 -0400
References: <20180629080320.320144-1-dplotnikov@virtuozzo.com>
	<20180629080320.320144-2-dplotnikov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1a933047-a140-67a3-594a-dab4b28c1a83@redhat.com>
Date: Fri, 29 Jun 2018 11:02:19 -0500
MIME-Version: 1.0
In-Reply-To: <20180629080320.320144-2-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v0 1/7] migration: add background snapshot
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, dgilbert@redhat.com, quintela@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

On 06/29/2018 03:03 AM, Denis Plotnikov wrote:
> The capability is used for the background vmstate saving
> using the migration infrastructure.
> Background vmstate saving means that the majority of vmstate
> (RAM) is saved in the background when VM's vCPUS are running.
> This helps to reduce the VM downtime on VM snapshotting.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>   migration/migration.c | 35 +++++++++++++++++++++++++++++++++++
>   migration/migration.h |  1 +
>   qapi/migration.json   |  6 +++++-
>   3 files changed, 41 insertions(+), 1 deletion(-)
> 

> +++ b/qapi/migration.json
> @@ -352,12 +352,16 @@
>   #
>   # @x-multifd: Use more than one fd for migration (since 2.11)
>   #
> +# @background-snapshot: Using migration infrastructure makes VM snapshot
> +#         saving its RAM in background. This reduces  VM downtime. (since 2.12)

You've missed 2.12; the next release is 3.0 (and even then, we're fast 
coming up on soft freeze, so a maintainer must be willing to take this 
feature soon, or it will become 3.1 material).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
