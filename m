Received: from eggs.gnu.org ([2001:4830:134:3::10]:36526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gI6As-0005Or-0l
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 02:09:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gI6An-0003Qb-1l
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 02:09:45 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gI6Am-0003QJ-Qv
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 02:09:40 -0400
Received: by mail-pf1-x444.google.com with SMTP id j22-v6so4986798pfh.3
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 23:09:40 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 31 Oct 2018 23:09:34 -0700
Message-Id: <1541052574-29085-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 0/2] fw_cfg reboot_time and splash_time  fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, armbru@redhat.com, philmd@redhat.com, lersek@redhat.com, kraxel@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

The first patch ensure the reboot_time is never negative
and second change the splash-time and reboot-timeout 
type to qemu_opt_get_number per Markus's advice:

https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06975.html


Li Qiang (2):
  hw: fw_cfg: ensure reboot_time is nonegative
  hw: fw_cfg: use qemu_opt_get_number to get splash-time and     
    reboot-timeout

 hw/nvram/fw_cfg.c | 38 +++++++++++++++-----------------------
 vl.c              |  4 ++--
 2 files changed, 17 insertions(+), 25 deletions(-)

-- 
1.8.3.1
