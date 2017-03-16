Received: from eggs.gnu.org ([2001:4830:134:3::10]:39934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coZir-0002uC-6w
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 14:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coZin-0007tT-Dr
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 14:02:01 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1coZin-0007t9-75
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 14:01:57 -0400
Received: by mail-wm0-x22c.google.com with SMTP id n11so54596550wma.0
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 11:01:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Mar 2017 18:01:35 +0000
Message-ID: <CAFEAcA-2mcGih5bscnMsevTNTy71g9kE7OjTy3hYJKeGoGQw-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Proposal for deprecating unsupported host OSes &
 architecutures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 16 March 2017 at 15:23, Peter Maydell <peter.maydell@linaro.org> wrote:
> (Technically right this instant 'mips' and 's390' would be in the
> 'dump' list, since I don't personally have access yet. But we have
> a plan for s390, and it turns out there is a mips machine in the
> gcc compile farm which I'm just checking out.)

...unfortunately the gcc compile farm mips board (1) is very slow
and (2) has very little disk space free in /tmp, which means that
it can't pass "make check" because for instance tests/test-replication
assumes it can write comparatively large test files to /tmp/...

thanks
-- PMM
