Received: from eggs.gnu.org ([209.51.188.92]:50436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guEYt-0002M7-Go
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:48:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guEYo-0002sJ-Vc
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:48:11 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 14 Feb 2019 11:47:03 +0100
Message-Id: <20190214104717.3543-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/14] Trivial branch patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, libvir-list@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Kamil Rytarowski <kamil@netbsd.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The following changes since commit 0b5e750bea635b167eb03d86c3d9a09bbd43bc06:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-02-12 10:53:37 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/trivial-branch-pull-request

for you to fetch changes up to 96566d09aa105ee04cbc1c9539cf8a9a40e8e422:

  configure: improve usbfs check (2019-02-14 11:46:30 +0100)

----------------------------------------------------------------
- some configure updates (HAX/NetBSD, remove "wav", -Waddress-of-packed-member)
- remove deprecated options
- some trace and error cleanup
- typo fixes

----------------------------------------------------------------

Cleber Rosa (2):
  configure: remove handling of "wav" audio driver
  configure: fix qemu-img name

Dr. David Alan Gilbert (4):
  pckbd: Convert DPRINTF->trace
  HMP: Prepend errors with 'Error:'
  kvm: Add kvm_set_ioeventfd* traces
  wavcapture: Convert to error_report

Eric Blake (1):
  qapi: Fix qcow2 encryption doc typo

Kamil Rytarowski (1):
  configure: Add HAX support in NetBSD

Peter Maydell (1):
  configure: Make -Waddress-of-packed-member warnings be errors

Philippe Mathieu-Daudé (1):
  hw/dma/i8257: Use qemu_log_mask(UNIMP) instead of fprintf

Thomas Huth (3):
  qemu-deprecated: Remove -virtioconsole and -no-frame for good
  qemu-options: Remove deprecated option -clock
  hw/sparc64: Explicitly set default_display = "std"

Thomas Petazzoni (1):
  configure: improve usbfs check

 accel/kvm/kvm-all.c    |  3 +++
 accel/kvm/trace-events |  2 ++
 audio/wavcapture.c     | 39 +++++++++++++++++----------------------
 configure              | 27 +++++++++++++++++++--------
 hmp.c                  |  2 +-
 hw/dma/i8257.c         |  4 +++-
 hw/input/pckbd.c       | 19 ++++++-------------
 hw/input/trace-events  |  7 +++++++
 hw/sparc64/sun4u.c     |  2 ++
 qapi/block-core.json   |  2 +-
 qemu-deprecated.texi   | 17 -----------------
 qemu-options.hx        |  3 ---
 vl.c                   |  6 ------
 13 files changed, 61 insertions(+), 72 deletions(-)

-- 
2.20.1
