Received: from eggs.gnu.org ([2001:4830:134:3::10]:40579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ezauE-0002fr-PW
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 00:35:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ezauB-0007Qe-M3
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 00:35:50 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:37932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ezauB-0007Q3-FK
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 00:35:47 -0400
Received: by mail-pf0-x22f.google.com with SMTP id d26so5499827pfn.5
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 21:35:47 -0700 (PDT)
References: <1521221171-47213-1-git-send-email-mjc@sifive.com>
	<dec4f79c-a46e-f341-ef17-7ba85086bc9a@amsat.org>
	<CAHNT7Nuv9G+e3-m-356HZDoiLju=vPCucfWhXLJ0QHPGM7NSQw@mail.gmail.com>
	<75283674-1f4b-453c-0833-d84ab76a52cd@linaro.org>
	<CAHNT7NsmzEaLavarW=qXYdx9o0GOQWY5_vDsEk9AU58S=jZocQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3e629c7d-c282-8cf1-859d-d5837c9350b7@linaro.org>
Date: Sat, 24 Mar 2018 12:35:32 +0800
MIME-Version: 1.0
In-Reply-To: <CAHNT7NsmzEaLavarW=qXYdx9o0GOQWY5_vDsEk9AU58S=jZocQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] RISC-V: Fix riscv_isa_string memory
 size bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, "Richard W.M. Jones" <rjones@redhat.com>

On 03/21/2018 02:06 AM, Michael Clark wrote:
> Okay, so this would move byte swapping into TCG generic code instead of the TCG
> backend, unless the backend explicitly supports load/store with byte swap? 

Yes.


r~
