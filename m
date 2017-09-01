Received: from eggs.gnu.org ([2001:4830:134:3::10]:45024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dnhML-0005Te-Fs
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 04:31:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dnhMG-0007Xt-Kl
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 04:31:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dnhMG-0007Xh-El
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 04:31:20 -0400
Message-ID: <1504254677.10150.3.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 01 Sep 2017 10:31:17 +0200
In-Reply-To: <CAFEAcA_pZn5evv_Z00EKevr1PrV+vNrs4bzEv9FaYLU_cisqyw@mail.gmail.com>
References: <20170831122925.GJ17315@redhat.com>
	<CAFEAcA_pZn5evv_Z00EKevr1PrV+vNrs4bzEv9FaYLU_cisqyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] RFC: changing ROM bundling in tar dists for
 releases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> >=C2=A0- The qemu release dists get ever larger as we add more ROMS.
> > Adding
> > =C2=A0=C2=A0=C2=A0EFI ROM builds for i386, x86_64, and aarch64 will m=
ake the dists
> > =C2=A0=C2=A0=C2=A0larger still.
>=20
> I think these make sense. Should we tie this into the
> recent suggestion (by Gerd?) that we should put all the
> rom blobs into git submodules, and otherwise generally
> try to regularise our handling of blobs?

It surely makes sense to consider both together, so we can work out a
reasonable workflow for firmware updates and distribution.

I think it makes sense to create a separate project for the firmware
blobs.  Move over the firmware binaries and source submodules to the
new project.  This way updating both firmware sources and binaries can
be done with a single commit, like we handle this today, just in the
new firmware repo instead of the main qemu repo.

When moving only the binaries to a separate git submodule and
continuing to have the sources as main qemu repo submodules firmware
updates become more complicated.

> > =C2=A0 3. Change existing dist, and add a new one with bundled bits
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu-X.Y.Z.tar.bz2 - qemu s=
ource only
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu-addons-X.Y.Z.tar.bz2 -=
 bundled ROMS + libs

With the scheme above it makes sense to have a qemu-firmware-
${version}.tar.gz addon tarball.  Maybe even two (one with the prebuilt
binaries and one with the sources).

Question is what to do with the non-firmware submodules (pixman, dtc,
more?) then.  I think they are not that big, so I doubt it is worth the
hassle to create two tarball versions.  And license-wise it isn't a
issue too.

cheers,
  Gerd
