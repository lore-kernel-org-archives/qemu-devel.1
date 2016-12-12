Received: from eggs.gnu.org ([2001:4830:134:3::10]:35828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cGNy0-0006l0-TZ
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:36:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cGNy0-0003Xk-0L
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:36:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cGNxz-0003X0-RA
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:36:19 -0500
Date: Mon, 12 Dec 2016 18:36:16 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20161212103616.GB7918@lemon>
References: <6BBB3038-0389-4221-9A41-63800F3FF514@livius.net>
	<20161212033512.GA3725@lemon>
	<908F0328-771A-4269-8301-9A7D08BD585F@livius.net>
	<20161212073915.GC3725@lemon>
	<96DEA2D0-3822-4A8C-9950-973B84AF4182@livius.net>
	<20161212093907.GA7918@lemon>
	<151F368B-80DA-4DF6-837C-E2E0737E4AE6@livius.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151F368B-80DA-4DF6-837C-E2E0737E4AE6@livius.net>
Subject: Re: [Qemu-devel] experience with SDL2, event loop & main thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liviu Ionescu <ilg@livius.net>
Cc: QEMU Developer <Qemu-devel@nongnu.org>

On Mon, 12/12 12:20, Liviu Ionescu wrote:
> 
> > On 12 Dec 2016, at 11:39, Fam Zheng <famz@redhat.com> wrote:
> > 
> > ... I myself know next to nothing about SDL project.
> 
> ok, neither do I.
> 
> 
> do you have any comments on the current situation of the SDL integration in
> QEMU? any comments on the conclusions I reached after integrating SDL2 into
> GNU ARM Eclipse QEMU?
> 
> personally I do not like at all polling the SDL loop every 10 ms on a timer,
> but I currently have no other solution. I tried to move the I/O loop on a
> separate thread, but the Windows implementation of `poll` works only on the
> main thread.

Like I said ealier, instead of "polling" SDL events in a timer, how about
registering an EventNotifier in the main thread which is notified by the vCPU
thread upon a new graphics operation? That will fix the latency issue.

Fam
