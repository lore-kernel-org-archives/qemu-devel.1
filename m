Received: from eggs.gnu.org ([2001:4830:134:3::10]:55763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1eo4vc-0007e6-AM
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 05:13:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1eo4vY-0001Nx-W8
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 05:13:40 -0500
References: <cover.1519036465.git.balaton@eik.bme.hu>
	<cfba6d194787f7c136b29be47d0c221c99d77ab1.1519036465.git.balaton@eik.bme.hu>
	<20180220024009.GH1109@umbus.fritz.box>
	<alpine.BSF.2.21.1802201055030.91792@zero.eik.bme.hu>
From: Alexander Graf <agraf@suse.de>
Message-ID: <8487b26a-77b0-1f00-8338-45575b72ff2f@suse.de>
Date: Tue, 20 Feb 2018 11:13:33 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1802201055030.91792@zero.eik.bme.hu>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
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
To: BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Francois Revol <revol@free.fr>

On 02/20/2018 11:09 AM, BALATON Zoltan wrote:
> On Tue, 20 Feb 2018, David Gibson wrote:
>> On Mon, Feb 19, 2018 at 11:34:25AM +0100, BALATON Zoltan wrote:
>> 1;5002;0c> Add emulation of aCube Sam460ex board based on AMCC 460EX=20
>> embedded SoC.
>>> This is not a complete implementation yet with a lot of components
>>> still missing but enough for the U-Boot firmware to start and to boot
>>> a Linux kernel or AROS.
>>>
>>> Signed-off-by: Fran=E7ois Revol <revol@free.fr>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>
>> I'm not thrilled with having a machine type that can't be used without
>> extracting a bootloader image from somewhere, but from the other
>> thread that's not easy to fix.
>
> This is not meant to be like that and I'd like to also submit the=20
> u-boot image once we figure out how to do it. Especially because the=20
> boot loader one can extract from the updater is buggy but here's a=20
> fixed binary that works here: http://zero.eik.bme.hu/~balaton/qemu/
>
> U-Boot is GPL so we would need to include the source as well (the=20
> README in the link above contain the source URL and the patches needed=20
> are there as well). If there's no easy way to host it in the QEMU repo=20
> I could put it in my own git repo and submit a patch to use that as a=20
> submodule if that's acceptable. It seems there are some firmware=20
> images that reference external git repos already but not sure what's=20
> the preferred way.

IMHO the preferred way would be to integrate sam460ex support in=20
upstream U-Boot and just build it from there. We already mirror U-Boot=20
on git.qemu.org and package up that tree, so packaging up one more=20
target from there would be trivial.


Alex
