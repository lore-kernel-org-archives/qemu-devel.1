Received: from eggs.gnu.org ([2001:4830:134:3::10]:38810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXBJ7-0006R2-HE
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 15:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXBJ6-0007jI-O7
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 15:03:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dXBJ6-0007ig-IE
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 15:03:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7EBD1356D6
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 19:03:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1500279971-13875-10-git-send-email-peterx@redhat.com> (Peter
	Xu's message of "Mon, 17 Jul 2017 16:26:09 +0800")
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
	<1500279971-13875-10-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 17 Jul 2017 21:03:47 +0200
Message-ID: <87h8yanawc.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 09/11] migration: provide
 migrate_caps_check()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> Abstract helper function to check migration capabilities (from the old
> qmp_migrate_set_capabilities).  Prepare to be used somewhere else.
>
> There is side effect on the change: when applying the capabilities, we
> were skipping the invalid ones, but still applying the valid ones (if
> they are provided in the same QMP request). After this refactoring,
> we'll ignore all the capabilities if we detected invalid setup along the
> way. However, I don't think it is a problem since general users should
> not provide anything invalid after all.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

I think that the "caveat" that we used to set the valid capabilities in
one message is just undefined behaviour.  I preffer the new semmantics
anyways.
