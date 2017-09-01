Received: from eggs.gnu.org ([2001:4830:134:3::10]:59848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dniBf-0004qv-Sv
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:24:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dniBb-0001dv-Sr
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:24:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dniBb-0001dZ-Ju
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:24:23 -0400
Date: Fri, 1 Sep 2017 10:24:07 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170901092407.GE31680@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170831122925.GJ17315@redhat.com>
	<CAFEAcA_pZn5evv_Z00EKevr1PrV+vNrs4bzEv9FaYLU_cisqyw@mail.gmail.com>
	<1504254677.10150.3.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1504254677.10150.3.camel@redhat.com>
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Sep 01, 2017 at 10:31:17AM +0200, Gerd Hoffmann wrote:
>   Hi,
>=20
> > >=C2=A0- The qemu release dists get ever larger as we add more ROMS.
> > > Adding
> > > =C2=A0=C2=A0=C2=A0EFI ROM builds for i386, x86_64, and aarch64 will=
 make the dists
> > > =C2=A0=C2=A0=C2=A0larger still.
> >=20
> > I think these make sense. Should we tie this into the
> > recent suggestion (by Gerd?) that we should put all the
> > rom blobs into git submodules, and otherwise generally
> > try to regularise our handling of blobs?
>=20
> It surely makes sense to consider both together, so we can work out a
> reasonable workflow for firmware updates and distribution.
>=20
> I think it makes sense to create a separate project for the firmware
> blobs.  Move over the firmware binaries and source submodules to the
> new project.  This way updating both firmware sources and binaries can
> be done with a single commit, like we handle this today, just in the
> new firmware repo instead of the main qemu repo.
>=20
> When moving only the binaries to a separate git submodule and
> continuing to have the sources as main qemu repo submodules firmware
> updates become more complicated.
>=20
> > > =C2=A0 3. Change existing dist, and add a new one with bundled bits
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu-X.Y.Z.tar.bz2 - qemu=
 source only
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu-addons-X.Y.Z.tar.bz2=
 - bundled ROMS + libs
>=20
> With the scheme above it makes sense to have a qemu-firmware-
> ${version}.tar.gz addon tarball.  Maybe even two (one with the prebuilt
> binaries and one with the sources).
>=20
> Question is what to do with the non-firmware submodules (pixman, dtc,
> more?) then.  I think they are not that big, so I doubt it is worth the
> hassle to create two tarball versions.  And license-wise it isn't a
> issue too.

I've always wondered why we need to specialcase those modules at all.
Personally I'd just remove them entirely and let people install the
-dev packages on their distro just like they do for any other build
prerequisite of QEMU.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
