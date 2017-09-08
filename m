Received: from eggs.gnu.org ([2001:4830:134:3::10]:32802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dqFex-00033t-U2
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:33:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dqFeq-0006BS-KT
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:33:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dqFeq-0006AV-EO
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:33:04 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170831142430.16665-1-berrange@redhat.com>
Date: Fri, 08 Sep 2017 11:33:01 +0200
In-Reply-To: <20170831142430.16665-1-berrange@redhat.com> (Daniel
	P. Berrange's message of "Thu, 31 Aug 2017 15:24:25 +0100")
Message-ID: <87r2vhfsc2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 0/5] qapi: support py2 & py3 in parallel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, David Michael <fedora.dm0@gmail.com>

"Daniel P. Berrange" <berrange@redhat.com> writes:

> Since I claimed that supporting py2 & py3 in parallel would be easy
> for QEMU, I figured I ought to actually give it a try to backup that
> assertion.
>
> This small patch series is the result of that effort. I tested this
> series on Fedora 26 using 2.7.13 and Python 3.6.2.
>
> To test with py3, I hacked config-host.mak to change the PYTHON
> variable to point to 'python3' binary, then compared the following
> generated content for the files:
>
>    qmp-commands.h qapi-types.h  qapi-visit.h  qapi-event.h
>    qmp-marshal.c qapi-types.c qapi-visit.c qapi-event.c
>    qmp-introspect.c qmp-introspect.h
>
> with that generated under py2 to see they are identical.
>
> It is possible there's still more bugs hiding that could impact
> on 2.6 or earlier versions of 3.x or 2.7.x, so this probably
> needs a bit wider testing, but I think the series illustrates
> the broad scope of the changes we can expect. Only the need
> to adapt to different module import locations adds to the
> line count, and that's fairly minimal.

This hasn't made it to the front of my review queue, but I got a quick
question meanwhile.

I guess this was triggered by the discussion of David's "[PATCH]
scripts: Support building with Python 3".  How does it differ from
David's patch?  Is it derived from it?  Or is it an independently
developed replacement?
