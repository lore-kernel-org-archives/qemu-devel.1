Received: from eggs.gnu.org ([2001:4830:134:3::10]:57758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceRop-0005KB-36
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 14:34:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceRoo-0007Nb-8Y
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 14:34:19 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:37134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ceRoo-0007NS-2t
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 14:34:18 -0500
Received: by mail-wm0-x22a.google.com with SMTP id v77so23198109wmv.0
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 11:34:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487262963-11519-1-git-send-email-peter.maydell@linaro.org>
References: <1487262963-11519-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Feb 2017 19:33:56 +0000
Message-ID: <CAFEAcA-MMw0_ombzTD+kQYpeNKywtcKY2UczcpR-hFDwGZhZJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 00/13] Rewrite NVIC to not
 depend on the GIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>

On 16 February 2017 at 16:35, Peter Maydell <peter.maydell@linaro.org> wrote:
> This patchset is the revamp of the NVIC code from Michael
> Davidsaver's patchset of a year ago.
>
> Despite some superficial similarities of register layout, the
> M-profile NVIC is really very different from the A-profile GIC.  Our
> current attempt to reuse the GIC code means that we have significant
> bugs in our NVIC.  The series pulls the NVIC apart from the GIC code
> (fixing a few accidental bugs in the process), and then once it has a
> place to stand, implements a few minor cleanups, a key bugfix
> (getting priority calculations and masking right) and a missing
> feature (escalation to HardFault).
>
> For testing, I have used the Stellaris image I have to hand:
> http://people.linaro.org/~peter.maydell/stellaris.tgz
> and also a set of bare-metal test programs also written by
> Michael. You can find my slightly tweaked and cleand up
> version of those here (a README explains how to run them):
> https://git.linaro.org/people/peter.maydell/m-profile-tests.git

PS: git branch of this v2 patchset at
https://git.linaro.org/people/peter.maydell/qemu-arm.git nvic-rewrite
(includes squashed-in fix to patch 3).

thanks
-- PMM
