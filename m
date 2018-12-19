Received: from eggs.gnu.org ([2001:4830:134:3::10]:48304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZlB0-0002VT-96
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 18:22:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZlAz-0006Pp-Bc
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 18:22:54 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gZlAw-0006NN-CN
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 18:22:50 -0500
Received: by mail-oi1-x241.google.com with SMTP id x23so3084256oix.3
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 15:22:49 -0800 (PST)
MIME-Version: 1.0
References: <20170809202712.6951-1-f4bug@amsat.org>
	<20170809202712.6951-13-f4bug@amsat.org>
	<CAAdtpL7UE2dGie9zYOx3=L98vFr16dyrk2cdLZi1Nu58i+9DOQ@mail.gmail.com>
	<CAFEAcA98P9ZagjLTMvAMDdKiktUp3hQPjO0rq9qBXBc7SHO3jg@mail.gmail.com>
	<CAAdtpL5FtLunqQcru3+ZBL1HGL=8ZYtjZs0MPkAikqB_tBGu1A@mail.gmail.com>
In-Reply-To: <CAAdtpL5FtLunqQcru3+ZBL1HGL=8ZYtjZs0MPkAikqB_tBGu1A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Dec 2018 23:22:36 +0000
Message-ID: <CAFEAcA8c564V_Ogq67v7gUjHQ5ykASiPy3z+oiq8+ypyHYM7zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.11 v3 12/16] travis/osx: silent
 texinfo warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, 19 Dec 2018 at 23:13, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> I'm trying to reduce OSX warnings, as of current QEMU master I count
> 80 warnings using Xcode 10, which result in me not looking at them (or
> worst, at new ones...).

A lot of them are the address-of-packed-member warnings, which
I've been gradually looking at -- I think we're now down to
just the slirp ones, which I've been leaving until the big
refactor that's pending has landed.
Other than that there are a bunch of deprecated-declaration
warnings about SASL, which I never figured out an approach
for and so just suppress in my "grep logs for warnings"
script. I don't think there's too many other than that?

thanks
-- PMM
