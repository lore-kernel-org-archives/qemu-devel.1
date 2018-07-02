Received: from eggs.gnu.org ([2001:4830:134:3::10]:58930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fZrcI-0007Fv-Dh
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 01:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fZrcD-0000R8-J5
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 01:43:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50440 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fZrcD-0000QZ-Ff
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 01:43:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A09583207
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 05:43:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180620073223.31964-1-peterx@redhat.com>
	<871sctea4y.fsf@dusky.pond.sub.org>
Date: Mon, 02 Jul 2018 07:43:06 +0200
In-Reply-To: <871sctea4y.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Tue, 26 Jun 2018 19:21:49 +0200")
Message-ID: <87sh52b3bp.fsf_-_@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] monitor: enable OOB by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org

More lose ends:

* scripts/qmp/ doesn't support OOB, yet.  qmp-shell.py in particular

* test-qmp-cmds neglects to cover the OOB additions to qmp-dispatch.c
