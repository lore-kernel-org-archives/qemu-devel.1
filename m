Received: from eggs.gnu.org ([2001:4830:134:3::10]:45661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDs0w-0007mX-9N
	for qemu-devel@nongnu.org; Wed, 02 May 2018 09:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDs0t-0004ko-4s
	for qemu-devel@nongnu.org; Wed, 02 May 2018 09:41:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49328 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fDs0s-0004kN-Vi
	for qemu-devel@nongnu.org; Wed, 02 May 2018 09:41:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 61AAC40201A2
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 13:41:39 +0000 (UTC)
References: <20180425111940.1030-1-quintela@redhat.com>
	<20180425111940.1030-6-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0b563a7d-a9cf-dae6-968f-57c2426ed739@redhat.com>
Date: Wed, 2 May 2018 15:41:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180425111940.1030-6-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 5/8] tests: Migration ppc now inlines
 its program
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

On 25.04.2018 13:19, Juan Quintela wrote:
> No need to write it to a file.  Just need a proper firmware O:-)
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> CC: Laurent Vivier <lvivier@redhat.com>
> ---
>  tests/migration-test.c | 41 +++++------------------------------------
>  1 file changed, 5 insertions(+), 36 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
