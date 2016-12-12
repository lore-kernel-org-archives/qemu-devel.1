Received: from eggs.gnu.org ([2001:4830:134:3::10]:55929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cGNjg-0003yj-Ia
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:21:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cGNja-0006BG-Dm
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:21:32 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ilg@livius.net>) id 1cGNja-0006Ad-0y
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:21:26 -0500
Received: by mail-wm0-f65.google.com with SMTP id a20so10232215wme.2
	for <Qemu-devel@nongnu.org>; Mon, 12 Dec 2016 02:21:25 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <20161212093907.GA7918@lemon>
Date: Mon, 12 Dec 2016 12:20:23 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <151F368B-80DA-4DF6-837C-E2E0737E4AE6@livius.net>
References: <6BBB3038-0389-4221-9A41-63800F3FF514@livius.net>
	<20161212033512.GA3725@lemon>
	<908F0328-771A-4269-8301-9A7D08BD585F@livius.net>
	<20161212073915.GC3725@lemon>
	<96DEA2D0-3822-4A8C-9950-973B84AF4182@livius.net>
	<20161212093907.GA7918@lemon>
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


> On 12 Dec 2016, at 11:39, Fam Zheng <famz@redhat.com> wrote:
>=20
> ... I myself know next to nothing about SDL project.

ok, neither do I.


do you have any comments on the current situation of the SDL integration =
in QEMU? any comments on the conclusions I reached after integrating =
SDL2 into GNU ARM Eclipse QEMU?

personally I do not like at all polling the SDL loop every 10 ms on a =
timer, but I currently have no other solution. I tried to move the I/O =
loop on a separate thread, but the Windows implementation of `poll` =
works only on the main thread.


regards,

Liviu
