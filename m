Received: from eggs.gnu.org ([2001:4830:134:3::10]:59389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cGQaB-0001zB-9f
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 08:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cGQa7-0004rg-Pm
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 08:23:55 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ilg@livius.net>) id 1cGQa7-0004pN-Ez
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 08:23:51 -0500
Received: by mail-wm0-f65.google.com with SMTP id u144so11251660wmu.0
	for <Qemu-devel@nongnu.org>; Mon, 12 Dec 2016 05:23:51 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <20161212122803.GC7918@lemon>
Date: Mon, 12 Dec 2016 15:22:48 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <EA7E7748-CB11-49AB-ADBA-555A0A510611@livius.net>
References: <6BBB3038-0389-4221-9A41-63800F3FF514@livius.net>
	<20161212033512.GA3725@lemon>
	<908F0328-771A-4269-8301-9A7D08BD585F@livius.net>
	<20161212073915.GC3725@lemon>
	<96DEA2D0-3822-4A8C-9950-973B84AF4182@livius.net>
	<20161212093907.GA7918@lemon>
	<151F368B-80DA-4DF6-837C-E2E0737E4AE6@livius.net>
	<20161212103616.GB7918@lemon>
	<220EB996-A454-4FB1-9BAD-B0F4A300345E@livius.net>
	<20161212122803.GC7918@lemon>
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


> On 12 Dec 2016, at 14:28, Fam Zheng <famz@redhat.com> wrote:
>=20
> ... Take a look at event_notifier_set_handler() and =
event_notifier_set().
> ... qemu_bh_new() and qemu_bh_schedule().
>=20
> Both can register a callback that will be called in main loop once =
fired.

ok, thank you, I'll consider them.

if I understand it right, this is a more portable alternative of using =
the SDL user events, to forward actions from the device thread to the =
main thread.

but this is only part of the problem, in addition to user events, =
graphical libraries also generate system events (like mouse, =
termination, etc) usually consumed by a kind of event loop. probably it =
is possible to set a notifier handler to run the SDL PollEvent, but, at =
least for SDL, I did not find any function in the public API to add a =
hook to trigger events associated with system events.

so, back to square one; any suggestion on how to avoid the periodic =
timer required to poll SDL system events?


regards,

Liviu
