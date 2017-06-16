Received: from eggs.gnu.org ([2001:4830:134:3::10]:51913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLv8b-0003jG-3a
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLv8a-0007gk-F3
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:34:25 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:32780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dLv8a-0007fN-8K
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:34:24 -0400
Received: by mail-wm0-x232.google.com with SMTP id m7so5343922wmg.0
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 10:34:24 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Jun 2017 18:34:02 +0100
Message-ID: <CAFEAcA8ZTj4YRdcnSdMw6fEizEKa-cJndZG+=WFkkMDKHX9mYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] ARM v6 memory barrier cp15 ops still implemented as
 NOPs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

Hi; I just noticed that we seem to still implement the ARM v6
memory-barrier cp15 ops as NOPs:

    { .name = "ISB", .cp = 15, .crn = 7, .crm = 5, .opc1 = 0, .opc2 = 4,
      .access = PL0_W, .type = ARM_CP_NO_RAW, .writefn = arm_cp_write_ignore },
    { .name = "DSB", .cp = 15, .crn = 7, .crm = 10, .opc1 = 0, .opc2 = 4,
      .access = PL0_W, .type = ARM_CP_NOP },
    { .name = "DMB", .cp = 15, .crn = 7, .crm = 10, .opc1 = 0, .opc2 = 5,
      .access = PL0_W, .type = ARM_CP_NOP },

Don't these need to do something more complicated with the
advent of MTTCG ?

thanks
-- PMM
