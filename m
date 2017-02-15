Received: from eggs.gnu.org ([2001:4830:134:3::10]:37191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdz3C-0000SP-5v
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 07:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdz3B-0007GB-AV
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 07:51:14 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:36054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cdz3B-0007F1-4u
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 07:51:13 -0500
Received: by mail-wr0-x22a.google.com with SMTP id k90so189883081wrc.3
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 04:51:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170215030211.GL28432@vapier>
References: <20170210061200.15373-1-vapier@gentoo.org>
	<CAFEAcA9rYHgR39tbmvJtQ+m01eok1QT7+K-Wpk_ykFDyqfFNNQ@mail.gmail.com>
	<20170215030211.GL28432@vapier>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Feb 2017 12:50:49 +0000
Message-ID: <CAFEAcA9CX2uVsK0qOM0K+y9JxQ+Nk=GMUp5M4xrMsqGg=fE4nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] osdep.h: pull in sys/sysmacros.h for
 major/minor/makedev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 15 February 2017 at 03:02, Mike Frysinger <vapier@gentoo.org> wrote:
> On 10 Feb 2017 09:04, Peter Maydell wrote:
>> I still think that it's a shame that glibc is breaking
>> compatibility with where these macros have always been
>> kept on every OS that's implemented them back to 2BSD...
>
> i don't think that characterization is accurate.  if it were,
> autoconf wouldn't have a AC_HEADER_MAJOR helper.

Hmm, Googling suggests that Solaris (and perhaps
other SysV Unixes) put them in mkdev.h.
That doesn't explain why glibc is taking yet a third
approach here rather than using either of the two
previously used choices...

thanks
-- PMM
