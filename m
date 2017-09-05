Received: from eggs.gnu.org ([2001:4830:134:3::10]:34789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpIHj-0007LO-4E
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpIHZ-0000MJ-Na
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:09:15 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:34020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpIHZ-0000Lq-Gl
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:09:05 -0400
Received: by mail-wr0-x22f.google.com with SMTP id a47so8489982wra.1
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 11:09:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150463414707.19543.9931062189110648888.malonedeb@chaenomeles.canonical.com>
References: <150463414707.19543.9931062189110648888.malonedeb@chaenomeles.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 19:08:44 +0100
Message-ID: <CAFEAcA--Twu0_+O3VD90bPs3CXQqgugNq_x+hUCv_gF9zYEdYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Bug 1715203] [NEW] Maintain Haiku support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1715203 <1715203@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 5 September 2017 at 18:55, kallisti5 <1715203@bugs.launchpad.net> wrote:
> It was pointed out that the 2.10 release notes are pushing to drop Haiku
> support.  The qemu port is currently working as-is under Haiku.
>
> Was there a reason this was recommended? Is there anything Haiku can do
> to keep it from being dropped?

Basically we don't want to try to support host systems where we
have no access to hardware that will let us compile and run
the test suite, and where there's nobody interacting with us
upstream to help fix issues that are Haiku related.

If there's genuinely a community of Haiku QEMU users out there
who want to help us maintain the support in the QEMU codebase that's
great. What we don't want is to be carrying around code we can't
test and where we don't seem to have anybody using it. (For instance
we're about to drop support for AIX...)

> We're working on a docker container to cross-compile rust-lang for
> Haiku, could this be of some use to qemu when complete?

Cross-compilation won't let us run the test suite.

thanks
-- PMM
