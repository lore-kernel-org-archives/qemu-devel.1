Received: from eggs.gnu.org ([2001:4830:134:3::10]:49171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfQM8-0003nT-MT
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 07:12:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfQM7-000851-P3
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 07:12:44 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:34638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cfQM7-00084d-Ht
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 07:12:43 -0500
Received: by mail-wr0-x230.google.com with SMTP id z61so50513140wrc.1
	for <qemu-devel@nongnu.org>; Sun, 19 Feb 2017 04:12:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CABHMSTUJEEwbo76-4cqRq01Lpv76Y0KMdjAvgcgmuVARZGudEw@mail.gmail.com>
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
	<CABHMSTUsZy0u4b1b84YC5CgafKvD-Zms5dCQ=31+XnQphUQxLA@mail.gmail.com>
	<20170217064327.GB21716@lemon.lan>
	<CAFEAcA8_f8SVX+rirAFBJ76ZiXaKUwh9uO0AeBFoR7G_q8pGDg@mail.gmail.com>
	<6ab86cf8-4780-ca76-f648-ac0ce211e27b@redhat.com>
	<CABHMSTWN2KdAXDjEEbyWio6rNM2FuDk_NUj40mFW0HdyZFu68g@mail.gmail.com>
	<CAFEAcA_N1j9tpxEBROG6D1per9vDMPZeuRyM93BRzNT5ZK3q0Q@mail.gmail.com>
	<CABHMSTUJEEwbo76-4cqRq01Lpv76Y0KMdjAvgcgmuVARZGudEw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 19 Feb 2017 12:12:21 +0000
Message-ID: <CAFEAcA_jQt1Xof9Pk6ANE4werM-uXi3wsp9XS2NW6Znr_J_56g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Fix build break during configuration on musl-libc
 based Linux systems.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chad Joan <chadjoan@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 19 February 2017 at 07:22, Chad Joan <chadjoan@gmail.com> wrote:
> I suspect I'm going to encounter this problem again as I try to make small
> fixes for more projects, so it might be worth it for me to spend a small
> amount of time at some point setting up a mail client that I can send git
> patches with.  Or perhaps I can just move the patch(es) onto another machine
> (ex: my personal laptop) and send it with 'git send-email' from there,
> instead of needing to install a mail client that is outside of my normal
> workflow.  I am not comfortable with putting smtp login information onto the
> server that I am using for this work.

Yes, I'd do that. If you do git format-patch on one machine you can
then copy the patch files onto another where you do git send-email
(my workflow actually involves something similar to this).

Or if the machine you're running on is a server with limited
development facilities you might prefer to do development
entirely on a different machine and then on the server
just do a git fetch or git pull from the git tree on your
development machine to build it. (I do this when I'm doing
build tests, since there usually isn't a nice dev environment
with my preferred editor and tools and so on on the test
machine.) Then your patches are all on the dev machine to
start with.

thanks
-- PMM
