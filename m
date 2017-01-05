Received: from eggs.gnu.org ([2001:4830:134:3::10]:43764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cP6J3-0006T4-H9
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 06:34:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cP6J2-0000KN-Kf
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 06:34:05 -0500
Received: from mail-ua0-x235.google.com ([2607:f8b0:400c:c08::235]:34646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cP6J2-0000KF-FU
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 06:34:04 -0500
Received: by mail-ua0-x235.google.com with SMTP id 34so335945164uac.1
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 03:34:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
References: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jan 2017 11:33:43 +0000
Message-ID: <CAFEAcA-dOaMYMSSUN_jrRUPRxLVQBZJX4MzZoM6KOz+o3YYBMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] New Year's starting over ... bsd-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sean Bruno <sbruno@freebsd.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 3 January 2017 at 16:18, Sean Bruno <sbruno@freebsd.org> wrote:
> I'm pondering where to start with getting FreeBSD's bsd-user code into
> shape so it could actually be reviewed and accepted now that its sort of
> working again (signal handling fixed finally).
>
> I almost feel like the existing code should be purged, except that it
> gives a good history (and this seems lazy to me).
>
> As a first pass, I guess, I'd like to at least make i386 user run on
> x86_64.  What would you folks like to see in a first pass?

So, here's my thoughts on this. I think our goals here are
 * get the out-of-tree code into the tree, over time
 * help you get to a point where you're maintaining and fixing
   the FreeBSD code with us upstream, rather than deploying
   downstream patches

and the primary obstacle is this big pile of non-upstreamed
code. From my end I don't think it really matters too much
what order we try to tackle things in, as long as the chunks
that arrive for upstream review are not too large and seem at
least vaguely coherent. If i386-on-x86_64 seems like you can
extract it sensibly then I think it's as good a place to start
as anything else (though of course it's of pretty much zero
practical utility :-)).

Whether you want to keep the sparc support or delete it is
I think up to you as the maintainer -- if it's broken and
nobody cares about it I think we can happily delete it.
On the other hand if you want to fix it up and keep it around
then that's fine too.

At some point it would be good to get the BSDs into the set of
things we test when merging code, so we don't regress them.
That would ideally require hardware we can access though (the only
real-hw setup in the gcc compile farm is an ancient NetBSD
5.1 install). I guess instructions-for-BSD-novices on how to
setup a VM on a Linux box would do in a pinch.

(We should also try to avoid breaking bsd-user on the other
BSDs in the course of fixing up FreeBSD -- do you know how
many of the other BSD hosts work right now?)

thanks
-- PMM
