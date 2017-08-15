Received: from eggs.gnu.org ([2001:4830:134:3::10]:44061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhWvh-0004rv-1d
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:10:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhWvc-0004oe-S0
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:10:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dhWvc-0004mc-Lh
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:10:20 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170731085110.1050-1-apahim@redhat.com>
	<20170731085110.1050-4-apahim@redhat.com>
Date: Tue, 15 Aug 2017 10:10:12 +0200
In-Reply-To: <20170731085110.1050-4-apahim@redhat.com> (Amador Pahim's message
	of "Mon, 31 Jul 2017 10:51:06 +0200")
Message-ID: <87zib1s13v.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 3/7] qemu.py: use python logging system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, ldoktor@redhat.com, famz@redhat.com, ehabkost@redhat.com, stefanha@gmail.com, mreitz@redhat.com, crosa@redhat.com

Please spell "Python" with a capital "P" (it's a proper name).

Amador Pahim <apahim@redhat.com> writes:

> Let's provide extra control and flexibility by using python logging
> system instead of print and/or sys.std*.write().
>
> Signed-off-by: Amador Pahim <apahim@redhat.com>

How exactly does this change error messages?

Is logging the right tool to report errors to the human user?  I'm
asking because logging and error reporting are generally separate
things.  Example: a program runs into a recoverable error.  It logs the
error, but does not report it.

Is reporting errors to stderr the right thing to do for library class
QEMUMachine?  I doubt it.  Libraries throw exceptions and let their
users decide how to handle them.
