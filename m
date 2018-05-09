Received: from eggs.gnu.org ([2001:4830:134:3::10]:59478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGOfR-0008Bp-C0
	for qemu-devel@nongnu.org; Wed, 09 May 2018 08:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGOfQ-0006hH-JE
	for qemu-devel@nongnu.org; Wed, 09 May 2018 08:58:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49034 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fGOfQ-0006go-E8
	for qemu-devel@nongnu.org; Wed, 09 May 2018 08:58:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EF346A27DB
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 12:57:59 +0000 (UTC)
References: <20180509112406.6183-1-quintela@redhat.com>
	<20180509112406.6183-23-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e60f7080-ad94-aeb4-9d0a-1da340e9909c@redhat.com>
Date: Wed, 9 May 2018 07:57:59 -0500
MIME-Version: 1.0
In-Reply-To: <20180509112406.6183-23-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 22/41] migration: new state
 "postcopy-recover"
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
> Introducing new migration state "postcopy-recover". If a migration
> procedure is paused and the connection is rebuilt afterward
> successfully, we'll switch the source VM state from "postcopy-paused" to
> the new state "postcopy-recover", then we'll do the resume logic in the
> migration thread (along with the return path thread).
> 
> This patch only do the state switch on source side. Another following up
> patch will handle the state switching on destination side using the same
> status bit.
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Message-Id: <20180502104740.12123-10-peterx@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---

> +++ b/qapi/migration.json
> @@ -91,6 +91,8 @@
>   #
>   # @postcopy-paused: during postcopy but paused. (since 2.13)
>   #
> +# @postcopy-recover: trying to recover from a paused postcopy. (since 2.11)
> +#

This doesn't have to hold up the pull request (a followup patch is 
fine), but this needs s/2.11/2.13/


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
