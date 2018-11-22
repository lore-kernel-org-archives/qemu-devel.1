Received: from eggs.gnu.org ([2001:4830:134:3::10]:59850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gPn7s-0000eY-E9
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:26:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gPn7o-0003s1-CG
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:26:28 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gPn7o-0003i5-1k
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:26:24 -0500
Date: Thu, 22 Nov 2018 13:26:12 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181122112611.GB8920@lap1>
References: <20181116200016.2080785-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181116200016.2080785-1-eblake@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] qapi: Reduce Makefile boilerplate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

On Tue, Nov 20, 2018 at 01:17:28PM +0200, Eric Blake wrote:
> Adding a new qapi module had some rather tedious repetition to
> wire it into Makefile, Makefile.objs, and .gitignore (for example,
> see commit bf42508f and its followup b61acdec). For make, add some
> indirection by taking advantage of GNU Make string processing to
> expand a list of module names into all the required artifacts, so
> that future additions of a new module need only touch the list of
> module names.  And for gitignore, use globs to cover all generated
> file names.
>=20
> The list has to live in Makefile.objs, due to the way that
> our unnest-vars macro slirps in that file without remembering
> any definition of $(QAPI_MODULES) from Makefile.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
> v3: also tweak .gitignore [Dan]
> v2: also condense Makefile.objs, prefer $(FOO:%=3Da%b) over
> $(patsubst %,a%b,$(FOO))
> ---

Used it to integrate a new QMP message for pvrdma device and it indeed
makes effort minimal.

So:

Tested-by: Yuval Shaia <yuval.shaia@oracle.com>

Thanks,
Yuval

>  Makefile      | 192 ++++++--------------------------------------------
>  Makefile.objs |  75 ++------------------
>  .gitignore    |  72 ++-----------------
>  3 files changed, 34 insertions(+), 305 deletions(-)
>=20
