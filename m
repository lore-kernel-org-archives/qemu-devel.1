Received: from eggs.gnu.org ([2001:4830:134:3::10]:39169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gW76J-0002Hb-HS
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 16:59:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gW76I-0002TX-N5
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 16:58:59 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gW76I-0002T9-Gt
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 16:58:58 -0500
Received: by mail-ot1-x342.google.com with SMTP id w25so8601071otm.13
	for <qemu-devel@nongnu.org>; Sun, 09 Dec 2018 13:58:58 -0800 (PST)
MIME-Version: 1.0
References: <20181205134243.4791-1-aaron@os.amperecomputing.com>
	<20181205134243.4791-9-aaron@os.amperecomputing.com>
	<20181205153242.GE5549@quinoa.localdomain>
	<75ec3369-0f1c-0ea7-1fc5-9e2263f6f86e@linaro.org>
In-Reply-To: <75ec3369-0f1c-0ea7-1fc5-9e2263f6f86e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 9 Dec 2018 21:58:46 +0000
Message-ID: <CAFEAcA9O3BtCSDuiHFEEbX2dbWWvV-oUtmPAhbG-on14oOtfJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v9 08/14] target/arm: Make PMCEID[01]_EL0
 64 bit registers, add PMCEID[23]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Aaron Lindsay <aaron@os.amperecomputing.com>, qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Fri, 7 Dec 2018 at 18:00, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/5/18 9:32 AM, Aaron Lindsay wrote:
> > On Dec 05 08:43, Aaron Lindsay wrote:
> >> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> >> +    if (FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) >= 4) {
> >
> > After further discussion on my last version, this should be
> >
> > if (FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) >= 4 &&
> >       FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) != 0xf) {
> >
> > to guard against defining these registers for implementation-defined
> > PMUs.
>
> When id fields define values like 0b1111, that is a hint that the field should
> be interpreted as signed, and you should still use a >= comparison.  (See
> D12.1.4, Principles of the ID scheme for fields in ID registers.)

That section calls out these PMU ID registers as exceptions
which do not follow the scheme and specifically notes that
the "not 0xf and greater than or equal to 4" is the kind of
comparison required here...

thanks
-- PMM
