Received: from eggs.gnu.org ([2001:4830:134:3::10]:49060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gPnyd-0005nt-MY
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gPnyZ-0008Nb-Lk
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:20:59 -0500
References: <20181116200016.2080785-1-eblake@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b5ad7ab0-b880-2cc0-c5b5-ebe5b4022494@vivier.eu>
Date: Thu, 22 Nov 2018 13:20:49 +0100
MIME-Version: 1.0
In-Reply-To: <20181116200016.2080785-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v3] qapi: Reduce Makefile
 boilerplate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com

On 16/11/2018 21:00, Eric Blake wrote:
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
> 
> ---
> v3: also tweak .gitignore [Dan]
> v2: also condense Makefile.objs, prefer $(FOO:%=a%b) over
> $(patsubst %,a%b,$(FOO))
> ---
>  Makefile      | 192 ++++++--------------------------------------------
>  Makefile.objs |  75 ++------------------
>  .gitignore    |  72 ++-----------------
>  3 files changed, 34 insertions(+), 305 deletions(-)

Applied to qemu-trivial branch.

Thanks,
Laurent
