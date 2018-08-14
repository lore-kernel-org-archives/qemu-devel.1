Received: from eggs.gnu.org ([2001:4830:134:3::10]:47234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fpUvC-0005k6-5V
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fpUvB-000828-A9
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:43:22 -0400
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:38044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fpUvA-00081f-SU
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:43:21 -0400
Received: by mail-oi0-x22a.google.com with SMTP id v8-v6so32185763oie.5
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 01:43:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5B71D4C8.7060006@gmx.com>
References: <153358448492.29549.3601216229452882398.malonedeb@chaenomeles.canonical.com>
	<153414808571.8168.1723488818633453757.malone@wampee.canonical.com>
	<5B71D4C8.7060006@gmx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 09:42:59 +0100
Message-ID: <CAFEAcA91Pj5WFfWtu+_OtpC86xeR003wx897jDJKo0cpdJAc6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel]
	=?utf-8?q?=5BBug_1785698=5D_Re=3A_Solaris_build_err?=
	=?utf-8?b?b3I6IHVua25vd24gdHlwZSBuYW1lIOKAmGdjcnlfZXJyb3JfdOKAmQ==?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1785698 <1785698@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 13 August 2018 at 19:58, Michele Denber <1785698@bugs.launchpad.net> wrote:
> I don't know why qemu is picky about
> POSIX, but there you have it.

We do assume a posix shell and that that shell is /bin/sh.
We may have bugs where we assume non-posix behaviour
from it, since almost all users are going to be on systems
where /bin/sh is bash or dash or whatever the BSD /bin/sh is.

(dtc is a sort-of-third-party module, not part of QEMU
proper.)

thanks
-- PMM
