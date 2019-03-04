Received: from eggs.gnu.org ([209.51.188.92]:52447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0qmx-0004MY-EU
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:50:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0qmw-0005g0-GW
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:50:03 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:36688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h0qmw-0005ev-7t
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:50:02 -0500
Received: by mail-wm1-x32f.google.com with SMTP id j125so5384011wmj.1
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 08:50:02 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	x74sm7238018wmf.22.2019.03.04.08.49.59 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 04 Mar 2019 08:49:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Mar 2019 16:49:51 +0000
Message-Id: <20190304164958.9362-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/7] cocoa queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Cocoa queue: this just has the refactoring to ensure we
can run reliably on OSX Mojave. Thanks to everybody who helped
in reviewing and testing this.

-- PMM
 
The following changes since commit 88687719c8859bf98ed94ce91612608c99c51c1a:

  Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2019-02-25-1' into staging (2019-03-04 15:56:08 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-cocoa-20190304

for you to fetch changes up to 5588840ff77800e839d8a34b7be10e5c3acd1721:

  ui/cocoa: Perform UI operations only on the main thread (2019-03-04 16:47:31 +0000)

----------------------------------------------------------------
cocoa tree:
 * Support OSX Mojave by ensuring that we always make Cocoa UI
   function calls from the main thread, never from any other QEMU
   thread. This was previously mostly harmless, but on Mojave
   it will cause OSX to terminate the QEMU process.

----------------------------------------------------------------
Peter Maydell (7):
      ui/cocoa: Ensure we have the iothread lock when calling into QEMU
      ui/cocoa: Use the pixman image directly in switchSurface
      ui/cocoa: Factor out initial menu creation
      ui/cocoa: Move console/device menu creation code up in file
      ui/cocoa: Don't call NSApp sendEvent directly from handleEvent
      ui/cocoa: Subclass NSApplication so we can implement sendEvent
      ui/cocoa: Perform UI operations only on the main thread

 ui/cocoa.m | 495 +++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 303 insertions(+), 192 deletions(-)
