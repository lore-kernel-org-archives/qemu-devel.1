Received: from eggs.gnu.org ([2001:4830:134:3::10]:43711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebkuW-0002kr-SB
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:25:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebkuS-0007IK-T9
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:25:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ebkuS-0007Hr-Mu
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:25:32 -0500
Date: Wed, 17 Jan 2018 10:25:27 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180117102527.GD19227@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20180112125000.27256-1-f4bug@amsat.org>
	<efc62dcb-cd6f-97c4-20b7-b2a4d210e55a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <efc62dcb-cd6f-97c4-20b7-b2a4d210e55a@redhat.com>
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
To: Fam Zheng <fzheng@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Wed, Jan 17, 2018 at 10:26:36AM +0800, Fam Zheng wrote:
>=20
>=20
> On 01/12/2018 08:49 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi,
> >=20
> > This series is to be clearer about which upstream version we are usin=
g.
> >=20
> > All "FROM distrib:latest" entries have now been removed and replaced =
by
> > explicit "FROM distrib:version" ones.
> >=20
> > To keep backward compatibility, a warning is displayed to the user,
> > suggesting which correct base image to use.
> >=20
> > To be consistent, we remove the deprecated images of the "make docker=
" output.
>=20
> Changing image names when a new release comes out is not maintainable f=
or
> Fedora and Ubuntu because of the fast pace. Therefore I prefer Paolo's
> simple patch.

The flipside is that if we release QEMU 2.12 with fedora:27, then for as =
 long
as the 2.12 stable branch exists, dockers tests run on that branch will h=
ave a
consistent target and will be unlikely to break.  If we use fedora:latest=
,
then every time a new Fedora comes out there's non-trivial chance that do=
cker
builds on all the stable branches will all break due to some new glibc ch=
ange.
Sticking with explicit named versions is a big win in this respect IMHO.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
