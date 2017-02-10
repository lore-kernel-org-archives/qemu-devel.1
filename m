Received: from eggs.gnu.org ([2001:4830:134:3::10]:60639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccBpZ-0000ZQ-Vh
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:05:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccBpY-000117-T7
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:05:45 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:34281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ccBpY-0000z4-Ja
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:05:44 -0500
Received: by mail-wm0-x229.google.com with SMTP id 196so65044324wmm.1
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 06:05:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486065742-28639-1-git-send-email-peter.maydell@linaro.org>
References: <1486065742-28639-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 14:05:20 +0000
Message-ID: <CAFEAcA8Tn=gqLxruPBm4b=MvEnhn7qNbZt2k-Sfk0Hu3eS+v3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/9] Rewrite NVIC to not depend
 on the GIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Liviu Ionescu <ilg@livius.net>, Michael Davidsaver <mdavidsaver@gmail.com>, "patches@linaro.org" <patches@linaro.org>

On 2 February 2017 at 20:02, Peter Maydell <peter.maydell@linaro.org> wrote:
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

Ping?

thanks
-- PMM
