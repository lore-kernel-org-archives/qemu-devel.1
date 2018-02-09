Received: from eggs.gnu.org ([2001:4830:134:3::10]:40982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ekAWr-0001EU-PO
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ekAWo-0007Hu-K4
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:23:57 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37292 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ekAWo-0007He-EY
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:23:54 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D151A8182D05
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 15:23:53 +0000 (UTC)
References: <20180208171807.24267-1-stefanha@redhat.com>
	<20180208171807.24267-3-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <012d5365-3c70-daff-4037-0253996abf98@redhat.com>
Date: Fri, 9 Feb 2018 09:23:53 -0600
MIME-Version: 1.0
In-Reply-To: <20180208171807.24267-3-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] block: test blk_aio_flush() with
 blk->root == NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

On 02/08/2018 11:18 AM, Stefan Hajnoczi wrote:
> From: Kevin Wolf <kwolf@redhat.com>
> 
> This patch adds test cases for the scenario where blk_aio_flush() is
> called on a BlockBackend with no root.  Calling drain afterwards should
> complete the requests with -ENOMEDIUM.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   tests/Makefile.include     |  2 ++
>   tests/test-block-backend.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 84 insertions(+)
>   create mode 100644 tests/test-block-backend.c
> 

> +++ b/tests/test-block-backend.c
> @@ -0,0 +1,82 @@
> +/*
> + * BlockBackend tests
> + *
> + * Copyright (c) 2017 Kevin Wolf <kwolf@redhat.com>

Want to include 2018?  Using a redhat.com address but a personal 
copyright?  (Then again, Red Hat has some pretty cool policies on what 
it permits for code written on an employee's own time).

As long as Kevin is happy with the final copyright line that goes into 
the commit:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
