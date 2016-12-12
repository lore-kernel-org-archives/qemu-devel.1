Received: from eggs.gnu.org ([2001:4830:134:3::10]:37252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edward.shishkin@gmail.com>) id 1cGV7X-0006p8-U1
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:14:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edward.shishkin@gmail.com>) id 1cGV7U-0000z8-UC
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:14:40 -0500
Received: from mail-wj0-f193.google.com ([209.85.210.193]:35022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edward.shishkin@gmail.com>)
	id 1cGV7U-0000qq-Nw
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:14:36 -0500
Received: by mail-wj0-f193.google.com with SMTP id he10so12905736wjc.2
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 10:14:13 -0800 (PST)
References: <7a0376a6-e9c1-92c0-a75f-6b44495ba2b2@gmail.com>
From: Edward Shishkin <edward.shishkin@gmail.com>
Message-ID: <db578624-4bdd-8d2d-3e18-02f518a6c212@gmail.com>
Date: Mon, 12 Dec 2016 19:13:11 +0100
MIME-Version: 1.0
In-Reply-To: <7a0376a6-e9c1-92c0-a75f-6b44495ba2b2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC][PATCH 0/7] 9p: v9fs read and write speedup - V2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Van Hensbergen <ericvh@gmail.com>, V9FS Developers Mailing List <v9fs-developer@lists.sourceforge.net>, Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>
Cc: QEMU Developers Mailing List <qemu-devel@nongnu.org>, ZhangWei <zhangwei555@huawei.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, Edward Shishkin <Eduard.Shishkin@huawei.com>, Greg Kurz <groug@kaod.org>, Alexander Graf <agraf@suse.de>

Hello everyone,

Version 2 of the patch-series contains cleanups and bug-fixes.
The patches 1, 2 remain unchanged. The patches 3, 4, 5 are
cleanups suggested by Fengguang Wu. The patches 6, 7 are fixups
for bugs found by Alexander Graf.

Any comments, suggestions are welcome as usual.

Thanks,
Edward.
