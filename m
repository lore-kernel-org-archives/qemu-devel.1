Received: from eggs.gnu.org ([2001:4830:134:3::10]:44806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dK0PP-00032J-5F
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 06:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dK0PO-0002zE-7w
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 06:47:51 -0400
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 11 Jun 2017 11:47:46 +0100
Message-ID: <CAJSP0QUD58kjc=8WAxwocK_HGJGqG-YeR5LqU3cCZCgdemZe4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Fuzzing event loops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu block <qemu-block@nongnu.org>

I wanted to share this idea about fuzzing event loops:

https://blog.acolyer.org/2017/06/09/node-fz-fuzzing-the-server-side-event-driven-architecture/

The idea is to expose ordering dependencies and atomicity bugs in
event loop callbacks/coroutines by randomly shuffling the order in
which fd handlers, timers, etc execute.

I'm not sure we'd find many bugs since QEMU tends to use big locks or
request serialization when concurrency gets tricky in the block layer.
Still, it's an interesting concept that we could apply in the future.

Stefan
