Received: from eggs.gnu.org ([2001:4830:134:3::10]:59758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cqfjl-0001lU-25
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cqfjh-0004Hy-5E
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:51:37 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:36562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cqfjg-0004HT-TC
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:51:33 -0400
Received: by mail-wm0-x233.google.com with SMTP id n11so35705026wma.1
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 05:51:32 -0700 (PDT)
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
	<CAFEAcA-2mcGih5bscnMsevTNTy71g9kE7OjTy3hYJKeGoGQw-g@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA-2mcGih5bscnMsevTNTy71g9kE7OjTy3hYJKeGoGQw-g@mail.gmail.com>
Date: Wed, 22 Mar 2017 12:51:29 +0000
Message-ID: <87k27hxyni.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 16 March 2017 at 15:23, Peter Maydell <peter.maydell@linaro.org> wrote:
>> (Technically right this instant 'mips' and 's390' would be in the
>> 'dump' list, since I don't personally have access yet. But we have
>> a plan for s390, and it turns out there is a mips machine in the
>> gcc compile farm which I'm just checking out.)
>
> ...unfortunately the gcc compile farm mips board (1) is very slow
> and (2) has very little disk space free in /tmp, which means that
> it can't pass "make check" because for instance tests/test-replication
> assumes it can write comparatively large test files to /tmp/...

That makes it sound like a mips cross build or mips linux-user powered
image would be useful then?

--
Alex Bennée
