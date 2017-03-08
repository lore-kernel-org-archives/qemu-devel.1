Received: from eggs.gnu.org ([2001:4830:134:3::10]:55248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wenwang@cs.umn.edu>) id 1cll1i-0000G1-By
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 18:29:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wenwang@cs.umn.edu>) id 1cll1f-0003Bt-2a
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 18:29:50 -0500
Received: from mail.cs.umn.edu ([128.101.32.201]:56866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wenwang@cs.umn.edu>) id 1cll1e-0003B1-RS
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 18:29:46 -0500
Received: from localhost (enchanter.cs.umn.edu [160.94.22.228])
	by mail.cs.umn.edu (Postfix) with ESMTP id 90DA9B1396
	for <qemu-devel@nongnu.org>; Wed,  8 Mar 2017 17:29:45 -0600 (CST)
Received: from mail.cs.umn.edu ([128.101.32.201])
	by localhost (enchanter.cs.umn.edu [160.94.22.228]) (amavisd-new,
	port 10024) with ESMTP id D_e6yMHhlmNB for <qemu-devel@nongnu.org>;
	Wed,  8 Mar 2017 17:29:43 -0600 (CST)
Received: from mail-it0-f47.google.com (mail-it0-f47.google.com
	[209.85.214.47])
	by mail.cs.umn.edu (Postfix) with ESMTPSA id B968AB1390
	for <qemu-devel@nongnu.org>; Wed,  8 Mar 2017 17:29:43 -0600 (CST)
Received: by mail-it0-f47.google.com with SMTP id h10so118953910ith.1
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 15:29:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Oms7=XCqnaZKhdmweB5bO2dPAZUBfMfb=tjHZiA5CoA@mail.gmail.com>
References: <CAAa=b7c4LFiBfNYWhoWPPmV00yRPjQ58RRgbKYV+ZPddL7RRPQ@mail.gmail.com>
	<CAFEAcA_Oms7=XCqnaZKhdmweB5bO2dPAZUBfMfb=tjHZiA5CoA@mail.gmail.com>
From: Wenwen Wang <wenwang@cs.umn.edu>
Date: Wed, 8 Mar 2017 17:29:02 -0600
Message-ID: <CAAa=b7fs=Ya4Brgu_cuN5UY4_xbBRHu=Sw1GZmjxDKX--WHhpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Performance difference between QEMU 2.2.0 and 2.6.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, MTTCG Devel <mttcg@listserver.greensocs.com>, Wenwen Wang <wenwang@cs.umn.edu>

Hi Peter,

Thanks for your suggestions! Will test some newer versions.

Best,
Wenwen

On Wed, Mar 8, 2017 at 2:42 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 8 March 2017 at 18:17, Wenwen Wang <wenwang@cs.umn.edu> wrote:
> > I just found that there is a significant performance difference between
> QEMU
> > version 2.2.0 and 2.6.0.
> >
> > Here are the execution times of the benchmark 458.sjeng from SPEC
> CINT2006
> > with test workload using user only emulation from ARM guest to x86-32
> host:
> >
> > qemu-2.2.0: 29 seconds
> > qemu-2.6.0: 38 seconds
>
> 2.6.0 is now quite old -- it would be interesting to test this on
> the current git master.
>
> > Could anyone tell me what this difference comes from or give me any hint?
>
> There are lots of changes between those two releases, and we don't
> in general track performance at all, so a regression is not very
> surprising to me. If you wanted to try to identify what caused it
> you could try a git bisect.
>
> thanks
> -- PMM
>
