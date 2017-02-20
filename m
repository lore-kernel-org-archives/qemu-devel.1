Received: from eggs.gnu.org ([2001:4830:134:3::10]:33235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cfsb7-0001Yg-Mo
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cfsb2-00044c-QB
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:22:05 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:24405 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1cfsb2-00043H-Fn
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:22:00 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Mon, 20 Feb 2017 21:21:52 +0300
Message-Id: <1487614915-18710-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH for 2.9 0/3] guest panic information follow-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Anton Nefedov <anton.nefedov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

This is a set of followup patches requested by Eric Blake.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Eric Blake <eblake@redhat.com>

Anton Nefedov (3):
  i386/cpu: release GuestPanicInformation memory
  qapi: flatten GuestPanicInformation union
  qmp-events: fix GUEST_PANICKED description formatting

 kvm-all.c         |  5 ++++-
 qapi-schema.json  | 12 ++++++++++++
 qapi/event.json   |  4 ++--
 target/i386/cpu.c | 15 ++++++---------
 vl.c              | 22 +++++++++-------------
 5 files changed, 33 insertions(+), 25 deletions(-)

-- 
2.7.4
