Received: from eggs.gnu.org ([2001:4830:134:3::10]:59342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGOei-0007lI-5L
	for qemu-devel@nongnu.org; Wed, 09 May 2018 08:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGOef-0005Wo-4A
	for qemu-devel@nongnu.org; Wed, 09 May 2018 08:57:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41656 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fGOee-0005WG-Vq
	for qemu-devel@nongnu.org; Wed, 09 May 2018 08:57:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C1A040200A0
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 12:57:12 +0000 (UTC)
References: <20180509112406.6183-1-quintela@redhat.com>
	<20180509112406.6183-21-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3e06b6ba-71bb-11f4-f2fc-9be98b8683d6@redhat.com>
Date: Wed, 9 May 2018 07:57:09 -0500
MIME-Version: 1.0
In-Reply-To: <20180509112406.6183-21-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 20/41] qmp: hmp: add migrate "resume" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 05/09/2018 06:23 AM, Juan Quintela wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> It will be used when we want to resume one paused migration.
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Message-Id: <20180502104740.12123-8-peterx@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>   hmp-commands.hx       | 7 ++++---
>   hmp.c                 | 4 +++-
>   migration/migration.c | 2 +-
>   qapi/migration.json   | 5 ++++-
>   4 files changed, 12 insertions(+), 6 deletions(-)
> 

> +++ b/qapi/migration.json
> @@ -1031,6 +1031,8 @@
>   # @detach: this argument exists only for compatibility reasons and
>   #          is ignored by QEMU
>   #
> +# @resume: resume one paused migration, default "off". (since 2.12)
> +#

This doesn't have to hold up the pull request (a followup patch is 
fine), but this should s/2.12/2.13/

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
