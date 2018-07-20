Received: from eggs.gnu.org ([2001:4830:134:3::10]:46757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fgOwe-0005IP-2f
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 02:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fgOwa-0007cZ-WC
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 02:31:16 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:54827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fgOwa-0007cC-Op
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 02:31:12 -0400
Received: by mail-wm0-x241.google.com with SMTP id c14-v6so8359068wmb.4
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 23:31:12 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jul 2018 08:31:07 +0200
Message-Id: <20180720063109.4631-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [RFC/RFT PATCH 0/2] spice-display locking fixes
 (cursors)?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The first issue was found by Coverity and should be trivial.  The second
however made me wonder how to test the code and whether it has ever
worked, because in theory it should be an instant deadlock whenever
qemu_spice_cursor_refresh_bh is called.

So I'm looking for help.  In fact, the changes are not tested beyond
compilation.

Paolo

Paolo Bonzini (2):
  spice-display: access ptr_x/ptr_y under Mutex
  spice-display: fix qemu_spice_cursor_refresh_bh locking

 ui/spice-display.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

-- 
2.17.1
