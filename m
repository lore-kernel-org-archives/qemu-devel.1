Received: from eggs.gnu.org ([2001:4830:134:3::10]:49988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1eo6i7-0002Ga-4C
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 07:07:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1eo6i2-0003dr-4F
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 07:07:51 -0500
References: <cover.1519036465.git.balaton@eik.bme.hu>
	<cfba6d194787f7c136b29be47d0c221c99d77ab1.1519036465.git.balaton@eik.bme.hu>
	<20180220024009.GH1109@umbus.fritz.box>
	<alpine.BSF.2.21.1802201055030.91792@zero.eik.bme.hu>
	<8487b26a-77b0-1f00-8338-45575b72ff2f@suse.de>
	<alpine.BSF.2.21.1802201204490.13607@zero.eik.bme.hu>
	<6c5cd396-cbaa-642d-4bb4-f9fb2ad9f39c@redhat.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <6664e09f-282a-6822-229a-fa3e71d8027f@suse.de>
Date: Tue, 20 Feb 2018 13:07:43 +0100
MIME-Version: 1.0
In-Reply-To: <6c5cd396-cbaa-642d-4bb4-f9fb2ad9f39c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 2/2] ppc: Add aCube Sam460ex
 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: Francois Revol <revol@free.fr>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Stefan Hajnoczi <stefanha@redhat.com>

On 02/20/2018 12:31 PM, Thomas Huth wrote:
> On 20.02.2018 12:16, BALATON Zoltan wrote:
>> On Tue, 20 Feb 2018, Alexander Graf wrote:
>>> On 02/20/2018 11:09 AM, BALATON Zoltan wrote:
>>>> On Tue, 20 Feb 2018, David Gibson wrote:
>>>>> On Mon, Feb 19, 2018 at 11:34:25AM +0100, BALATON Zoltan wrote:
>>>>> 1;5002;0c> Add emulation of aCube Sam460ex board based on AMCC 460E=
X
>>>>> embedded SoC.
>>>>>> This is not a complete implementation yet with a lot of components
>>>>>> still missing but enough for the U-Boot firmware to start and to b=
oot
>>>>>> a Linux kernel or AROS.
>>>>>>
>>>>>> Signed-off-by: Fran=C3=A7ois Revol <revol@free.fr>
>>>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>> I'm not thrilled with having a machine type that can't be used with=
out
>>>>> extracting a bootloader image from somewhere, but from the other
>>>>> thread that's not easy to fix.
>>>> This is not meant to be like that and I'd like to also submit the
>>>> u-boot image once we figure out how to do it. Especially because the
>>>> boot loader one can extract from the updater is buggy but here's a
>>>> fixed binary that works here: http://zero.eik.bme.hu/~balaton/qemu/
>>>>
>>>> U-Boot is GPL so we would need to include the source as well (the
>>>> README in the link above contain the source URL and the patches
>>>> needed are there as well). If there's no easy way to host it in the
>>>> QEMU repo I could put it in my own git repo and submit a patch to us=
e
>>>> that as a submodule if that's acceptable. It seems there are some
>>>> firmware images that reference external git repos already but not
>>>> sure what's the preferred way.
>>> IMHO the preferred way would be to integrate sam460ex support in
>>> upstream U-Boot and just build it from there. We already mirror U-Boo=
t
>>> on git.qemu.org and package up that tree, so packaging up one more
>>> target from there would be trivial.
>> As discussed in other thread that's not really feasible. Upstream U-Bo=
ot
>> has removed support for this CPU and the board code was never upstream=
ed
>> by the hardware vendor. I'm not willing to take the task of porting th=
is
>> to latest U-Boot, re-adding all necessary CPU support to latest U-Boot
>> and then take on supporting all this in future versions. So it has to =
be
>> a separate source or you'd have to downgrade U-Boot on git.qemu.org to
>> the older version where the patch applies (but that's not desired as
>> this old version has some bugs which are fixed in later U-Boot
>> versions). We also cannot omit the vendor patches to U-Boot and use
>> latest upstream U-Boot for this board because guests rely on these
>> firmware modifications to boot. So I see no way to have one U-Boot
>> version to be used by both e500 and sam460ex even if it means adding
>> another U-Boot source (but this source is fairly static, I don't expec=
t
>> many changes to it so it won't diverge more than it is now and we main=
ly
>> need to add it to satisfy GPL so we can bundle the binary).
> Not sure, but would it maybe be possible to simply include a diff patch
> file between the version of u-boot that we ship in QEMU and the version
> that is required for the sam460ex in the roms/ directory?

That diff would change constantly, so that's not a great option IMHO.

I guess we could just clone yet another U-Boot git tree from a random=20
github page, as long as people are aware this is only for sam460ex.


Alex
