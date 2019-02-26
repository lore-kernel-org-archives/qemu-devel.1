Received: from eggs.gnu.org ([209.51.188.92]:38211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gyk0j-00071e-G9
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 16:11:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gyk0h-0001RO-FB
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 16:11:33 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:42885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1gyk0d-0001Mq-HP
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 16:11:29 -0500
Received: by mail-wr1-x432.google.com with SMTP id r5so15545017wrg.9
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 13:11:19 -0800 (PST)
MIME-Version: 1.0
References: <CAKyx-3Paa6_RreGZw3sT+qmwu1=_DLnR_RDxa_gN20vwD1EnLw@mail.gmail.com>
	<20190225152618.r3epnypkpu6fyokt@sirius.home.kraxel.org>
	<A17B6D30-F428-48E5-B9D0-6F6E7DEE3778@gmail.com>
	<20190226064347.i5kvwazmz3xcupkj@sirius.home.kraxel.org>
In-Reply-To: <20190226064347.i5kvwazmz3xcupkj@sirius.home.kraxel.org>
From: G 3 <programmingkidx@gmail.com>
Date: Tue, 26 Feb 2019 16:11:06 -0500
Message-ID: <CAKyx-3OOkkdSQ=UAucP_ZpormrEczwNhEpAnVtFeQOSOrnD7Vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Questions about EDID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

When I use edid=on, I do see a lot of extra resolutions available in Mac OS
9 and Mac OS X, just not the resolution I want to use. Is there some kind
of rule like the resolution value has to be divisible by a certain number?

On Tue, Feb 26, 2019 at 1:43 AM Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Mon, Feb 25, 2019 at 09:49:22PM -0500, Programmingkid wrote:
> >
> > > On Feb 25, 2019, at 10:26 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > > On Mon, Feb 25, 2019 at 09:05:30AM -0500, G 3 wrote:
> > >> Hi Gerd, I was wondering if you have made any documentation for your
> EDID
> > >> patches. If you have could you provide a link please?
> > >
> > > No docs.
> > >
> > >> Also could a feature be added that allows the user to specify
> resolutions
> > >> to be made available to the guest?
> > >>
> > >> Maybe it could work like this: -device
> VGA,edid=on,res=1366x768,7680x4320
> > >
> > > A single resolution works (via xres + yres properties).
> >
> > Could you send an example of the xres and yres properties please?
> > I tried this but it didn't work: -device VGA,edid=on,xres=999,yres=888
>
> That is correct.  But you also need a guest driver with edid support.
>
> I think the macos driver got support for that, for linux support landed
> in the 5.0 devel cycle.
>
> cheers,
>   Gerd
>
>
