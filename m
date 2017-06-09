Received: from eggs.gnu.org ([2001:4830:134:3::10]:44505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dJEYu-0005b6-G8
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 03:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dJEYq-0006d0-K9
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 03:42:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dJEYq-0006cu-EL
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 03:42:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 72BBA8553E
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 07:42:23 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1496980142-8986-3-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Fri, 9 Jun 2017 11:48:58 +0800")
References: <1496980142-8986-1-git-send-email-peterx@redhat.com>
	<1496980142-8986-3-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 09 Jun 2017 09:42:18 +0200
Message-ID: <87fuf9a9ph.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/6] migration: let MigrationState be a
 qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> Let the old man "MigrationState" join the object family. Direct benefit
> is that we can start to use all the property features derived from
> current QDev, like: HW_COMPAT_* bits, command line setup for migration
> parameters (so will never need to set them up each time using HMP/QMP,
> this is really, really attractive for test writters), etc.
>
> I see no reason to disallow this happen yet. So let's start from this
> one, to see whether it would be anything good.
>
> No functional change at all.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
