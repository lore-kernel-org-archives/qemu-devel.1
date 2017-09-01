Received: from eggs.gnu.org ([2001:4830:134:3::10]:36051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dnia7-0005LC-SE
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:49:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dnia4-0002td-R0
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:49:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dnia4-0002tO-La
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:49:40 -0400
Message-ID: <1504259378.10150.8.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 01 Sep 2017 11:49:38 +0200
In-Reply-To: <20170901092407.GE31680@redhat.com>
References: <20170831122925.GJ17315@redhat.com>
	<CAFEAcA_pZn5evv_Z00EKevr1PrV+vNrs4bzEv9FaYLU_cisqyw@mail.gmail.com>
	<1504254677.10150.3.camel@redhat.com>
	<20170901092407.GE31680@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> > Question is what to do with the non-firmware submodules (pixman,
> > dtc,
> > more?) then.=C2=A0=C2=A0I think they are not that big, so I doubt it =
is worth
> > the
> > hassle to create two tarball versions.=C2=A0=C2=A0And license-wise it=
 isn't a
> > issue too.
>=20
> I've always wondered why we need to specialcase those modules at all.
> Personally I'd just remove them entirely and let people install the
> -dev packages on their distro just like they do for any other build
> prerequisite of QEMU.

Yes, we can probably do that now with pixman.  A few years back when
the submodule was added there was the problem that some distros shipped
too old versions of pixman.  Known offender: RHEL-5.  But RHEL-5 is EOL
meanwhile and I think qemu raised the minimum glib version to something
newer than what RHEL-5 ships, so it qemu doesn't build on RHEL-5
anyway.

Dunno about dtc.

cheers,
  Gerd
