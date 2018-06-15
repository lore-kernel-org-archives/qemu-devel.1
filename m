Received: from eggs.gnu.org ([2001:4830:134:3::10]:49097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTqX7-0008K0-OS
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTqX4-0003aJ-Pg
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:21:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42922 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fTqX4-0003ZF-Kp
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:20:58 -0400
Date: Fri, 15 Jun 2018 16:20:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180615152052.GO31552@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180615044042.7928-1-tamiko@43-1.org>
	<20180615044042.7928-2-tamiko@43-1.org>
	<20180615094207.GK31552@redhat.com> <8736xorxsr.fsf@43-1.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8736xorxsr.fsf@43-1.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Partially revert commit d4e5ec877ca
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthias Maier <tamiko@43-1.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>

On Fri, Jun 15, 2018 at 08:20:36AM -0500, Matthias Maier wrote:
>=20
> On Fri, Jun 15, 2018, at 04:42 CDT, Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>=20
> > On Thu, Jun 14, 2018 at 11:40:41PM -0500, Matthias Maier wrote:
> >> This commit removes the PYTHON_UTF8 workaround. The problem with set=
ting
> >>=20
> >>   LC_ALL=3D LANG=3DC LC_CTYPE=3Den_US.UTF-8
> >>=20
> >> is that the en_US.UTF-8 locale might not be available. In this case
> >
> > What platform are you using where  UTF8 locale is not available ?
>=20
> For example, neither Debian (and for that matter Ubuntu) nor Gentoo
> guarantee that the en_US.UTF-8 locale is available.
>=20
> We in particular encounter build problems on Gentoo when users have onl=
y
> set very specific, non en_US locales, for example de_DE.UTF-8 (or
> similar).
>=20
> > Indeed I would ideally like to make the entire of QEMU build with an
> > explicit en_US.UTF-8 or C.UTF-8 locale, to ensure that we get reliabl=
y
> > reproducible builds, as locale differences have been known to impact
> > output of many tools not just python.
>=20
> We face the same problem in Gentoo and usually advice users to set
> LC_ALL=3DC when submitting bug reports. (It is frustrating that glibc
> upstream doesn't get their act together fixing and merging the current
> C.UTF-8 proposal.)
>=20
> So what about making the build system more robust (by merging the
> patches, or a variant) and either setting C.UTF-8, or C globally
> (depending on availability)?

Yes, if we could figure out a way to check for existance of locales, we
could make configure check for C.UTF-*, en_US.UTF-8, C  in that order,
using the first it finds to work. Fun fact, on macOS 'C' is always
UTF-8, so its valid to use just 'C'.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
