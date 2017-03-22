Received: from eggs.gnu.org ([2001:4830:134:3::10]:37081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqg16-00068J-8y
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:09:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqg15-0001so-AH
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:09:32 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cqg15-0001sh-1c
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:09:31 -0400
Received: by mail-wm0-x231.google.com with SMTP id t189so37279381wmt.1
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 06:09:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87k27hxyni.fsf@linaro.org>
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
	<CAFEAcA-2mcGih5bscnMsevTNTy71g9kE7OjTy3hYJKeGoGQw-g@mail.gmail.com>
	<87k27hxyni.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 Mar 2017 13:09:09 +0000
Message-ID: <CAFEAcA-oLDW2F=L3NCdSvrLp_eh3tu9mfKR0mTfZ=3O3dpdKbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 March 2017 at 12:51, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>> ...unfortunately the gcc compile farm mips board (1) is very slow
>> and (2) has very little disk space free in /tmp, which means that
>> it can't pass "make check" because for instance tests/test-replication
>> assumes it can write comparatively large test files to /tmp/...
>
> That makes it sound like a mips cross build or mips linux-user powered
> image would be useful then?

Cross build can't actually run 'make check' and I wouldn't
trust linux-user to run our test suite. Also, if there's
no hardware that we can sensibly do make/make check
on then how much can people really care about QEMU on MIPS?
(In fact since MIPS supports KVM these days, there really
ought to be sufficiently capable hardware to work as
a build system.)

The "test uses /tmp/" stuff is a test suite bug which
we should fix, which might make the gcc cfarm box at
least kind of usable.

thanks
-- PMM
