Received: from eggs.gnu.org ([2001:4830:134:3::10]:40753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fY6Bb-0005Vu-9y
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fY6BX-0003JG-9e
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:52:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43802 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fY6BX-0003J5-4x
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:52:19 -0400
Date: Wed, 27 Jun 2018 10:52:17 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180627085217.blrsx5lmu4sau4fd@sirius.home.kraxel.org>
References: <20180625131253.11218-1-kraxel@redhat.com>
	<20180625131253.11218-2-kraxel@redhat.com>
	<6ad67e44-b002-1cd7-cfd1-2d98ebde1a7e@redhat.com>
	<20180627065126.mwzdxshr3njzok7n@sirius.home.kraxel.org>
	<0df8a05c-43fc-6e85-b13c-d3f5c4691964@redhat.com>
	<87fu18ach6.fsf_-_@dusky.pond.sub.org>
	<alpine.BSF.2.21.1806271010080.90116@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1806271010080.90116@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] Drop support for 32bit hosts in qemu? (was: [PULL
 1/6] audio/hda: create millisecond timers that handle IO)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Martin Schrodt <martin@schrodt.org>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

  Hi,

> > Is QEMU still useful on 32-bit hosts?  Honest question!
> 
> I guess it depends on what 32-bit hosts you consider. If you look at only
> x86 vs. x86_64 then probably x86 is not that important any more but for some
> embedded systems/SoCs 32bit might still be common and QEMU useful for those
> (also as host not only emulated).

Well.  I've used kvm with an 32bit arm soc (cubietruck).  It's very
slow.  And all the arm architecture improvements to support kvm better
are for aarch64 only.

> Another option might be to not support audio/hda on 32bit hosts. It's not
> nice either but a lot nicer than dropping support for 32bit hosts
> alltogether to fix a problem in device emulation.

But it also is not useful and a waste of resources to maintain 32bit
host compatibility if nobody actually uses that ...

For me testbuilds are the only reason to compile qemu for 32bit hosts.
Since years.

cheers,
  Gerd
