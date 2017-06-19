Received: from eggs.gnu.org ([2001:4830:134:3::10]:39707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dMz3d-0005jW-8S
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dMz3Z-00048G-UF
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:57:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dMz3Z-00047X-O7
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:57:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9BFB67F6A1
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 15:57:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1497876588-947-14-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Mon, 19 Jun 2017 20:49:48 +0800")
References: <1497876588-947-1-git-send-email-peterx@redhat.com>
	<1497876588-947-14-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 19 Jun 2017 17:57:25 +0200
Message-ID: <87k2489di2.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 13/13] migration: move
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
