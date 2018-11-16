Received: from eggs.gnu.org ([2001:4830:134:3::10]:52660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNbLE-00019K-8o
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:27:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNbLA-0006iG-Bl
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:27:12 -0500
Date: Fri, 16 Nov 2018 10:26:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181116102659.GA28597@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181115225052.1322639-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181115225052.1322639-1-eblake@redhat.com>
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, xiezhide@huawei.com

On Thu, Nov 15, 2018 at 04:50:52PM -0600, Eric Blake wrote:
> Adding a new qapi module requires some rather tedious repetition to
> wire it into Makefile and Makefile.objs. Add some indirection by
> taking advantage of GNU Make string processing to expand a list
> of module names into all the required artifacts, so that future
> additions of a new module need only touch the list of module names.
>=20
> The list has to live in Makefile.objs, due to the way that
> unnest-vars slirps in that file without remembering any definition
> of $(QAPI_MODULES) from Makefile.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v2: also condense Makefile.objs, prefer $(FOO:%=3Da%b) over
> %(patsubst %,a%b,$(foo))
> ---
>  Makefile      | 192 ++++++--------------------------------------------
>  Makefile.objs |  75 ++------------------
>  2 files changed, 30 insertions(+), 237 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Though I'd also suggest .gitignore is updated to use wildcards
to exclude the generated files.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
