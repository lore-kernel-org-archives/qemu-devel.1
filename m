Received: from eggs.gnu.org ([2001:4830:134:3::10]:40823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cGhQi-0002Ds-CM
	for Qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:23:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cGhQe-0005LD-AC
	for Qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:23:16 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ilg@livius.net>) id 1cGhQe-0005E4-0l
	for Qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:23:12 -0500
Received: by mail-wm0-f65.google.com with SMTP id a20so16376617wme.2
	for <Qemu-devel@nongnu.org>; Mon, 12 Dec 2016 23:22:49 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <20161213070453.GB2165@lemon>
Date: Tue, 13 Dec 2016 09:21:46 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <79F9B097-F930-430E-800D-83F98F17CBC3@livius.net>
References: <20161212073915.GC3725@lemon>
	<96DEA2D0-3822-4A8C-9950-973B84AF4182@livius.net>
	<20161212093907.GA7918@lemon>
	<151F368B-80DA-4DF6-837C-E2E0737E4AE6@livius.net>
	<20161212103616.GB7918@lemon>
	<220EB996-A454-4FB1-9BAD-B0F4A300345E@livius.net>
	<20161212122803.GC7918@lemon>
	<EA7E7748-CB11-49AB-ADBA-555A0A510611@livius.net>
	<20161212145117.GB21817@lemon>
	<F71562E4-2D12-4F28-AC3F-70463E91E6A5@livius.net>
	<20161213070453.GB2165@lemon>
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
Cc: QEMU Developer <Qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>


> On 13 Dec 2016, at 09:04, Fam Zheng <famz@redhat.com> wrote:
>=20
> using qemu_bh_schedule_idle in the QEMU main loop and poll event there
> periodically.

ok, so my TODO list includes two items: to move user events on an event =
notifier and to run the SDL_PollEvent() on qemu_bh_schedule_idle. I'll =
do this, but after I'll be ready with my new release (planned by the end =
of this year).


regards,

Liviu
