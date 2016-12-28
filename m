Received: from eggs.gnu.org ([2001:4830:134:3::10]:38404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cMIjR-0005IN-OS
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 13:13:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cMIjQ-0001hr-LA
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 13:13:45 -0500
Received: from mail-ua0-x230.google.com ([2607:f8b0:400c:c08::230]:33590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cMIjQ-0001hm-Cm
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 13:13:44 -0500
Received: by mail-ua0-x230.google.com with SMTP id i68so108603136uad.0
	for <qemu-devel@nongnu.org>; Wed, 28 Dec 2016 10:13:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <db8a59e9-f4b3-1cb5-c1ed-82158b61b008@freebsd.org>
References: <098092bd-b92b-4fb8-5061-f77f9f75e392@freebsd.org>
	<CAFEAcA8ZuCxeFz83moePn80GFUbh0wGu4+T2wHdTSN=LE6-1CQ@mail.gmail.com>
	<db8a59e9-f4b3-1cb5-c1ed-82158b61b008@freebsd.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Dec 2016 18:13:23 +0000
Message-ID: <CAFEAcA_DMEoAW7WP+7XsmnN4rZVjVL7WzZdDa1kn-rK_xGMXzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Looking for a linux-user mode test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sean Bruno <sbruno@freebsd.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 28 December 2016 at 17:12, Sean Bruno <sbruno@freebsd.org> wrote:
> On 12/28/16 10:05, Peter Maydell wrote:
>> Ideally all of that rework (including the support for properly
>> interrupting syscalls without races) should be ported over to
>> bsd-user at some point.
>
> If you have a moment to point me at the merge commit that pulled in the
> majority of this overhaul, I'll take a moment to review it for
> application to bsd-user.

Merges 430da7a81d356e3, 3e904d6ade7f36, b66e10e4c9ae7,
d6550e9ed2e1a60 (listed here latest first but probably more
helpfully examined the other way round) have the bulk of it,
there are probably some bugfixes that got in via other merges.

thanks
-- PMM
