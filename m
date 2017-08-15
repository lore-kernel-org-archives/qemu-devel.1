Received: from eggs.gnu.org ([2001:4830:134:3::10]:48220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhYRo-0003iT-1n
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhYRj-0001An-0P
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:47:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dhYRi-0001AA-QS
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:47:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3435C04D2B3
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 09:47:33 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170808203935.30021-1-ehabkost@redhat.com>
	<20170808203935.30021-2-ehabkost@redhat.com>
Date: Tue, 15 Aug 2017 11:47:28 +0200
In-Reply-To: <20170808203935.30021-2-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Tue, 8 Aug 2017 17:39:31 -0300")
Message-ID: <87o9rhp3gv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.11 v2 1/5] qmp-shell: Use optparse
 module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

> It makes command-line parsing and generation of help text much
> simpler.

There's really no excuse for parsing command line arguments by hand in
Python.

> The optparse module is deprecated since Python 2.7, but argparse
> is not available in Python 2.6 (the minimum Python version
> required for building QEMU).

We have a few uses of argparse in the tree.  Are they okay?

We also use getopt in places.  Perhaps we should pick one way to parse
command lines and stick to it.

>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
