Received: from eggs.gnu.org ([2001:4830:134:3::10]:51840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKJZ8-0001fY-JT
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 02:47:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKJZ4-0001m1-JQ
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 02:47:26 -0500
Received: from mail-eopbgr50096.outbound.protection.outlook.com
	([40.107.5.96]:50368
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eKJZ4-0001ka-6i
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 02:47:22 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3c1d9325-56a9-225d-4ff8-230f8ed52fed@virtuozzo.com>
Date: Thu, 30 Nov 2017 10:47:12 +0300
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] export root node for write through NBD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>

Hi all.

We need the following option: start vm in stopped mode (-S) and write 
it's disk before start through NBD.
It should be absolutely safe, but unfortunately it is disallowed by root 
role of the disk.
Is there any workaround or if not, what is a true way to implement this 
possibility?

----
error message:
     unable to execute QEMU command 'nbd-server-add': Conflicts with use 
by drive0 as 'root', which does not allow 'write' on #block100

-- 
Best regards,
Vladimir
