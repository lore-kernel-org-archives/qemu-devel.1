Received: from eggs.gnu.org ([2001:4830:134:3::10]:50261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cGRwr-00080F-54
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 09:51:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cGRwn-0005JG-AB
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 09:51:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cGRwn-0005Im-5E
	for Qemu-devel@nongnu.org; Mon, 12 Dec 2016 09:51:21 -0500
Date: Mon, 12 Dec 2016 22:51:17 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20161212145117.GB21817@lemon>
References: <20161212033512.GA3725@lemon>
	<908F0328-771A-4269-8301-9A7D08BD585F@livius.net>
	<20161212073915.GC3725@lemon>
	<96DEA2D0-3822-4A8C-9950-973B84AF4182@livius.net>
	<20161212093907.GA7918@lemon>
	<151F368B-80DA-4DF6-837C-E2E0737E4AE6@livius.net>
	<20161212103616.GB7918@lemon>
	<220EB996-A454-4FB1-9BAD-B0F4A300345E@livius.net>
	<20161212122803.GC7918@lemon>
	<EA7E7748-CB11-49AB-ADBA-555A0A510611@livius.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EA7E7748-CB11-49AB-ADBA-555A0A510611@livius.net>
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

On Mon, 12/12 15:22, Liviu Ionescu wrote:
> so, back to square one; any suggestion on how to avoid the periodic timer
> required to poll SDL system events?

Good question, I've missed that!

Sadly I don't find it possible. The main thread of QEMU has to run the glib
event loop so it cannot block on SDL_WaitEvent().

Ideally SDL should provide an API to get a pollable fd (or a set of) to allow
such types of integration, not much can be done from QEMU side in its current
form.

Fam
