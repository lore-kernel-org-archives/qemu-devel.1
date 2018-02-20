Received: from eggs.gnu.org ([2001:4830:134:3::10]:38440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eo5uK-0004dK-K2
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eo5uF-0005BK-Kr
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:16:24 -0500
Date: Tue, 20 Feb 2018 12:16:09 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <8487b26a-77b0-1f00-8338-45575b72ff2f@suse.de>
Message-ID: <alpine.BSF.2.21.1802201204490.13607@zero.eik.bme.hu>
References: <cover.1519036465.git.balaton@eik.bme.hu>
	<cfba6d194787f7c136b29be47d0c221c99d77ab1.1519036465.git.balaton@eik.bme.hu>
	<20180220024009.GH1109@umbus.fritz.box>
	<alpine.BSF.2.21.1802201055030.91792@zero.eik.bme.hu>
	<8487b26a-77b0-1f00-8338-45575b72ff2f@suse.de>
MIME-Version: 1.0
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
To: Alexander Graf <agraf@suse.de>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Francois Revol <revol@free.fr>

On Tue, 20 Feb 2018, Alexander Graf wrote:
> On 02/20/2018 11:09 AM, BALATON Zoltan wrote:
>> On Tue, 20 Feb 2018, David Gibson wrote:
>>> On Mon, Feb 19, 2018 at 11:34:25AM +0100, BALATON Zoltan wrote:
>>> 1;5002;0c> Add emulation of aCube Sam460ex board based on AMCC 460EX=20
>>> embedded SoC.
>>>> This is not a complete implementation yet with a lot of components
>>>> still missing but enough for the U-Boot firmware to start and to boo=
t
>>>> a Linux kernel or AROS.
>>>>=20
>>>> Signed-off-by: Fran=E7ois Revol <revol@free.fr>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>=20
>>> I'm not thrilled with having a machine type that can't be used withou=
t
>>> extracting a bootloader image from somewhere, but from the other
>>> thread that's not easy to fix.
>>=20
>> This is not meant to be like that and I'd like to also submit the u-bo=
ot=20
>> image once we figure out how to do it. Especially because the boot loa=
der=20
>> one can extract from the updater is buggy but here's a fixed binary th=
at=20
>> works here: http://zero.eik.bme.hu/~balaton/qemu/
>>=20
>> U-Boot is GPL so we would need to include the source as well (the READ=
ME in=20
>> the link above contain the source URL and the patches needed are there=
 as=20
>> well). If there's no easy way to host it in the QEMU repo I could put =
it in=20
>> my own git repo and submit a patch to use that as a submodule if that'=
s=20
>> acceptable. It seems there are some firmware images that reference ext=
ernal=20
>> git repos already but not sure what's the preferred way.
>
> IMHO the preferred way would be to integrate sam460ex support in upstre=
am=20
> U-Boot and just build it from there. We already mirror U-Boot on git.qe=
mu.org=20
> and package up that tree, so packaging up one more target from there wo=
uld be=20
> trivial.

As discussed in other thread that's not really feasible. Upstream U-Boot=20
has removed support for this CPU and the board code was never upstreamed=20
by the hardware vendor. I'm not willing to take the task of porting this=20
to latest U-Boot, re-adding all necessary CPU support to latest U-Boot an=
d=20
then take on supporting all this in future versions. So it has to be a=20
separate source or you'd have to downgrade U-Boot on git.qemu.org to the=20
older version where the patch applies (but that's not desired as this old=
=20
version has some bugs which are fixed in later U-Boot versions). We also=20
cannot omit the vendor patches to U-Boot and use latest upstream U-Boot=20
for this board because guests rely on these firmware modifications to=20
boot. So I see no way to have one U-Boot version to be used by both e500=20
and sam460ex even if it means adding another U-Boot source (but this=20
source is fairly static, I don't expect many changes to it so it won't=20
diverge more than it is now and we mainly need to add it to satisfy GPL s=
o=20
we can bundle the binary).

Regards,
BALATON Zoltan
