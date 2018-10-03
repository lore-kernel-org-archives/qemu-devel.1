Received: from eggs.gnu.org ([2001:4830:134:3::10]:50903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dcsapak@zita.proxmox.com>) id 1g7dRj-00037u-BO
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 05:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dcsapak@zita.proxmox.com>) id 1g7dKS-0000N0-Af
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 05:20:28 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:7435)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dcsapak@zita.proxmox.com>)
	id 1g7dKQ-0000GK-IZ
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 05:20:22 -0400
From: Dominik Csapak <d.csapak@proxmox.com>
Date: Wed,  3 Oct 2018 11:13:43 +0200
Message-Id: <20181003091344.24496-1-d.csapak@proxmox.com>
Subject: [Qemu-devel] [PATCH 0/1] add exit-script option to qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

this patch aims to execute a script when qemu exits
so that one can do cleanups when using --daemonize without
having to use the qmp monitor

for now i have mostly copied the script execution code from
the launch_script function of net/tap.c as i am not sure
if it would make sense to refactor that and if it does, where
to put such a function

Dominik Csapak (1):
  vl.c: call optional script when exiting

 qemu-options.hx | 18 ++++++++++++++++++
 vl.c            | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

-- 
2.11.0
