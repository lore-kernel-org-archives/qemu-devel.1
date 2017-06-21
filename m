Received: from eggs.gnu.org ([2001:4830:134:3::10]:36026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dNbTH-0003uR-Nq
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dNbTB-0000II-Nd
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:58:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dNbTB-0000HN-Hn
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:58:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 562137CE17
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 08:58:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1498031528-1990-5-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Wed, 21 Jun 2017 15:52:02 +0800")
References: <1498031528-1990-1-git-send-email-peterx@redhat.com>
	<1498031528-1990-5-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 21 Jun 2017 10:58:29 +0200
Message-ID: <87h8z9n2dm.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 04/10] migration: let MigrationState be
 a qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

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
> Now we init the MigrationState struct statically in main() to make sure
> it's initialized after global properties are applied, since we'll use
> them during creation of the object.
>
> No functional change at all.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
