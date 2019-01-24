Received: from eggs.gnu.org ([209.51.188.92]:44257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gmeSG-000159-PL
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:50:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gmeSF-00011l-0P
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:50:00 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 24 Jan 2019 13:49:01 +0100
Message-Id: <20190124124906.16653-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/5] Trivial patches patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The following changes since commit 6d809e7da943bb4b95b408fbf3d80d097c0f7d38:

  Merge remote-tracking branch 'remotes/xtensa/tags/20190122-xtensa' into staging (2019-01-23 21:50:49 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/trivial-patches-pull-request

for you to fetch changes up to 285816d76f37c412f391fa14a2b28a35b7cb134e:

  hw/i386/pc.c: fix one typo in function name (2019-01-24 13:34:20 +0100)

----------------------------------------------------------------
- Some typo and UTF-8 fixes
- a ppc e6500 fix to remove duplicate SPR registering

----------------------------------------------------------------

Jon Diekema (1):
  ppc: e6500 registers SPR 604 twice

Philippe Mathieu-Daudé (3):
  MAINTAINERS: Fix utf-8 mangling
  contrib/gitdm: Fix a typo
  virtio-net: Fix a typo

Wei Yang (1):
  hw/i386/pc.c: fix one typo in function name

 MAINTAINERS                     | 2 +-
 contrib/gitdm/filetypes.txt     | 2 +-
 hw/i386/pc.c                    | 4 ++--
 include/hw/virtio/virtio-net.h  | 2 +-
 target/ppc/translate_init.inc.c | 8 --------
 5 files changed, 5 insertions(+), 13 deletions(-)

-- 
2.20.1
