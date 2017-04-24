Received: from eggs.gnu.org ([2001:4830:134:3::10]:33494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yanghongyang@huawei.com>) id 1d2cSH-0004ZX-6d
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 07:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yanghongyang@huawei.com>) id 1d2cSD-0006mo-7Z
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 07:46:57 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3519
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <yanghongyang@huawei.com>) id 1d2cSC-0006kD-Rw
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 07:46:53 -0400
From: Yang Hongyang <yanghongyang@huawei.com>
Message-ID: <830bfc39-56c7-a901-9ebb-77d6e7a5614c@huawei.com>
Date: Mon, 24 Apr 2017 19:46:19 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] About QEMU BQL and dirty log switch in Migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Huangzhichao <huangzhichao@huawei.com>, wangxinxin.wang@huawei.com, "quintela@redhat.com" <quintela@redhat.com>, pbonzini@redhat.com, "Gonglei (Arei)" <arei.gonglei@huawei.com>

Hi all,

We found dirty log switch costs more then 13 seconds while migrating
a 4T memory guest, and dirty log switch is currently protected by QEMU
BQL. This causes guest freeze for a long time when switching dirty log on,
and the migration downtime is unacceptable.
Are there any chance to optimize the time cost for dirty log switch operation?
Or move the time consuming operation out of the QEMU BQL?

-- 
Thanks,
Yang
