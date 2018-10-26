Received: from eggs.gnu.org ([2001:4830:134:3::10]:37061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gG87P-0005EK-6s
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 15:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gG87K-0007Yb-Kv
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 15:50:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gG87K-0007YN-FH
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 15:49:58 -0400
Date: Sat, 27 Oct 2018 01:19:53 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20181021175858.25886-1-ppandit@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1810270118190.7551@xnncv>
References: <20181021175858.25886-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v1] bt: use size_t type for length
 parameters instead of int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <pmathieu@redhat.com>, Arash TC <tohidi.arash@gmail.com>

+-- On Sun, 21 Oct 2018, P J P wrote --+
| The length parameter values are not negative, thus use an unsigned
| type 'size_t' for them. Many routines pass 'len' values to memcpy(3)
| calls. If it was negative, it could lead to memory corruption issues.
| Add check to avoid it.
| 
| Reported-by: Arash TC <tohidi.arash@gmail.com>
| Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
| ---
|  bt-host.c              |  8 +++---
|  bt-vhci.c              |  7 +++---
|  hw/bt/core.c           |  2 +-
|  hw/bt/hci-csr.c        | 20 +++++++--------
|  hw/bt/hci.c            | 38 ++++++++++++++--------------
|  hw/bt/hid.c            | 10 ++++----
|  hw/bt/l2cap.c          | 56 ++++++++++++++++++++++--------------------
|  hw/bt/sdp.c            |  6 ++---
|  hw/usb/dev-bluetooth.c | 12 ++++-----
|  include/hw/bt.h        |  8 +++---
|  include/sysemu/bt.h    | 10 ++++----
|  11 files changed, 90 insertions(+), 87 deletions(-)
| 
| Update v1: add assert check in vhci_host_send. Also check other places wherein
| length is used with fixed size buffers.
|   -> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03831.html

Ping...!
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
