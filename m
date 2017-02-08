Received: from eggs.gnu.org ([2001:4830:134:3::10]:52134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cbYDG-000397-08
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:47:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cbYDC-0004pr-UL
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:47:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cbYDC-0004pl-Op
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:47:30 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B70B47E9CE
	for <qemu-devel@nongnu.org>; Wed,  8 Feb 2017 19:47:30 +0000 (UTC)
Message-ID: <1486583247.3641.34.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed, 08 Feb 2017 20:47:27 +0100
In-Reply-To: <7952cdc6-9852-7a5e-27bd-2d2d1a859866@redhat.com>
References: <1486575331-14455-1-git-send-email-abologna@redhat.com>
	<1486575331-14455-3-git-send-email-abologna@redhat.com>
	<3fa3d4b8-3e3a-d6c4-a2c1-affef7361576@redhat.com>
	<1486579756.3641.30.camel@redhat.com>
	<7952cdc6-9852-7a5e-27bd-2d2d1a859866@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 2/2] mach-virt: Provide sample
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: marcel@redhat.com, drjones@redhat.com, kraxel@redhat.com

On Wed, 2017-02-08 at 20:34 +0100, Laszlo Ersek wrote:
> > > Also, I can't verify the exact pathnames for Fedora.
> >=C2=A0
> > https://koji.fedoraproject.org/koji/rpminfo?rpmID=3D8491933 ;)
>=C2=A0
> Ahhh, it's *very* good that you provided this reference, because now I
> see that the file names below are incorrect. Namely, for aarch64 guests=
,
> you have to use the files that are padded to 64MB, *not* the files as
> they fall out of the edk2 build process.

Go figure... Thanks for spotting that!

[...]
> > # Depending on the OS distribution you're using on the
> > # host, the name of the package containing the firmware
> > # binary and variable store, as well as the paths to the
>=C2=A0
> red flag: please say "variable store *template*"

Right. Missed it, sorry.

[...]
> > # Fedora:
> > #=C2=A0=C2=A0=C2=A0edk2-aarch64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(package)
> > #=C2=A0=C2=A0=C2=A0/usr/share/edk2/aarch64/QEMU_EFI.fd=C2=A0=C2=A0=C2=
=A0(binary)
> > #=C2=A0=C2=A0=C2=A0/usr/share/edk2/aarch64/QEMU_VARS.fd=C2=A0=C2=A0(t=
emplate)
> > #
> > # RHELSA:
> > #=C2=A0=C2=A0=C2=A0AAVMF=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0(package)
> > #=C2=A0=C2=A0=C2=A0/usr/share/AAVMF/AAVMF_CODE.fd=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0(binary)
> > #=C2=A0=C2=A0=C2=A0/usr/share/AAVMF/AAVMF_VARS.fd=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0(varstore)
>=C2=A0
> Two comments:
>=C2=A0
> - Under Fedora, you have (template), which is cool, (varstore) is bad. =
:)

That just shows that I'm getting really tired and I should
step away from the keyboard for the day :/

> - Again, the files you note above for Fedora are 2MB and 768KB in size,
> respectively, which is wrong. The files you note for RHELSA are both
> 64MB in size, which is right. Fedora ships the according files as well,
> but their names are different:
>=C2=A0
> /usr/share/edk2/aarch64/QEMU_EFI-pflash.raw=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0(binary)
> /usr/share/edk2/aarch64/vars-template-pflash.raw (varstore template)

Consider it fixed!

(Those filenames, though... Ewww.)

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
