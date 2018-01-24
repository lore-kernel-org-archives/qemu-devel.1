Received: from eggs.gnu.org ([2001:4830:134:3::10]:40258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1ee8YD-0002Mc-DJ
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 19:05:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1ee8X2-0003iD-Km
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 19:04:25 -0500
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:41719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jimw@sifive.com>) id 1ee8X2-0003fo-Bm
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 19:03:12 -0500
Received: by mail-qt0-x22d.google.com with SMTP id i1so6100967qtj.8
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 16:03:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHNT7Nsz9rkS1iTtbo+1oofH==CvQ288PYJ7UGNsqc5fWFzckA@mail.gmail.com>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-7-git-send-email-mjc@sifive.com>
	<f15753f1-7446-26f1-9937-f3b67d15c0a6@linaro.org>
	<CAHNT7NvcUU8D10jaq+y=B2odsD7-r0MnsZRsq2yheY_a-THSUA@mail.gmail.com>
	<CAHNT7Nsz9rkS1iTtbo+1oofH==CvQ288PYJ7UGNsqc5fWFzckA@mail.gmail.com>
From: Jim Wilson <jimw@sifive.com>
Date: Tue, 23 Jan 2018 16:03:11 -0800
Message-ID: <CAFyWVaYO0uVm7HS_gSjhEoMMpCjvtGh4oCmiqK8_zMaHagNXvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 06/21] RISC-V FPU Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Tue, Jan 23, 2018 at 3:35 PM, Michael Clark <mjc@sifive.com> wrote:
> We want minimum number (minnum). It's been added to the draft spec and wi=
ll
> be in riscv-spec-v2.3.pdf

In the preface of the draft, it says
=E2=80=A2 Defined the signed-zero behavior of FMIN.fmt and FMAX.fmt, and
changed their behavior on
signaling-NaN inputs to conform to the minimumNumber and maximumNumber
operations
in the proposed IEEE 754-201x specification.

But if qemu doesn't have minimumNumber support yet, then yes minNum is corr=
ect.

This is discussed a bit here
    https://github.com/riscv/riscv-isa-manual/issues/65

Jim
