Received: from eggs.gnu.org ([2001:4830:134:3::10]:56867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gHX1p-0001v9-6G
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gHX1l-0003wH-Dz
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:38:03 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:47100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gHX1k-0003t5-QT
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:38:01 -0400
Received: by mail-wr1-x444.google.com with SMTP id 74-v6so5132152wrb.13
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 09:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180921111332.12973-1-marcandre.lureau@redhat.com>
	<20180924111241.0a686314@redhat.com>
	<CAJ+F1CK4BisaXjrJN7uX8pkteScSetTpQjyYoWXv8OyHNT-kGQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CK4BisaXjrJN7uX8pkteScSetTpQjyYoWXv8OyHNT-kGQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 30 Oct 2018 20:37:47 +0400
Message-ID: <CAJ+F1CJDqvCdoHpVQ5NnAHEY_suda65q58d3bOYQ4Q=Zk7k0Sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] RFC: object: recommend a few type
 check macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Guangrong Xiao <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

Hi

On Mon, Oct 1, 2018 at 5:47 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Mon, Sep 24, 2018 at 1:30 PM Igor Mammedov <imammedo@redhat.com> wrote=
:
> >
> > On Fri, 21 Sep 2018 15:13:30 +0400
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> >
> > > Hi,
> > >
> > > This is a readability suggestion. See the first patch for the doc
> > > change, and the second patch for an example of usage and readability
> > > improvement.
> > Looks like a nice improvement,
> > but could you conversion tree wide so we end up with a consistent
> > way to cast across the tree.
> > Probably it would result in negative diffstat and demonstrate
> > usefulness of the simplification in numbers.
>
> It doesn't result in negative diffstat, since often a one-liner is
> replaced by a 2-liner macro ;)
>
> However, the resulting code is more pleasant to read imho.
>
> I attached the whole diff here, the branch with the 49 patches
> split-series is here: https://github.com/elmarco/qemu/commits/object
>
> Let me know what you think

So after doing that conversion work, what do we do?

>
> >
> > > thanks
> > >
> > > Marc-Andr=C3=A9 Lureau (2):
> > >   object: recommend a few type check macros
> > >   nvdimm: use IS_NVDIMM macro
> > >
> > >  include/hw/mem/nvdimm.h |  1 +
> > >  include/qom/object.h    | 25 ++++++++++++++++---------
> > >  hw/acpi/ich9.c          |  2 +-
> > >  hw/acpi/nvdimm.c        |  2 +-
> > >  hw/acpi/piix4.c         |  2 +-
> > >  hw/i386/pc.c            |  8 +++-----
> > >  hw/mem/pc-dimm.c        |  2 +-
> > >  7 files changed, 24 insertions(+), 18 deletions(-)
> > >
> >
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau



--=20
Marc-Andr=C3=A9 Lureau
