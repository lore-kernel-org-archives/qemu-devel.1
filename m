Received: from eggs.gnu.org ([2001:4830:134:3::10]:48821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1coVwu-0001sS-7J
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:00:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1coVwq-0000pI-F1
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:00:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1coVwq-0000oR-9F
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:00:12 -0400
Message-ID: <1489672808.15659.90.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 16 Mar 2017 15:00:08 +0100
In-Reply-To: <143C0AFC63FC204CB0C55BB88F3A8ABB3336BB2E@EX02.corp.qihoo.net>
References: <1489656642-12925-1-git-send-email-kraxel@redhat.com>
	<1489656642-12925-5-git-send-email-kraxel@redhat.com>
	<143C0AFC63FC204CB0C55BB88F3A8ABB3336BB2E@EX02.corp.qihoo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PULL for-2.9 4/7] cirrus: add option to disable
 blitter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?=E6=9D=8E=E5=BC=BA?= <liqiang6-s@360.cn>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

  Hi,

> > +    DEFINE_PROP_BOOL("blitter", struct PCICirrusVGAState,
>=20
> > +                     cirrus_vga.enable_blitter, true),
>=20
>=20
> The default is 'ENABLE'?

Yes.

>  I think there should be 'false'.

Just flipping it to false isn't an option.  At minimum we would have to
keep it enabled by default for older machine types, for backward
compatibility with older qemu versions.

Beside that I don't want rush it.   When flipping the default I'd do it
early in the 2.10 development cycle, so we have a few months to the next
release to see what the fallout is and decide which default we want.

But I think the most sensible approach would be to have upper management
layer handle this.  We have libosinfo, which records capabilities of
guests, and we could add a field there telling whenever the guest os in
question uses the blitter (and therefore breaks when we turn it off) or
whenever it is safe to turn it off.

cheers,
  Gerd
