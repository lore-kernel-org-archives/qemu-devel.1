Received: from eggs.gnu.org ([2001:4830:134:3::10]:41980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ekAae-0004WJ-5T
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:27:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ekAaa-00011K-Bq
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:27:52 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45380 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ekAaa-00010l-6l
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:27:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05BAF7D845
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 15:27:44 +0000 (UTC)
References: <20180208171807.24267-1-stefanha@redhat.com>
	<20180208171807.24267-4-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4f3ce4c9-7d76-c06d-8c03-229bf308e1e4@redhat.com>
Date: Fri, 9 Feb 2018 09:27:39 -0600
MIME-Version: 1.0
In-Reply-To: <20180208171807.24267-4-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] Revert "IDE: Do not flush empty CDROM
 drives"
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
> This reverts commit 4da97120d51a4383aa96d741a2b837f8c4bbcd0b.
> 
> blk_aio_flush() now handles the blk->root == NULL case, so we no longer
> need this workaround.
> 
> Cc: John Snow <jsnow@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   hw/ide/core.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
