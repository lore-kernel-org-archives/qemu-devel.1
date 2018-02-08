Received: from eggs.gnu.org ([2001:4830:134:3::10]:45799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejnmk-0005lB-US
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:06:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejnmf-0004cq-TW
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:06:50 -0500
Received: from mail-pl0-x22d.google.com ([2607:f8b0:400e:c01::22d]:33909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejnmf-0004cK-NO
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:06:45 -0500
Received: by mail-pl0-x22d.google.com with SMTP id q17-v6so2203253pll.1
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 07:06:45 -0800 (PST)
References: <CAHNT7NvmANaTCbwb7xP9i1TBZ9-2Syf00hxM_vaWh3zk57oj7g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <82eff582-04aa-7f1f-f389-b313733f476f@linaro.org>
Date: Thu, 8 Feb 2018 07:06:41 -0800
MIME-Version: 1.0
In-Reply-To: <CAHNT7NvmANaTCbwb7xP9i1TBZ9-2Syf00hxM_vaWh3zk57oj7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] QEMU support for IEEE 754-201x
 minimumNumber/maximumNumber
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Jim Wilson <jimw@sifive.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 02/07/2018 02:45 PM, Michael Clark wrote:
> My question. Should we add support for minimumNumber/maximumNumber in
> fpu/softfloat.c or just implement private versions of these intrinsics in
> target/riscv/fpu_helper.c

Adding them to softfloat.c is best; eventually another cpu will have these
operations.

> Does the fpu/softfloat.c code have good test coverage in make check?

Not really.

We've done most of our regression testing with RISU, validating the results of
random input passed through random instructions against hardware.


r~
