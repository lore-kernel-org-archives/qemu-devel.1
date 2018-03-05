Received: from eggs.gnu.org ([2001:4830:134:3::10]:44502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esqLs-0004Dd-VB
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:40:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esqLs-0006V8-62
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:40:28 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:38619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1esqLs-0006Ut-0H
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:40:28 -0500
Received: by mail-ot0-x22a.google.com with SMTP id 95so14901905ote.5
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 05:40:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180305133654.7aokepvzcmxhzk4q@kamzik.brq.redhat.com>
References: <20180228180215.25470-1-wei@redhat.com>
	<20180228180215.25470-2-wei@redhat.com>
	<ca21f795-dae7-d6b5-44f1-ef8ba792ac04@redhat.com>
	<20180305110122.GD3131@work-vm>
	<20180305133654.7aokepvzcmxhzk4q@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Mar 2018 13:40:06 +0000
Message-ID: <CAFEAcA8jse2AdCO8JgA7m99h8pwTRBCQ9aOi=-0QOG+pA9tk2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V7 1/4] rules: Move cross compilation auto
 detection functions to rules.mak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>

On 5 March 2018 at 13:36, Andrew Jones <drjones@redhat.com> wrote:
> IMO, the makefile is the right approach. I wouldn't like to see AArch64
> added with a script and then converted, along with x86, to a makefile at
> some later time (probably never).

I'm not really enthusiastic about this approach of picking a cross
compiler in the makefile rather than configure, though. The stuff
we have at the moment that tries to build the x86 ROMs with whatever
random host compiler we happen to be using is already a source
of occasional brokenness. If we're going to try to build target
code on a wider basis than just the x86 roms I'd like to see it
done in a cleaner manner...

thanks
-- PMM
