Received: from eggs.gnu.org ([2001:4830:134:3::10]:59473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gK2iG-0006A0-Sv
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:52:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gK2iD-0005i6-88
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:52:16 -0500
References: <20181021175858.25886-1-ppandit@redhat.com>
	<nycvar.YSQ.7.76.1810270118190.7551@xnncv>
	<nycvar.YSQ.7.76.1811021434001.17929@xnncv>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1055bb12-6b57-1240-790c-930f2405ebee@redhat.com>
Date: Tue, 6 Nov 2018 15:52:02 +0100
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1811021434001.17929@xnncv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Arash TC <tohidi.arash@gmail.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On 2018-11-02 10:05, P J P wrote:
> +-- On Sat, 27 Oct 2018, P J P wrote --+
> |+-- On Sun, 21 Oct 2018, P J P wrote --+
> || The length parameter values are not negative, thus use an unsigned
> || type 'size_t' for them. Many routines pass 'len' values to memcpy(3)
> || calls. If it was negative, it could lead to memory corruption issues=
.
> || Add check to avoid it.
> ||=20
> || Reported-by: Arash TC <tohidi.arash@gmail.com>
> || Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> || ---
> ||  bt-host.c              |  8 +++---
> ||  bt-vhci.c              |  7 +++---
> ||  hw/bt/core.c           |  2 +-
> ||  hw/bt/hci-csr.c        | 20 +++++++--------
> ||  hw/bt/hci.c            | 38 ++++++++++++++--------------
> ||  hw/bt/hid.c            | 10 ++++----
> ||  hw/bt/l2cap.c          | 56 ++++++++++++++++++++++-----------------=
---
> ||  hw/bt/sdp.c            |  6 ++---
> ||  hw/usb/dev-bluetooth.c | 12 ++++-----
> ||  include/hw/bt.h        |  8 +++---
> ||  include/sysemu/bt.h    | 10 ++++----
> ||  11 files changed, 90 insertions(+), 87 deletions(-)
> ||=20
> || Update v1: add assert check in vhci_host_send. Also check other plac=
es wherein
> || length is used with fixed size buffers.
> ||   -> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03831.=
html
> |=20
> | Ping...!
>=20
> Ping...!

The bluetooth subsystem is completely unmaintained, so if Paolo does not
want to pick it up through his "misc" tree, maybe Peter could apply this
patch directly? Or maybe it could go through the trivial tree since it
does not look very complicated?

FWIW, the patch looks OK to me at a first glance, so:

Acked-by: Thomas Huth <thuth@redhat.com>

PS: I still think we should deprecate the bt subsystem, since nobody
really touched it within years...
