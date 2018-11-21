Received: from eggs.gnu.org ([2001:4830:134:3::10]:43675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gPKmc-0003ww-PG
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 00:10:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gPKmZ-0002lu-NF
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 00:10:38 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gPKmZ-0002k4-H8
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 00:10:35 -0500
Received: by mail-pl1-x642.google.com with SMTP id e5so3688615plb.5
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 21:10:35 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 20 Nov 2018 21:10:23 -0800
Message-Id: <1542777026-2788-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/3] fw_cfg: fix boot bootsplash and
 reboot-timeout error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: armbru@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, lersek@redhat.com, philmd@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com

And also do some code cleanup.
A lot of thanks to Markus's review and advice.

v2: fix some small issue per Markus's review.

Li Qiang (3):
  fw_cfg: fix -boot bootsplash error checking
  fw_cfg: fix -boot reboot-timeout error checking
  fw_cfg: make qemu_extra_params_fw locally

 hw/nvram/fw_cfg.c       | 63 +++++++++++++++++++++----------------------------
 include/sysemu/sysemu.h |  1 -
 vl.c                    |  4 ++--
 3 files changed, 29 insertions(+), 39 deletions(-)

-- 
2.11.0
