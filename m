Received: from eggs.gnu.org ([2001:4830:134:3::10]:49476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNbBr-0002qV-JZ
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:17:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNbBp-00077y-Lw
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:17:31 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181115225052.1322639-1-eblake@redhat.com>
Date: Fri, 16 Nov 2018 11:17:25 +0100
In-Reply-To: <20181115225052.1322639-1-eblake@redhat.com> (Eric Blake's
	message of "Thu, 15 Nov 2018 16:50:52 -0600")
Message-ID: <87bm6p72dm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] qapi: Reduce Makefile boilerplate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, pbonzini@redhat.com, xiezhide@huawei.com

Eric Blake <eblake@redhat.com> writes:

> Adding a new qapi module requires some rather tedious repetition to
> wire it into Makefile and Makefile.objs. Add some indirection by
> taking advantage of GNU Make string processing to expand a list
> of module names into all the required artifacts, so that future
> additions of a new module need only touch the list of module names.
>
> The list has to live in Makefile.objs, due to the way that
> unnest-vars slirps in that file without remembering any definition
> of $(QAPI_MODULES) from Makefile.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
> v2: also condense Makefile.objs, prefer $(FOO:%=a%b) over
> %(patsubst %,a%b,$(foo))
> ---
>  Makefile      | 192 ++++++--------------------------------------------
>  Makefile.objs |  75 ++------------------
>  2 files changed, 30 insertions(+), 237 deletions(-)

Lovely diffstat.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
