Received: from eggs.gnu.org ([209.51.188.92]:34679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDtic-0005kL-Lj
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDtib-0003cV-OA
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:35:30 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:37486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hDtib-0003XB-DR
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:35:29 -0400
Received: by mail-wm1-x333.google.com with SMTP id v14so4088255wmf.2
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 09:35:23 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	l23sm13312650wmj.10.2019.04.09.09.35.20 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 09:35:20 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  9 Apr 2019 18:35:19 +0200
Message-Id: <1554827719-10184-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 0/5] Misc patches for QEMU 5.0-rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 248987f92cfda8305d6d44ced23e173e62a8bc0e:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.0-pull-request' into staging (2019-04-09 10:02:30 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 3e20c81ed87cb15cd04f929b075e244e0758641a:

  tests: Make check-block a phony target (2019-04-09 18:34:21 +0200)

----------------------------------------------------------------
* fixes for Alpine and SuSE
* fix crash when hot-plugging nvdimm on older machine types

----------------------------------------------------------------
Markus Armbruster (1):
      tests: Make check-block a phony target

Peter Maydell (1):
      include/qemu/bswap.h: Use __builtin_memcpy() in accessor functions

Philippe Mathieu-Daudé (2):
      roms: Rename the EFIROM variable to avoid clashing with iPXE
      roms: Allow passing configure options to the EDK2 build tools

Thomas Huth (1):
      hw/i386/pc: Fix crash when hot-plugging nvdimm on older machine types

 hw/i386/pc.c           |  9 +++++++--
 include/qemu/bswap.h   | 26 ++++++++++++++++----------
 roms/Makefile          | 23 ++++++++++++++++++-----
 tests/Makefile.include |  2 +-
 4 files changed, 42 insertions(+), 18 deletions(-)
-- 
1.8.3.1
