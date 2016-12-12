Received: from eggs.gnu.org ([2001:4830:134:3::10]:44190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cGOn1-0002gQ-Lp
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:29:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cGOmx-0004VT-PV
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:29:03 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ilg@livius.net>) id 1cGOmx-0004Uz-Is
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:28:59 -0500
Received: by mail-wm0-f66.google.com with SMTP id a20so10612529wme.2
	for <Qemu-devel@nongnu.org>; Mon, 12 Dec 2016 03:28:59 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <20161212103616.GB7918@lemon>
Date: Mon, 12 Dec 2016 13:27:55 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <220EB996-A454-4FB1-9BAD-B0F4A300345E@livius.net>
References: <6BBB3038-0389-4221-9A41-63800F3FF514@livius.net>
	<20161212033512.GA3725@lemon>
	<908F0328-771A-4269-8301-9A7D08BD585F@livius.net>
	<20161212073915.GC3725@lemon>
	<96DEA2D0-3822-4A8C-9950-973B84AF4182@livius.net>
	<20161212093907.GA7918@lemon>
	<151F368B-80DA-4DF6-837C-E2E0737E4AE6@livius.net>
	<20161212103616.GB7918@lemon>
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


> On 12 Dec 2016, at 12:36, Fam Zheng <famz@redhat.com> wrote:
>=20
> an EventNotifier in the main thread which is notified by the vCPU
> thread upon a new graphics operation?=20

the idea of using notifications is ok, but I could not figure out what =
api to use to implement it. can you provide more details?

regards,

Liviu
