Received: from eggs.gnu.org ([2001:4830:134:3::10]:50264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cbqbN-0004tx-Sk
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:25:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cbqbJ-0003Ff-N4
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:25:41 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:26223 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1cbqbJ-0003FA-5O
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:25:37 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Thu,  9 Feb 2017 18:25:32 +0300
Message-Id: <1486653934-14805-1-git-send-email-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] chardevice hotswap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

During debug it would be very nice to connect to different backend
for serial console. This is especially helpful during Windows
debug when one want to establish the connection to alive VM
from VM with WinDbg.

This could be achieved with host means but the feature as a whole
looks attractive to us.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
