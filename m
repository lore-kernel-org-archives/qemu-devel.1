Received: from eggs.gnu.org ([2001:4830:134:3::10]:48337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1coGJK-0000CA-Pr
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 17:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1coG9F-00051q-U7
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 17:08:01 -0400
Received: from chuckie.co.uk ([82.165.15.123]:34388
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1coG9F-0004xx-Mz
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 17:07:57 -0400
Date: Wed, 15 Mar 2017 21:07:14 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20170315210714.GB26201@kentang.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL for-2.9] Update OpenBIOS images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org

Hi Peter,

This update contains just the 64-bit PCI BAR fix which enables virtio modern devices to
work once again. Please pull.


ATB,

Mark. 


The following changes since commit 1883ff34b540daacae948f493b0ba525edf5f642:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-03-15 18:44:05 +0000)

are available in the git repository at:


  https://github.com/mcayland/qemu.git tags/qemu-openbios-signed

for you to fetch changes up to 111308e789b7a3e2771a61f68bd057f8f8b1bc22:

  Update OpenBIOS images to f233c3f built from submodule. (2017-03-15 19:42:08 +0000)

----------------------------------------------------------------
Update OpenBIOS images

----------------------------------------------------------------
Mark Cave-Ayland (1):
      Update OpenBIOS images to f233c3f built from submodule.

 pc-bios/openbios-ppc     |  Bin 750840 -> 750840 bytes
 pc-bios/openbios-sparc32 |  Bin 382048 -> 382048 bytes
 pc-bios/openbios-sparc64 |  Bin 1593408 -> 1593408 bytes
 roms/openbios            |    2 +-
 4 files changed, 1 insertion(+), 1 deletion(-)
