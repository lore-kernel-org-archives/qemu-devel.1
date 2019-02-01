Received: from eggs.gnu.org ([209.51.188.92]:49353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpajN-0004As-LN
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 10:27:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpajM-0001a9-OF
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 10:27:49 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:32966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpajK-0001Vo-HX
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 10:27:48 -0500
Received: by mail-oi1-x243.google.com with SMTP id c206so6123593oib.0
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 07:27:37 -0800 (PST)
MIME-Version: 1.0
References: <1648289.tQCHxfjYn9@basile.remlab.net>
In-Reply-To: <1648289.tQCHxfjYn9@basile.remlab.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Feb 2019 15:27:26 +0000
Message-ID: <CAFEAcA98cbqquL+mtz00XNgXoVuWqy66tvaw5pym02qy55ubUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/3] target/arm: fix PAuth in
 user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?R=C3=A9mi_Denis=2DCourmont?= <remi@remlab.net>
Cc: qemu-arm <qemu-arm@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>

On Fri, 25 Jan 2019 at 23:02, R=C3=A9mi Denis-Courmont <remi@remlab.net> wr=
ote:
>
>         Hello,
>
> As things stand, ARMv8.3-PAuth does not work in user mode. These tiny pat=
ches
> attempt to fix that.
>
> Br,
>
> ----------------------------------------------------------------
> Remi Denis-Courmont (3):
>       target/arm: fix AArch64 virtual address space size
>       target/arm: actually enable PAuth in user mode
>       target/arm: fix decoding of B{,L}RA{A,B}

Thanks for this patchset. I've applied patches 1 (v2) and 3
to my target-arm.next tree. (For patch 2 I prefer the approach
in Richard's patchset which deletes the cpu properties entirely.)

PS: for future patchsets, if you do a v2 of a patch it's better
to then resend the whole patchset as a fresh email thread (not a
followup. That makes our automated patch email handling tooling
happier as it can keep the v1 and v2 versions distinct.

thanks
-- PMM
