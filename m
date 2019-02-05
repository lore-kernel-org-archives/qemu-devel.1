Received: from eggs.gnu.org ([209.51.188.92]:57935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gquRc-0005wb-NL
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 01:42:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gquRc-0000wB-1m
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 01:42:56 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190204211204.27321-1-philmd@redhat.com>
	<20190204211204.27321-4-philmd@redhat.com>
Date: Tue, 05 Feb 2019 07:42:49 +0100
In-Reply-To: <20190204211204.27321-4-philmd@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 4 Feb 2019 22:12:04
	+0100")
Message-ID: <87a7jaag7q.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/3] util/cutils: Move function
 documentations to the header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, qemu-riscv@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Many functions have documentation before the implementation in
> cutils.c. Since we expect documentation around the prototype
> declaration in headers,

We do?

There are two justifiable function comment placement styles: (1) next to
definition, and (2) next to declaration if it's in a header, else next
to definition.

The rationale for the latter is having the headers do double-duty as
interface documentation.

The rationale for the former is consistently placing the function
comments close to the code gives them a fighting chance to actually
match the code.

I'm in the "next to definition" camp.  If you want concise interface
specification, use something like Sphinx.

QEMU code is, as so often, in all camps.

>                         move the comments in cutils.h.

We document some cutils functions next to their definition, and some
next to their declaration.  The inconsistency is ugly, and your patch
fixes it.  I'd fix it in the other direction.

Even if we decide to fix this one in this direction, I object to the
sweeping generalization in the commit message :)
