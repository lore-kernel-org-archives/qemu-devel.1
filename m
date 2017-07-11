Received: from eggs.gnu.org ([2001:4830:134:3::10]:51730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlMX-0005a5-3f
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 22:57:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlMT-00008t-Va
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 22:57:21 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 10 Jul 2017 23:57:00 -0300
Message-Id: <20170711025703.24194-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 0/3] disable Xen on ARM (until supported)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-arm@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Anthony Perard <anthony.perard@citrix.com>, Marcelo Tosatti <mtosatti@redhat.com>, xen-arm@lists.xen.org, Anoob Soman <anoob.soman@citrix.com>, Juergen Gross <jgross@suse.com>, Anthony Xu <anthony.xu@intel.com>, Paul Durrant <paul.durrant@citrix.com>

Hi,

Those errors were triggered installing libxen v4.8 on debian Stretch
ARM (32b and 64b).

It seems QEMU only support Xen on x86 host.

patch 1 disable PCI Passthrough if not on x86,
patch 2 disable xen_map_cache() on ARM, I don't think it is the correct
way to do it, then
patch 3 add few comments to think about spliting x86 part from arch
agnostic Xen code.

That said, I realize there is no Xen ARM entry in MAINTAINERS, I'll Cc:
X86 maintainers although.

Regards,

Phil.

Philippe Mathieu-Daudé (3):
  configure: disable Xen PCI Passthrough on !x86 archs
  [XXX] xen/mapcache: disable on arm*
  [XXX] xen/pt: comment about !x86 archs

 configure                     | 11 +++++++++--
 hw/xen/xen_pt.c               |  4 ++--
 include/sysemu/xen-mapcache.h |  4 +++-
 3 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.13.2
