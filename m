Received: from eggs.gnu.org ([2001:4830:134:3::10]:54047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dlHfC-0007vD-Q1
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:41:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dlHfC-0005w8-04
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:40:54 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:37376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dlHfB-0005vS-Oy
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:40:53 -0400
Received: by mail-wr0-x232.google.com with SMTP id a47so937726wra.4
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 09:40:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4eede1a1-5ac4-41e3-e6ef-700348fc3d37@amsat.org>
References: <20170825155732.15665-1-stefanha@redhat.com>
	<4eede1a1-5ac4-41e3-e6ef-700348fc3d37@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Aug 2017 17:40:30 +0100
Message-ID: <CAFEAcA_skx8s28zo38uTwM-TcJvX1pC6oTAxjy3q_AVN3JwHBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] scripts: add argparse module for
 Python 2.6 compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>

On 25 August 2017 at 17:35, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> Hi Stefan,
>
> On 08/25/2017 12:57 PM, Stefan Hajnoczi wrote:
>>
>> Many scripts can benefit from the standard library argparse module, whic=
h
>> has
>> improvements over the older optparse module.  Unfortunately argparse was
>> only
>> shipped in Python 2.7 so we need a fallback for Python 2.6.
>
>
> I probably missed some discussion about it, but what are the reasons to s=
tay
> 2.6 compatible?
>
> Python 2.6 support ended during October 2013, 4 years ago... [1] Why don'=
t
> kill it, start deprecating 2.7 which support will end in less than 3 year=
s
> from now [2], and move efforts to version 3...?

Our choices about our dependencies are generally driven by "what
are the versions available on the oldest distros which we wish
to support building QEMU on", which typically is whatever the
long-term-support versions of Ubuntu, SUSE, Redhat, etc are.

Has somebody checked what that means for our Python version
requirements? (It would certainly be nicer if we could get away
with bumping the version-req rather than including a big lump
of code with yet-another-software-license, but maybe we can't.)

> Apparently we expect a C compiler compatible with GCC >=3D 4.1 which was
> released on 2006, before Python 2.5 :S
> Then QEMU_BUILD_BUG_ON() try to use C11 feature...

That's protected by a configure check for exactly this reason.

thanks
-- PMM
