Received: from eggs.gnu.org ([2001:4830:134:3::10]:37477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farrah.chen@intel.com>) id 1e5WBF-0003HM-2l
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farrah.chen@intel.com>) id 1e5WBB-00061a-Sy
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:13:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:22272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farrah.chen@intel.com>)
	id 1e5WBA-0005wH-5t
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:13:33 -0400
From: "Chen, Farrah" <farrah.chen@intel.com>
Date: Fri, 20 Oct 2017 12:13:05 +0000
Message-ID: <1B925CC0CD9F3341B32D442251E7E1DC391048B2@shsmsx102.ccr.corp.intel.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] qemu compile error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Hu, Robert" <robert.hu@intel.com>

Hi,

When I build qemu with commit from aef45d51d1204f3335fb99de6658e0c5612c2b67=
 to the latest one, the following error occurred:

tsocks git clone git://git.qemu.org/qemu.git
cd qemu

./configure --target-list=3Dx86_64-softmmu --enable-kvm --enable-vnc --disa=
ble-gtk --enable-libusb --enable-numa --disable-sdl
make
  GEN     config-host.h
  GIT     dtc
  GEN     trace/generated-tcg-tracers.h
  GEN     trace/generated-helpers-wrappers.h
  GEN     trace/generated-helpers.h
  GEN     module_block.h
  GEN     trace/generated-helpers.c
make: *** [git-submodule-update] Error 1


Would you mind telling me how to avoid this error?


Thanks,
Fan Chen
