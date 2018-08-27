Received: from eggs.gnu.org ([2001:4830:134:3::10]:35359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fu77f-0004ih-U5
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 22:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fu77f-0007tR-2z
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 22:19:19 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130]:34577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fu77e-0007rC-Qm
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 22:19:18 -0400
Received: by mail-lf1-x130.google.com with SMTP id g9-v6so10734130lfh.1
	for <qemu-devel@nongnu.org>; Sun, 26 Aug 2018 19:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <1533796458-22306-1-git-send-email-whois.zihan.yang@gmail.com>
	<af1df9c5-852e-82ab-a1bb-854a4ce6a24e@gmail.com>
	<CAKwiv-gVDxJWm4Oc+sSmsfdawLoo0F8L5n6xMznk9ixkCLR0yA@mail.gmail.com>
	<f7926420-ccd7-6821-f18d-794eb3a96105@gmail.com>
In-Reply-To: <f7926420-ccd7-6821-f18d-794eb3a96105@gmail.com>
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Mon, 27 Aug 2018 02:19:05 +0000
Message-ID: <CAKwiv-jsnYW_+0WvWQiseA-B=torgAJyrhE0K_c47DQ8oGnjng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 3/6] i386/acpi-build: describe new pci
 domain in AML
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

Marcel Apfelbaum <marcel.apfelbaum@gmail.com> =E4=BA=8E2018=E5=B9=B48=E6=9C=
=8825=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=887:58=E5=86=99=E9=81=93=
=EF=BC=9A
>
>
>
> On 08/19/2018 05:00 AM, Zihan Yang wrote:
> > Marcel Apfelbaum <marcel.apfelbaum@gmail.com> =E4=BA=8E2018=E5=B9=B48=
=E6=9C=8818=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=881:49=E5=86=99=E9=
=81=93=EF=BC=9A
> >>
> >>
> >> On 08/09/2018 09:34 AM, Zihan Yang wrote:
> >>> Describe new pci segments of host bridges in AML as new pci devices,
> >>> with _SEG and _BBN to let them be in DSDT.
> >>>
> >>> Besides, bus_nr indicates the bus number of pxb-pcie under pcie.0 bus=
,
> >>> but since we put it into separate domain, it should be zero,
> >> Why should it be 0? Isn't possible we start another domain from bus_nr=
> 0?
> > In the last version, I got a misunderstanding about bus_nr, and you poi=
nted me
> > out that we should start from bus 0 when in new domain. I can support t=
his
> > start_bus in later patch, but I wonder when would we want to start a do=
main
> > from bus_nr > 0? I'm not quite familiar with the use case.
>
> That is a good point. I can't think of a reason to start a new PCI
> domain with a bus number  >0 , but is it possible.
> So if it doesn't complicate the implementation we don't
> want this kind of limitation.
> On the other hand, if it makes the code too complicated,
> we can argue for requiring it.

OK, then I will add it first and see its impact.

> Thanks,
> Marcel
>
> [...]
