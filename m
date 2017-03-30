Received: from eggs.gnu.org ([2001:4830:134:3::10]:43813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ctad1-00079b-3g
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ctacy-0003f6-IT
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:00:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ctacy-0003er-CH
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:00:40 -0400
Message-ID: <1490882437.28523.21.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 30 Mar 2017 16:00:37 +0200
In-Reply-To: <1490880938-90331-1-git-send-email-agraf@suse.de>
References: <1490880938-90331-1-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] input: Add trace events for polled
 keyboard input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org

On Do, 2017-03-30 at 15:35 +0200, Alexander Graf wrote:
> When driving QEMU from the outside, we have basically no chance to
> determine how quickly the guest OS picks up key events, so we usually
> have to limit ourselves to very slow keyboard presses to make sure
> the guest always has enough chance to pick them up.
>=20
> This patch adds trace events for when the guest polls for HID keyboard
> events. That way we can be reasonably safely assume that the guest
> handled that one key event and can type the next.

Hmm, I'm wondering why you are tracing the event details?  Input layer
has tracepoints for this already, so why duplicate this here?
Especially as you have to do quite some effort to store the data for
tracing?

For queue management (in automated testing I assume?) a simple "queue
empty" trace point should do the trick, no?  Or maybe a "queue has $i of
$n slots filled atm" trace points, if you wanna know how much you can
pass in without loosing events due to the queue being full.

cheers,
  Gerd
