Received: from eggs.gnu.org ([209.51.188.92]:51139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1goknW-0008H9-Dy
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 03:00:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1goknS-00012K-Go
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 03:00:37 -0500
Date: Wed, 30 Jan 2019 09:00:12 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190130080012.pc3swshuknpoknzy@sirius.home.kraxel.org>
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	<20190128124027.776wwcqrckalvr7x@sirius.home.kraxel.org>
	<CAFEAcA-jwBhBXQb-SHT=b_Vy5Sq+M2iaMP2XtVn_2HQvzaEoVQ@mail.gmail.com>
	<87wommmwa8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wommmwa8.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [libvirt] Configuring pflash devices for OVMF
 firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Krempa <pkrempa@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>

  Hi,

> > (Migration compat is left as an exercise for the reader :-))
> 
> It's not just migration compatibility, it's also guest ABI: "the guest
> can tell the difference".

Is that actually the case on x86?  I don't think so.

Note: arm is different, because the flash is listed in the device tree
which is guest visible.

> So, old machine types continue to get two flash devices, and new
> machine types get one.  In other words, we're stuck maintaining (a)
> even if we decide to switch to (b).

I think that'll be true nevertheless for live migration compatibility.

cheers,
  Gerd
