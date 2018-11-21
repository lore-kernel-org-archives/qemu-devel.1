Received: from eggs.gnu.org ([2001:4830:134:3::10]:57790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gPVsY-0003oN-5C
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:01:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gPVsV-0005cJ-0P
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:01:30 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:33347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gPVsR-0005Xs-Ag
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:01:25 -0500
Received: by mail-wm1-x333.google.com with SMTP id 79so7730304wmo.0
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 09:01:21 -0800 (PST)
References: <mhng-995d2bae-d043-45c1-872d-7639baafd856@palmer-si-x1c4>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7a76c14a-78c1-d3f3-2d51-b9fc06931927@linaro.org>
Date: Wed, 21 Nov 2018 18:01:13 +0100
MIME-Version: 1.0
In-Reply-To: <mhng-995d2bae-d043-45c1-872d-7639baafd856@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC v1 11/23] riscv: tcg-target: Add the
 relocation functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>, alistair23@gmail.com
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org

On 11/21/18 4:53 PM, Palmer Dabbelt wrote:
> 
> Per the memory model chapter (which is being ratified now), FSD is not atomic
> on rv32i:
> 
>    An FLD or FSD instruction for which XLEN<64 may also be decomposed into a   
> set of component memory operations of any granularity.

Ah, thanks.  I knew I should have checked the manual.  Anyway, that means
*only* the indirect goto_tb method is viable for rv32.


r~
