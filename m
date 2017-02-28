Received: from eggs.gnu.org ([2001:4830:134:3::10]:45096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cidkD-0004c0-Sp
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:06:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cidk9-0000uE-K5
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:06:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cidk9-0000t9-Ek
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:06:49 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A30C4D689
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 09:06:49 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 28 Feb 2017 10:06:43 +0100
Message-Id: <1488272804-27144-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] seabios: update to 1.10.2 release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

  Hi,

Here comes the seabios update for qemu 2.9,
the just tagged 1.10.2 release.

Our seabios.git mirror @ qemu.org seems to not sync properly.  The
commit isn't there even though it was pushed a few days ago already
(only the tag was pushed today).  John, can you have a look please?
master branch, *-stable branches and all tags should be mirrored.

thanks,
  Gerd

The following changes since commit 9b9fbe8a4e9eec9072ee2697a6af59144442785f:

  Merge remote-tracking branch 'remotes/kraxel/tags/pull-ui-20170227-1' into staging (2017-02-27 19:19:46 +0000)

are available in the git repository at:


  git://git.kraxel.org/qemu tags/pull-seabios-20170228-1

for you to fetch changes up to 8779fccbef0c2e97fd6564ddf9f1df9fc724f2f0:

  seabios: update to 1.10.2 release (2017-02-28 09:54:23 +0100)

----------------------------------------------------------------
seabios: update to 1.10.2 release

----------------------------------------------------------------
Gerd Hoffmann (1):
      seabios: update to 1.10.2 release

 pc-bios/bios-256k.bin      | Bin 262144 -> 262144 bytes
 pc-bios/bios.bin           | Bin 131072 -> 131072 bytes
 pc-bios/vgabios-cirrus.bin | Bin 38400 -> 38400 bytes
 pc-bios/vgabios-qxl.bin    | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-stdvga.bin | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-virtio.bin | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-vmware.bin | Bin 38912 -> 38912 bytes
 pc-bios/vgabios.bin        | Bin 38400 -> 38400 bytes
 roms/seabios               |   2 +-
 9 files changed, 1 insertion(+), 1 deletion(-)
