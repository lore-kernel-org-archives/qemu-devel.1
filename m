Received: from eggs.gnu.org ([2001:4830:134:3::10]:49755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1enqNw-00044V-TR
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 13:41:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1enqNw-0008OO-6d
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 13:41:56 -0500
MIME-Version: 1.0
In-Reply-To: <CAJSP0QV5mrt8RiKxXUfXkk7UPLHtwJMUOvcj77Ro43FP=5MkFg@mail.gmail.com>
References: <CAJSP0QV=rntD8h4kLdDaydDHxf9ustrK0jnUfU-aQFJp2wPAWg@mail.gmail.com>
	<95b23032-6a23-914f-2c79-3da8bbc79c22@redhat.com>
	<CAJSP0QV5mrt8RiKxXUfXkk7UPLHtwJMUOvcj77Ro43FP=5MkFg@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 19 Feb 2018 18:41:54 +0000
Message-ID: <CAJSP0QX81kB2PKJU7FG3vY6E9Z2yrysaezrz9wS2v3KHaT2uAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Multiqueue block layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

By the way, one thing that makes me nervous is that we lack an
explicit "request queue" or "per-queue" concept.  State can either be
per-BlockDriverState (shared state) or per-request, but not per-queue.

So far there hasn't been a need for per-queue state but there may be
opportunities to eliminate locking if we can replace shared state with
per-queue state.

Stefan
