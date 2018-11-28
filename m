Received: from eggs.gnu.org ([2001:4830:134:3::10]:46093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gS3AR-0005n3-LJ
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:58:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gS3AN-0001p4-DP
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:58:27 -0500
Date: Wed, 28 Nov 2018 16:58:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181128165803.GT24355@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1543399094-2260-1-git-send-email-thuth@redhat.com>
	<20181128160525.GP24355@redhat.com>
	<3d95da16-5f2a-2ec8-a674-189b44eab222@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d95da16-5f2a-2ec8-a674-189b44eab222@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1?] target/arm/sve_helper: Fix
 compilation with clang 3.4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Richard Henderson <rth@twiddle.net>

On Wed, Nov 28, 2018 at 05:50:38PM +0100, Thomas Huth wrote:
> On 2018-11-28 17:05, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Nov 28, 2018 at 10:58:14AM +0100, Thomas Huth wrote:
> >> Clang 3.4 does not know the "flatten" attribute yet. We've already
> >> introduced the QEMU_FLATTEN macro for this in commit 97ff87c0ed020c2=
,
> >> so use this macro now here, too, to fix this issue.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >=20
> > Although we currently only aim to support CLang and GCC, we don't hav=
e
> > any checks for a minimum version of these two tools in configure.
> >=20
> > So I was wondering if we actually still need to support CLang 3.4 at =
all
> > in QEMU, given our targetted build platforms.
> >=20
> > Unfortunately repology.org is failing me in reporting clang versions
> > for most distros, so I don't have an answer yet. I do see that Debian
> > Jessie however ships clang =3D=3D 3.5 and that's usually the oldest d=
istro
> > if RHEL hasn't got something older.
>=20
> I'm using RHEL7 and the clang that I get "for free" is 3.4.2 via EPEL.

Hmm, raises interesting question of whether we should consider 3rd
party repos for purposes of determining our min versions.

I'd pretty much intended to only care about vendor provided repos,
in which case RHEL7 would be considered to lack clang, for purposes
of deciding min versions.

EPEL is a bit murky because while it is a 3rd party repo, many users
of RHEL consider to be a defacto standard repo.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
