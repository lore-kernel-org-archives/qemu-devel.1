Received: from eggs.gnu.org ([2001:4830:134:3::10]:37294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0V51-0003s1-KO
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 13:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0V4x-0004Hk-Lh
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 13:06:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g0V4v-0004GV-Ro
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 13:06:55 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com
	[10.5.11.27])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AFFB308404C
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 17:06:53 +0000 (UTC)
References: <20180913132313.11370-1-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cb804ba8-5fb7-a5f9-0c56-cb7f6c299a95@redhat.com>
Date: Thu, 13 Sep 2018 12:06:44 -0500
MIME-Version: 1.0
In-Reply-To: <20180913132313.11370-1-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration-test: Only generate a single
 target architecture
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

On 9/13/18 8:23 AM, Juan Quintela wrote:
> Several changes:
> - We only allow generate header "inside" the tree.  Why?  Because we
>    need to connit the result, so it makes no sense to generate them on

s/connit/commit/

>    the build dir.
> - We only generate a single target each time.  Getting all the
>    cross-compilers correctly is an impossible task.  So know you do:

s/know/now/

>       make -C tests/migration $target (native)
>       make CROSS_PREFIX=foo- -C tests/migratiion $target (cross)
>    And you are done.
> 
> - If we are building out of tree, we have no data about if we are
>    cross-compile or whatever.  So instead of guess what is happening,
>    just do what I pointed on previous point.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>   tests/migration/Makefile | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
