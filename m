Received: from eggs.gnu.org ([2001:4830:134:3::10]:42432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hellokittyme@163.com>) id 1f13Fq-0004e5-OE
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 01:04:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hellokittyme@163.com>) id 1f13Fn-0003An-Ks
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 01:04:10 -0400
Received: from m12-15.163.com ([220.181.12.15]:60832)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hellokittyme@163.com>) id 1f13Fm-00039D-Q0
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 01:04:07 -0400
Date: Wed, 28 Mar 2018 12:48:48 +0800 (CST)
From: iscccc <hellokittyme@163.com>
MIME-Version: 1.0
Message-ID: <69678ef4.64d2.1626aefe0be.Coremail.hellokittyme@163.com>
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] cpu_memory_rw_debug function is too slow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello, I found that use cpu_memory_rw_debug in tcg mode when qemu access guest virtual address is too slow, can I choose to use some other more fast function ?
