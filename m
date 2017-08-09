Received: from eggs.gnu.org ([2001:4830:134:3::10]:45711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dfSPm-000286-9J
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dfSPh-0001qi-EI
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:56:54 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:34241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dfSPh-0001px-93
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:56:49 -0400
Received: by mail-it0-x242.google.com with SMTP id t78so4804659ita.1
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 07:56:47 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <1C4DF81E-D39F-42E2-9D0C-5D76819662A4@gmail.com>
Date: Wed, 9 Aug 2017 10:56:45 -0400
Subject: [Qemu-devel] No video for Windows 2000 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, ehabkost@redhat.com
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

The default vga card not longer works with a Windows 2000 guest. All I =
see is a black screen after a the Windows splash screen.

This is the command-line I used:=20

qemu-system-i386 -hda Windows2000HD.qcow2 -boot c -m 512

When using the -vga cirrus option video works. Testing was done with =
QEMU v2.10.0 rc2.=20=
