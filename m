Received: from eggs.gnu.org ([2001:4830:134:3::10]:48296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cOqMt-0001Ib-7M
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 13:33:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cOqMq-0004ov-5M
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 13:32:59 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:32957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cOqMp-0004oO-Uo
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 13:32:56 -0500
Received: by mail-wm0-x236.google.com with SMTP id v3so4957568wme.0
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 10:32:54 -0800 (PST)
References: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
Date: Wed, 04 Jan 2017 18:32:51 +0000
Message-ID: <8760lu65gs.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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


Sean Bruno <sbruno@freebsd.org> writes:

> I'm pondering where to start with getting FreeBSD's bsd-user code into
> shape so it could actually be reviewed and accepted now that its sort of
> working again (signal handling fixed finally).

Also don't forget the parallel_cpus changes which were made for enhanced
atomic support. There was also work in fixing up exclusive_start/end
which is used for safe work like tb_flush.

> I almost feel like the existing code should be purged, except that it
> gives a good history (and this seems lazy to me).
>
> As a first pass, I guess, I'd like to at least make i386 user run on
> x86_64.  What would you folks like to see in a first pass?

One thing that bugs me about linux-user is the amount of copy&paste
repetition that goes on for the main run loop. Perhaps with a clean-up
of the unused BSD architectures we could explore how a re-factored
run loop could look with a view to moving to common run-loop code across
both?

Apart from syscall mapping and backend calls to the BSD ABI what
differences are there between the two user-mode implementations?

>
> sean
>
> ref: https://github.com/seanbruno/qemu-bsd-user/tree/bsd-user


--
Alex Bennée
