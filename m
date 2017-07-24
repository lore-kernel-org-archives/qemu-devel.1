Received: from eggs.gnu.org ([2001:4830:134:3::10]:57532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dZYu4-0008E2-2l
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 04:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dZYtz-00041L-3I
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 04:39:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dZYty-0003v7-TN
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 04:39:43 -0400
Message-ID: <1500885573.15837.3.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 24 Jul 2017 10:39:33 +0200
In-Reply-To: <20170721172843.GA6606@morn.lan>
References: <1500470414-7911-1-git-send-email-zuban32s@gmail.com>
	<1500533554.6553.1.camel@redhat.com>
	<3e0f92ea-58ce-abfb-1aed-4d56c1fa68b2@redhat.com>
	<1500631461.12926.5.camel@redhat.com>
	<eeba9fcf-4b52-2c24-af03-d88333cd2dc6@redhat.com>
	<20170721172843.GA6606@morn.lan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [SeaBIOS] [RFC PATCH 0/2] Allow RedHat PCI bridges
 reserve more buses than necessary during init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin O'Connor <kevin@koconnor.net>, Marcel Apfelbaum <marcel@redhat.com>
Cc: Aleksandr Bezzubikov <zuban32s@gmail.com>, seabios@seabios.org, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org

On Fri, 2017-07-21 at 13:28 -0400, Kevin O'Connor wrote:
> On Fri, Jul 21, 2017 at 03:15:46PM +0300, Marcel Apfelbaum wrote:
> > On 21/07/2017 13:04, Gerd Hoffmann wrote:
> > > I'd prefer to have a single vendor capability for all resource
> > > allocation hints provided by qemu.
> >=20
> > Sure, the capability looking something like:
> >=20
> > =C2=A0=C2=A0=C2=A0[flags: reserve-buses|reserve-IO|reserve-MEM|...]
> > =C2=A0=C2=A0=C2=A0[extra-buses][IO-size][MEM-size]
> >=20
> > =C2=A0=C2=A0=C2=A0if reserve-buses -> use 'extra-buses' value and so =
on
>=20
> I don't have any objection to using a PCI capability, but I do wonder
> if fw_cfg would be a better fit.=C2=A0=C2=A0This information is purely =
qemu ->
> firmware, right?

fw_cfg quickly becomes messy if you want allow different hints per
bridge.

cheers,
  Gerd
