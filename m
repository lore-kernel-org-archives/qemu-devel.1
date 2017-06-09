Received: from eggs.gnu.org ([2001:4830:134:3::10]:44413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dJEY7-00051k-49
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 03:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dJEY3-0006Vn-9A
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 03:41:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dJEY3-0006VZ-2a
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 03:41:35 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2657155E4
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 07:41:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1496980142-8986-2-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Fri, 9 Jun 2017 11:48:57 +0800")
References: <1496980142-8986-1-git-send-email-peterx@redhat.com>
	<1496980142-8986-2-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 09 Jun 2017 09:41:28 +0200
Message-ID: <87k24la9qv.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/6] machine: export
 register_compat_prop()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> We have HW_COMPAT_*, however that's only binded to machines, not other
> things (like accelerators).  Behind it, it was register_compat_prop()
> that played the trick.  Let's export the function for further use
> outside HW_COMPAT_* magic.
>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Marcel Apfelbaum <marcel@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>


I would let others talk about this approach, for me it is ok.

Later, Juan.
