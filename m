Received: from eggs.gnu.org ([2001:4830:134:3::10]:35951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa3ru-0002WW-Oy
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa3rr-0003iq-Nq
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:48:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51428 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fa3rr-0003iI-8x
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:48:07 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180629195544.34263-1-eblake@redhat.com>
	<20180629195544.34263-3-eblake@redhat.com>
Date: Mon, 02 Jul 2018 20:48:05 +0200
In-Reply-To: <20180629195544.34263-3-eblake@redhat.com> (Eric Blake's message
	of "Fri, 29 Jun 2018 14:55:44 -0500")
Message-ID: <87r2kl8oey.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] qapi: Drop qapi-gen --unmask option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, armbru@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Eric Blake <eblake@redhat.com> writes:

> Now that we have useful access to the type name as a comment
> in the generated qapi-introspect.c, we don't need to regenerate
> code with a temporary -u option just to get at type names.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

I occasionally feed output of query-qmp-schema to ad hoc Python scripts.
My last one searched for object types containing non-string members
(directly or indirectly).  -u remains useful there, and having to
recompile is not a problem.  I'd prefer to keep it.
