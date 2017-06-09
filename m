Received: from eggs.gnu.org ([2001:4830:134:3::10]:34283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dJQ62-0005kB-CN
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 16:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dJQ5z-0000tu-Bt
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 16:01:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dJQ5z-0000sw-7D
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 16:01:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A16BC80F93
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 20:01:21 +0000 (UTC)
Message-ID: <1497038478.10080.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 09 Jun 2017 22:01:18 +0200
In-Reply-To: <7a7647cd-3d7a-0b6f-0691-d656c9026f44@redhat.com>
References: <20170608161013.17920-1-lersek@redhat.com>
	<20170608204026-mutt-send-email-mst@kernel.org>
	<1496951333.29761.5.camel@redhat.com>
	<20170608224942-mutt-send-email-mst@kernel.org>
	<7a7647cd-3d7a-0b6f-0691-d656c9026f44@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] q35/mch: implement extended TSEG sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>

On Fri, 2017-06-09 at 13:40 +0200, Paolo Bonzini wrote:
>=20
> On 08/06/2017 21:55, Michael S. Tsirkin wrote:
> > We don't have room anywhere in PCI config space. Laszlo makes
> > argument
> > why it's safe for this device based on spec but it's anyone's guess
> > whether current and future software will follow spec.=C2=A0=C2=A0In sho=
rt,
> > going
> > anywhere near the emulated device has a potential to break some
> > drivers.
>=20
> There are no such drivers.=C2=A0=C2=A0The MCH and PCH are only touched by=
 the
> firmware, not by the OS.

Yea.  That is *exactly* the reason why I think simply using the 0x50
offset probably works fine in practice even though I suspect on
physical hardware it might be some undocumented register.  Much of the
stuff in the host bridge pci config space is firmware territory, and we
run qemu specific firmware *anyway*.

cheers,
  Gerd
