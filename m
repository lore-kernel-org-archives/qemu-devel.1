Received: from eggs.gnu.org ([2001:4830:134:3::10]:35857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cbXIx-0005SI-0j
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 13:49:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cbXIt-0001qX-Ua
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 13:49:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cbXIt-0001qL-MH
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 13:49:19 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C9E2B2E604E
	for <qemu-devel@nongnu.org>; Wed,  8 Feb 2017 18:49:19 +0000 (UTC)
Message-ID: <1486579756.3641.30.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed, 08 Feb 2017 19:49:16 +0100
In-Reply-To: <3fa3d4b8-3e3a-d6c4-a2c1-affef7361576@redhat.com>
References: <1486575331-14455-1-git-send-email-abologna@redhat.com>
	<1486575331-14455-3-git-send-email-abologna@redhat.com>
	<3fa3d4b8-3e3a-d6c4-a2c1-affef7361576@redhat.com>
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

On Wed, 2017-02-08 at 19:11 +0100, Laszlo Ersek wrote:
> How about:
>=C2=A0
>=C2=A0=C2=A0=C2=A0For any new guest, its permanent, private variable sto=
re should
>=C2=A0=C2=A0=C2=A0initially be copied from the template file provided as=
 part of the
>=C2=A0=C2=A0=C2=A0ArmVirtQemu firmware platform (which is occasionally d=
istributed
>=C2=A0=C2=A0=C2=A0under the AAVMF package).

The naming is confusing enough as it is, no need to drag
ArmVirtQemu into this I think ;)

> > +# Fedora:
> > +#=C2=A0=C2=A0=C2=A0/usr/share/edk2/aarch64/QEMU_EFI.fd
> > +#=C2=A0=C2=A0=C2=A0/usr/share/edk2/aarch64/QEMU_VARS.fd
>=C2=A0
> Please annotate each as firmware binary & variable store template.

I had such annotations at some points, I got rid of them
because they seemed a bit redundant. Added them back in.

> Also, I can't verify the exact pathnames for Fedora.

https://koji.fedoraproject.org/koji/rpminfo?rpmID=3D8491933 ;)

[...]
> > +# RHEL:
> > +#=C2=A0=C2=A0=C2=A0/usr/share/AAVMF/AAVMF_CODE.fd
> > +#=C2=A0=C2=A0=C2=A0/usr/share/AAVMF/AAVMF_VARS.fd
>=C2=A0
> Looks legit. (Might want to call "RHEL" "RHELSA" though, in this contex=
t
> -- no clue. Ask Drew :))

Yeah, you're probably right.

[...]
> Please expand the comment:
>=C2=A0
>=C2=A0=C2=A0=C2=A0CHANGE ME TO THE NAME OF THE FILE THAT YOU CREATED AS =
A COPY of THE
>=C2=A0=C2=A0=C2=A0VARSTORE TEMPLATE

Nope. The line would get waaay too long, and I trust the
user to understand the basic idea after having gone through
the paragraphs above.

Here's an updated version, what do you think about it?


# Firmware configuration
# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
#
# There are two parts to the firmware: a read-only image
# containing the executable code, which is shared between
# guests, and a read/write variable store that is owned
# by one specific guest, exclusively, and is used to record
# information such as the UEFI boot order.
#
# For any new guest, its permanent, private variable store
# should initially be copied from the template file
# provided along with the firmware binary.
#
# Depending on the OS distribution you're using on the
# host, the name of the package containing the firmware
# binary and variable store, as well as the paths to the
# files themselves, will be different. Some examples:
#
# Fedora:
#=C2=A0=C2=A0=C2=A0edk2-aarch64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(package)
#=C2=A0=C2=A0=C2=A0/usr/share/edk2/aarch64/QEMU_EFI.fd=C2=A0=C2=A0=C2=A0(=
binary)
#=C2=A0=C2=A0=C2=A0/usr/share/edk2/aarch64/QEMU_VARS.fd=C2=A0=C2=A0(templ=
ate)
#
# RHELSA:
#=C2=A0=C2=A0=C2=A0AAVMF=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(=
package)
#=C2=A0=C2=A0=C2=A0/usr/share/AAVMF/AAVMF_CODE.fd=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0(binary)
#=C2=A0=C2=A0=C2=A0/usr/share/AAVMF/AAVMF_VARS.fd=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0(varstore)

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
