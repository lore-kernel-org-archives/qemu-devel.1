Received: from eggs.gnu.org ([2001:4830:134:3::10]:52300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cb0YG-0004DI-Lc
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 02:51:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cb0YD-0002ek-J5
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 02:51:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cb0YD-0002dj-Cb
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 02:50:57 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <CAFEAcA-yFVYzwxt4FG9D3g3BwEJFPnmNrr-pJOzYV-h5Y6bu7A@mail.gmail.com>
	(Peter Maydell's message of "Mon, 6 Feb 2017 18:53:27 +0000")
References: <1486399909-16338-1-git-send-email-quintela@redhat.com>
	<CAFEAcA-yFVYzwxt4FG9D3g3BwEJFPnmNrr-pJOzYV-h5Y6bu7A@mail.gmail.com>
Reply-To: quintela@redhat.com
Date: Tue, 07 Feb 2017 08:50:41 +0100
Message-ID: <87lgti1lta.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 0/6] Migration pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Amit Shah <amit.shah@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Peter Maydell <peter.maydell@linaro.org> wrote:
> On 6 February 2017 at 16:51, Juan Quintela <quintela@redhat.com> wrote:


> I get a test failure on aarch64 host on one of the ppc guest tests:
>
> TEST: tests/prom-env-test... (pid=26435)
>   /ppc64/prom-env/mac99:                                               OK
>   /ppc64/prom-env/g3beige:                                             OK
>   /ppc64/prom-env/pseries:                                             **
> ERROR:/home/petmay01/qemu/tests/prom-env-test.c:42:check_guest_memory:
> assertion failed (signature == MAGIC): (0x7c7f1b78 == 0xcafec0de)
> FAIL
> GTester: last random seed: R02Sbd97cf9617f5dd55ba90b08765cfa0d0
> (pid=26445)
> FAIL: tests/prom-env-test
>
>
> This might just be the test having an overzealous timeout (I
> think I've seen this before a while back, when I was trying
> to do a 'make -j2 check' on this slow board); but on the other
> hand it's been fine recently but it failed twice trying to test
> this pullreq.

I don't have n aarch64 host, all I can say is that make check worked on
x86_64.

I would expect that this didn't change anything for prom enviroment, but
one never knows :p

I will wait to see if ppc folks can take a look at this.

Thanks, Juan.
