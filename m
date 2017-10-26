Received: from eggs.gnu.org ([2001:4830:134:3::10]:57813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7bTY-0001z2-Bb
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 02:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7bTX-0001N9-Hz
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 02:17:08 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:44268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e7bTX-0001MD-Ap
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 02:17:07 -0400
Received: by mail-wr0-x22c.google.com with SMTP id z55so2071768wrz.1
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 23:17:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA99zpvcgk2EuXkrcOY+8rHeRkJhH4GqViJkEgQV3bdWFg@mail.gmail.com>
References: <20171025123056.3165-1-richard.henderson@linaro.org>
	<CAFEAcA99zpvcgk2EuXkrcOY+8rHeRkJhH4GqViJkEgQV3bdWFg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Oct 2017 07:16:45 +0100
Message-ID: <CAFEAcA9XdoV0YVw+q7op_vafe9X0JTiQdYmGcmPgqRR3qhUYrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/11] Disassembler patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>

On 26 October 2017 at 07:07, Peter Maydell <peter.maydell@linaro.org> wrote:
> Hi. This failed to build for Windows:

Also, after it failed and I backed out the merge, the next thing I
tried to build failed everywhere with:

warning: unable to rmdir capstone: Directory not empty
error: pathspec 'capstone' did not match any file(s) known to git.
error: pathspec 'capstone' did not match any file(s) known to git.

That's bad, because it suggests that bisection is going to break
across this merge commit.

Dan, is this going to be a generic problem with the new submodule
stuff, or is it specific to something with how the capstone
submodule is being handled in this patchset?

thanks
-- PMM
