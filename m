Received: from eggs.gnu.org ([2001:4830:134:3::10]:49347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cGPiE-0005wS-89
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 07:28:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cGPiA-0004L1-W2
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 07:28:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cGPiA-0004Kh-QG
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 07:28:06 -0500
Date: Mon, 12 Dec 2016 20:28:03 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20161212122803.GC7918@lemon>
References: <6BBB3038-0389-4221-9A41-63800F3FF514@livius.net>
	<20161212033512.GA3725@lemon>
	<908F0328-771A-4269-8301-9A7D08BD585F@livius.net>
	<20161212073915.GC3725@lemon>
	<96DEA2D0-3822-4A8C-9950-973B84AF4182@livius.net>
	<20161212093907.GA7918@lemon>
	<151F368B-80DA-4DF6-837C-E2E0737E4AE6@livius.net>
	<20161212103616.GB7918@lemon>
	<220EB996-A454-4FB1-9BAD-B0F4A300345E@livius.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <220EB996-A454-4FB1-9BAD-B0F4A300345E@livius.net>
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

On Mon, 12/12 13:27, Liviu Ionescu wrote:
> 
> > On 12 Dec 2016, at 12:36, Fam Zheng <famz@redhat.com> wrote:
> > 
> > an EventNotifier in the main thread which is notified by the vCPU
> > thread upon a new graphics operation? 
> 
> the idea of using notifications is ok, but I could not figure out what api to
> use to implement it. can you provide more details?

Take a look at event_notifier_set_handler() and event_notifier_set().

Or alternatively (whichever works better for you, I don't know): qemu_bh_new()
and qemu_bh_schedule().

Both can register a callback that will be called in main loop once fired.

Fam
