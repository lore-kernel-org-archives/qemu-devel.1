Received: from eggs.gnu.org ([2001:4830:134:3::10]:44787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dZeMv-0000Lt-N0
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dZeMs-00043T-DE
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:29:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dZeMs-00042n-7H
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:29:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 35EE9C0BAA1B
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 14:29:53 +0000 (UTC)
Message-ID: <1500906591.30644.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 24 Jul 2017 16:29:51 +0200
In-Reply-To: <20170724141825.GB11443@redhat.com>
References: <20170724140117.27651-1-kraxel@redhat.com>
	<20170724141825.GB11443@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] Fix qemu keymaps, part one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, 2017-07-24 at 15:18 +0100, Daniel P. Berrange wrote:
> On Mon, Jul 24, 2017 at 04:01:14PM +0200, Gerd Hoffmann wrote:
> > qemu carries a bunch of reverse keymaps in pc-bios/keymaps/, to map
> > keysyms it receives from vnc clients back to keycodes.=C2=A0=C2=A0The=
se
> > keymaps
> > seem to be buggy and incomplete at times.=C2=A0=C2=A0So, to tackle th=
e issue
> > once
> > for all, I've written a tool to generate those maps from xkb
> > keyboard
> > layout data using libxkbcommon.
> >=20
> > This patch series only adds the tool, it doesn't touch the maps in
> > pc-bios/keymaps/ yet.=C2=A0=C2=A0I want some testing feedback first .=
..
>=20
> Hmm, we recently split out the keymap database and code for
> generating
> lookup tables (that was duplicated across spice-gtk, gtk-vnc, and
> libvirt)
> into a shared git sub-module
>=20
> =C2=A0 https://gitlab.com/keycodemap/keycodemapdb/
>=20
> some other VNC clients were also switching to its use.
>=20
> I was coincidentally working on a patch to get QEMU to use this too,
> so all projects are aligned on the same data maps and thus share
> fixes
> in this area.
>=20
> IMHO that'd be preferable than doing something custom in QEMU only.

This is a different issue.  gtk-vnc & friends have to map keycodes from
one system (ps/2, evdev, xorg, ...) to another.  qemu has to map
keysyms back to keycodes, using a reverse keymap, in case the vnc
client doesn't support VNC_ENCODING_EXT_KEY_EVENT.

cheers,
  Gerd
