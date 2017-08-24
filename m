Received: from eggs.gnu.org ([2001:4830:134:3::10]:47949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dksWO-0000Wf-3O
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:50:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dksWJ-0006BW-9C
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:50:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dksWI-0006Aq-W2
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:50:03 -0400
References: <20170807163121.797e7ad6@nial.brq.redhat.com>
	<CAFEAcA8=+8cPjKayq3Bre7y9=6jzFgjCCjRkNUeHxArJu9Ue6A@mail.gmail.com>
	<be880655-0c04-8369-01fc-76dd6241ca78@redhat.com>
	<1503316706.26016.11.camel@redhat.com>
	<CAFEAcA9Lz=pBZxYqHk7kdaU_LsvE34+DJmTm_jHSFeKzoCM3xw@mail.gmail.com>
	<1503572130.22313.8.camel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d5fabedc-11f5-60c0-cc86-6fbe4387cf3d@redhat.com>
Date: Thu, 24 Aug 2017 15:49:55 +0200
MIME-Version: 1.0
In-Reply-To: <1503572130.22313.8.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] AVMF & OVMF blobs in QEMU tree???
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 08/24/17 12:55, Gerd Hoffmann wrote:
>   Hi,
>=20
>> Having all our precompiled blobs be in a submodule would
>> maybe be handy for properly keeping them separate from the
>> QEMU code -- would that be useful for downstream distro
>> packagers?
>=20
> I like the clear separation.
>=20
> Also you don't have to fetch the firmware submodule if you don't need
> the prebuilds.
>=20
> It would be a good opportunity to cleanup the mess we have in pc-bios/
> right now.
>=20
> Clear disadvantage is that firmware updates will become more
> complicated then as two repos must be updated.  So either two pull
> requests per firmware update, or write access to the firmware binary
> repo for all firmware maintainers.
>=20
> Or maybe make the firmware sources submodules of the firmware binary
> repo instead of the qemu repo.
>=20
>> In any case this seems like a good opportunity to write down
>> exactly what our policy about ROM blobs is (eg where they
>> are, how we update them, requirement for source, whether
>> we allow source to be in a submodule not on qemu.org...)
>=20
> Tried to write down the current state.
>=20
> cheers,
>   Gerd
>=20
> ---------------------- docs/firmware.txt ------------------------
>=20
> prebuilt firmware in qemu
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>=20
> The process of building firmware isn't as easy as building qemu
> itself, for example because you must have cross compilers installed
> when building firmware for other architectures.=C2=A0=C2=A0So qemu ship=
s
> prebuilt firmware binaries for convenience reasons.
>=20
>=20
> directories
> -----------
>=20
> pc-bios/
> =C2=A0=C2=A0=C2=A0=C2=A0Firmware binaries.
> =C2=A0=C2=A0=C2=A0=C2=A0Also other files like keymaps and logos which a=
re copied to
> =C2=A0=C2=A0=C2=A0=C2=A0$prefix/share/qemu by "make install".
>=20
> pc-bios/optionrom/
> =C2=A0=C2=A0=C2=A0=C2=A0Firmware sources, part of the qemu project.
>=20
> roms/
> =C2=A0=C2=A0=C2=A0=C2=A0Firmware sources, third-party projects, as git =
submodules.
>=20
>=20
> third-party git repos
> ---------------------
>=20
> For third party firmware sources it is recommended to have a git
> mirror on git.qemu.org.=C2=A0=C2=A0In case the firmware license is GPL =
the git
> mirror is mandatory for GPL compilance reasons:=C2=A0=C2=A0We ship bina=
ries, so
> we must provide sources too.
>=20
>=20
> building the firmware
> ---------------------
>=20
> Firmware builds should be done using rules in roms/Makefile.=C2=A0=C2=A0=
That
> serves as documentation how the firmware is built, and it also makes
> firmware updates easier for the maintainer.
>=20
> "make -C roms" prints a list of firmware build targets.
> "make -C roms $target" kicks a build.
>=20
>=20
> notes for specific firmwares
> ----------------------------
>=20
> ipxe: see https://wiki.qemu.org/IpxeDownstreamForQemu
>=20

Looks good to me!

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo
