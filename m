Received: from eggs.gnu.org ([2001:4830:134:3::10]:44155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVWzc-0003TB-VP
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 02:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVWzc-0005Ds-3G
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 02:53:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52472 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fVWzb-0005DT-US
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 02:53:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9B35805A531
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 06:53:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180619203918.65450-1-eblake@redhat.com>
Date: Wed, 20 Jun 2018 08:53:21 +0200
In-Reply-To: <20180619203918.65450-1-eblake@redhat.com> (Eric Blake's message
	of "Tue, 19 Jun 2018 15:39:18 -0500")
Message-ID: <877emukkym.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] tests: Simplify .gitignore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, armbru@redhat.com

Eric Blake <eblake@redhat.com> writes:

> Commit 0bcc8e5b was yet another instance of 'git status' reporting
> dirty files after an in-tree build, thanks to the new binary
> tests/check-block-qdict.
>
> Instead of piecemeal exemptions of each new binary as they are
> added, let's use git's negative globbing feature to exempt ALL
> files that have a 'test-' or 'check-' prefix, except for the ones
> ending in '.c' or '.sh'.  We still have a couple of generated
> files that then need (re-)exclusion, but the overall list is a
> LOT shorter, and less prone to needing future edits.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

No objections to your patch, but the true cure for the ".gitignore is
huge and perpetually stale" is getting rid of in-tree builds.
