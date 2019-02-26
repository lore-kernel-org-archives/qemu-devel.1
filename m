Received: from eggs.gnu.org ([209.51.188.92]:48643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gyWTG-0003qP-Tg
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 01:44:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gyWTF-0000r7-W2
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 01:44:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:13948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gyWTF-0000jC-Pu
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 01:44:05 -0500
Date: Tue, 26 Feb 2019 07:43:47 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190226064347.i5kvwazmz3xcupkj@sirius.home.kraxel.org>
References: <CAKyx-3Paa6_RreGZw3sT+qmwu1=_DLnR_RDxa_gN20vwD1EnLw@mail.gmail.com>
	<20190225152618.r3epnypkpu6fyokt@sirius.home.kraxel.org>
	<A17B6D30-F428-48E5-B9D0-6F6E7DEE3778@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A17B6D30-F428-48E5-B9D0-6F6E7DEE3778@gmail.com>
Subject: Re: [Qemu-devel] Questions about EDID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

On Mon, Feb 25, 2019 at 09:49:22PM -0500, Programmingkid wrote:
> 
> > On Feb 25, 2019, at 10:26 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > 
> > On Mon, Feb 25, 2019 at 09:05:30AM -0500, G 3 wrote:
> >> Hi Gerd, I was wondering if you have made any documentation for your EDID
> >> patches. If you have could you provide a link please?
> > 
> > No docs.
> > 
> >> Also could a feature be added that allows the user to specify resolutions
> >> to be made available to the guest?
> >> 
> >> Maybe it could work like this: -device VGA,edid=on,res=1366x768,7680x4320
> > 
> > A single resolution works (via xres + yres properties).
> 
> Could you send an example of the xres and yres properties please?
> I tried this but it didn't work: -device VGA,edid=on,xres=999,yres=888

That is correct.  But you also need a guest driver with edid support.

I think the macos driver got support for that, for linux support landed
in the 5.0 devel cycle.

cheers,
  Gerd
