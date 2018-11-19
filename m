Received: from eggs.gnu.org ([2001:4830:134:3::10]:46448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gOjJj-0000Ow-7f
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:10:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gOjJf-0001wj-6z
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:10:19 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181116200016.2080785-1-eblake@redhat.com>
Date: Mon, 19 Nov 2018 14:10:07 +0100
In-Reply-To: <20181116200016.2080785-1-eblake@redhat.com> (Eric Blake's
	message of "Fri, 16 Nov 2018 14:00:16 -0600")
Message-ID: <87h8gdqkls.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3] qapi: Reduce Makefile boilerplate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, pbonzini@redhat.com

Eric Blake <eblake@redhat.com> writes:

> Adding a new qapi module had some rather tedious repetition to
> wire it into Makefile, Makefile.objs, and .gitignore (for example,
> see commit bf42508f and its followup b61acdec). For make, add some
> indirection by taking advantage of GNU Make string processing to
> expand a list of module names into all the required artifacts, so
> that future additions of a new module need only touch the list of
> module names.  And for gitignore, use globs to cover all generated
> file names.
>
> The list has to live in Makefile.objs, due to the way that
> our unnest-vars macro slirps in that file without remembering
> any definition of $(QAPI_MODULES) from Makefile.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
