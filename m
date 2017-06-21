Received: from eggs.gnu.org ([2001:4830:134:3::10]:36943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dNbWH-0005s3-FJ
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:01:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dNbWD-00034f-Js
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:01:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dNbWD-00034L-EQ
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:01:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5E6F930AF42
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 09:01:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1498031528-1990-9-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Wed, 21 Jun 2017 15:52:06 +0800")
References: <1498031528-1990-1-git-send-email-peterx@redhat.com>
	<1498031528-1990-9-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 21 Jun 2017 11:01:38 +0200
Message-ID: <871sqdn28d.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 08/10] migration: move
 skip_section_footers
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
> Move it into MigrationState, revert its meaning and renaming it to
> send_section_footer, with a property bound to it. Same trick is played
> like previous patches.
>
> Removing savevm_skip_section_footers().
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
