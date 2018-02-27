Received: from eggs.gnu.org ([2001:4830:134:3::10]:50716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eqhh5-00070D-Kv
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:01:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eqhh2-0000W0-4K
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:01:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34188 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eqhh2-0000Vo-01
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:01:28 -0500
Date: Tue, 27 Feb 2018 16:01:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180227160124.GU18258@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-8-armbru@redhat.com>
	<addfee56-eb31-49b0-5321-d898ad1ed0a2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <addfee56-eb31-49b0-5321-d898ad1ed0a2@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/29] qapi: Turn generators into modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On Tue, Feb 27, 2018 at 09:53:22AM -0600, Eric Blake wrote:
> On 02/11/2018 03:35 AM, Markus Armbruster wrote:
> > The next commit will introduce a common driver program for all
> > generators.  The generators need to be modules for that.  qapi2texi.p=
y
> > already is.  Make the other generators follow suit.
> >=20
> > The changes are actually trivial.  Obvious in the diffs once you view
> > them with whitespace changes ignored.
> >=20
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   scripts/qapi-commands.py   | 43 ++++++++++++++++++--------------
> >   scripts/qapi-event.py      | 43 ++++++++++++++++++--------------
> >   scripts/qapi-introspect.py | 54 ++++++++++++++++++++++-------------=
-----
> >   scripts/qapi-types.py      | 56 ++++++++++++++++++++++-------------=
------
> >   scripts/qapi-visit.py      | 62 +++++++++++++++++++++++++----------=
-----------
> >   5 files changed, 143 insertions(+), 115 deletions(-)
>=20
> Urgh. One annoyance of this patch is that if you switch to another bran=
ch
> without the patch, leftover .pyc files in the source tree can cause wei=
rd
> errors until you 'rm -f scripts/qapi/*.pyc':

Pehaps make our build system set  PYTHONDONTWRITEBYTECODE=3D1  env variab=
le

  https://docs.python.org/3/using/cmdline.html#envvar-PYTHONDONTWRITEBYTE=
CODE

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
