Received: from eggs.gnu.org ([209.51.188.92]:35976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h3IAM-0006YN-EF
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:28:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h3IAL-0000K8-4x
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:28:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h3IAK-0000Je-K2
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:28:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E321930917EE
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 10:28:15 +0000 (UTC)
Date: Mon, 11 Mar 2019 10:28:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190311102801.GM12393@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190309004826.9027-1-lersek@redhat.com>
	<bf1a5775-17d9-c5bd-4e08-451585d3015e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf1a5775-17d9-c5bd-4e08-451585d3015e@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/10] bundle edk2 platform firmware with
 QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, imammedo@redhat.com, kraxel@redhat.com, mst@redhat.com, qemu-devel@nongnu.org

On Sat, Mar 09, 2019 at 02:20:06AM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 3/9/19 1:48 AM, Laszlo Ersek wrote:
> > Repo:   https://github.com/lersek/qemu.git
> > Branch: edk2_build
> >=20
> > This series advances the roms/edk2 submodule to the "edk2-stable20190=
3"
> > release, and builds and captures platform firmware binaries from that
> > release. At this point they are meant to be used by both end-users an=
d
> > by Igor's ACPI unit tests in qtest ("make check").
> >=20
> > Previous discussion:
> >=20
> >   [Qemu-devel] bundling edk2 platform firmware images with QEMU
> >   http://mid.mail-archive.com/80f0bae3-e79a-bb68-04c4-1c9c684d95b8@re=
dhat.com
> >   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02601.html
> >=20
> > Note that the series was formatted with "--no-binary" (affecting patc=
h
> > #8), therefore it cannot be applied with "git-am". See the remote
> > repo/branch reference near the top instead.
> >=20
> > Thanks,
> > Laszlo
> >=20
> > Laszlo Ersek (10):
> >   roms: lift "edk2-funcs.sh" from "tests/uefi-test-tools/build.sh"
> >   roms/edk2-funcs.sh: require gcc-4.8+ for building i386 and x86_64
> >   tests/uefi-test-tools/build.sh: work around TianoCore#1607
> >   roms/edk2: advance to tag edk2-stable201903
> >   roms/edk2-funcs.sh: add the qemu_edk2_get_thread_count() function
> >   roms/Makefile: replace the $(EFIROM) target with "edk2-basetools"
> >   roms: build edk2 firmware binaries and variable store templates
> >   pc-bios: add edk2 firmware binaries and variable store templates
> >   pc-bios: document the edk2 firmware images; add firmware descriptor=
s
> >   Makefile: install the edk2 firmware images and their descriptors
> >=20
> >  Makefile                                       |  17 +-
> >  pc-bios/README                                 |  11 +
> >  pc-bios/descriptors/50-edk2-i386-secure.json   |  34 +++
> >  pc-bios/descriptors/50-edk2-x86_64-secure.json |  35 +++
> >  pc-bios/descriptors/60-edk2-aarch64.json       |  31 +++
> >  pc-bios/descriptors/60-edk2-arm.json           |  31 +++
> >  pc-bios/descriptors/60-edk2-i386.json          |  33 +++
> >  pc-bios/descriptors/60-edk2-x86_64.json        |  34 +++
> >  pc-bios/edk2-aarch64-code.fd                   | Bin 0 -> 67108864 b=
ytes
> >  pc-bios/edk2-arm-code.fd                       | Bin 0 -> 67108864 b=
ytes
> >  pc-bios/edk2-arm-vars.fd                       | Bin 0 -> 67108864 b=
ytes
>=20
> GitHub moans here:
>=20
> remote: warning: GH001: Large files detected. You may want to try Git
> Large File Storage - https://git-lfs.github.com.
> remote: warning: See http://git.io/iEPt8g for more information.
> remote: warning: File pc-bios/edk2-arm-vars.fd is 64.00 MB; this is
> larger than GitHub's recommended maximum file size of 50.00 MB
> remote: warning: File pc-bios/edk2-arm-code.fd is 64.00 MB; this is
> larger than GitHub's recommended maximum file size of 50.00 MB
> remote: warning: File pc-bios/edk2-aarch64-code.fd is 64.00 MB; this is
> larger than GitHub's recommended maximum file size of 50.00 MB

I wonder if this is a such that github isn't handling sparse files
well, or if they just blindly do this check before they look at the
actual required storage for the files.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
