Received: from eggs.gnu.org ([2001:4830:134:3::10]:57331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dLx6d-00063P-Go
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 15:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dLx6a-0007ro-Be
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 15:40:31 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:34534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dLx6a-0007rW-4q
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 15:40:28 -0400
Received: by mail-wr0-x233.google.com with SMTP id 77so43400869wrb.1
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 12:40:27 -0700 (PDT)
References: <CAFEAcA8ZTj4YRdcnSdMw6fEizEKa-cJndZG+=WFkkMDKHX9mYw@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA8ZTj4YRdcnSdMw6fEizEKa-cJndZG+=WFkkMDKHX9mYw@mail.gmail.com>
Date: Fri, 16 Jun 2017 20:41:03 +0100
Message-ID: <87efujbu0g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] ARM v6 memory barrier cp15 ops still implemented
 as NOPs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Pranith Kumar <bobby.prani@gmail.com>


Peter Maydell <peter.maydell@linaro.org> writes:

> Hi; I just noticed that we seem to still implement the ARM v6
> memory-barrier cp15 ops as NOPs:
>
>     { .name = "ISB", .cp = 15, .crn = 7, .crm = 5, .opc1 = 0, .opc2 = 4,
>       .access = PL0_W, .type = ARM_CP_NO_RAW, .writefn = arm_cp_write_ignore },
>     { .name = "DSB", .cp = 15, .crn = 7, .crm = 10, .opc1 = 0, .opc2 = 4,
>       .access = PL0_W, .type = ARM_CP_NOP },
>     { .name = "DMB", .cp = 15, .crn = 7, .crm = 10, .opc1 = 0, .opc2 = 5,
>       .access = PL0_W, .type = ARM_CP_NOP },
>
> Don't these need to do something more complicated with the
> advent of MTTCG ?

Yeah they should - what does ISB do that it needs a write handler?

>
> thanks
> -- PMM


--
Alex Bennée
