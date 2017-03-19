Received: from eggs.gnu.org ([2001:4830:134:3::10]:43186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpZLg-00049c-Ov
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 07:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpZLf-0006kY-Rm
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 07:50:12 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:34956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cpZLf-0006iP-Ky
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 07:50:11 -0400
Received: by mail-wm0-x234.google.com with SMTP id u132so44648539wmg.0
	for <qemu-devel@nongnu.org>; Sun, 19 Mar 2017 04:50:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <697c2a7ba87fb3852eabfe3cc7d309c2@cs.nmt.edu>
References: <697c2a7ba87fb3852eabfe3cc7d309c2@cs.nmt.edu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 19 Mar 2017 11:49:49 +0000
Message-ID: <CAFEAcA9xB-pBjrvh9EhfZcv+b9adONpJ7chaR7L8-hf2wbjRpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] GSOC Qemu Project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: aahud <aahud@cs.nmt.edu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>

On 18 March 2017 at 22:48, aahud <aahud@cs.nmt.edu> wrote:
> I am sending this email, admittedly late, to suggest a new project. I would
> love to see Qemu ported to an operating system without a monolithic kernel.
> My initial ideas for target platforms are Minix3 or a Plan9-like (ie Harvey
> or 9front). My personal preference would be Harvey, as I have made small
> contributions to that project, and am simply more familiar.

So from the project's perspective, I'm afraid this would be
rather going against the direction we're currently headed.
We're actually looking right now at *removing* support for
some host OSes which are unused and unmaintained (eg AIX,
Solaris, Haiku), because we have no way to test them and we
strongly suspect that few or no users are using them. So I'd be
reluctant to add host support for another platform unless:
 * there was clearly a large body of users who wanted it
 * there was going to be ongoing maintenance and support
   for the code for several years (ie more than just the length
   of a GSoC project)
 * there's an easily accessible machine for doing build testing

thanks
-- PMM
