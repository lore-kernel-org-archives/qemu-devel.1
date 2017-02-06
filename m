Received: from eggs.gnu.org ([2001:4830:134:3::10]:56804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1carc8-0007lH-Eb
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 17:18:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1carc4-0004je-7a
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 17:18:24 -0500
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:38369)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1carc4-0004jY-13
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 17:18:20 -0500
Received: from player732.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 68C7721535
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 23:18:17 +0100 (CET)
Date: Mon, 6 Feb 2017 23:18:15 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170206231815.632cacdf@bahia.lan>
In-Reply-To: <8b845abb-ea7c-b256-97db-ebf178df37d1@cran.org.uk>
References: <8b845abb-ea7c-b256-97db-ebf178df37d1@cran.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Build of master pollutes parent directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Rebecca Cran <rebecca@bluestop.org>
Cc: qemu-devel@nongnu.org

On Mon, 6 Feb 2017 14:07:24 -0700
Rebecca Cran <rebecca@bluestop.org> wrote:

> Building commit 7d2c6c95511e42dffe2b263275e09957723d0ff4 is causing 
> pollution of the parent directory: e.g. ~/workspace/qemu/.. contains the 
> following extra directories:
> 
> audio backends block chardev crypto disas fsdev hw io linux-user 
> migration ndb net qapi qom replay slirp target ui util
> 
> I'm configuring QEMU with:
> 
> ./configure --prefix=$HOME --enable-sdl --enable-kvm --enable-linux-aio 
> --enable-vhost-net --enable-spice --enable-vnc --enable-system 
> --disable-smartcard --disable-tpm --disable-libssh2 --disable-curses 
> --disable-libusb --disable-usb-redir --disable-xen   --disable-bluez 
> --disable-user --disable-vde --target-list=x86_64-softmmu,aarch64-softmmu
> 

This is a merge commit... maybe you could bisect to find the real culprit ?
