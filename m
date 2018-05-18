Received: from eggs.gnu.org ([2001:4830:134:3::10]:50430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJkAf-0006cn-HY
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJkAe-0008Ei-SH
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:32:05 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:33173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJkAe-0008Ec-O2
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:32:04 -0400
Received: by mail-ot0-x243.google.com with SMTP id l22-v6so10211110otj.0
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 11:32:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180518091440.1559-3-alex.bennee@linaro.org>
References: <20180518091440.1559-1-alex.bennee@linaro.org>
	<20180518091440.1559-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 19:31:43 +0100
Message-ID: <CAFEAcA968HDBJiBRCBEu+hV=fUx5HzHbnn6GDGKYzusEtjHGUQ@mail.gmail.com>
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
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Another flaky test for the collection:

TEST: tests/boot-serial-test... (pid=3D25144)
  /sparc64/boot-serial/sun4u:                                          **
ERROR:/home/petmay01/linaro/qemu-for-merges/tests/boot-serial-test.c:140:ch=
eck_guest_output:
assertion failed: (output_ok)
FAIL

Probably another "overly optimistic timeout" setting. (Failed
for me on x86-64 host just now.)

thanks
-- PMM
