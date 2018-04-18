Received: from eggs.gnu.org ([2001:4830:134:3::10]:57563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f8j1b-00029C-DI
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f8j1V-0007FX-N1
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:05:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35382 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f8j1V-0007FF-IP
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:05:05 -0400
Date: Wed, 18 Apr 2018 11:04:57 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180418090457.dqg5gxnzobdofkao@sirius.home.kraxel.org>
References: <20180417224054.26363-1-lersek@redhat.com>
	<20180418060243.iafg4wj5gwsruop5@sirius.home.kraxel.org>
	<b9c7d767-39c4-065f-f487-34c0c682bd85@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <b9c7d767-39c4-065f-f487-34c0c682bd85@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

> This surfaced in the RFCv1 discussion, but Daniel suggested ignoring
> version numbers:
>=20
> http://mid.mail-archive.com/20180410093412.GI5155@redhat.com
>=20
> On 04/10/18 11:34, Daniel P. Berrang=E9 wrote:
> > IMHO it would be valid to just keep life simple and only record the
> > base machine type name that can use the firmware ie "pc", "q35", and
> > ignore the fact that in some cases the firmware might require a
> > specific version of the machine type.

IIRC this bit referes to the fact that SMM requires qemu >=3D 2.x (don't
remember which x) to work.  So smm-enabled edk2 would just say
"pc-q35-*" instead of trying to specifying a version range somehow.

> Continuing:
>=20
> On 04/18/18 08:02, Gerd Hoffmann wrote:
> >> +# @secure-boot: The firmware implements the software interfaces for=
 UEFI Secure
> >> +#               Boot, as defined in the UEFI specification. Note th=
at without
> >> +#               @requires-smm, guest code running with kernel privi=
leges can
> >> +#               undermine the security of Secure Boot.
> >> +#
> >> +# @secure-boot-enrolled-keys: The variable store (NVRAM) template a=
ssociated
> >
> > I think "enrolled-keys" should better be a separate feature.
>=20
> It's not possible from the edk2 side; without -D SECURE_BOOT_ENABLE, th=
e
> SB-related variables (SetupMode, PK, KEK, ...) don't work at all.

Sure.  The firmware builds will advertise both "secure-boot" and
"enrolled-keys" features to specify that.

But I think it should be enough to check for "secure-boot" feature to
figure whenever a given firmware build supports secure boot, not both
"secure-boot" and "secure-boot-plus-something-else".

cheers,
  Gerd
