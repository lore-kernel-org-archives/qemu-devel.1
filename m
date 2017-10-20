Received: from eggs.gnu.org ([2001:4830:134:3::10]:35564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e5UBH-0007JA-Cg
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e5UBB-0003le-Fd
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:05:31 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:39549)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e5UBB-0003eY-2s
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:05:25 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <d34ce785-80bb-c4f5-4e35-2ec71b00344d@msgid.tls.msk.ru>
Date: Fri, 20 Oct 2017 13:05:13 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] SDL2 issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel qemu-devel <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>

Hello

After we tried to switch from SDL1 to SDL2 in Debian qemu,
we receives quite some reports about various issues.

We use 2.10.1 version of qemu.

Example of the issues: http://bugs.debian.org/879193
http://bugs.debian.org/870025 - a few patches at the bottom
http://bugs.debian.org/878087

What's the status of SDL2 support in qemu? I've seen it is
the default now if SDL2 is present on the system (it was
SDL1 before).

Also, what's the status of SDL _audio_ support, is it needed
at all once we have alsa, pa and oss?

Thanks,

/mjt
