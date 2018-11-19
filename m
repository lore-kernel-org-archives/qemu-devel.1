Received: from eggs.gnu.org ([2001:4830:134:3::10]:54943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOh0u-0005vk-3G
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:42:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOh0p-0008AO-VL
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:42:44 -0500
Date: Mon, 19 Nov 2018 10:42:35 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181119104235.GL19532@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181116200016.2080785-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, qemu-trivial@nongnu.org

On Fri, Nov 16, 2018 at 02:00:16PM -0600, Eric Blake wrote:
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
>=20
> ---
> v3: also tweak .gitignore [Dan]
> v2: also condense Makefile.objs, prefer $(FOO:%=3Da%b) over
> $(patsubst %,a%b,$(FOO))
> ---
>  Makefile      | 192 ++++++--------------------------------------------
>  Makefile.objs |  75 ++------------------
>  .gitignore    |  72 ++-----------------
>  3 files changed, 34 insertions(+), 305 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
