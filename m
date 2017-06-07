Received: from eggs.gnu.org ([2001:4830:134:3::10]:37098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIeCi-0004ze-JM
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIeCc-0005Yg-J1
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:53:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dIeCc-0005Xx-CR
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:53:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 532F9804E0
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 16:53:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1496745042-2379-2-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Tue, 6 Jun 2017 18:30:37 +0800")
References: <1496745042-2379-1-git-send-email-peterx@redhat.com>
	<1496745042-2379-2-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 07 Jun 2017 18:52:57 +0200
Message-ID: <87o9tzd9jq.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/6] migration: let MigrationState be a qdev
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

I am not qapi expert, but for the migration bits:

Reviewed-by: Juan Quintela <quintela@redhat.com>
