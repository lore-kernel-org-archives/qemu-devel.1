Received: from eggs.gnu.org ([209.51.188.92]:41569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hFz7Z-0004gF-FJ
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hFz7Y-0003aU-7Z
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:45:53 -0400
MIME-Version: 1.0
References: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
	<1555103178-21894-5-git-send-email-atar4qemu@gmail.com>
	<29f79530-fd9e-ea60-8cf3-df593b855f10@reactos.org>
	<CACXAS8De=OS0O4O2=Q721KCUc9RuQryOGNfedejM+yzWcX9aOg@mail.gmail.com>
	<4eec1d45-01a6-1c96-ee49-6c3131823b83@reactos.org>
	<5665d408-512e-2ad4-aa4e-481287fc39e7@redhat.com>
In-Reply-To: <5665d408-512e-2ad4-aa4e-481287fc39e7@redhat.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Mon, 15 Apr 2019 12:45:38 +0200
Message-ID: <CACXAS8CDswPp5pss+1VVZxKw8LLS2m0W=jyovBdPDdoJVqNOMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/isa/i82378.c: use 1900 as a base
 year
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, "open list:PReP" <qemu-ppc@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>

On Mon, Apr 15, 2019 at 12:36 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 4/14/19 11:24 PM, Herv=C3=A9 Poussineau wrote:
> > Le 14/04/2019 =C3=A0 20:53, Artyom Tarasenko a =C3=A9crit :
> >> On Sun, Apr 14, 2019 at 7:01 PM Herv=C3=A9 Poussineau
> >> <hpoussin@reactos.org> wrote:
> >>>
> >>> Le 12/04/2019 =C3=A0 23:06, Artyom Tarasenko a =C3=A9crit :
> >>>> AIX 5.1 expects the base year to be 1900. Adjust accordingly.
> >>>>
> >>>> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
> >>>> ---
> >>>>    hw/isa/i82378.c | 4 +++-
> >>>>    1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
> >>>> index a5d67bc..546c928 100644
> >>>> --- a/hw/isa/i82378.c
> >>>> +++ b/hw/isa/i82378.c
> >>>> @@ -107,7 +107,9 @@ static void i82378_realize(PCIDevice *pci, Error
> >>>> **errp)
> >>>>        isa =3D isa_create_simple(isabus, "i82374");
> >>>>
> >>>>        /* timer */
> >>>> -    isa_create_simple(isabus, TYPE_MC146818_RTC);
> >>>> +    isa =3D isa_create(isabus, TYPE_MC146818_RTC);
> >>>> +    qdev_prop_set_int32(DEVICE(isa), "base_year", 1900);
> >>>> +    qdev_init_nofail(DEVICE(isa));
> >>>
> >>> I am not sure the base_year should be hardcoded in i82378. I can
> >>> assume other machines with a i82378 can have another base_year.
> >>
> >> I doubt it to be honest. How would it work in the hardware? Is there a
> >> pin which would switch a year?
> >> I do believe the different i823xx may have the different base years
> >> though.
>
> There is no RTC on the i82378, this should be moved to the board code
> and set the date there. Do you want me to send this patch?

Please do. I won't have a chance to get to it till the next weekend.

Artyom

--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu
