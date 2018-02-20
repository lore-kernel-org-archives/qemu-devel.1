Received: from eggs.gnu.org ([2001:4830:134:3::10]:54820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eo4rJ-00059d-Ma
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 05:09:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eo4rD-0006lC-Il
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 05:09:13 -0500
Date: Tue, 20 Feb 2018 11:09:05 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180220024009.GH1109@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1802201055030.91792@zero.eik.bme.hu>
References: <cover.1519036465.git.balaton@eik.bme.hu>
	<cfba6d194787f7c136b29be47d0c221c99d77ab1.1519036465.git.balaton@eik.bme.hu>
	<20180220024009.GH1109@umbus.fritz.box>
MIME-Version: 1.0
Content-ID: <alpine.BSF.2.21.1802201056580.91792@zero.eik.bme.hu>
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/2] ppc: Add aCube Sam460ex board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>

On Tue, 20 Feb 2018, David Gibson wrote:
> On Mon, Feb 19, 2018 at 11:34:25AM +0100, BALATON Zoltan wrote:
> 1;5002;0c> Add emulation of aCube Sam460ex board based on AMCC 460EX em=
bedded SoC.
>> This is not a complete implementation yet with a lot of components
>> still missing but enough for the U-Boot firmware to start and to boot
>> a Linux kernel or AROS.
>>
>> Signed-off-by: Fran=E7ois Revol <revol@free.fr>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> I'm not thrilled with having a machine type that can't be used without
> extracting a bootloader image from somewhere, but from the other
> thread that's not easy to fix.

This is not meant to be like that and I'd like to also submit the u-boot=20
image once we figure out how to do it. Especially because the boot loader=
=20
one can extract from the updater is buggy but here's a fixed binary that=20
works here: http://zero.eik.bme.hu/~balaton/qemu/

U-Boot is GPL so we would need to include the source as well (the README=20
in the link above contain the source URL and the patches needed are there=
=20
as well). If there's no easy way to host it in the QEMU repo I could put=20
it in my own git repo and submit a patch to use that as a submodule if=20
that's acceptable. It seems there are some firmware images that reference=
=20
external git repos already but not sure what's the preferred way.

> Since we have dtc in a submodule, there's really no reason we should
> be including .dtb files as well as .dts files, we should build them
> ourselves.  But fixing that isn't really in scope for this patch.

I think there are already make rules to build a dtb from dts so it may be=
=20
possible to build these if we can add them as a dependency somewhere.=20
However a normal make does not build dtc for me from the submodule so I'm=
=20
not sure it would work.

> So, applied.

Thank you,
BALATON Zoltan
