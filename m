Received: from eggs.gnu.org ([2001:4830:134:3::10]:57885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZxvg-0004UI-6R
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZxvf-0004dr-8B
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:27:40 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:38399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fZxvf-0004dd-31
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:27:39 -0400
Received: by mail-oi0-x244.google.com with SMTP id v8-v6so15993565oie.5
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 05:27:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180628213158.GO24595@lianli.shorne-pla.net>
References: <20180628030330.15615-1-richard.henderson@linaro.org>
	<20180628213158.GO24595@lianli.shorne-pla.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Jul 2018 13:27:17 +0100
Message-ID: <CAFEAcA_4GqsgTzawem-CgYVieeaAZSS=rKLnLBd5eZG_tHHPVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 00/23] target/openrisc improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 28 June 2018 at 22:31, Stafford Horne <shorne@gmail.com> wrote:
> On Wed, Jun 27, 2018 at 08:03:07PM -0700, Richard Henderson wrote:
>> Changes since v2:
>>   * Fix missing mtspr break.
>>   * Reorg print_insn_or1k and interrupt logging to the start.
>>   * Adjust exit after mtspr; fixing smp kernel crash.
>>   * Fix signals patch based on Larent's review.
>
> Thanks, I confirmed this is working for me too.
>
> As mentioned before there are a few items I am working on.  I will take the
> series and send the pull request during the merge window.

QEMU doesn't have "merge windows". We just have a softfreeze
date. During the "general development" part of the release
cycle, send pullrequests whenever you like, for new features,
bugfixes, etc. Prefer "little and often" rather than saving
up lots of patches and sending huge pull requests infrequently.

The last pullrequests before softfreeze need to be on the
mailing list by the softfreeze date. After softfreeze, only
bug fixes should be submitted. We get gradually stricter
about how bad the bug has to be to justify allowing in a
fix as we go along; so in rc1 we're fairly relaxed about
larger changes that fix bugs, and by the time we get to
rc3 or rc4 we really only want safe small changes that
fix bugs that are regressions from the previous release.

Pull request cover letters during the freeze part of the
release cycle should include enough detail about the bugs
being fixed to let me judge whether they match the criteria
for going into the next rc, especially at the end of the cycle.

thanks
-- PMM
