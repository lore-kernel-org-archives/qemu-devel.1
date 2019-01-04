Received: from eggs.gnu.org ([208.118.235.92]:54143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfSIq-0005uH-7T
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:26:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfSIm-0002rO-Vs
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:26:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gfSIl-0002jQ-0y
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:26:28 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A1277F6C5
	for <qemu-devel@nongnu.org>; Fri,  4 Jan 2019 16:26:19 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  4 Jan 2019 17:25:55 +0100
Message-Id: <20190104162559.20760-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] fw_cfg 20190104 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=83=C2=A9?= <philmd@redhat.com>

Hi Peter,

The following changes since commit 6395fe0c2c7d9f336d87960a7c9924b630c57c=
91:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2019-01-04 13:22:51 +0000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/fw_cfg-20190104-pull-request

for you to fetch changes up to 19bcc4bc3213e78c303ad480a7a578f62258252d:

  fw_cfg: Make qemu_extra_params_fw locally (2019-01-04 15:30:52 +0100)

----------------------------------------------------------------

fw_cfg patches for 2019-01-04

Two fixes from Li Qiang:
- Improve error message when can't load splash file
- Fix boot bootsplash and reboot-timeout error checking

----------------------------------------------------------------

Li Qiang (4):
  fw_cfg: Improve error message when can't load splash file
  fw_cfg: Fix -boot bootsplash error checking
  fw_cfg: Fix -boot reboot-timeout error checking
  fw_cfg: Make qemu_extra_params_fw locally

 hw/nvram/fw_cfg.c       | 70 ++++++++++++++++++-----------------------
 include/sysemu/sysemu.h |  1 -
 vl.c                    |  5 ++-
 3 files changed, 32 insertions(+), 44 deletions(-)

--=20
2.17.2
