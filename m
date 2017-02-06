Received: from eggs.gnu.org ([2001:4830:134:3::10]:41357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rebecca@bluestop.org>) id 1caqbL-0004xU-BK
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 16:13:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rebecca@bluestop.org>) id 1caqbI-0002PL-82
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 16:13:31 -0500
Received: from muon.bluestop.org ([74.50.51.35]:37731 helo=muon.cran.org.uk)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rebecca@bluestop.org>)
	id 1caqbI-0002Oo-2o
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 16:13:28 -0500
Received: from muon.bluestop.org (localhost [127.0.0.1])
	by muon.cran.org.uk (Postfix) with ESMTP id DFAEC347C5
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 21:13:25 +0000 (UTC)
Received: from muon.cran.org.uk ([127.0.0.1])
	by muon.bluestop.org (muon.bluestop.org [127.0.0.1]) (amavisd-new,
	port 10026) with ESMTP id k0hTl70EdE6M for <qemu-devel@nongnu.org>;
	Mon,  6 Feb 2017 21:13:24 +0000 (UTC)
Received: from [192.168.1.28] (c-73-20-20-155.hsd1.ut.comcast.net
	[73.20.20.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by muon.cran.org.uk (Postfix) with ESMTPSA
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 21:13:24 +0000 (UTC)
From: Rebecca Cran <rebecca@bluestop.org>
Message-ID: <ab8002a9-6d13-d409-8c1b-ae696181bc6e@bluestop.org>
Date: Mon, 6 Feb 2017 14:13:21 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Build of master pollutes parent directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Building commit 7d2c6c95511e42dffe2b263275e09957723d0ff4 is causing 
pollution of the parent directory: e.g. ~/workspace/qemu/.. contains the 
following extra directories:

audio backends block chardev crypto disas fsdev hw io linux-user 
migration ndb net qapi qom replay slirp target ui util

I'm configuring QEMU with:

./configure --prefix=$HOME --enable-sdl --enable-kvm --enable-linux-aio 
--enable-vhost-net --enable-spice --enable-vnc --enable-system 
--disable-smartcard --disable-tpm --disable-libssh2 --disable-curses 
--disable-libusb --disable-usb-redir --disable-xen   --disable-bluez 
--disable-user --disable-vde --target-list=x86_64-softmmu,aarch64-softmmu

-- 
Rebecca
