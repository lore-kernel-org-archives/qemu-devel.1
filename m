Received: from eggs.gnu.org ([2001:4830:134:3::10]:44644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d8pMQ-0005RG-Ag
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d8pMP-0006s2-2Q
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:46:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d8pMO-0006ro-TB
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:46:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D55FB7F3E1
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 14:46:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170511143901.6340-1-quintela@redhat.com> (Juan Quintela's
	message of "Thu, 11 May 2017 16:39:01 +0200")
References: <20170511143901.6340-1-quintela@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 11 May 2017 16:46:28 +0200
Message-ID: <87mvajh2nv.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] migration: Move check_migratable() into
 qdev.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Juan Quintela <quintela@redhat.com> wrote:
> The function is only used once, and nothing else in migration knows
> about objects.  Create the function vmstate_device_is_migratable() in
> savem.c that really do the bit that is related with migration.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Hi, I forget to "add" the comments section.

I switched to Peter Xu idea of only testing ->unmigratable is savevm.c
and move the only_migratable check to qdev.c.

Once there, change the return types from -1/0 to true/false and improve
slightly the naming.

Please, comment.
