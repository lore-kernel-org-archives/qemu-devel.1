Received: from eggs.gnu.org ([2001:4830:134:3::10]:49855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJcS2-0003Lg-0h
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJcS0-0003aa-Hn
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:17:29 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:41954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJcS0-0003Zu-9B
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:17:28 -0400
Received: by mail-ot0-x243.google.com with SMTP id t1-v6so8493031oth.8
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 03:17:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180518091440.1559-3-alex.bennee@linaro.org>
References: <20180518091440.1559-1-alex.bennee@linaro.org>
	<20180518091440.1559-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 11:17:07 +0100
Message-ID: <CAFEAcA95fh6Zwd_cMiCT+vFKYU0UmfL1TN+hVLLJs90K5AaA_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 18 May 2018 at 10:14, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> The following tests keep showing up in failed Travis runs:
>
>   - test-aio
>   - rcutorture
>   - tpm-crb-test
>   - tpm-tis-test
>
> I suspect it is load that causes the problems but they really need to
> be fixed properly.

Another one that seems to crop up occasionally (I just hit this on
an x86-64 build test):

TEST: tests/migration-test... (pid=3D19076)
  /ppc64/migration/deprecated:                                         OK
  /ppc64/migration/bad_dest:                                           OK
  /ppc64/migration/postcopy/unix:                                      OK
  /ppc64/migration/precopy/unix:
Unexpected 32 on dest_serial serial
**
ERROR:/home/petmay01/linaro/qemu-for-merges/tests/migration-test.c:144:wait=
_for_serial:
code should not be reached
FAIL

See
https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg02589.html
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg00107.html

migration-test seems to be a bit optimistic about convergence time.

thanks
-- PMM
