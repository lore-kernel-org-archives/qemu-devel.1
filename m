Received: from eggs.gnu.org ([2001:4830:134:3::10]:52015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYUUO-0007oS-Rw
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYUUL-0005KH-06
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:44:52 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:36208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYUUK-0005Hb-Px
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:44:48 -0400
Received: by mail-wm0-x232.google.com with SMTP id w191so4032226wmw.1
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 02:44:48 -0700 (PDT)
References: <20170720150426.12393-1-alex.bennee@linaro.org>
	<20170720150426.12393-4-alex.bennee@linaro.org>
	<d58f694c-cc8a-fb0f-f01c-ba1e2eebc6e1@twiddle.net>
	<1ff55ec6-b8e5-8696-7472-0ac22073ddf4@redhat.com>
	<87ziby6udk.fsf@linaro.org>
	<CAFEAcA_a9RW8zhaY6gpPuXAYk7twWgB0G39qOUTug44HbwyE7Q@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_a9RW8zhaY6gpPuXAYk7twWgB0G39qOUTug44HbwyE7Q@mail.gmail.com>
Date: Fri, 21 Jul 2017 10:44:45 +0100
Message-ID: <87vamm6s4y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.11 03/23] softfloat3c: dos2unix
 all files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 21 July 2017 at 09:56, Alex Bennée <alex.bennee@linaro.org> wrote:
>> One thing playing in my mind against moving to SoftFloat3c is the
>> inscrutability of the upstream. It's nice there has been a new release
>> with new features but there isn't a source repository or as far as I can
>> tell a development list. It is basically as far as I can tell a one man
>> project albeit backed by academic funding.
>
> I think https://github.com/ucb-bar/berkeley-softfloat-3 may
> be official-ish, though it's hard to tell with github repos.

Ohh good catch - it certainly looks as though it could be. I'll submit
the compile fixes and see if it is a worthwhile path for feeding stuff
upstream.

If so maybe it would be worth considering the integration as a git
submodule?

>
> thanks
> -- PMM


--
Alex Bennée
