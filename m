Received: from eggs.gnu.org ([2001:4830:134:3::10]:58051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dMyZJ-0002tH-D8
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dMyZE-0001rr-N5
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:26:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dMyZE-0001rV-Gc
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:26:16 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170616160658.32290-1-famz@redhat.com> (Fam Zheng's message of
	"Sat, 17 Jun 2017 00:06:58 +0800")
References: <20170616160658.32290-1-famz@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 19 Jun 2017 17:26:03 +0200
Message-ID: <8760fsatis.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] migration: Fix race of image locking
 between src and dst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, peterx@redhat.com, mreitz@redhat.com, stefanha@redhat.com, Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jsnow@redhat.com

Fam Zheng <famz@redhat.com> wrote:
> Previously, dst side will immediately try to lock the write byte upon
> receiving QEMU_VM_EOF, but at src side, bdrv_inactivate_all() is only
> done after sending it. If the src host is under load, dst may fail to
> acquire the lock due to racing with the src unlocking it.
>
> Fix this by hoisting the bdrv_inactivate_all() operation before
> QEMU_VM_EOF.
>
> N.B. A further improvement could possibly be done to cleanly handover
> locks between src and dst, so that there is no window where a third QEMU
> could steal the locks and prevent src and dst from running.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
