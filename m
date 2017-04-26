Received: from eggs.gnu.org ([2001:4830:134:3::10]:50011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d3NIj-0002qR-Dp
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d3NIf-0002mf-2J
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:48:13 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:34468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d3NIe-0002mJ-RD
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:48:08 -0400
Received: by mail-wm0-x22e.google.com with SMTP id r190so21080033wme.1
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 06:48:08 -0700 (PDT)
References: <CAPnv1PJeMRPKv9UUSmSWxyn=GFOPaWY8eUgH8ZeL=ZBMDJpbdg@mail.gmail.com>
	<CAJhHMCCZh7hvQT8x9Bks9k6=ka4G1Oybv1MrkKJ9_VZ_eRZBfQ@mail.gmail.com>
	<CAPnv1PL7-BAt36BvTxP7G8J8990Ur9MJJbr-QPccWziD4sy28g@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAPnv1PL7-BAt36BvTxP7G8J8990Ur9MJJbr-QPccWziD4sy28g@mail.gmail.com>
Date: Wed, 26 Apr 2017 14:48:35 +0100
Message-ID: <87bmrj8eks.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] What is the best commit for record-replay?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor R <boost.lists@gmail.com>
Cc: Pranith Kumar <bobby.prani+qemu@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>


Igor R <boost.lists@gmail.com> writes:

>>> Hi,
>>>
>>> I'm trying to use the deterministic record/replay feature, and I would
>>> like to know which commit I should take to get it work.
>>> In RC0 it seems to be broken. I tried pre-MTTCG commit 2421f381dc, as
>
>> Can you retry with the latest rc? There were some fixes regarding rr since rc0.
>
>
> I've taken 2.9 release, and RR does not seem to work there.
> I recorded the boot process of x86 Fedora-21 linux and the replay got
> stuck almost immediately.

What's your command line?

Does it get stuck at the same place each time?

Can you boot fine with icount but without record/replay?

--
Alex Bennée
