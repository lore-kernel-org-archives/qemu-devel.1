Received: from eggs.gnu.org ([2001:4830:134:3::10]:38726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRKaW-0002Ts-Dx
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:17:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRKaS-0004DX-Rb
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:17:52 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:50022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eRKaS-0004D7-GL
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:17:48 -0500
References: <20171219151636.5162-1-michael.weiser@gmx.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f30766d6-d2ac-e28e-d410-d57932c3b01f@vivier.eu>
Date: Tue, 19 Dec 2017 17:17:35 +0100
MIME-Version: 1.0
In-Reply-To: <20171219151636.5162-1-michael.weiser@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/4] Add aarch64_be-linux-user target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Weiser <michael.weiser@gmx.de>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

Le 19/12/2017 à 16:16, Michael Weiser a écrit :
> Hello,
> 
> below patches add support for big-endian aarch64 to linux-user. Almost
> everything is already in place. The patches just set up the CPU flags as
> required for big-endianess, add a distinction in uname and make sure the
> instructions for the signal trampoline end up in memory little-endian.
> Finally, configure is extended to allow building of a
> aarch64_be-linux-user target.
> 
> With this I am able to run individual aarch64_be binaries as well as
> chroot into a full-blown aarch64_be userland using binfmt_misc, running
> and compiling things (Gentoo crossdev/native).

Could you also update scripts/qemu-binfmt-conf.sh for the aarch64_be magic?

Thanks,
Laurent
