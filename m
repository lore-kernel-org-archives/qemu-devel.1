Received: from eggs.gnu.org ([2001:4830:134:3::10]:45010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f3Bv8-0003kx-Nu
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 22:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f3Bv7-0001e5-AY
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 22:43:38 -0400
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:33362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f3Bv7-0001cZ-4D
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 22:43:37 -0400
Received: by mail-ot0-x234.google.com with SMTP id 23-v6so17797620otj.0
	for <qemu-devel@nongnu.org>; Mon, 02 Apr 2018 19:43:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180401184956.GZ2787@redhat.com>
References: <1522344417-60114-1-git-send-email-mjc@sifive.com>
	<CAHNT7Nvtx85EfQ6g_E1bL5XRvwZYoo=YoarMA6r9V4dER-O3Cw@mail.gmail.com>
	<20180401184956.GZ2787@redhat.com>
From: Michael Clark <mjc@sifive.com>
Date: Mon, 2 Apr 2018 19:43:35 -0700
Message-ID: <CAHNT7Nt4v1R27paaETG1=vjftL8+OjoWntiRSDB1Hn1DEyHNPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] RISC-V: Critical fixes for QEMU 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>

On Sun, Apr 1, 2018 at 11:49 AM, Richard W.M. Jones <rjones@redhat.com>
wrote:

> On Fri, Mar 30, 2018 at 10:08:23AM -0700, Michael Clark wrote:
> > Hi Peter,
> >
> > I had tested Richard's proper fix but we didn't have a PR or the required
> > Reviewed-by and Signed-off-by so I made the PR for the conservative fix,
>
> "Richard" is me or Richard Henderson?  Anyway if you meant Stefan
> O'Rear's fix (https://github.com/rwmjones/fedora-riscv-bootstrap/blob/
> master/stage1-riscv-qemu/force-float-save.patch)
> then it is my understanding that this is also just a workaround.


Apologies for not being precise. Richard Henderson has a comprehensive fix
that correctly marks mstatus.FS dirty inside of FP arithmetic and FP loads.
This logic is missing in the current QEMU, hence the bug. i.e. QEMU
currently only has logic to throw exceptions if mstatus.FS state is set of
off, but FP arithmetic and FP loads do not cause state change to dirty.

I submitted the pull request for your's/Stefan's workaround so that QEMU
2.12 has working FP context switching under Linux (always returning dirty
or off is valid implementation choice according to the specification),
given Richard Henderson had not made a PR for his more comprehensive fix,
with the rationale that we could implement the comprehensive fix for QEMU
2.13.

At this point, I think neither of the fixes have gone in due to timing i.e.
the Easter Holidays, so vendors will need either your's/Stefan's workaround
or Richard Henderson's 2 patch series which he sent to the mailing list.

- https://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg07034.html
