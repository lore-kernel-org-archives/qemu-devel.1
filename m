Received: from eggs.gnu.org ([2001:4830:134:3::10]:52605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ciolS-0002vM-8R
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:52:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ciolP-0004rg-RH
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:52:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ciolP-0004rA-Lj
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:52:51 -0500
Date: Tue, 28 Feb 2017 21:52:47 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170228205247.GC4090@noname.redhat.com>
References: <CAFEAcA_KVG19uhPuBUNx4ySmebnL1Hit6=HUX9ug0FkBFMwasg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_KVG19uhPuBUNx4ySmebnL1Hit6=HUX9ug0FkBFMwasg@mail.gmail.com>
Subject: Re: [Qemu-devel] intermittent make check failure:
 "tcg_handle_interrupt: assertion failed: (qemu_mutex_iothread_locked())"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

Am 28.02.2017 um 20:10 hat Peter Maydell geschrieben:
> I got a make check failure on aarch64 host running a sparc64 test:

Probably completely unrelated, but while we're at it...

For me, tests/vhost-user-test has been hanging for check-qtest-i386
occasionally in the past few days. Has anyone else seen this?

Kevin
