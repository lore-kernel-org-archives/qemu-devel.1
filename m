Received: from eggs.gnu.org ([2001:4830:134:3::10]:50092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1dsQfe-00054g-Cg
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 05:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1dsQfb-0006mN-AB
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 05:42:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1dsQfa-0006S1-BR
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 05:42:51 -0400
From: "WangJie (Captain)" <wangjie88@huawei.com>
Message-ID: <59BA4ED4.6070108@huawei.com>
Date: Thu, 14 Sep 2017 17:41:40 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] =?utf-8?q?question=EF=BC=9Aa_question_about_throttle?=
 =?utf-8?q?_and_hot-unplug?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: berto@igalia.com, stefanha@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Hi, Kevin

the patch you commited: https://github.com/qemu/qemu/commit/7ca7f0f6db1fedd28d490795d778cf23979a2aa7#diff-ea36ba0f79150cc299732696a069caba

remove blk_io_limits_disable from blk_remove_bs

Then, if a disk which configured qos hot-unplug from VM, the backend of the disk reminds in throttle group.

So when I hot-unplug and hot-plug a disk, and use the same throttle group name, will lead to qemu crash.


and Eric committed a path as fallow fixed the bug on qemu-kvm 2.9.0-rc4:
https://github.com/qemu/qemu/commit/1606e4cf8a976513ecac70ad6642a7ec45744cf5#diff-7cb66df56045598b75a219eebc27efb6


Is what I said as below correct? I just want to make sure it. Thank you :）
