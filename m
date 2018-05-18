Received: from eggs.gnu.org ([2001:4830:134:3::10]:50503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJcUD-0004Y4-OR
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJcUC-000535-PU
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:19:45 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:45724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJcUC-000523-Jx
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:19:44 -0400
Received: by mail-oi0-x230.google.com with SMTP id b130-v6so6639435oif.12
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 03:19:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9+qqcVO1gq7PiLqCdKiHkrE81KroEdz7+iPanQ50zJRQ@mail.gmail.com>
References: <20180509112406.6183-1-quintela@redhat.com>
	<CAFEAcA9+qqcVO1gq7PiLqCdKiHkrE81KroEdz7+iPanQ50zJRQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 11:19:23 +0100
Message-ID: <CAFEAcA-7ebtCy+-YzpDhxY9eiZBU+7qcs98CmHKwiu60-ro2Og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/41] Migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

On 11 May 2018 at 14:41, Peter Maydell <peter.maydell@linaro.org> wrote:
> Hi. I get some test failures here:
>
> S390x host:
> TEST: tests/migration-test... (pid=57456)
>   /ppc64/migration/deprecated:                                         OK
>   /ppc64/migration/bad_dest:                                           OK
>   /ppc64/migration/postcopy/unix:                                      OK
>   /ppc64/migration/precopy/unix:                                       OK
>   /ppc64/migration/xbzrle/unix:
> Unexpected 32 on dest_serial serial
> **
> ERROR:/home/linux1/qemu/tests/migration-test.c:144:wait_for_serial:
> code should not be reached
> FAIL

It turns out that this one is an intermittent that we've seen
before (I just hit it again this morning on an unrelated test run
on an x86-64 host, and last time it was on a ppc host).
In this mail Laurent tracked it down to an overly optimistic
setting for downtime-limit in migration-test.c:
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg00107.html

Can we push that up to something that we won't hit even if the
test is being run on a machine that's under CPU load, please?

thanks
-- PMM
