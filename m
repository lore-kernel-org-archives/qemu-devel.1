Received: from eggs.gnu.org ([2001:4830:134:3::10]:38807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crt2L-00075U-4A
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 17:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crt2J-0007oV-Tx
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 17:15:49 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:34864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1crt2J-0007lx-Mp
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 17:15:47 -0400
Received: by mail-wr0-x229.google.com with SMTP id u1so12430763wra.2
	for <qemu-devel@nongnu.org>; Sat, 25 Mar 2017 14:15:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490474958.11328.86.camel@oracle.com>
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
	<1490474958.11328.86.camel@oracle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 Mar 2017 21:15:25 +0000
Message-ID: <CAFEAcA-BaDtJyNk0pB7AwyJNXtZ8V9LgJzcuAfPbN65b7OFsSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Proposal for deprecating unsupported host OSes &
 architecutures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Knut Omang <knut.omang@oracle.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 25 March 2017 at 20:49, Knut Omang <knut.omang@oracle.com> wrote:
> Can we please keep the Sparc support in for a while still?

Yes, John Paul Adrian Glaubitz and the Debian Project have
kindly provided me with access to a Sparc box. I'm planning
to send a patch that puts sparc into the 'supported'
category before 2.9 release.

I would note that so far I've found a couple of TCG
bugs of the "this just doesn't work at all" level, so
it doesn't look like anybody using sparc has been
doing any testing against git master...

> When it comes to build platforms, a legitimate need to be able to keep anything
> running, I don't have any authority to promise away hardware or other forms of
> Sparc access, but I have been told that that part can be worked out in some way
> if we get enough support for this internally.

I'd recommend trying to get a machine into the gcc compile
farm (assuming they'd be willing to take it) -- that way
it's accessible to developers for a range of open
source projects.

thanks
-- PMM
