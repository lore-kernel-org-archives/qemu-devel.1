Received: from eggs.gnu.org ([2001:4830:134:3::10]:40460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1djmfq-0001Rf-0l
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1djmfm-0004IN-2X
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:23:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1djmfl-0004Hd-S9
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:23:17 -0400
Date: Mon, 21 Aug 2017 15:23:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170821152308.3191c400@nial.brq.redhat.com>
In-Reply-To: <1503316706.26016.11.camel@redhat.com>
References: <20170807163121.797e7ad6@nial.brq.redhat.com>
	<CAFEAcA8=+8cPjKayq3Bre7y9=6jzFgjCCjRkNUeHxArJu9Ue6A@mail.gmail.com>
	<be880655-0c04-8369-01fc-76dd6241ca78@redhat.com>
	<1503316706.26016.11.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] AVMF & OVMF blobs in QEMU tree???
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>

On Mon, 21 Aug 2017 13:58:26 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Mon, 2017-08-07 at 18:51 +0200, Laszlo Ersek wrote:
> > On 08/07/17 16:40, Peter Maydell wrote:  
> > > On 7 August 2017 at 15:31, Igor Mammedov <imammedo@redhat.com>
> > > wrote:  
> > > > As I recall there were issues with FAT driver licensing in edk2,
> > > > but I've heard there were some changes in that regard.
> > > > 
> > > > Is there any other reasons why we are not putting subj.
> > > > in QEMU tree like we do with SeaBIOS and other roms?  
> > > 
> > > I suspect the primary answer is "nobody who's willing to
> > > maintain, test and update the resulting binary blobs has
> > > stepped forward to say they want to do so" :-)
> > > 
> > > (I think that shipping them in the QEMU tree would be
> > > nice but is principally a convenience for our direct
> > > users, since distros are going to want to build their
> > > own ROM blobs from source anyway.)  
> > 
> > I agree that OVMF and ArmVirtQemu firmware binaries (and matching
> > varstore templates, likely compressed) should be bundled with QEMU.
> > There are no license-related reasons left that would prevent this.
> > 
> > Please let us discuss this when Gerd returns from vacation. (CC'ing
> > Gerd.)  
> 
> slighly oldish wip branch:
> https://www.kraxel.org/cgit/qemu/log/?h=work/edk2
> 
> Related question (as the edk2 blobs are pretty big):  Do we want commit
> this to the qemu repo directly?   Or should we create a qemu-firmware
> repo for the precompiled blobs and hook it up as submodule?
I suppose both would work for me (making make check work),
though I'd prefer in tree blob (as I didn't have much experience with submodules).
So it's up to you to pick way that makes it simpler to maintain.

> 
> cheers,
>   Gerd
> 
