Received: from eggs.gnu.org ([2001:4830:134:3::10]:44245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnndl-0001CD-P4
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnndi-00073n-IF
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:13:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dnndi-00073L-CC
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:13:46 -0400
Date: Fri, 1 Sep 2017 16:13:40 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170901151340.GQ31680@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170831122925.GJ17315@redhat.com>
	<CAFEAcA_pZn5evv_Z00EKevr1PrV+vNrs4bzEv9FaYLU_cisqyw@mail.gmail.com>
	<1504254677.10150.3.camel@redhat.com>
	<1504275104.10150.19.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1504275104.10150.19.camel@redhat.com>
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

On Fri, Sep 01, 2017 at 04:11:44PM +0200, Gerd Hoffmann wrote:
>   Hi,
>=20
> > I think it makes sense to create a separate project for the firmware
> > blobs.=C2=A0=C2=A0Move over the firmware binaries and source submodul=
es to the
> > new project.=C2=A0=C2=A0This way updating both firmware sources and b=
inaries
> > can
> > be done with a single commit, like we handle this today, just in the
> > new firmware repo instead of the main qemu repo.
>=20
> i.e. something like this:
>=20
> https://www.kraxel.org/cgit/qemu-firmware/
>=20
> (only seabios is there for now)

So presumably we'd want a 'make install' target there too, to place the
various ROMS in the location QEMU expects ?

So non-distro users would need to download & install the ROMs,
and then download, build & install QEMU ?

How would you view ROM install working for devs working against GIT ?

eg when we update a ROM in the firmware directory, how do devs know to
update their firmware. Would the qemu-firmware.git be a submodule of
qemu.git, so that a 'make install' would deploy roms for devs ?

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
