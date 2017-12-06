Received: from eggs.gnu.org ([2001:4830:134:3::10]:59078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eMg5p-0001bv-HL
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:14:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eMg5o-0002cQ-OO
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:14:57 -0500
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:38670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eMg5o-0002c4-Im
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:14:56 -0500
Received: by mail-ot0-x22f.google.com with SMTP id p3so4460769oti.5
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 12:14:56 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Dec 2017 20:14:35 +0000
Message-ID: <CAFEAcA_u2-NTsXPg8dBS8fWd53BSLRVH4ja6HjrAJx5BE+i3sQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] reminder: please include justification/explanation for
 any pull request after rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

Hi; I just wanted to send out a general email to ask submaintainers
who send me pullrequests for patches to go in after about rc2 to
make sure they include a justification and explanation of why the
bugs being fixed mean the changes need to go into the release.
I realized that I wasn't sure if I'd ever actually explicitly
asked people to do that, hence this mail.

The way our process works is that at the start of the rc cycle
we put in pretty much any bug fix, and as we move forwards the
bar gets steadily higher (so we prefer bug fixes that are simple,
that clearly don't affect other subsystems, that fix regressions
since the previous release, and so on), until by the last rc we
are very reluctant indeed to put in any more code.

I've had a few pull requests this cycle where the maintainer hasn't
put a clear explanation in the cover letter of why the patches
need to go into the release. I don't have a good grasp of every
subsystem and usually haven't been following the mailing list
threads, so I won't know whether the bugs being fixed are important
or trivial, risky or very safe. So I have to send an email
asking for clarification and get a reply, which can waste a day
if there are timezone differences or other delays.

So if people could make sure they write good cover letters that
give me the context I need for managing the release process,
that will make my job easier and the whole thing smoother.

thanks
-- PMM
