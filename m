Received: from eggs.gnu.org ([2001:4830:134:3::10]:58987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cEMoE-0003Hd-MW
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:57:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cEMoB-0006Qw-JV
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:57:54 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cEMoB-0006Nm-E9
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:57:51 -0500
Received: by mail-yw0-f196.google.com with SMTP id b66so29935649ywh.2
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 12:57:30 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue,  6 Dec 2016 15:56:24 -0500
Message-Id: <20161206205627.8443-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 0/3] tcg: tb lock updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, mst@redhat.com, cota@braap.org

Hello,

Please find a few minor tb lock updates in the MTTCG series. The main
motivation was to remove tb_lock_reset() and explicitly unlock the
tb_lock wherever possible so that reset() can be removed. This is not
possible yet since we take interrupts and exit the execution loop with
the tb lock held from multiple locations. However, I still think that explicit
unlocking is a good idea.

Thanks,

Pranith Kumar (3):
  tcg: Release tb_lock in the order acquired
  tcg: Reuse hashed pc value
  tcg: Explicitly unlock tb_lock

 cpu-exec.c         | 17 ++++++-----------
 exec.c             |  2 ++
 hw/i386/kvmvapic.c |  1 +
 translate-all.c    |  3 +++
 4 files changed, 12 insertions(+), 11 deletions(-)

-- 
2.11.0
