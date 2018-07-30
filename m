Received: from eggs.gnu.org ([2001:4830:134:3::10]:58232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fkEkg-0005ij-BE
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:26:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fkEkf-0000UB-Ls
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:26:46 -0400
MIME-Version: 1.0
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Mon, 30 Jul 2018 22:26:44 +0200
Message-ID: <CABoDooPN3LASO-0FVm_shUg3QwQKmCaEfWnuPBS6BOABGr+STw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] ARM: SVE issue in saturated subtraction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

Hello Richard,

the signed overflow computation for 64-bit saturated subtraction in
do_sat_addsub_64 looks wrong:  I think the second xor should use t1
instead of t0.

Thanks,

Laurent
