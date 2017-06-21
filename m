Received: from eggs.gnu.org ([2001:4830:134:3::10]:36674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dNbVT-0005Q7-RJ
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dNbVP-0002iE-Af
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:00:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dNbVP-0002hX-5J
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:00:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 20D7AC060203
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 09:00:54 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1498031528-1990-8-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Wed, 21 Jun 2017 15:52:05 +0800")
References: <1498031528-1990-1-git-send-email-peterx@redhat.com>
	<1498031528-1990-8-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 21 Jun 2017 11:00:40 +0200
Message-ID: <8760fpn29z.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 07/10] migration: move
 skip_configuration out
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
> It was in SaveState but now moved to MigrationState altogether, reverted
> its meaning, then renamed to "send_configuration". Again, using
> HW_COMPAT_2_3 for old PC/SPAPR machines, and accel_register_prop() for
> xen_init().
>
> Removing savevm_skip_configuration().
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
