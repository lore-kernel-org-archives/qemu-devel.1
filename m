Received: from eggs.gnu.org ([2001:4830:134:3::10]:49782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dhqWe-0001k4-Dx
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 01:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dhqWa-0007AB-0H
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 01:05:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dhqWZ-00079q-8G
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 01:05:47 -0400
From: Thomas Huth <thuth@redhat.com>
Message-ID: <451ff313-11c5-9f67-d7f1-a606c02efc79@redhat.com>
Date: Wed, 16 Aug 2017 07:05:37 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Crash when deleting the diag288 watchdog
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Sascha Silbe <silbe@linux.vnet.ibm.com>

 Hi,

I recently noticed that QEMU abort()s if you try to remove the diag288
watchdog. For example:

$ qemu-system-s390x -nographic -nodefaults -S -monitor stdio
QEMU 2.9.92 monitor - type 'help' for more information
(qemu) device_add diag288,id=3Dx
(qemu) device_del x
**
ERROR:/home/thuth/devel/qemu/qdev-monitor.c:872:qdev_unplug: assertion
failed: (hotplug_ctrl)
Aborted (core dumped)

This is ugly, can we fix this somehow? For example, should the diag288
device be hot-pluggable at all, or can it only be used via the
"-watchdog" parameter instead? In the latter case, we could simply mark
the device with "user_creatable =3D false", I guess?

 Thomas
