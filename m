Received: from eggs.gnu.org ([2001:4830:134:3::10]:37654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHyy0-0001vs-4X
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHyxv-0006Yn-6E
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:28:00 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHyxu-0006Y8-UP
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:27:55 -0400
Received: by mail-wm1-x343.google.com with SMTP id l2-v6so10437094wmh.3
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 15:27:54 -0700 (PDT)
References: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
	<20181031132029.4887-26-kbastian@mail.uni-paderborn.de>
	<CAKmqyKNKC7TFNYmH242EEbD8y7m3ZSZ+BCA5i+GiqaK5j-u8qg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <78263165-02fd-c85e-5ef8-c3fcb793db39@linaro.org>
Date: Wed, 31 Oct 2018 22:27:51 +0000
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNKC7TFNYmH242EEbD8y7m3ZSZ+BCA5i+GiqaK5j-u8qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 25/35] target/riscv: make
 ADD/SUB/OR/XOR/AND insn use arg lists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org, peer.adelt@hni.uni-paderborn.de, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 10/31/18 8:44 PM, Alistair Francis wrote:
> This series causes a lot of kernel oops during boot...

The only bug I can see is in trans_addw.  But that's a biggie and could easily
explain, since non-extended values could have caused a compare to misfire.


r~
