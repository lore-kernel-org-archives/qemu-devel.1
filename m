Received: from eggs.gnu.org ([2001:4830:134:3::10]:33529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fujXg-0006O1-1p
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fujKZ-000423-6Q
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:07:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45318 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fujKY-0003zu-W0
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:07:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8AB87C12C4
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 19:07:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180827213943.33524-1-eblake@redhat.com>
Date: Tue, 28 Aug 2018 21:07:08 +0200
In-Reply-To: <20180827213943.33524-1-eblake@redhat.com> (Eric Blake's message
	of "Mon, 27 Aug 2018 16:39:41 -0500")
Message-ID: <87wosajoo3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 0/2] qapi: easier debugging of
 introspection file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> When inspecting the generated qapi-introspect.c (for debugging,
> or to see what QAPI changes are user visible vs. internal only),
> the fact that we've intentionally masked names from the QMP client
> makes it harder to tie back generated code back to the original
> QAPI .json files.  We have a -u switch to qapi-gen for temporarily
> bypassing the name masking, but that's a rather heavy-handed
> tactic just for some temporary debugging.  Better is to just make
> the generated file include strategic comments.
>
> v1 was sent back in June, but was stalled due to 3.0 hard freeze.
> Now that 3.1 is open, it's time to revisit this.
>
> Since then:
> - drop the original patch 2 (deleting --unmask proved controversial) [Markus]
> - rebase patch on top of Marc-Andre's conditional work [Markus]
> - update documentation to match code change [Eric]
> - split out a preliminary cleanup patch [pep8]

Queued.  Thanks!
