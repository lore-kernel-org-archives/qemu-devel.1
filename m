Received: from eggs.gnu.org ([2001:4830:134:3::10]:44331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gL7OD-00011o-LG
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:04:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gL7O9-0003u3-EW
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:04:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gL7O9-0003mo-5a
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:03:57 -0500
Date: Fri, 9 Nov 2018 15:03:54 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181109140354.bgib5g5v62iafhks@sirius.home.kraxel.org>
References: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
	<20181109111731.vxdmqmkorblcnntx@sirius.home.kraxel.org>
	<20181109112953.w4wtltwxpl4z2lpj@sirius.home.kraxel.org>
	<1724064a-acdc-5571-4f54-f0ac021027d0@redhat.com>
	<6e7304f6-b81a-982f-a94c-d8df4202a82e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e7304f6-b81a-982f-a94c-d8df4202a82e@redhat.com>
Subject: [Qemu-devel] deprecating/removing bluetooth (was: Re: List of files
 containing devices which have not been QOMified)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On Fri, Nov 09, 2018 at 02:16:53PM +0100, Paolo Bonzini wrote:
> On 09/11/2018 13:39, Thomas Huth wrote:
> > On 2018-11-09 12:29, Gerd Hoffmann wrote:
> >>
> >> Tried this after studying docs:
> >>
> >>   qemu -usb -device usb-bt-dongle -bt hci,vlan=0 -bt device:keyboard
> >>
> >> Segfaults right anway on first keypress.
> >> I guess that qualifies as "broken and obviously unused".
> > 
> > Thanks for checking! I guess that means we could even get rid of it
> > without deprecating it first if it is broken already for more than two
> > releases...?
> 
> I think what others were using bluetooth passthrough.  But it's
> certainly possible that it's broken.

That code is in bt-*.c (toplevel dir).  Likewise no actual code changes
since ages.  Comes in two variants, host + vhci.  vhci commit says:

    commit ab2b6f507ded382df734fe6a237ec56e2f421de4
    Author: balrog <balrog@c046a42c-6fe2-441c-8c8c-71466251a162>
    Date:   Mon Sep 29 00:31:41 2008 +0000

        Use VHCI to allow the host os to participate in a qemu bluetooth "vlan".
    
        This does the reverse of bt-host.c, proxying from guest to host.
        Appears to be more reliable.

Hmm.  Not much of a clue.  Also ten years old.

There is also a null hci, not connecting to anything.  Probably useful as
dummy when your board has bluetooth (see arm/nseries) but you don't want
hook up any bluetooth devices.

Anyone has used bluetooth passthrough and can report what the state is?

I guess the keyboard can be dropped right away no matter what.

cheers,
  Gerd
