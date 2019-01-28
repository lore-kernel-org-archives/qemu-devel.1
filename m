Received: from eggs.gnu.org ([209.51.188.92]:51412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1go8XB-0008Io-Nv
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1go8Lb-00048L-DK
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:57:15 -0500
MIME-Version: 1.0
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Mon, 28 Jan 2019 15:57:23 +0100
Message-ID: <CABoDooPLHeQgTW-5C93VKsmRf9CzJUuAzmJHFrCDOpLZoUn-Lg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] AArch64: fcmla decoding errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

Hello,

I found two issues with FCMLA decoding in AArch64 disas_simd_indexed:

- FCMLA is not available as a scalar instruction
- size is wrongly shifted by one instead of being incremented by one.

Thanks,

Laurent
