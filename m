Received: from eggs.gnu.org ([2001:4830:134:3::10]:58747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fH7ZH-0003Gl-7b
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fH7ZD-0008Au-ER
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:54:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36020 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fH7ZD-0008Ac-9Z
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:54:35 -0400
Date: Fri, 11 May 2018 13:54:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180511125430.GI22098@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA9gG5aSPr7KmqMvgP4OZ9zOC5Z5_UnS_pP+eujDiQmZHw@mail.gmail.com>
	<20180511124253.GH22098@redhat.com>
	<CAFEAcA9TyhX+UyskvuHMSEnJXi-dUdw-E1Es_Fs5NjfdwgZiLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9TyhX+UyskvuHMSEnJXi-dUdw-E1Es_Fs5NjfdwgZiLQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/30] Misc patches for 2018-05-09
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, May 11, 2018 at 01:50:28PM +0100, Peter Maydell wrote:
> On 11 May 2018 at 13:42, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> > On Fri, May 11, 2018 at 01:19:51PM +0100, Peter Maydell wrote:
> >> Some of my build setups barf on the new glib version requirement:
> >>
> >>  * my aarch64 build host (a gcc compile farm machine which is runnin=
g
> >>    Ubuntu 14.04.5 LTS and has glib 2.40.2)
> >
> > That is expected - per the policy we only aim to support the most rec=
ent,
> > and most recent but one for 2 years overlap. Since LTS releases are t=
wo
> > years apart, this basically means always just 2 most recent LTS relea=
ses
> > for Ubuntu. Since we Ubuntu 18.04 LTS came out last month, we don't
> > need to continue 14.04 LTS
>=20
> ...well, I could ask the GCC compile farm admins what their
> upgrade plans are, but I don't particularly see the need
> to impose load on a volunteer set of admins when the distro
> they're running is still supported for another year. And I
> don't want to drop aarch64 from my build test set.

Ah ok, I didn't realize you weren't in control of the OS version.
2.40.2 is not too old, so we can accomodate that without significant
problems.

> >>  * my windows cross compile setups (which have glib 2.34.3)
> >
> > Presumably you're using a Debian host for that ?
>=20
> Ubuntu.
>=20
> > The debian-win64-cross.docker job seems to pull in packages from
> >
> >   deb http://pkg.mxe.cc/repos/apt/debian jessie main
> >
> > And mxe claims to have glib 2.54
>=20
> Thanks, I will have a look at this. (They seem to have tarballs
> as well as debian packages.)

Ok, let me know if that works out, and if so, I'll repost min glib
patches setting it to 2.40.2 to allow for the aarch64 build host.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
