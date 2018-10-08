Received: from eggs.gnu.org ([2001:4830:134:3::10]:34878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9Z7H-0000zI-Cx
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9Z0y-0003nM-3w
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:08:16 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9Z0x-0003ml-FZ
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:08:16 -0400
Received: by mail-oi1-x244.google.com with SMTP id u197-v6so16057679oif.5
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 10:08:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181008164026.GD4604@localhost.localdomain>
References: <20181005143802.18412-1-peter.maydell@linaro.org>
	<CAFEAcA8-FvVG7XBLrd7NQfRcKrvo6GtPEjfqJzkjd68iP9=TeQ@mail.gmail.com>
	<20181005161739.GC4606@localhost.localdomain>
	<CAFEAcA-SWRHwnwsa+QiHXfdBRB6u2u0paV9HsEqfjR6nZvAHSg@mail.gmail.com>
	<20181005180901.GA32677@localhost.localdomain>
	<CAFEAcA80cys-98QwJgAk_2LXfAeMHgCUS2L3Z+NgY4ZsCFhSPw@mail.gmail.com>
	<CAFEAcA8gYwFZynMyiEHf+VPbaBerA9JTUPAHsipEvOqkBjHxMQ@mail.gmail.com>
	<20181008164026.GD4604@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Oct 2018 18:07:52 +0100
Message-ID: <CAFEAcA80vkufJ=hwr5s5i9xFzE1HxZKbfk7KVux2uEF-T9Gyug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tests: Disable test-bdrv-drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 8 October 2018 at 17:40, Kevin Wolf <kwolf@redhat.com> wrote:
> By the way, can you reproduce this with virtio-blk/scsi and an iothread
> in a real QEMU or is it only the test case that fails? In theory, I
> don't see what would prevent QEMU from hanging at shutdown.

I haven't tested, but I suspect this is less likely to
cause a problem, because in a real QEMU run we'll only
kill these threads and cause the memory corruption at
the end of the run when QEMU is exiting anyway. The problem
in the test case is that we kill threads and corrupt memory,
and then continue to use the same process for the next test
in the set, which then crashes later as a result of the
memory corruption.

thanks
-- PMM
