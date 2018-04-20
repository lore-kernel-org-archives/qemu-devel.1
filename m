Received: from eggs.gnu.org ([2001:4830:134:3::10]:56425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f9QzC-0006Kc-3W
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f9Qz6-0008D3-73
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:01:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34984 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f9Qz6-0008CG-3i
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:01:32 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180419223151.623174-1-eblake@redhat.com>
	<20180419223151.623174-2-eblake@redhat.com>
Date: Fri, 20 Apr 2018 10:01:24 +0200
In-Reply-To: <20180419223151.623174-2-eblake@redhat.com> (Eric Blake's message
	of "Thu, 19 Apr 2018 17:31:50 -0500")
Message-ID: <87po2u1f3f.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qapi: Rename QMP and QGA schema
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Eric Blake <eblake@redhat.com> writes:

> Having two files in the tree both named qapi-schema.json just adds
> confusion.  Rename these files to {qmp,qga}-schema to make it
> obvious which schema is in effect, and relocate qga into the common
> qapi/ subdirectory.  Update all build rules that refer to the file
> names, and adjust other documentation and comment references that
> need to refer to the new file names.
>
> Maintainer-wise, this means that qapi/qga-schema.json continues
> to belong to Michael as QGA maintainer, but now also notifies
> Markus and Eric as QAPI maintainers, alongside all the other
> QMP QAPI files, matching how other .json QAPI modules belong
> to multiple maintainer blurbs.  Also, fix a stale reference to
> a file removed in commit eb815e248f.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

We have three separate things: QAPI infrastructure, its use in QEMU
proper, and its use in QGA.  We keep the former two in qapi/, and the
latter in qga/.

Giving the two qapi-schema.json different names is fine with me.
qga-schema.json is an obvious choice.  qmp-schema.json less so, because
it's actually used for more than just QMP now.  qemu-schema.json?  Or
just keep the old name?

Splitting qapi/ into infrastructure and use now doesn't seem to be worth
the bother.  I'd prefer to keep the use for QGA separate, though.  The
case for moving them together would be stronger if they shared schema
parts.  Matter of taste, I guess, and that means it's up to the QGA
maintainer.  Michael?

If we decide to keep them separate, but still want MAINTAINERS' QAPI
Schema stanza to cover QGA, that's a one-liner.
