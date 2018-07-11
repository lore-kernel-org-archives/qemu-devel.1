Received: from eggs.gnu.org ([2001:4830:134:3::10]:35864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1fdHa9-0004gR-4q
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1fdHa8-0001bS-6c
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:03:09 -0400
Received: from forwardcorp1g.cmail.yandex.net ([2a02:6b8:0:1465::fd]:56987)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dimastep@yandex-team.ru>)
	id 1fdHa7-0001ac-UD
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:03:08 -0400
Date: Wed, 11 Jul 2018 19:03:04 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
Message-ID: <20180711160304.GB7198@dimastep-nix>
References: <1528877995-5043-1-git-send-email-dimastep@yandex-team.ru>
	<1528877995-5043-3-git-send-email-dimastep@yandex-team.ru>
	<20180619141216.GA16512@dimastep-nix>
	<20180711083431.GA5085@dimastep-nix>
	<69f9565f-e5f9-54f3-03dd-e610bea47ddc@amsat.org>
	<CAFEAcA_6mnQZA9HhaTW1oQ9wAVzpTkJq-bjyxg9NGDEqc55zoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA_6mnQZA9HhaTW1oQ9wAVzpTkJq-bjyxg9NGDEqc55zoQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] memory: fix possible NULL pointer
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, wrfsh@yandex-team.ru

On Wed, Jul 11, 2018 at 03:09:13PM +0100, Peter Maydell wrote:
> On 11 July 2018 at 14:47, Philippe Mathieu-Daud=E9 <f4bug@amsat.org> wr=
ote:
> > Hi Dima,
> >
> > On 07/11/2018 05:34 AM, Dima Stepanov wrote:
> >> Gentle ping. CCing Paolo Bonzini.
> >>
> >> Regards, Dima.
> >>
> >> On Tue, Jun 19, 2018 at 05:12:16PM +0300, Dima Stepanov wrote:
> >>> Ping.
> >>>
> >>> Regards, Dima.
> >>>
> >>> On Wed, Jun 13, 2018 at 11:19:55AM +0300, Dima Stepanov wrote:
> >>>> In the memory_region_do_invalidate_mmio_ptr() routine the section
> >>>> variable is intialized by the memory_region_find() call. The secti=
on.mr
> >>>> field can be set to NULL.
> >>>>
> >>>> Add the check for NULL before trying to drop a section.
> >>>>
> >>>> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> >>>> ---
> >>>>  memory.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/memory.c b/memory.c
> >>>> index 3212acc..bb45248 100644
> >>>> --- a/memory.c
> >>>> +++ b/memory.c
> >>>> @@ -2712,7 +2712,7 @@ static void memory_region_do_invalidate_mmio=
_ptr(CPUState *cpu,
> >>>>      /* Reset dirty so this doesn't happen later. */
> >>>>      cpu_physical_memory_test_and_clear_dirty(offset, size, 1);
> >>>>
> >>>> -    if (section.mr !=3D mr) {
> >>>> +    if (section.mr && (section.mr !=3D mr)) {
> >
> > section.mr can't be NULL here.
> >
> > You can give the static analyzer a hint using "assert(section.mr);"
>=20
> Not in my view much point in messing with this code, though:
> (a) it's broken and unusable as it stands (race conditions)
> (b) it's obsoleted by the execute-from-mmio patchset
> http://patchwork.ozlabs.org/cover/942090/ and if/when that
> goes in it will all just get deleted.


Got it.

Thanks, Dima.

>=20
> thanks
> -- PMM
