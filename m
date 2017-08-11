Received: from eggs.gnu.org ([2001:4830:134:3::10]:39183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dgEFN-0007MU-3X
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 14:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dgEFM-0004dF-1f
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 14:01:21 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:36923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dgEFL-0004ck-P9
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 14:01:19 -0400
Received: by mail-wm0-x236.google.com with SMTP id i66so42873wmg.0
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 11:01:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9_nP9S7+bt4Crs3S2FR1szrevk7Q0GT40FmXh92tPv3Q@mail.gmail.com>
References: <20170811140536.2792-1-kwolf@redhat.com>
	<CAFEAcA9_nP9S7+bt4Crs3S2FR1szrevk7Q0GT40FmXh92tPv3Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Aug 2017 19:00:57 +0100
Message-ID: <CAFEAcA9hhJtGJLrJxMSJE4tOBvRWNqdc9-WiAcFTMRuhDZmGWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] Block/Multiboot patches for 2.10.0-rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 11 August 2017 at 18:10, Peter Maydell <peter.maydell@linaro.org> wrote:
> I get an intermittent failure on aarch64 test-aio-multithread:
>
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> gtester -k --verbose -m=quick tests/test-aio-multithread
> TEST: tests/test-aio-multithread... (pid=19863)
>   /aio/multi/lifecycle:                                                OK
>   /aio/multi/schedule:                                                 OK
>   /aio/multi/mutex/contended:                                          OK
>   /aio/multi/mutex/handoff:                                            OK
>   /aio/multi/mutex/mcs:                                                **
> ERROR:/home/pm215/qemu/tests/test-aio-multithread.c:368:test_multi_fair_mutex:
> assertion failed (counter == atomic_counter): (343406 == 343407)
> FAIL
> GTester: last random seed: R02S227b39277b8c54976c98f0e990305851
> (pid=21145)
>   /aio/multi/mutex/pthread:                                            OK
> FAIL: tests/test-aio-multithread
>
>
> but I've pushed this to master on the optimistic assumption that
> it's not the fault of anything in this pullreq... (will
> investigate further)

I can repro this on 95766c2cd043 so it definitely isn't this patchset's
fault.

thanks
-- PMM
