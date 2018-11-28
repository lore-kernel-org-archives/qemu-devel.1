Received: from eggs.gnu.org ([2001:4830:134:3::10]:59533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gS3VR-00082e-Gs
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:20:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gS3VO-0007CZ-Qd
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:20:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gS3VO-0007Bm-JC
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:20:06 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2344659AC
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 17:20:05 +0000 (UTC)
Date: Wed, 28 Nov 2018 17:20:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181128172001.GV24355@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181128153526.10948-1-berrange@redhat.com>
	<31667b3c-0071-e2b3-63d1-2fdc0c96c98f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <31667b3c-0071-e2b3-63d1-2fdc0c96c98f@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH] Document how to test the site
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

On Wed, Nov 28, 2018 at 11:15:11AM -0600, Eric Blake wrote:
> On 11/28/18 9:35 AM, Daniel P. Berrang=C3=A9 wrote:
> > Add a README file that tells people this is a jekyll based static
> > website, and shows people how to run jekyll for testing purposes.
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >=20
> > NB, we should really mention a license in the README too, but I don't
> > see info about what license we consider qemu-web to be covered by...
> >=20
> >   README      | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++
> >   _config.yml |  2 ++
> >   2 files changed, 55 insertions(+)
> >   create mode 100644 README
> >=20
> > diff --git a/README b/README
> > new file mode 100644
> > index 0000000..d06606a
> > --- /dev/null
> > +++ b/README
> > @@ -0,0 +1,53 @@
> > +QEMU Webite
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> s/Webite/Website/ (and the corresponding =3D line lengthening)
>=20
>=20
> > +* Install Jekyll and its dependencies
> > +
> > +   # bundle install --path vendor
> > +
>=20
> $ pwd
> /home/eblake
> $ bundle install --path vendor
> Could not locate Gemfile
>=20
> What am I missing?
>=20
> > +Jekyll is now installed into the 'vendor/' directory of the git chec=
kout.
>=20
> Oh - this step must be run within the top-level directory of the
> qemu-web.git checkout (which might be obvious for someone reading the R=
EADME
> from a fresh qemu-web git checkout, but wasn't for me while reviewing t=
he
> patch).  So I repeated the command in the right directory, and it appea=
rs to
> work:
>=20
> $ bundle install --path vendor
> Fetching gem metadata from https://rubygems.org/..............
> Fetching gem metadata from https://rubygems.org/..
> Resolving dependencies...
> Fetching public_suffix 2.0.5
> ...
> Installing jekyll 3.3.0
> ...
> Bundle complete! 9 Gemfile dependencies, 25 gems now installed.
> Bundled gems are installed into `./vendor`
> ...
>=20
> but I don't know if it is the same version of Jekyll that the documenta=
tion
> wanted ("QEMU requires a specific version of Jekyll which may not match=
 that
> provided by your OS vendor" doesn't actually say WHICH specific version=
).

Yes,  'bundle install' reads the versions from Gemfile, so it should
get the right version that qemu-web wants. Thus I preferred not to
duplicate the version in the docs too.

>=20
> > +Note the 'vendor/' path has been explicitly excluded from the web co=
ntent
> > +in _config.yml, so don't try to use a different path within the git
> > +checkout.
> > +
> > +
> > +To test the site launch jeykll
> > +
> > +  # bundle exec jekyll serve
>=20
> $ bundle exec jekyll serve
> Configuration file: /home/eblake/qemu-web/_config.yml
> Configuration file: /home/eblake/qemu-web/_config.yml
>             Source: /home/eblake/qemu-web
>        Destination: /home/eblake/qemu-web/_site
>  Incremental build: disabled. Enable with --incremental
>       Generating...
>              ERROR: YOUR SITE COULD NOT BE BUILT:
>                     ------------------------------------
>                     Invalid date '<%=3D Time.now.strftime('%Y-%m-%d %H:=
%M:%S
> %z') %>': Document 'vendor/ruby/2.5.0/gems/jekyll-3.3.0/lib/site_templa=
te/_posts/0000-00-00-welcome-to-jekyll.markdown.erb'
> does not have a valid date in the YAML front matter.
>=20
> Did I do things right?

Yes, but this error is what the addition in _config.yml.....

> > diff --git a/_config.yml b/_config.yml
> > index 0a0201c..576b0a5 100644
> > --- a/_config.yml
> > +++ b/_config.yml
> > @@ -37,3 +37,5 @@ gems:
> >   exclude:
> >     - Gemfile
> >     - Gemfile.lock
> > +  - vendor/
> > +  - README

...here is supposed to fix, so I'm puzzelled why you'd still get that
error message

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
