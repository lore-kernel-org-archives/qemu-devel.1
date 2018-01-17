Received: from eggs.gnu.org ([2001:4830:134:3::10]:35510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eboKs-0005PC-Df
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:05:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eboKp-00082y-6I
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:05:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eboKo-00080o-Up
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:04:59 -0500
Date: Wed, 17 Jan 2018 14:04:41 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180117140441.GO19227@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20180112125000.27256-1-f4bug@amsat.org>
	<efc62dcb-cd6f-97c4-20b7-b2a4d210e55a@redhat.com>
	<20180117102527.GD19227@redhat.com>
	<19661b12-2ac7-5253-3d6a-44c8994c18cc@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19661b12-2ac7-5253-3d6a-44c8994c18cc@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/7] docker: update Ubuntu and Fedora
 images, deprecate old ones
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Fam Zheng <fzheng@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Wed, Jan 17, 2018 at 10:58:21AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 01/17/2018 07:25 AM, Daniel P. Berrange wrote:
> > On Wed, Jan 17, 2018 at 10:26:36AM +0800, Fam Zheng wrote:
> >> On 01/12/2018 08:49 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> Hi,
> >>>
> >>> This series is to be clearer about which upstream version we are us=
ing.
> >>>
> >>> All "FROM distrib:latest" entries have now been removed and replace=
d by
> >>> explicit "FROM distrib:version" ones.
> >>>
> >>> To keep backward compatibility, a warning is displayed to the user,
> >>> suggesting which correct base image to use.
> >>>
> >>> To be consistent, we remove the deprecated images of the "make dock=
er" output.
> >>
> >> Changing image names when a new release comes out is not maintainabl=
e for
> >> Fedora and Ubuntu because of the fast pace. Therefore I prefer Paolo=
's
> >> simple patch.
> >=20
> > The flipside is that if we release QEMU 2.12 with fedora:27, then for=
 as  long
> > as the 2.12 stable branch exists, dockers tests run on that branch wi=
ll have a
> > consistent target and will be unlikely to break.  If we use fedora:la=
test,
> > then every time a new Fedora comes out there's non-trivial chance tha=
t docker
> > builds on all the stable branches will all break due to some new glib=
c change.
> > Sticking with explicit named versions is a big win in this respect IM=
HO.
>=20
> What happened to me twice is checking an older QEMU tag while bisecting
> and being unable to run 'make docker-test' because the older QEMU tag
> use 'latest' which is not the current 'latest' from the Docker library,
> and I had to manually change the tag to the version 'latest' was
> pointing to at the time of the QEMU tag release.
>=20
> On each stable release we need to freeze the current tag in a new
> Dockerfile, and keep the generic Dockerfile following the 'latest' tag.
>=20
> Once tagged different that 'latest' the Dockerfile isn't suppose to
> change. So we only maintain the 'latest' version.
>=20
> Fam/Alex/Daniel do you agree with this approach?

I don't see a benefit to that as opposed to just updating git master
to the most recent Fedora stable release every 6 months. In fact it is
more work, because it'll require special action by whomever actually
makes the releases.

Even in git master the use of 'latest' is causing pain. A patch series
of mine passed when i run it in docker because it pulled down fresh
f26 image to my machine, but it failed in patchew because patchew had
latest resolving to a previously cached f25 image. Using explicit
versions all the time will avoid this kind of caching problem.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
