Received: from eggs.gnu.org ([2001:4830:134:3::10]:34550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSMWN-0004EQ-8l
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 08:38:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSMWJ-0007Du-Gq
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 08:38:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gSMWJ-0007Cy-8D
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 08:38:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6E00A83F44
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 13:38:18 +0000 (UTC)
Date: Thu, 29 Nov 2018 13:38:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181129133811.GD25007@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181129104658.26585-1-berrange@redhat.com>
	<14b6a1da-dc71-adbc-1911-a6e281229c43@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14b6a1da-dc71-adbc-1911-a6e281229c43@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH v2] Document how to test the site
 with jekyll locally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On Thu, Nov 29, 2018 at 07:34:56AM -0600, Eric Blake wrote:
> On 11/29/18 4:46 AM, Daniel P. Berrang=C3=A9 wrote:
> > Add a README file that tells people this is a jekyll based static
> > website, and shows people how to run jekyll for testing purposes.
> >=20
> > Tested-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >   .gitignore  |  2 ++
> >   README      | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++
> >   _config.yml |  2 ++
> >   3 files changed, 59 insertions(+)
> >   create mode 100644 README
>=20
> > +Testing locally with Jekyll
> > +---------------------------
> > +
> > +When adding/changing content on this site, it is possible to run a
> > +local Jekyll service to test the result.
> > +
> > +QEMU requires a specific version of Jekyll (listedin Gemfile) which =
may
>=20
> s/listedin/listed in/
>=20
> > +++ b/_config.yml
> > @@ -37,3 +37,5 @@ gems:
> >   exclude:
> >     - Gemfile
> >     - Gemfile.lock
> > +  - vendor/
> > +  - README
>=20
> Should .gitignore be in this list?  But that's pre-existing.

AFAICT, it excludes all dotfiles by default

>=20
> With the typo fix,
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
