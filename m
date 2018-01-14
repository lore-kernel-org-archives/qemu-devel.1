Received: from eggs.gnu.org ([2001:4830:134:3::10]:38050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eaiHj-0007l1-5h
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 08:25:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eaiHf-0000q7-M7
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 08:25:14 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:28322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1eaiHf-0000f8-Ev
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 08:25:11 -0500
Date: Sun, 14 Jan 2018 14:24:57 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <151593225024.11261.9880390596143098449.malonedeb@soybean.canonical.com>
Message-ID: <alpine.BSF.2.21.1801141421010.19489@zero.eik.bme.hu>
References: <151593225024.11261.9880390596143098449.malonedeb@soybean.canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: Re: [Qemu-devel] [Bug 1743214] [NEW] OS/2 Warp 3 support broken in
 2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: MVoloshin <1743214@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org

On Sun, 14 Jan 2018, MVoloshin wrote:
> Hello, I used to run OS/2 Warp 3 on QEMU with the following command 
> line: qemu-system-i386 -vga cirrus -soundhw sb16 -hda os2warp3v2.img 
> -boot c. It runs OK on QEMU 2.10, but immediately gives TRAP 0006 
> (invalid opcode?) on QEMU 2.11 (see screenshot).
>
> If it is important I have Fixpack 40 and GRADD installed in OS/2.
> Here is the image:
> https://drive.google.com/open?id=15umPecy7JlPLKUP6520MB_87CfrCDWO5

This image boots for me without problem with latest version from git so 
either it's already fixed or the problem is elsewhere. Can you try latest 
git version? If it still does not work with that maybe you need to provide 
more details, like configure options or what host arch/OS are you on.
