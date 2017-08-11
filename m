Received: from eggs.gnu.org ([2001:4830:134:3::10]:55720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dgDSc-0007fU-I9
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 13:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dgDSb-0002LS-8K
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 13:10:58 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:38646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dgDSb-0002K3-0I
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 13:10:57 -0400
Received: by mail-wm0-x22d.google.com with SMTP id f15so52446689wmg.1
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 10:10:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170811140536.2792-1-kwolf@redhat.com>
References: <20170811140536.2792-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Aug 2017 18:10:35 +0100
Message-ID: <CAFEAcA9_nP9S7+bt4Crs3S2FR1szrevk7Q0GT40FmXh92tPv3Q@mail.gmail.com>
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

On 11 August 2017 at 15:05, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit 95766c2cd04395e5712b4d5967b3251f35d537df:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-08-10 18:53:39 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 8565c3ab537e78f3e69977ec2c609dc9417a806e:
>
>   qemu-iotests: fix 185 (2017-08-11 14:44:39 +0200)
>
> ----------------------------------------------------------------
> Block layer patches for 2.10.0-rc3
>
> ----------------------------------------------------------------

I get an intermittent failure on aarch64 test-aio-multithread:

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
gtester -k --verbose -m=quick tests/test-aio-multithread
TEST: tests/test-aio-multithread... (pid=19863)
  /aio/multi/lifecycle:                                                OK
  /aio/multi/schedule:                                                 OK
  /aio/multi/mutex/contended:                                          OK
  /aio/multi/mutex/handoff:                                            OK
  /aio/multi/mutex/mcs:                                                **
ERROR:/home/pm215/qemu/tests/test-aio-multithread.c:368:test_multi_fair_mutex:
assertion failed (counter == atomic_counter): (343406 == 343407)
FAIL
GTester: last random seed: R02S227b39277b8c54976c98f0e990305851
(pid=21145)
  /aio/multi/mutex/pthread:                                            OK
FAIL: tests/test-aio-multithread


but I've pushed this to master on the optimistic assumption that
it's not the fault of anything in this pullreq... (will
investigate further)

thanks
-- PMM
