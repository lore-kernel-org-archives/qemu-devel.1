Received: from eggs.gnu.org ([2001:4830:134:3::10]:47541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC0Tq-0006IG-G6
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC0Tp-00030E-Nr
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:19:54 -0400
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:40922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC0Tp-000306-IJ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:19:53 -0400
Received: by mail-oi0-x22d.google.com with SMTP id c203-v6so1121359oib.7
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 03:19:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHNT7NsFuC4kHPvdVHkmMzJCr_Z80t-eNdbaaw6pt29dDh-8pw@mail.gmail.com>
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
	<CAHNT7NsVNohpxfic=A30oAufaygPWFp1BoT+PUTcgPyhaVif6g@mail.gmail.com>
	<CAHNT7NtRi4qwqpR+SuU-ANXHEAAkp6TitkWFroJ54GsJowTXNg@mail.gmail.com>
	<CAKmqyKMtO5JQ7GnpKU9E_MGeDRGHsb=c0ra0CnGX8vxKtKsunQ@mail.gmail.com>
	<CAHNT7NsFuC4kHPvdVHkmMzJCr_Z80t-eNdbaaw6pt29dDh-8pw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 11:19:32 +0100
Message-ID: <CAFEAcA_b6SVjdv+QeRC4MYX-npLD8nuzhc0ha9CGd=1TzCeBWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 00/35] QEMU 2.13 Privileged ISA
 emulation updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: Alistair Francis <alistair23@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Su Hang <suhang16@mails.ucas.ac.cn>, Matthew Suozzo <msuozzo@google.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Richard Henderson <richard.henderson@linaro.org>, "Emilio G. Cota" <cota@braap.org>, Alistair Francis <Alistair.Francis@wdc.com>, RISC-V Patches <patches@groups.riscv.org>

On 27 April 2018 at 01:34, Michael Clark <mjc@sifive.com> wrote:
> I wasn't sure whether I was going to send this series out before or after
> the 2.12 release and the remaining patches that need review depend on the
> earlier patches. The reason was so that patchew could digest the series i.e.
> if I sent out 26 patches that depend on changes made in the first 9 which
> weren't merged then patchew wouldn't be able to apply the series.

Patchew has a feature to support that. In the second series, after
the '---' line you say
Based-on: <message-id-of-first-patchset-cover-letter>

and then patchew knows it needs to apply the first patchset before
trying to apply and test the second.

thanks
-- PMM
