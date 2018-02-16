Received: from eggs.gnu.org ([2001:4830:134:3::10]:44554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emZrR-00086D-Td
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 01:51:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emZrO-0001j9-R1
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 01:51:09 -0500
References: <cover.1518730026.git.balaton@eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <dffa45c9-48a6-ef85-3b28-d8ce1daf72e4@redhat.com>
Date: Fri, 16 Feb 2018 07:50:47 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1518730026.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 0/3] Sam460ex emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Francois Revol <revol@free.fr>, David Gibson <david@gibson.dropbear.id.au>

On 15.02.2018 22:27, BALATON Zoltan wrote:
> Remaining patches for Sam460ex emulation. The original cover letter
> with more details is here:
>=20
> http://lists.nongnu.org/archive/html/qemu-ppc/2017-08/msg00112.html
>=20
> We'll need to also add binaries for firmware (customised u-boot
> version) and dtb but I'm not sure how to submit those.

For the dtb, I think you could simply provide a patch that adds the dts
file to the pc-bios directory and another one that adds the dtb. Just
like it is already done with pc-bios/bamboo.dts / pc-bios/bamboo.dtb.

For u-boot, can you use the same upstream level as e500 ? I.e. check
whether "git submodule status roms/u-boot" is fine for you? If that's
ok, just do a "git submodule update roms/u-boot" and build uboot from
that directory - you then can submit a binary patch with that file for
pc-bios, too.

In case you need another u-boot version, I think you've got to update
the submodule to the newer upstream version first, and then also rebuild
the e500 binary... Cumbersome, but that's necessary since we've got to
ship the u-boot sources in the QEMU release tarballs, too, to be
compliant with the GPL.

 Thomas
