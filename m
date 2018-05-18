Received: from eggs.gnu.org ([2001:4830:134:3::10]:59659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJh02-0001IP-Nx
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:08:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJgzz-0007As-H5
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:08:54 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:45706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fJgzz-0007AT-9z
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:08:51 -0400
Received: by mail-wr0-x22b.google.com with SMTP id w3-v6so1854007wrl.12
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 08:08:51 -0700 (PDT)
References: <20180518091440.1559-1-alex.bennee@linaro.org>
	<20180518091440.1559-3-alex.bennee@linaro.org>
	<20180518120239.GA31915@stefanha-x1.localdomain>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180518120239.GA31915@stefanha-x1.localdomain>
Date: Fri, 18 May 2018 16:08:47 +0100
Message-ID: <87h8n5dmrk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 2/2] tests/Makefile: comment out flakey
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: famz@redhat.com, pbonzini@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org


Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Fri, May 18, 2018 at 10:14:40AM +0100, Alex Benn=C3=A9e wrote:
>> The following tests keep showing up in failed Travis runs:
>>
>>   - test-aio
>
> What is the issue?

GTESTER tests/test-thread-pool
**
ERROR:tests/test-aio.c:501:test_timer_schedule: assertion failed: (aio_poll=
(ctx, true))
GTester: last random seed: R02S66126aca97f9606b33e5d7be7fc9b625
make: *** [check-tests/test-aio] Error 1
make: *** Waiting for unfinished jobs....

From:
  https://travis-ci.org/stsquad/qemu/jobs/380665386#L9697

--
Alex Benn=C3=A9e
