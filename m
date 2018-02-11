Received: from eggs.gnu.org ([2001:4830:134:3::10]:33865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ekoCA-0006Im-8G
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:45:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ekoC5-0007BL-Rn
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:45:14 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54108 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ekoC5-0007AA-KC
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:45:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C6CF4084FEF
	for <qemu-devel@nongnu.org>; Sun, 11 Feb 2018 09:45:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180211004013.10784-1-eblake@redhat.com>
Date: Sun, 11 Feb 2018 10:44:58 +0100
In-Reply-To: <20180211004013.10784-1-eblake@redhat.com> (Eric Blake's message
	of "Sat, 10 Feb 2018 18:40:10 -0600")
Message-ID: <87h8qnj1wl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/3] QAPI file renames
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

> This has been mentioned on list before as a possible improvement,
> so I went ahead and did some renames to figure out how it would
> look.  Patch 1 is something I hit on the way while debugging
> patch 2 and 3; patch 2 is rather non-controversial, and patch 3
> may or may not be worth doing (but if we do it, it is going
> to cause a lot of rebase churn to anyone editing files in the
> meantime, although git rename detection will probably get things
> right more often than not).

Conflicts with my "[PATCH v2 00/29] Modularize generated QAPI code".
Your series is much smaller.  Would you mind rebasing it?
