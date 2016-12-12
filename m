Received: from eggs.gnu.org ([2001:4830:134:3::10]:47485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cGKtr-0002LV-UP
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 02:19:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cGKtn-00014Z-Us
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 02:19:51 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ilg@livius.net>) id 1cGKtn-0000vn-PG
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 02:19:47 -0500
Received: by mail-wm0-f65.google.com with SMTP id a20so9252219wme.2
	for <Qemu-devel@nongnu.org>; Sun, 11 Dec 2016 23:19:26 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <20161212033512.GA3725@lemon>
Date: Mon, 12 Dec 2016 09:18:23 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <908F0328-771A-4269-8301-9A7D08BD585F@livius.net>
References: <6BBB3038-0389-4221-9A41-63800F3FF514@livius.net>
	<20161212033512.GA3725@lemon>
Subject: Re: [Qemu-devel] experience with SDL2, event loop & main thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developer <Qemu-devel@nongnu.org>


> On 12 Dec 2016, at 05:35, Fam Zheng <famz@redhat.com> wrote:
>=20
> Isn't it possible to notify the main thread with an EventNotifier and =
process
> the deferred events in its handler?

ideally, the SDL main loop might be re-implemented asynchronously, for =
example using a pipe to pass the events, and in this case the SDL would =
be just a regular client of the main I/O loop.

any idea how difficult would be to push any changes to SDL?


regards,

Liviu
